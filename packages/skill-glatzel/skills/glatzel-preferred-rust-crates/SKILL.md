---
name: preferred-rust-crates
description: The user's preferred Rust crates, grouped by field (async, CLI, serialization, errors, logging, testing, FFI, GPU kernels, plotting, verification, and more). Use this skill whenever writing, editing, reviewing, or scaffolding Rust code and a dependency might be needed, including choosing crates for a new Cargo.toml, adding a dependency, picking a library for a task, or comparing crate options. Consult it even when the user does not mention crates, e.g. "add CLI parsing", "write a benchmark", "serialize this struct", "add logging", "generate bindings", "write tests" in a Rust project.
---

# Preferred Rust crates

The user has a settled set of crates they like. When a Rust task needs a dependency, reach for the crate listed here for that field before considering anything else. This keeps projects consistent and saves the user from correcting the same choices repeatedly.

## The list

The full list is in `references/crates.csv` with columns `Field,Crates,Description`. It is about 90 rows, so read the whole file when a task needs a dependency (or `grep -i` it for a field or crate name). A blank Description just means the crate needs no explanation.

## How to use it

1. **Only add a dependency when the task needs one.** The list is a preference, not a shopping list. Prefer `std` when it does the job cleanly.
2. **Match the need to a Field, then use the crate listed.** Don't ask first.
3. **Respect "alternative to" notes in the Description.** Where two crates are alternatives (`clap`/`bpaf`, `fixed`/`heapless`, `flux`/`kani`/`verus`), pick based on context and say briefly which you chose if it isn't obvious.
4. **If nothing fits, use your judgment** and pick a well-maintained crate. Mention it is outside the preferred list so the user can decide whether to keep it.
5. **Don't guess APIs or versions.** Several of these crates are new or niche (`solidcore`, `cuda-oxide`, `cutile-rs`, `PhastFT`, `fory`). Check current docs or use `cargo add` for the latest version before writing code against them.
6. **Match the project's constraints.** For `no_std` or embedded work, prefer `heapless` and `defmt` and the user's `no_std` textwrap fork over std-based options.

## Notes

- `PhastFT` is the preferred FFT crate; don't reach for `rustfft`, `realfft`, or `fftw`.
- `textwrap` is the user's own `no_std` fork. If it isn't already in the project's `Cargo.toml`, ask for its crate name or git source rather than adding upstream `textwrap`.

## Quick picks

- New binary with arguments: `clap` + `clap-verbosity-flag` + `tracing` + `tracing-subscriber`
- Library error types: `thiserror`
- Serializing structs: `serde` + `serde_json` (`toml` for config, `rmp-serde` for compact binary)
- Tests: `rstest` for parameterization, `insta` for snapshots, `proptest` for invariants, `tempfile` for scratch dirs
- Benchmarks: `criterion`
- Calling C/C++: `bindgen` + `libc`
- Python extension module: `pyo3` (+ `numpy` for arrays)
- Embedded / `no_std`: `heapless` + `defmt`
- Data-parallel loops: `rayon`
- Dataframes / columnar data: `polars`, with `arrow` / `parquet` for interchange and storage
