licenses(['notice'])
package(default_visibility = ['//visibility:public'])

java_library(
  name = 'commons-logging',
  javacopts = [
    '-extra_checks:off',
  ],
  srcs = glob([
    'upstream/src/main/**/*.java'
  ], exclude=[
    'upstream/src/main/java/org/apache/commons/logging/impl/AvalonLogger.java',
    'upstream/src/main/java/org/apache/commons/logging/impl/ServletContextCleaner.java',
    # This depends apache logkit
    'upstream/src/main/java/org/apache/commons/logging/impl/LogKitLogger.java'
  ]),
  deps = [
    '//third_party/java/log4j',
  ],
)
