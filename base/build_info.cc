#include "base/build_info.h"

const char* kBuildEmbedLabel = BUILD_EMBED_LABEL;
const char* kBuildHost = BUILD_HOST;
const char* kBuildUser = BUILD_USER;
const char* kBuildScmRevision = BUILD_SCM_REVISION;
const char* kBuildScmStatus = BUILD_SCM_STATUS;
const time_t kBuildTimestamp = (time_t)(BUILD_TIMESTAMP / 1000.0);
const char* kBazelTargetName = G3_TARGET_NAME;
const char* kBazelPlatform = GPLATFORM;
