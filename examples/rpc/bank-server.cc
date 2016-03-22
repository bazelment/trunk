#include "examples/rpc/bank.grpc.pb.h"

#include <memory>
#include <sstream>
#include <unordered_map>

#include <grpc/grpc.h>
#include <grpc++/server.h>
#include <grpc++/server_builder.h>
#include <grpc++/server_context.h>

#include "gflags/gflags.h"
#include "glog/logging.h"
// #include "base/strutil.h"

DEFINE_int32(port, 10000, "Listening port of RPC service");

namespace examples {

class BankImpl : public Bank::Service {
 public:
  virtual grpc::Status Deposit(grpc::ServerContext* context,
                               const DepositRequest* request,
                               DepositReply* response) {
    double balance = balances_[request->account()];
    balance += request->amount();
    balances_[request->account()] = balance;
    response->set_account(request->account());
    response->set_balance(balance);
    return grpc::Status::OK;
  }

 private:
  std::unordered_map<std::string, double> balances_;
};

static void RunServer() {
  std::stringstream server_address;
  server_address << "0.0.0.0:" << FLAGS_port;
  BankImpl service;

  LOG(INFO) << "Server listening on " << server_address.str();
  grpc::ServerBuilder builder;
  builder.AddListeningPort(server_address.str(),
                           grpc::InsecureServerCredentials());
  builder.RegisterService(&service);
  std::unique_ptr<grpc::Server> server(builder.BuildAndStart());
  server->Wait();
}

}  // namespace examples

int main(int argc, char** argv) {
  google::InstallFailureSignalHandler();
  google::ParseCommandLineFlags(&argc, &argv, false);
  google::InitGoogleLogging(argv[0]);
  examples::RunServer();

  return 0;
}
