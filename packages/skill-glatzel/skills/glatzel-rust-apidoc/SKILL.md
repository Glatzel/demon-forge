---
name: glatzel-rust-apidoc
description: Write and review concise Rust API documentation (rustdoc comments, `///`, `//!`) using Rustdoc conventions and a fixed NumPy-inspired section order, with compact std-style doctest examples on every public item. Use whenever the user asks to document, add or improve doc comments, or review documentation for Rust functions, methods, structs, enums, traits, modules, macros, constants or crates, including unsafe and numerical APIs, even if they do not say "rustdoc" or "numpydoc". Also use when the user asks to add or improve examples or doctests for Rust APIs.
---

# Rust API Documentation

Write concise, accurate documentation for API users. Follow Rustdoc conventions and Rust terminology; borrow only the section order from NumPy. Use the shortest prose that fully explains the public API. Add prose detail only when it improves correctness, safety, or usability. **Examples are the exception to brevity-by-omission: every public item that can have one gets one, kept compact.**

## Core rules

- Write for API users, not implementers.
- Explain behavior that is not obvious from the signature.
- Document established guarantees only. Behavior that is observable but not clearly intended (iteration order, allocation strategy, incidental performance) is either omitted or stated as unspecified. Never promise it.
- Never invent performance guarantees, complexity bounds, or mathematical properties.
- Preserve existing project terminology and style unless they conflict with these rules.
- Use the section order below even if existing docs differ.
- Touch documentation only: no changes to behavior, signatures, non-doc comments, or unrelated formatting.
- Scope: document all `pub` items. Skip private items unless asked. Give `pub(crate)` items a summary and only the sections that carry real constraints.
- **Examples are the default.** Every `pub` fn, method, struct, enum, trait, macro and module gets a compact `# Examples` section unless it falls under the narrow exemptions in "Examples" below. Do not skip an example because the summary "already explains it"; std documents even trivial methods with a one-liner.

## Section order

Fixed order. Omit sections that do not apply (except `# Examples`, see below); never reorder the rest.

1. Summary (required, no heading)
2. `# Arguments`
3. `# Returns`
4. `# Errors`
5. `# Panics`
6. `# Safety` (mandatory for `unsafe fn`)
7. `# See also`
8. `# Notes`
9. `# References`
10. `# Examples` (always last)

Use only these headings. Add another only if an unusual API cannot express the information under an existing one. Adapt sections to the item: do not force function-oriented sections onto types, traits, or modules. Never add empty sections or list trivia to fill the template.

## Section guidance

**Summary.** One line, third person, present tense, ending in a period ("Computes…", "Returns…"). Add a short paragraph after it only when the summary cannot convey essential behavior.

**Arguments.** Document only arguments whose meaning or constraints are not obvious. Always use the exact identifier; restate the type only when it adds meaning. Use this format:

```rust
/// # Arguments
///
/// * `signal` - Input samples, interleaved by channel.
/// * `window` - Window length in samples; must be a power of two.
```

Cover semantics, constraints, units, and dimensions where relevant.

**Returns.** Describe the meaning and caller-relevant guarantees. For `Result<T, E>`, describe the success value here and failures under `# Errors`. For `Option<T>`, say what `None` means if not obvious. Mention shape, ordering, units, or ownership only when relevant.

**Errors.** State when each meaningful error is returned, linking error types or variants. Do not conflate with panics.

**Panics.** State precise triggering conditions. No vague or speculative statements.

**Safety.** Required for every `unsafe fn`. List concrete obligations: pointer validity, alignment, initialization, aliasing, lifetimes, synchronization, as applicable. For unsafe traits, state the invariants implementors must uphold. Never write "the caller must ensure this is safe."

**See also.** Intra-doc links, only when they materially help.

**Notes / References.** Short. Notes for important details that fit nowhere else; References for papers, standards, or authoritative algorithm descriptions.

## Examples

Model examples on the Rust standard library: small, readable at a glance, and verified by `assert!`/`assert_eq!` so the doctest proves the documented behavior.

### Shape

- **Default size: 1–5 lines of real code.** Rarely more than ~10. If it needs more, the API probably needs a better example, not more setup.
- **Assert, don't print.** Use `assert_eq!`, `assert!`, `assert_eq!(x, Some(..))` so the result is visible next to the call. Avoid `println!` and avoid comments that merely narrate the code.
- **Use the real public API** with realistic but minimal values (`[1.0, 2.0, 3.0]`, `"hello"`, `4`), not placeholders like `foo`/`bar` unless the domain has none.
- **One idea per example.** For anything with more than one meaningful behavior, use several short examples, each introduced by a one-line lead-in ending in a colon, as std does:

```rust
/// # Examples
///
/// Basic usage:
///
/// ```
/// use my_crate::Window;
///
/// let w = Window::hann(4);
/// assert_eq!(w.len(), 4);
/// ```
///
/// Zero length yields an empty window:
///
/// ```
/// # use my_crate::Window;
/// assert!(Window::hann(0).is_empty());
/// ```
```

- Lead-ins: "Basic usage:", "Handling the error case:", "Out-of-range input returns `None`:". Skip the lead-in when there is only one example and it is obviously basic usage.
- Put `use` lines first and visible only when they teach the import path; hide repeated setup with `# ` in later blocks.

### What to cover

1. **Primary use case**, always.
2. **The edge that the docs call out**, when a section documents it: the `None`/`Err` path under `# Returns`/`# Errors`, and a `should_panic` example under `# Panics` if the condition is easy to trigger.
3. **A numerical or convention detail** only when it is easy to show in one assertion (axis order, normalization, units).

