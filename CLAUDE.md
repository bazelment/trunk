This is bazel managed mono repo, focus on C++ code and Java code.

It uses bzlmod (Bazel 9 dropped WORKSPACE), but unlike a typical bzlmod setup it ensures all the dependencies are fully materiliazed: every vendored module is declared with local_path_override in MODULE.bazel so it resolves to the checked out submodule and never to an archive from the registry, and bazel BUILD files are embedded with the dependencies it tries to pull in

For each source repo, it uses
- submodule to ensure the code is visible in a single tree
- if needed, create a fork to allow code change and bazel BUILD files be added to that submodule
- if that module needs extra dependency, repeat the same thing. 
