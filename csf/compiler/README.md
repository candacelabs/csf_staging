# csfc - the CSF compiler

`csfc` checks declared process and scope relationships and selected Go source
boundaries. The [architecture compiler](architecture/README.md) owns this
implementation; the [documentation compiler](language/README.md) owns the
shared vocabulary and diagrams. Root `tools/` copies are generated compatibility
mirrors, maintained by `tools/sync-csf-compiler-compat.sh` in the monorepo.

The public module supplies pinned OCaml dependencies as development dependencies,
so Go consumers do not resolve the compiler toolchain. From its root:

```sh
bash tools/bazel.sh test //csf/compiler/architecture:all //csf/compiler:csfc --nobuild_tests_only --lockfile_mode=error
bazel-bin/csf/compiler/bin/csfc check
```

The monorepo also stages the executable at `bazel-bin/bin/csfc`. Start with the
[runnable walkthrough](architecture/WALKTHROUGH.md). The compiling
[Lean verifier stub](verification/README.md) returns `notImplemented` for every
input; it proves no compiler, runtime, or physical-safety property.
