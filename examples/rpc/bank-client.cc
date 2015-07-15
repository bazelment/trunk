#include "examples/rpc/bank.grpc.pb.h"

#include "gflags/gflags.h"
#include "glog/logging.h"

#include <grpc/grpc.h>
#include <grpc++/channel_arguments.h>
#include <grpc++/channel_interface.h>
#include <grpc++/client_context.h>
#include <grpc++/create_channel.h>
#include <grpc++/credentials.h>
#include <grpc++/status.h>

using grpc::ChannelArguments;
using grpc::ChannelInterface;
using grpc::ClientContext;
using grpc::Status;

DEFINE_int32(port, 10000, "Listening port of RPC service");

namespace examples {

static void RunClient() {
  LOG(INFO) << "Start the client.";
  std::shared_ptr<ChannelInterface> 
    channel(grpc::CreateChannel("localhost:10000",
                                grpc::InsecureCredentials(),
                                ChannelArguments()));
  std::unique_ptr<Bank::Stub> stub(Bank::NewStub(channel));
  DepositRequest request;
  request.set_account("xucheng");
  request.set_amount(25);
  ClientContext context;
  DepositReply response;
  Status status = stub->Deposit(&context, request, &response); 
  if (status.IsOk()) {
    LOG(INFO) << response.account() << " balance:" << response.balance();
  } else {
    LOG(INFO) << "Rpc failed";
  }
}

}  // namespace examples

int main(int argc, char** argv) {
  google::InstallFailureSignalHandler();
  google::ParseCommandLineFlags(&argc, &argv, false);
  google::InitGoogleLogging(argv[0]);
  grpc_init();
  examples::RunClient();

  grpc_shutdown();
  return 0;
}
