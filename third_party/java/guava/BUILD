package(default_visibility = ['//visibility:public'])

licenses(['notice'])

java_library(
  name = 'guava',
  javacopts = [
    '-extra_checks:off',
  ],
  srcs = glob([
    'upstream/guava/src/com/google/**/*.java'
  ]),
  deps = [
    '//third_party/java/animal-sniffer:annotations',
    '//third_party/java/error-prone/annotations',
    '//third_party/java/j2objc:annotations',
    '//third_party/java/jsr305',
  ],
)
