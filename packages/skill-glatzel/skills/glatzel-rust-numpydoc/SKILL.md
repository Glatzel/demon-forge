---
name: glatzel-rust-numpydoc
description: Generate and review concise, reader-friendly Rust API documentation using Rustdoc conventions and NumPy-inspired section ordering. Use when documenting or reviewing Rust functions, methods, types, traits, modules, and other APIs.
---

# Rust API Documentation

## Objective

Write concise, accurate, reader-friendly Rust documentation.

Follow Rustdoc conventions and Rust terminology while adopting NumPy-inspired section organization. Prioritize usability over completeness: document what readers need to understand and correctly use an API without unnecessary prose.

## Core rules

- Write for API users, not implementers.
- Start with a clear, concise summary sentence without a heading.
- Prefer simple language, short sentences, and precise terminology.
- Explain behavior that is not obvious from the signature.
- Document established behavior and guarantees only.
- Avoid redundant prose, unnecessary sections, and implementation details.
- Use actual Rust argument names and types.
- Preserve existing project terminology and style unless they conflict with this skill's explicit rules.
- Follow the section order defined below, even when existing documentation uses a different order.
- Do not change API behavior or signatures when only documentation is requested.

## Section order

Follow this exact order. Omit sections that do not apply, but never reorder the remaining sections.

1. Summary — required; no heading.
2. `# Arguments` — when argument semantics or constraints need explanation.
3. `# Returns` — when return-value semantics need explanation.
4. `# Errors` — when meaningful error conditions need documentation.
5. `# Panics` — when relevant panic conditions need documentation.
6. `# Safety` — mandatory for `unsafe fn`; document applicable safety contracts for other unsafe APIs.
7. `# See also` — when related APIs materially help readers.
8. `# Notes` — when important details do not fit elsewhere.
9. `# References` — when relevant external references are needed.
10. `# Examples` — when useful; always last.

The summary must always come first. Keep Rust-specific sections after `Returns` and before `See also`, `Notes`, `References`, and `Examples`.

Use only headings from this list by default. Do not add sections merely to provide more detail. Introduce another heading only when an unusual API genuinely requires it and the information cannot be expressed clearly under an existing heading.

Adapt the applicable sections to the documented item. Do not force function-oriented sections onto types, traits, or modules.

Keep documentation concise. Do not add empty sections or enumerate trivial information merely to fill a template.

## Writing guidelines

### Summary

Describe the item's purpose in one sentence.

Prefer:

```rust
/// Computes the discrete Fourier transform of the input signal.
```

Avoid:

```rust
/// This function is used to compute the discrete Fourier transform.
```

Add an introductory paragraph only when the summary alone cannot communicate essential behavior.

### Arguments

Use `# Arguments` to explain arguments whose meaning or constraints are not obvious from the signature.

- Use the exact identifiers and types from the Rust signature.
- Explain semantics, constraints, units, dimensions, or interpretation when relevant.
- Avoid repeating information already obvious from the type.
- Do not document trivial arguments merely to enumerate them.

### Returns

Explain the meaning of the return value and guarantees relevant to callers.

- For `Result<T, E>`, describe the successful result here and failure conditions under `# Errors` when needed.
- For `Option<T>`, explain what `Some` and `None` represent when their meaning is not obvious.
- Document shape, ordering, units, ownership, and other properties only when relevant.

### Errors

Use `# Errors` when callers need to understand meaningful failure conditions.

Describe when an error occurs. Link to relevant error types or variants when useful.

Do not confuse returned errors with panics.

### Panics

Use `# Panics` when the API has relevant panic conditions that callers should know about.

State the triggering conditions precisely. Do not add vague or speculative panic descriptions.

### Safety

For every `unsafe fn`, include `# Safety` and describe the obligations callers must uphold.

Address relevant requirements such as pointer validity, alignment, initialization, aliasing, lifetime, and synchronization.

For unsafe traits and implementations, document the safety invariants required of implementors when applicable.

Avoid vague statements such as "The caller must ensure that this is safe."

### See also

Use `# See also` only when links to related APIs materially help readers understand or use the current API.

Prefer valid Rustdoc intra-doc links. Do not add links merely to increase cross-reference counts.

### Notes and references

Use `# Notes` for important technical details that do not fit naturally into the preferred sections.

Use `# References` for relevant papers, standards, specifications, or authoritative algorithm descriptions.

Keep both sections short and omit them when unnecessary.

### Examples

Provide small, practical examples that demonstrate how to use the public API.

- Prefer examples that compile as Rustdoc tests.
- Use the actual public API.
- Include only necessary imports and setup.
- Demonstrate the primary use case.
- Follow the project's error-handling conventions.
- Avoid unnecessary dependencies and boilerplate.
- Omit examples when they add no meaningful value.

Use Rustdoc code-block attributes such as `no_run` or `ignore` only when justified. Prefer executable examples.

## API-specific guidance

- **Functions and methods:** explain behavior and non-obvious argument and return semantics.
- **Structs:** explain the represented concept and important invariants.
- **Fields:** document non-obvious meaning, units, and constraints.
- **Enums:** explain the overall concept and each variant.
- **Traits:** describe the abstraction and implementation requirements.
- **Type aliases:** explain their meaning when it is not self-evident.
- **Constants and statics:** explain their meaning, units, and interpretation.
- **Modules:** use `//!` for module-level documentation.
- **Macros:** explain their inputs, expansion behavior, and constraints.
- **Unsafe APIs:** document safety requirements explicitly.

Do not force the same documentation structure onto every item. Choose sections based on the API's actual semantics.

## Technical APIs

For numerical, scientific, and signal-processing APIs, document technical conventions when they affect correct use, such as:

- Input and output dimensions.
- Axis and index interpretation.
- Units and normalization.
- Frequency ordering and sign conventions.
- Boundary behavior and padding.
- Numerical precision and limitations.
- Allocation and in-place behavior.
- Algorithmic complexity, when known and useful.

Prefer concise, concrete explanations over lengthy theoretical discussions. Include mathematical details only when necessary to understand the API correctly.

Never invent performance guarantees, complexity bounds, or mathematical properties.

## Workflow

When generating or reviewing documentation:

1. Inspect the signature and relevant implementation.
2. Consult tests and related APIs when necessary to establish behavior.
3. Write the summary first.
4. Add only useful sections in the prescribed order.
5. Verify argument names, return semantics, error conditions, panic behavior, and safety requirements.
6. Check intra-doc links and example validity.
7. Keep changes focused on documentation.
8. Run relevant checks when practical, such as `cargo doc --no-deps` and `cargo test --doc`, following workspace and feature requirements.

Never claim that checks passed unless they were actually run.

## Final review

Before finishing, verify:

- The summary is clear and concise.
- Every sentence helps readers understand, use, or safely interact with the API.
- Rust terminology and signatures are correct.
- Sections follow the prescribed order.
- Unnecessary sections and redundant prose have been removed.
- Errors, panics, and safety obligations accurately reflect the API contract.
- Examples and intra-doc links are valid.
- Every claim is supported by the implementation or an established API contract.
- Existing behavior and public API signatures remain unchanged.

Default to the shortest documentation that fully explains the public API. Add detail only when it improves correctness, safety, or usability.
