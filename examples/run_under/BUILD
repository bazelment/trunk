py_binary(
  name = 'env',
  srcs = [
    'env.py'
  ]
)

load('//tools/build_rules:run_under.bzl', 'run_under_test')

run_under_test(
  name = 'hello_test',
  under = ':env',
  command = '//examples:hello',
  data = [
    ':env'
  ],
)
