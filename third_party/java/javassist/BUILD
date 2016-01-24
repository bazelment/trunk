licenses(['notice'])
package(default_visibility = ['//visibility:public'])

java_library(
  name = 'javassist',
  javacopts = [
    '-extra_checks:off',
  ],
  srcs = glob([
    'upstream/src/main/**/*.java'
  ], exclude=[
    'upstream/src/main/javassist/util/HotSwapper.java',
  ]),
  deps = [
  ],
)
