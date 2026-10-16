---
name: glatzel-rust-apidoc
description: Write and review concise Rust API documentation (rustdoc comments, `///`, `//!`) using Rustdoc conventions and a fixed NumPy-inspired section order. Use whenever the user asks to document, add or improve doc comments, or review documentation for Rust functions, methods, structs, enums, traits, modules, macros, constants or crates, including unsafe and numerical APIs, even if they do not say "rustdoc" or "numpydoc".
---

# Rust API Documentation

Write concise, accurate documentation for API users. Follow Rustdoc conventions and Rust terminology; borrow only the section order from NumPy. Use the shortest documentation that fully explains the public API. Add detail only when it improves correctness, safety, or usability.

## Core rules

- Write for API users, not implementers.
- Explain behavior that is not obvious from the signature.
- Document established guarantees only. Behavior that is observable but not clearly intended (iteration order, allocation strategy, incidental performance) is either omitted or stated as unspecified. Never promise it.
- Never invent performance guarantees, complexity bounds, or mathematical properties.
- Preserve existing project terminology and style unless they conflict with these rules.
- Use the section order below even if existing docs differ.
- Touch documentation only: no changes to behavior, signatures, non-doc comments, or unrelated formatting.
- Scope: document all `pub` items. Skip private items unless asked. Give `pub(crate)` items a summary and only the sections that carry real constraints.

## Section order

Fixed order. Omit sections that do not apply; never reorder the rest.

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

**Examples.** Small, executable, using the real public API, covering the primary use case.
- Include only needed imports and setup; hide boilerplate with `#` lines.
- To use `?`, end with `# Ok::<(), ErrorType>(())`.
- Use `compile_fail` to demonstrate rejected code; use `no_run` or `ignore` only when justified.
- Omit the example if it adds no value.

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

Placement: put a convention under `# Arguments` or `# Returns` when it describes a specific parameter or result; otherwise under `# Notes`. Keep it concrete and brief. Include math only when needed to use the API correctly.

## Workflow

1. Read the signature, then the implementation, tests, and related APIs as needed to establish *intended* behavior (see the unspecified-behavior rule).
2. Write the summary, then add only useful sections in order.
3. Verify names, return semantics, errors, panics, and safety obligations against the code.
4. Run checks when practical, following workspace and feature requirements:
   - `RUSTDOCFLAGS="-D warnings" cargo doc --no-deps` (fails on broken intra-doc links)
   - `cargo test --doc` (library targets only)
   - `cargo clippy` with `clippy::missing_errors_doc`, `missing_panics_doc`, `missing_safety_doc`, and `doc_markdown` enabled
5. Never claim a check passed unless it was run. Say which were skipped.

## Review mode

When asked to review rather than write, do not rewrite the docs unless asked. Return findings ordered by severity, each with location, issue, and suggested fix:

1. Missing or vague `# Safety`
2. Incorrect or unsupported claims (wrong errors, panics, guarantees)
3. Missing `# Errors` or `# Panics` for real conditions
4. Wrong section order, redundant or empty sections
5. Style: summary form, argument format, example quality

If there are no findings, say so rather than inventing nitpicks.

## Before finishing

- Summary is one clear line; every sentence helps readers use or safely call the API.
- Sections are in order, with no redundant or empty ones.
- Every claim is backed by the implementation or an established contract.
- Examples compile and intra-doc links resolve.
- Behavior and signatures are unchanged.