Do not enumerate every code path; examples are documentation, not tests.

### Mechanics

- Hide boilerplate with `#` lines; keep what the reader needs to understand the call visible.
- To use `?`, end with `# Ok::<(), ErrorType>(())`.
- Use `should_panic` for `# Panics` demos, `compile_fail` to show rejected code (borrow rules, type-state misuse).
- Floating-point: compare with a tolerance (`(a - b).abs() < 1e-12`) or an existing approx helper; never `assert_eq!` on computed floats.
- `unsafe fn`: show a minimal sound call inside `unsafe { }` with a `// SAFETY:` comment that satisfies each obligation in `# Safety`.
- Use `no_run` or `ignore` only when the code genuinely cannot run in doctests (needs hardware, network, FFI host such as Houdini/Rhino) and say why in the lead-in. Prefer restructuring so a small part runs.
- Feature-gated items: gate the example the same way (`#[cfg(feature = "...")]` inside the hidden setup, or rely on the item's own gate).

### Per item type

- **Functions, methods:** call it and assert the result.
- **Constructors (`new`, `from_*`, `default`):** build one and assert one observable property.
- **Structs:** one example constructing and using the type; field-level docs usually need none.
- **Enums:** one example matching or constructing the most important variants; do not repeat one per variant.
- **Traits:** one example of a minimal implementation or of calling via the trait; for unsafe traits, a sound `unsafe impl`.
- **Macros:** one invocation with its asserted result.
- **Modules / crates (`//!`):** a short end-to-end example of the main workflow.
- **Trait impls, `Debug`/`Display`, operator impls:** one example only if output format or semantics are not obvious; otherwise none.

### When to omit

Omit `# Examples` only when one of these holds, and do not mention the omission:

- The item is a field, variant, associated constant, static, or type alias whose meaning is self-evident from its docs.
- It is a trivial trait-impl method (`fmt`, `clone`, `from`) with no non-obvious behavior.
- It cannot be demonstrated without external state that no `no_run` structure can sensibly capture.
- It is `pub(crate)` or private.

"The function is simple" or "the summary is enough" are **not** valid reasons.

## By item type

- **Functions, methods:** behavior plus non-obvious argument and return semantics.
- **Structs:** the concept and important invariants. **Fields:** non-obvious meaning, units, constraints.
- **Enums:** the concept, then each variant.
- **Traits:** the abstraction and implementor requirements.
- **Type aliases, constants, statics:** meaning, units, interpretation when not self-evident.
- **Modules:** `//!` docs.
- **Macros:** inputs, expansion behavior, constraints.
- **Feature-gated items:** keep `#[doc(cfg(...))]` (or `doc_auto_cfg`) consistent with the project; mention the required feature in the summary or `# Notes` only if not already surfaced.
- **Deprecated items:** keep the `#[deprecated]` note accurate and point to the replacement; do not duplicate it in prose.

## Technical APIs

For numerical, scientific, and signal-processing APIs, document conventions that affect correct use: input and output dimensions, axis and index meaning, units, normalization, frequency ordering, sign conventions, boundary behavior and padding, precision limits, allocation and in-place behavior, and complexity when known and useful.

Placement: put a convention under `# Arguments` or `# Returns` when it describes a specific parameter or result; otherwise under `# Notes`. Keep it concrete and brief. Include math only when needed to use the API correctly. When a convention can be shown in one assertion (e.g. DC bin is index 0, output length is `n / 2 + 1`), show it in an example.

## Workflow

1. Read the signature, then the implementation, tests, and related APIs as needed to establish _intended_ behavior (see the unspecified-behavior rule). Existing tests are a good source of compact example inputs.
2. Write the summary, then add only useful sections in order.
3. Write the examples: draft the smallest snippet that demonstrates the primary use case, add the call-out edge if any, then trim until each line earns its place.
4. Verify names, return semantics, errors, panics, and safety obligations against the code. Every assertion in an example must be true of the actual implementation; run it rather than reasoning about it when possible.
5. Run checks when practical, following workspace and feature requirements:
   - `cargo test --doc` (library targets only). **Run this whenever examples were added or changed.**
   - `RUSTDOCFLAGS="-D warnings" cargo doc --no-deps` (fails on broken intra-doc links)
   - `cargo clippy` with `clippy::missing_errors_doc`, `missing_panics_doc`, `missing_safety_doc`, and `doc_markdown` enabled
6. Never claim a check passed unless it was run. Say which were skipped. If doctests were not run, say the examples are unverified.

## Review mode

When asked to review rather than write, do not rewrite the docs unless asked. Return findings ordered by severity, each with location, issue, and suggested fix:

1. Missing or vague `# Safety`
2. Incorrect or unsupported claims (wrong errors, panics, guarantees), including doctest assertions that do not match behavior
3. Missing `# Errors` or `# Panics` for real conditions
4. Missing `# Examples` on a `pub` item that does not qualify for an exemption; examples that are bloated (>~10 lines), print instead of assert, or cover several ideas in one block
5. Wrong section order, redundant or empty sections
6. Style: summary form, argument format

If there are no findings, say so rather than inventing nitpicks.

## Before finishing

- Summary is one clear line; every sentence helps readers use or safely call the API.
- Sections are in order, with no redundant or empty ones.
- Every claim is backed by the implementation or an established contract.
- Every non-exempt `pub` item has a compact example: 1–5 lines typical, asserts rather than prints, one idea per block, hidden boilerplate.
- Examples compile and pass (`cargo test --doc` run, or stated as not run); intra-doc links resolve.
- Behavior and signatures are unchanged.
