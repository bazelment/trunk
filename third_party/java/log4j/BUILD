licenses(['notice'])
package(default_visibility = ['//visibility:public'])

java_library(
  name = 'log4j',
  javacopts = [
    '-extra_checks:off',
  ],
  srcs = glob([
    'upstream/src/main/java/org/apache/log4j/*.java',
    'upstream/src/main/java/org/apache/log4j/config/*.java',
    'upstream/src/main/java/org/apache/log4j/helpers/*.java',
    'upstream/src/main/java/org/apache/log4j/pattern/*.java',
    'upstream/src/main/java/org/apache/log4j/or/*.java',
    'upstream/src/main/java/org/apache/log4j/spi/*.java',
  ], exclude=[
  ]),
)
