---
name: xerj-token-audit
description: Investigate whether xerj would actually save tokens for the current repository and the way this user works with agents, then report a measured, evidence-based verdict (adopt, adopt for specific cases, or skip). Use this skill whenever the user asks if xerj is worth using, whether it saves tokens or cost, how to use xerj in this repo, or wants to evaluate, benchmark, compare, or justify enabling xerj, even if they do not say "audit". Read-only investigation; it never changes tracked files.
---

# xerj token audit

Decide, with evidence, whether xerj reduces token usage for this repository and this user's workflow. "It does not help here" is a valid and useful result. The same tool can save a lot for one workload and nothing (or cost extra) for another, so the job is to match xerj's mechanism to where tokens are actually spent here, then measure.

## Ground rules

- Read-only. Do not create branches, worktrees, or PRs, do not edit tracked files, and do not edit the repository's agent instruction files (AGENTS.md, CLAUDE.md, TODO.md and the like). Put scratch files in an ignored local workspace such as `agent-work/` if the repo has one, otherwise a temp directory outside the repo.
- Do not assume what xerj does. Learn it from the installed skill and its own docs in step 1. Anything you could not verify is labelled "unverified".
- Never report a saving you did not measure. If tokens cannot be counted directly, say so and name the proxy you used (for example output bytes), as a proxy.
- Efficiency that loses information is not a saving. If xerj shortens, filters, caches or summarizes anything, check that decisions made from the result stay correct (failing tests, compiler errors, diff content, baseline values).
- Follow the repo's own agent rules (for example do not touch read-only directories). If an instruction file forbids something this skill suggests, the instruction file wins.

## Step 1: Learn what xerj is and what it costs

Read xerj's installed SKILL.md and run its help or version command (try `xerj --help`; if the command does not exist, find how it is installed and say so). Write a short factual profile:

- **Mechanism**: which tokens does it target? Pick all that apply: agent replies (output), tool or command output, file reads and repeated reads, context carried between turns, skill/tool descriptions, searches, or something else.
- **Invocation**: automatic hook, wrapper around commands, explicit command the agent must remember to call, or a mode the user switches on.
- **Fixed cost**: size of its skill description and any instructions loaded on every session, extra tool calls or latency it adds, state it keeps.
- **Information loss risk**: does it ever truncate, summarize, deduplicate or cache in a way that could hide something?
- **Claims**: any savings figures in its docs, and whether they come from a benchmark that resembles agent work in a repository.

If the installed docs are missing or contradictory, stop guessing: report that and list what you would need.

## Step 2: Learn how this repository and user actually spend tokens

Look at the repo and the way work is assigned, using only reads:

- Agent instruction files, task backlog, contributing docs, CI workflows, and scripts. They show the typical tasks (feature work, bug fixes, planning, review, maintenance) and the commands agents run most (build, test, lint, benchmarks, generators).
- Size of the things agents read: largest tracked files, generated files, lockfiles, snapshots, baselines, logs, vendored code. Use real sizes (`git ls-files` with sizes, `wc`), not estimates.
- Length of real command output for the common commands (run them if cheap and safe, capture to a file, and count). Verbose build, test and lint output is often the largest single sink.
- Which parts of the work are mostly code and tool calls versus prose. Savings on prose-style output matter little when most output is code or edits.

Produce a ranked list of token sinks for this repo, each with a rough size and how often it is hit. Ask the user a single short question only if a decision truly depends on something you cannot see (for example which agent or harness they use, or whether they work in long sessions).

## Step 3: Match mechanism to sinks

For every sink in step 2, say whether xerj's mechanism from step 1 applies, how much of that sink it could remove, and the risk. Also include its fixed cost from step 1 against the saving. A tool that adds a per-session overhead needs enough repeated use to pay that back. Mark each row: helps, marginal, no effect, or risky.

## Step 4: Measure

Choose two or three small, read-only tasks that represent the top sinks (for example "summarize current test failures", "find which rows in the comparison baseline fail and why", "locate and explain a function across several files"). For each task:

1. Run it without xerj and with xerj, in fresh sessions or contexts, with the same prompt, same repo state, and same model.
2. Record input tokens, output tokens, total, tool calls, and wall time, or the closest figures the harness provides. State exactly how each was obtained.
3. Repeat at least three runs per configuration if affordable, because agent runs vary. Report the range, not one number.
4. Compare answers. They must be equivalent in substance. If xerj changes the answer or hides detail, record that as a defect, not a saving.
5. Include fixed overhead in the "with xerj" total (descriptions and instructions loaded each session).

If a clean A/B is impossible (no way to disable xerj, no token counts), say what you could and could not control and downgrade confidence accordingly.

## Step 5: Report

Use this structure, in chat, concise:

1. **Verdict**: one of *adopt*, *adopt for specific cases*, *skip*, or *inconclusive*, with a one-sentence reason.
2. **What xerj does** (3-5 lines from step 1) and its fixed cost.
3. **Where tokens go here**: top sinks, ranked, with sizes.
4. **Fit table**: sink, does xerj apply, expected effect, risk.
5. **Measurements**: table of task, configuration, tokens, tool calls, runs, and whether answers matched. Say which numbers are measured and which are estimates.
6. **Recommendation**: exactly when to use it and when not to (specific commands, files, or task types), and how to enable it. If this suggests changing an agent instruction file, give the proposed wording as text and say it must be done as a separate task; do not edit the file.
7. **Caveats**: unverified claims, skipped checks, things that could change the verdict (different tasks, longer sessions, a different agent).

Keep the tone neutral. The goal is an honest answer the user can act on, not a case for or against xerj.