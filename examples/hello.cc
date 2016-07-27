#include <ctime>
#include "base/build_info.h"
#include "glog/logging.h"
#include "gflags/gflags.h"

DECLARE_bool(logtostderr);
int main(int argc, char *argv[]) {
  FLAGS_logtostderr = true;
  google::InstallFailureSignalHandler();
  gflags::SetUsageMessage("hello");
  gflags::ParseCommandLineFlags(&argc, &argv, false);
  google::InitGoogleLogging(argv[0]);
  LOG(INFO) << "Hello World!";
  char timestamp[32];
  std::strftime(timestamp, sizeof(timestamp), "%c",
                std::localtime(&kBuildTimestamp));
  LOG(INFO) << "Built by " << kBuildUser << "@" << kBuildHost
            << " as " << kBazelTargetName
            << " on " << timestamp 
            << " as " << kBazelTargetName
            << " with git revision @" << kBuildScmRevision;
  return 0;
}
