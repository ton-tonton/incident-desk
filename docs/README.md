# Docs index for AI agents

Start here. Find your task, then read the files in that row.
Paths are relative to the repo root.

Before any code change, read [Rules](#rules) (how to read `.claude/skills/rules/`) and [Definition of Done](#definition-of-done) (how to use `docs/definition-of-done.md`).

## Task → files to read

| Task | Files to read |
| --- | --- |
| Understand the product | [docs/requirements.md](requirements.md), [docs/user-stories.md](user-stories.md) |
| Write or change any code | the matching rules in [.claude/skills/rules/](../.claude/skills/rules/) (see [Rules](#rules)) |
| Build a feature or fix a bug | [docs/user-stories.md](user-stories.md), the matching mockup in [docs/design/](design/), [tdd skill](../.agents/skills/tdd/SKILL.md), [docs/definition-of-done.md](definition-of-done.md), `GLOSSARY.md` (created later), `docs/adr/` (created later) |
| Build or change a UI screen | the matching mockup in [docs/design/](design/), [docs/design/styles.css](design/styles.css), [.claude/skills/rules/style.md](../.claude/skills/rules/style.md) |
| Work from a GitHub issue | [docs/agents/issue-tracker.md](agents/issue-tracker.md), [implement skill](../.agents/skills/implement/SKILL.md) |
| Split a plan into tickets | [docs/agents/issue-tracker.md](agents/issue-tracker.md), [to-tickets skill](../.agents/skills/to-tickets/SKILL.md) |
| Check if work is done / open a PR | [docs/definition-of-done.md](definition-of-done.md) (see [Definition of Done](#definition-of-done)) |
| Review code | [code-review skill](../.agents/skills/code-review/SKILL.md), [.claude/skills/rules/](../.claude/skills/rules/) (the coding standards), [docs/requirements.md](requirements.md) |
| Name domain terms or record a decision | [docs/agents/domain.md](agents/domain.md), [domain-modeling skill](../.agents/skills/domain-modeling/SKILL.md), `GLOSSARY.md` (created later), `docs/adr/` (created later) |
| Design or refactor a module | [codebase-design skill](../.agents/skills/codebase-design/SKILL.md) |

## Rules

Coding rules live in `.claude/skills/rules/`. They tell you how to write code.

| File | Applies to | What it covers |
| --- | --- | --- |
| [security.md](../.claude/skills/rules/security.md) | All files, always | Secrets, auth, owner scoping, escaping, broadcast auth |
| [rails.md](../.claude/skills/rules/rails.md) | `app/`, `config/`, `db/`, `test/` | Rails conventions, migrations, tests, indexes |
| [style.md](../.claude/skills/rules/style.md) | `app/`, `lib/`, `test/` | Method order, routing, jobs, naming |

How to read them:

1. Read `security.md` before any change.
2. Read every other file whose `paths:` (in the front matter at the top) matches a file you will edit.
3. No agent loads these files on its own. Open and read them yourself.
4. A rule is required. If a rule conflicts with the task, stop and ask the user. Do not break the rule quietly.

## Definition of Done

[docs/definition-of-done.md](definition-of-done.md) is the checklist a change must pass. The rules say how to write code; the Definition of Done says how to check it is finished.

How to use it:

1. **Before you start:** read it, so you know what "done" means for this change.
2. **Before you say "done" or open a PR:** go through it category by category.
3. **Items with no tag** are required. **Items tagged _(optional)_** are guesses: check them when they are cheap, or when a rule in `.claude/skills/rules/` requires them.
4. **Skip** a whole category only when it does not apply (for example, Functionality for a docs-only change). Say which ones you skipped and why.
5. **Run the command** in an item; do not tick it from memory. `bin/ci` runs most of the checks at once.
6. **Report** each item as pass, fail (with the output), or skipped (with the reason).
7. **Do not edit** the Definition of Done to make your change pass. Ask the user instead.

## Documents

| File | What it holds |
| --- | --- |
| [docs/requirements.md](requirements.md) | Roles, functional requirements, out-of-scope list |
| [docs/user-stories.md](user-stories.md) | User stories 1–6 with acceptance criteria |
| [docs/definition-of-done.md](definition-of-done.md) | Checklist a change must pass before it is done |
| [.claude/skills/rules/](../.claude/skills/rules/) | Coding rules (security, Rails, style) |
| [docs/agents/issue-tracker.md](agents/issue-tracker.md) | How to read, create, and link GitHub issues with `gh` |
| [docs/agents/domain.md](agents/domain.md) | How to use the glossary and ADRs |
| `GLOSSARY.md` | Domain terms. **Created later.** |
| `docs/adr/` | Architecture decision records. **Created later.** |

## UI mockups

Static HTML in `docs/design/`. Open in a browser. All share [styles.css](design/styles.css).

| File | Screen | Role | Story |
| --- | --- | --- | --- |
| [index.html](design/index.html) | Sign in | Both | 1 |
| [my-tickets.html](design/my-tickets.html) | My tickets list | Customer | 2 |
| [new-ticket.html](design/new-ticket.html) | New ticket form | Customer | 2 |
| [customer-ticket.html](design/customer-ticket.html) | Ticket detail + comments | Customer | 4, 5 |
| [agent-tickets.html](design/agent-tickets.html) | All tickets list with filters | Agent | 3 |
| [agent-ticket.html](design/agent-ticket.html) | Ticket detail, status, comments | Agent | 4, 5 |

## Skills

In `.agents/skills/` (linked into `.claude/skills/`).

| Skill | Use it to |
| --- | --- |
| [implement](../.agents/skills/implement/SKILL.md) | Build work from a spec or ticket (user-invoked only) |
| [tdd](../.agents/skills/tdd/SKILL.md) | Build features or fix bugs test-first |
| [code-review](../.agents/skills/code-review/SKILL.md) | Review changes against standards and the spec |
| [to-tickets](../.agents/skills/to-tickets/SKILL.md) | Break a plan into GitHub issues (user-invoked only) |
| [domain-modeling](../.agents/skills/domain-modeling/SKILL.md) | Edit `GLOSSARY.md` or write an ADR |
| [codebase-design](../.agents/skills/codebase-design/SKILL.md) | Design deep modules and seams |
