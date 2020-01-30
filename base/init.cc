#include "base/init.h"

#include "absl/debugging/failure_signal_handler.h"
#include "absl/debugging/symbolize.h"
#include "absl/flags/parse.h"
#include "glog/logging.h"

namespace base {
void InitProgram(int argc, char *argv[]) {
  // Initialize the symbolizer to get a human-readable stack trace
  absl::InitializeSymbolizer(argv[0]);

  absl::FailureSignalHandlerOptions options;
  absl::InstallFailureSignalHandler(options);
  
  absl::ParseCommandLine(argc, argv);
  google::InitGoogleLogging(argv[0]);
}
					 
}  // namespace base
