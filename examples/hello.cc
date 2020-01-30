#include <ctime>
#include "base/build_info.h"
#include "base/init.h"
#include "glog/logging.h"

// DECLARE_bool(logtostderr);
int main(int argc, char *argv[]) {
  // FLAGS_logtostderr = true;
  base::InitProgram(argc, argv);
  LOG(INFO) << "Hello World!";
  char timestamp[32];
  std::strftime(timestamp, sizeof(timestamp), "%c",
                std::localtime(&kBuildTimestamp));
  LOG(INFO) << "Built by " << kBuildUser << "@" << kBuildHost
            << " as " << kBazelTargetName
            << " on " << timestamp 
            << " as " << kBazelTargetName
            << " with git revision @" << kBuildScmRevision;
  abort();
  char* buffer = new char[1024*1024*1024];
  buffer[0] = 'a';
  delete[] buffer;
  return 0;
}
