# Definition of Done

A ticket is done when every required item below is checked.

- Items with no tag come from `docs/requirements.md`, `docs/user-stories.md`, or `config/ci.rb`.
- Items tagged _(optional)_ are guesses. The team can make them required or delete them.
- Skip an item if it does not apply to the change (for example, a docs-only change skips Functionality).
- There is no GitHub Actions workflow yet. CI runs locally with `bin/ci`.

## Functionality

- [ ] Every acceptance criterion of the linked user story works in the browser (`bin/dev`).
- [ ] A ticket has: title, description, severity (`Low`, `Medium`, `High`, `Urgent`), status (`Open`, `In Progress`, `Resolved`), creator (customer), and an optional assignee (agent).
- [ ] A new ticket has status `Open`.
- [ ] The new ticket form rejects a title under 5 characters and a description under 10 characters, and shows the error on the form.
- [ ] After a ticket is created, the user lands on the ticket detail page.
- [ ] A wrong email or password shows "Invalid email or password".
- [ ] The top navigation bar has a working log out link.
- [ ] The agent ticket list shows the columns ID, Title, Customer, Severity, Status, and Created At.
- [ ] The agent ticket list has the filters `All`, `Open`, `In Progress`, and `Resolved`.
- [ ] `High` and `Urgent` tickets look different in the agent ticket list.
- [ ] With two browser windows open, a status change by the agent shows in the customer's window with no page reload.
- [ ] With two browser windows open, a new comment appears at the bottom of the thread in both windows with no page reload, and the comment input is cleared.
- [ ] Every status change saves one audit event.
- [ ] Creating a `High` or `Urgent` ticket enqueues a background job.
- [ ] A `High` or `Urgent` ticket that is still `Open` with no assignee after 15 minutes is flagged "Overdue", and a notification line is written to the log.
- [ ] The screen has every element shown in its mockup in `docs/design/`.
- [ ] No out-of-scope feature was added: SMTP password reset, attachments, roles other than `customer` and `agent`, or a rich-text editor.

## Access Control

- [ ] A signed-out request to any ticket page redirects to sign in.
- [ ] The only roles are `customer` and `agent`.
- [ ] A customer who requests another customer's ticket is refused (404 or redirect). A test proves it.
- [ ] A customer cannot change status or assignee, even with a direct request (not only a hidden button). A test proves it.
- [ ] An agent can view, assign, and update any ticket. A test proves it.
- [ ] Live updates (status, comments) only reach users who can view that ticket.

## Code Quality

- [ ] `bin/rubocop` reports no offenses.
- [ ] `yarn build` and `yarn build:css` exit with code 0.
- [ ] `rg -n 'binding\.irb|debugger|console\.log' app` finds nothing. _(optional)_
- [ ] Each new `# rubocop:disable` has a comment that explains why. _(optional)_
- [ ] Domain names in code match `GLOSSARY.md` (created later). _(optional)_

## Testing

- [ ] `bin/rails test` passes.
- [ ] `env RAILS_ENV=test bin/rails db:seed:replant` passes.
- [ ] Each acceptance criterion in the linked story has at least one test. _(optional)_
- [ ] The overdue job has a test for the 15-minute rule, using time travel (`travel_to`). _(optional)_
- [ ] `bin/rails test:system` passes. It is commented out in `config/ci.rb` today. _(optional)_

## Security

- [ ] `bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error` passes.
- [ ] `bin/bundler-audit` passes.
- [ ] `yarn audit` passes.
- [ ] The diff has no passwords, tokens, or keys. Secrets come from ENV or `bin/rails credentials:edit`.
- [ ] `git ls-files config/master.key` prints nothing.
- [ ] Passwords are stored with `has_secure_password`: the `users` table has `password_digest` and no `password` column. _(optional)_
- [ ] New sensitive params are added to `config/initializers/filter_parameter_logging.rb`. _(optional)_
- [ ] `rg -n 'html_safe|raw\(' app/views` finds nothing new on user input (titles, descriptions, comments). _(optional)_

## Operations

- [ ] Background jobs use Solid Queue (the database queue), and `bin/jobs` runs the escalation job.
- [ ] `GET /up` returns 200.
- [ ] `bin/setup --skip-server` runs with no errors on a fresh clone.
- [ ] `bin/rails db:migrate` and then `bin/rails db:rollback` both run with no errors. _(optional)_
- [ ] `db/schema.rb` is committed and matches the migrations. _(optional)_
- [ ] `docker build .` succeeds. _(optional)_

## Documentation

- [ ] If behavior differs from `docs/requirements.md` or `docs/user-stories.md`, those files are updated in the same PR. _(optional)_
- [ ] New domain terms are added to `GLOSSARY.md` (created later). _(optional)_
- [ ] Hard-to-reverse decisions have an ADR in `docs/adr/` (created later). _(optional)_
- [ ] A new doc file is listed in `docs/README.md`. _(optional)_
- [ ] `README.md` has real setup and test steps, not the Rails stub. _(optional)_

## Delivery

- [ ] `bin/ci` passes end to end.
- [ ] The work has a GitHub issue of type `Task` (see `docs/agents/issue-tracker.md`).
- [ ] The PR description has `Closes #<issue number>`. _(optional)_
- [ ] Commit messages follow Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`). _(optional)_
- [ ] The `code-review` skill was run on the branch, and its findings are fixed or answered. _(optional)_
- [ ] The PR is merged into `main`. _(optional)_
