package(default_visibility = ['//visibility:public'])

licenses(['notice'])

guava = '//third_party/java/guava'
jsr305 = '//third_party/java/jsr305'

java_library(
  name = 'args-core',
  srcs = [
    'upstream/src/java/com/twitter/common/args/' + x for x in [
      'Arg.java',
      'ArgParser.java',
      'CmdLine.java',
      'NoParser.java',
      'Parser.java',
      'ParserOracle.java',
      'Positional.java',
      'Verifier.java',
      'VerifierFor.java',
    ]
  ],
  deps = [
    jsr305,
    ':base',
    ':collections',
    '//third_party/java/guava',
  ],
)

java_library(
  name = 'base',
  srcs = glob([
    'upstream/src/java/com/twitter/common/base/**/*.java',
  ]),
  deps = [
    ':collections',
    ':quantity',
    ':system-clocks',
    '//external:apache-commons-lang2',
    '//third_party/java/jsr305',
    '//third_party/java/guava',
  ],
)

java_library(
  name = 'collections',
  srcs = glob([
    'upstream/src/java/com/twitter/common/collections/**/*.java',
  ]),
  deps = [
    '//external:apache-commons-lang2',
    '//external:jsr305',
    '//third_party/java/guava',
  ],
)

java_library(
  name = 'logging',
  srcs = [
    'upstream/src/java/com/twitter/common/logging/Glog.java',
    'upstream/src/java/com/twitter/common/logging/Log.java',
    'upstream/src/java/com/twitter/common/logging/LogUtil.java',
    'upstream/src/java/com/twitter/common/logging/LogFormatter.java',
    'upstream/src/java/com/twitter/common/logging/RootLogConfig.java',
  ],
  deps = [
    ':args-core',
    '//external:apache-commons-lang2',
    '//external:joda-time',
    guava,
    jsr305,
  ]
)

java_library(
  name = 'quantity',
  srcs = glob([
    'upstream/src/java/com/twitter/common/quantity/**/*.java',
  ]),
  deps = [
    ':collections',
    '//third_party/java/guava',
  ],
)

# Inside util
java_library(
  name = 'util-logging',
  srcs = glob([
    'upstream/src/java/com/twitter/common/util/logging/*.java',
  ]),
  deps = [
    #':collections',
    guava,
  ],
)

java_library(
  name = 'system-clocks',
  srcs = [
    'upstream/src/java/com/twitter/common/util/Clock.java',
    'upstream/src/java/com/twitter/common/util/Random.java',
  ],
  deps = [
    guava,
  ],
)
