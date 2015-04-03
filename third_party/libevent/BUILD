licenses(["notice"])
cc_library(
  visibility = ["//visibility:public"],
  includes = [
    "upstream",
    "linux-k8",
  ],
  srcs = [
    "upstream/event.c",
    "upstream/buffer.c",
    "upstream/evbuffer.c",
    "upstream/log.c",
    "upstream/evutil.c",
    "upstream/event_tagging.c",
    "upstream/http.c",
    "upstream/evdns.c",
    "upstream/strlcpy.c",
    "upstream/signal.c",
    "upstream/epoll.c",
    "upstream/poll.c",
    "upstream/select.c",
  ],
  hdrs = [
    "upstream/event.h",
    "upstream/evhttp.h",
  ],
  name = "libevent",
  copts = [
    "-DHAVE_CONFIG_H",
    "-Ithird_party/libevent/upstream/compat",
    "-Ithird_party/libevent/linux-k8/internal",
    "-Wno-unused-but-set-variable",
  ],
)

