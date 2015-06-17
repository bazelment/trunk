package(default_visibility = ['//visibility:public'])

licenses(['notice'])

java_library(
  name = 'guava',
  srcs = glob([
    'upstream/guava/src/com/google/**/*.java'
  ]),
  deps = [
    '//third_party/java/error-prone/annotations',
    '//third_party/java/jsr305',
  ],
)
