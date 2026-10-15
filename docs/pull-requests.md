# Pull Request Guidelines

A good PR lets a reviewer understand the change and decide "merge or not" fast.
Write for a reviewer who has not read the issue and has not seen your branch.

The template is in [.github/pull_request_template.md](../.github/pull_request_template.md). GitHub fills it in when you open a PR. [PR #12](https://github.com/BananaCoding/incident-desk/pull/12) is a good example.

## Before you open a PR

- **One PR, one purpose.** A PR closes one issue or does one thing. Put refactors, renames, and tooling changes in their own PR.
- **Keep it small.** Aim for under about 400 changed lines of app code. If it is bigger, split it, or explain in **Risks / Notes** why it cannot be split.
- **If unrelated commits must ride along,** keep them in separate commits and list them in **Risks / Notes**.
- **Read your own diff first.** Remove debug code, commented-out code, and changes you did not mean to make.
- **Run `bin/ci`** and go through [docs/definition-of-done.md](definition-of-done.md).
- **Open a draft PR** if you want early feedback. Mark it ready only when the checks above are done.

## Title

- Say what the PR does, in plain words: `Sign in and log out with email and password`.
- Use the imperative mood ("Add", "Fix", "Remove"), not "Added" or "Adds".
- Keep it under about 70 characters.
- Describe the result, not the work: `Show overdue tickets in the agent list`, not `Update tickets controller and view`.
- Do not use only an issue number or `WIP` as the title. Use a draft PR instead of `WIP`.

## Description

Fill in every section of the template. Keep each one short.

### Summary

- 1–3 sentences.
- Say what is different for the user or developer after the merge.

### What Changed

- Use bullets, most important change first.
- Group by behavior ("Every page needs sign-in"), not by file ("Changed `application_controller.rb`").
- Start each bullet with a short **bold label**, so a reviewer can scan.
- Do not repeat what the diff already shows. Explain what the diff does not: the effect and the reason.
- Call out changes that touch many places: the base controller, the shared layout, config, or the database schema.
- When a flow is hard to follow from the code, add a small text diagram.

### Why

- Explain the problem this solves.
- Link the issue with `Closes #<number>`, so GitHub closes it on merge.
- Name any choice a reviewer might question, and why you made it. Example: "Password reset is out of scope in `docs/requirements.md`, so it is not included."
- For hard-to-reverse decisions, link the ADR in `docs/adr/`.

### Test Plan

A reviewer should be able to check your work without asking you.

- **Paste real results.** Write the `bin/ci` result and test counts, not "tests pass".
- **List new tests by behavior.** Name the file, then say what each test proves.
- **Write manual steps** as a numbered list. Each step says what to do and what the reviewer should see.
- **Include the setup a reviewer needs**: migrations, seeds, env vars.
- **Say what you did not test, and why.** Example: "System tests not run: they are off in `config/ci.rb`."
- For UI changes, add a screenshot or a short screen recording.

### Risks / Notes

This is the section reviewers need most. Check each item below and keep the ones that apply:

- **Breaking change or wide impact**: what other code or users does it affect?
- **Database**: new migrations, data changes, and whether rollback is safe.
- **Access control or security**: who can now see or do what.
- **New dependency**: name it and say why it is needed.
- **New env var or config**: name it, say if it is required, and what happens if it is missing.
- **Outside service**: any new call to a service outside the app.
- **Known gap or failing check**: say what fails, why, and whether `main` fails the same way.
- **Unrelated commits**: list them with their hashes.
- **Easy to undo?** Say if a revert is safe, and any steps it needs.

If nothing applies, write **"None."** Do not leave the section empty: an empty section looks like you forgot to check.

## What to leave out

- Long stories about how you worked on the change. Write the result, not the journey.
- Full logs or stack traces. Paste only the lines that matter.
- Passwords, tokens, keys, or real customer data, including in screenshots and logs. Use placeholders like `<pw>`. If a secret was ever committed, rotate it and remove it from the git history before you open the PR.

## During review

- Answer every comment: fix it, or explain why not.
- Push fixes as new commits, so reviewers can see what changed since their last review.
- If the change grows or the plan changes, update the PR description so it stays true.
