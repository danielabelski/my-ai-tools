---
name: "accountable-engineering"
description: "Disciplined AI-assisted engineering — own outcomes, avoid cognitive surrender, and amplify the human-agent feedback loop"
license: "MIT"
compatibility: "cline, claude, opencode, amp, codex, gemini, cursor, pi"
hint: "Use for every non-trivial AI-assisted task to stay accountable for architecture, security, and outcomes"
user-invocable: true
---

# Accountable Engineering

## Core Idea

AI increases how much software people can build. It does not remove the need for engineering judgment.

The valuable engineer is not someone who writes code fastest. They are an **accountable system builder** who:

- Understands the problem and constraints
- Uses AI effectively without surrendering judgment
- Makes and owns architectural, security, and product decisions
- Takes responsibility for correctness, deployment, and maintenance

**Source**: Addy Osmani on the future of software engineering with AI ([YouTube](https://www.youtube.com/watch?v=2fyPnxKu8ZM)).

## When to Use

Use this skill for **every non-trivial AI-assisted task**:

- New features or integrations
- Refactors with architectural impact
- Security-sensitive changes
- Production deployments and operational work
- Learning a unfamiliar part of the codebase

Skip for trivial edits (typos, comment fixes, one-line changes with obvious behavior).

## Cognitive Surrender

**Cognitive surrender** happens when you accept AI-generated solutions without understanding the important decisions behind them.

You do not need to inspect every line. You **must** understand:

- Major architectural choices
- Security and data-handling decisions
- Business logic and user-impact trade-offs
- Operational constraints (cost, reliability, monitoring)

If you cannot explain why a decision was made, you have not finished the task.

## Mutual Amplification

The goal is not faster output alone. It is a better developer-agent feedback loop:

| Agent responsibility | Developer responsibility |
| -------------------- | ------------------------ |
| Record decisions, discoveries, and lessons | Review and internalize those lessons |
| Propose approaches before coding | Challenge weak assumptions |
| Implement in small verifiable steps | Verify edge cases and failure modes |
| Document what was learned | Own deployment and maintenance |

Use `implementation-logger` and `qmd-knowledge` for durable recording. Use `quiz-me` to verify your understanding.

## The 8-Step Workflow

For every AI-assisted task, follow this sequence:

### 1. Define behavior and constraints

State expected behavior, non-goals, security boundaries, performance expectations, and verification criteria before any code is written.

### 2. Propose approach before implementation

Ask the agent to propose an approach — not code yet. Review trade-offs, risks, and alternatives.

**Companion skills**: `blindspot-pass`, `spec-interview`, `context-discovery`

### 3. Review architecture and key decisions

Approve or redirect major decisions: data flow, integration points, failure handling, rollout strategy.

Do not proceed until you can explain the approach to a teammate.

### 4. Implement in small steps

Let the agent implement incrementally. Each step should be small enough to review and test independently.

**Companion skills**: `implementation-logger`, `tdd`

### 5. Run tests and inspect edge cases

Verify happy path, failure paths, regressions, and operational concerns (logs, metrics, cost).

Never ship on "it compiled" or "the agent said it works."

### 6. Document what was learned

Capture deviations from plan, surprises, and durable lessons for future sessions.

**Companion skills**: `implementation-logger`, `qmd-knowledge`

### 7. Review the final result yourself

Read the diff. Run the app or tests yourself. Confirm behavior matches intent.

**Companion skills**: `code-review`, `code-quality-review`, `slop`

### 8. Own deployment and maintenance

Take responsibility for rollout, monitoring, rollback plan, and follow-up fixes.

**Companion skills**: `draft-pull-request`, `commit-atomic`, `pr-review`

## Senior AI Engineer Dimensions

A strong AI engineer in this environment combines:

1. **Technical depth** — RAG, agents, evaluation, deployment, observability
2. **AI leverage** — use coding agents, but verify their work
3. **Product sense** — understand who benefits and what success means
4. **Operational ownership** — reliability, cost, security, monitoring
5. **Communication** — explain trade-offs to technical and non-technical audiences

Broaden beyond "someone who writes code." Product thinking, UX judgment, and go-to-market awareness increasingly matter.

## Vibe Coding vs Disciplined Engineering

| Vibe coding | Disciplined AI-assisted engineering |
| ----------- | ----------------------------------- |
| Prompt → accept output | Define constraints → propose → review → implement |
| Skip architecture review | Understand major decisions before merging |
| Trust without verification | Test edge cases and failure modes |
| Agent owns the outcome | You own deployment and maintenance |
| No learning captured | Record lessons for the next session |

## Full Quality Pipeline

Accountable engineering wraps the discovery and review skills into one accountable loop:

```text
accountable-engineering (this skill — meta workflow)
  ├─ 1. blindspot-pass / context-discovery / spec-interview
  ├─ 2. implementation-logger (during work)
  ├─ 3. slop (pre-review cleanup)
  ├─ 4. code-review (conventions + intent)
  ├─ 5. code-quality-review (structural audit, when needed)
  ├─ 6. pr-review → commit-atomic
  └─ 7. quiz-me (verify you understand the change)
```

## Agent Instructions

When this skill is active:

1. **Propose before coding** on non-trivial tasks unless the user explicitly asks for immediate implementation.
2. **Surface decisions** — flag architectural, security, and product trade-offs explicitly.
3. **Record learnings** — log deviations and surprises; offer to persist durable notes via `qmd-knowledge`.
4. **Verify, don't claim** — run tests and show evidence; avoid "should work" language.
5. **Prompt ownership** — remind the user to review key decisions and own rollout when appropriate.

## Success Criteria

You have practiced accountable engineering when:

- You can explain every major decision in the change
- Tests and verification cover edge cases, not just the happy path
- Learnings are recorded for future sessions
- You would confidently own production issues from this change
- The outcome is better engineering, not just faster typing

## References

- [Addy Osmani — The Future of Software Engineering with AI](https://www.youtube.com/watch?v=2fyPnxKu8ZM)
- `skills/blindspot-pass/` — find unknowns before starting
- `skills/implementation-logger/` — track deviations during work
- `configs/fable-guide.md` — discovery techniques and staying in the loop
- `configs/implementation-notes-guidelines.md` — where to route durable notes
