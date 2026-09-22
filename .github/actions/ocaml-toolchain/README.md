# OCaml installation cache

Run `mode: compiler` to prepare OCaml, then `mode: prepare` in a dependent job to
complete its locked package graph. Native check jobs use `mode: restore` after
both preparation stages. Each stage has its own job budget. A missing exact
prerequisite cache fails the consumer instead of rebuilding inside its budget.

The pinned Bazel launcher mounts `.git/csf-ocaml-toolchain/` at
`/csf-ocaml-toolchain`. Only the opam installation is shared; each checkout keeps
its own Bazel output base, repository manifests and configuration helper.
The package lock, Bazel modules and toolchain implementation identify the cache.
There are no fallback keys. The intermediate compiler cache has a separate key
and validates the compiler version and installed package subset against the
lock. It is preparation evidence only and never satisfies a native check job.
Final preparation completes the full package and library lock validation before
saving. Repository materialization repeats that
validation when a consumer uses the installation. Tests and generated-output
checks remain the responsibility of each consuming job.

Without `CANDACE_OCAML_TOOLCHAIN_CACHE`, the launcher retains its ordinary
repository-local installation behavior. Bazel tracks the optional container
environment through `repository_ctx.getenv`.
