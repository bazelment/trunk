HPP_FILES = glob(["**/*.hpp"])

H_FILES = glob(["**/*.h"])

INL_FILES = glob(["**/*.inl"])

INCLUDES = HPP_FILES + H_FILES

cc_library(
    name = "glm",
    srcs = INCLUDES,
    hdrs = [
        "glm/fwd.hpp",
        "glm/glm.hpp",
    ],
    textual_hdrs = INL_FILES,
    visibility = ["//visibility:public"],
)
