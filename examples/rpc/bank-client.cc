#include "examples/rpc/bank.grpc.pb.h"

#include <grpc/grpc.h>
#include <grpc++/channel.h>
#include <grpc++/client_context.h>
#include <grpc++/create_channel.h>
#include <grpc++/security/credentials.h>
#include <grpc++/support/status.h>

#include "absl/flags/flag.h"
#include "absl/strings/str_format.h"
#include "glog/logging.h"

#include "base/init.h"

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;

ABSL_FLAG(int32_t, port, 10000, "Listening port of RPC service");
ABSL_DECLARE_FLAG(bool, logtostderr);

namespace examples {

static void RunClient() {
  LOG(INFO) << "Start the client.";
  std::shared_ptr<Channel>
    channel(grpc::CreateChannel(absl::StrFormat("localhost:%d", absl::GetFlag(FLAGS_port)),
				grpc::InsecureChannelCredentials()));
  std::unique_ptr<Bank::Stub> stub(Bank::NewStub(channel));
  DepositRequest request;
  request.set_account("xucheng");
  request.set_amount(25);
  ClientContext context;
  DepositReply response;
  Status status = stub->Deposit(&context, request, &response);
  if (status.ok()) {
    LOG(INFO) << response.account() << " balance:" << response.balance();
  } else {
    LOG(INFO) << "RPC failed: " << status.error_code();
  }
}

}  // namespace examples

int main(int argc, char** argv) {
  // Set this to true so that useful logout can be seen.
  absl::SetFlag(&FLAGS_logtostderr, true);
  base::InitProgram(argc, argv);
  examples::RunClient();

  return 0;
}
