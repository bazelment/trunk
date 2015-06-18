licenses(['notice'])
package(default_visibility = ['//visibility:public'])

java_library(
  name = 'api',
  srcs = glob([
    'upstream/slf4j-api/src/main/java/**/*.java'
  ]),
  deps = [
  ],
)

java_library(
  name = 'slf4j',
  exports = [
    'api',
  ],
)
