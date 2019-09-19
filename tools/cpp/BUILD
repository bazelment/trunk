package(default_visibility = ["//visibility:public"])

# This can used to enable some conditional setting based on when
# asan/msan/tsan/ubsan is used.
config_setting(
  name = "asan_enabled",
  values = {
    "copt" : "-fsanitize=address",
  }
)

config_setting(
  name = "msan_enabled",
  values = {
    "copt" : "-fsanitize=memory",
  }
)

config_setting(
  name = "tsan_enabled",
  values = {
    "copt" : "-fsanitize=thread",
  }
)

config_setting(
  name = "ubsan_enabled",
  values = {
    "copt" : "-fsanitize=undefined",
  }
)

config_setting(
  name = "debug_enabled",
  values = {
    "compilation_mode": "dbg"
  }
)

config_setting(
  name = "opt_enabled",
  values = {
    "compilation_mode": "opt"
  }
)

# This can used to enable some conditional setting for ARM CPU
config_setting(
  name = "arm",
  values = {
    "cpu": "arm",
  }
)

# This can used to enable some conditional setting for X86 32 bit CPU
config_setting(
  name = "x86_32",
  values = {
    "cpu": "piii",
  }
)
