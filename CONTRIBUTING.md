# Contributing

Whether your a member of the team or anyone else, thank you for taking the time to contribute!

This document is meant to help walk you through how you can request or submit additions and changes to the codebase.
If you haven't got your workspace up and running yet, start with the [Getting Started](README.md#getting-started) section in the README.

## Table of Contents
<!--ts-->
   * [How To](#how-to)
      * [File a bug report](#file-a-bug-report)
      * [Request a feature](#request-a-feature)
      * [Work on an ticket/issue](#work-on-an-ticketissue)
      * [Submit a pull request](#submit-a-pull-request)
         * [Rebase merging](#rebase-merging)
   * [Style](#style)
      * [Code](#code)
         * [Markdown](#markdown)
         * [C++](#c)
         * [Python](#python)
         * [Other](#other)
      * [Pull requests](#pull-requests)
      * [Commits](#commits)
      * [Branch naming](#branch-naming)
   * [AI Agents](#ai-agents)
<!--te-->

## How To

### File a bug report
If something doesn't seem to be working right, 
1. Go to the [Issues tab](https://github.com/urc-uh/rover-ws/issues).
2. Click on the "New issue" button.
3. Select the "Bug report" option from the list.
4. Answer everything in the template as best you can.

You can also select "Feature request" instead of "Bug report" if you want to request some sort of additional functionality for the rover or the control interface.

### Request a feature
1. Go to the [Issues tab](https://github.com/urc-uh/rover-ws/issues).
2. Click on the "New issue" button.
3. Select the "Bug report" option from the list.
4. Answer everything in the template as best you can.

### Work on an ticket/issue
1. Go to the [current software project](https://github.com/urc-uh/projects/5).
2. Select a ticket from the "Ready" column.
    Look for one marked "good first issue" if available and it is your first time contributing, especially if you are not very comfortable in the environment.
4. Add a comment that pings `@maintainers` asking them to change the ticket status to "In progress".
    Also consider commenting about what you plan on starting with and what you might need help with and asking any implementation questions or clarifications on the acceptance criteria you may have.
4. Click the "Create a branch" link under Development on the right side.
5. Name the branch following the [style guide](#branch-naming) and create it.
6. Run `git checkout -b <local_branch_name> origin/<branch_name>` where `<branch_name>` is the branch you just created and `<local_branch_name>` is what you want the branch to be called on your machine (it's a good idea to use the same name to avoid confusion).
7. Make your changes, test them, commit them, and when you feel you have completed a logical unit of change, [submit a pull request](#submit-a-pull-request)!

You can also create a branch locally and push to remote, but make sure after pushing to remote you open the issue and link the branch under "Development".

> [!TIP]
> You do **not** have to close the issue in a single pull request.
> In fact, in most cases, it is probably better not to.
> Any time you feel you have completed a logically connected set of changes (that do not break the build or functionality) you should submit a pull request.
> Simpler pull requests are easier to review and long-lived branches that make a lot of sweeping changes before being merged back in can cause a lot of complications and delay being able to actually use your code!
> As a general rule, try to keep your pull requests small enough that you think a reviewer will be able to understand the general idea of your changes in under thirty minutes and your changes can be effectively squashed into a single commit for merging without losing important history.

### Submit a pull request

#### Rebase merging
> [!WARNING]
> This section is intended for more advanced users.
> If you aren't comfortable with git, just stick to small pull requests and use squash merging.
> Even if you are comfortable with git, you should stick to squash merges whenever possible.

If you need to submit a single pull request while still preserving history within the request, you can use rebase merging instead.
```console
$ git pull --rebase origin main  # ensure you are up to date with the main branch
$ git rebase --interactive `git merge-base main HEAD`  # interactive rebase of all commits on the current branch since main
```
Then, use `pick` to select which commits you want to keep and `squash` to move changes to the previous `pick`ed commit.
You will then be given an opportunity to combine the commit messages of any squashed commits.
If you need to edit the messages any `pick`ed commits with no `squash`ed commits below them, use `reword` instead.
If you don't need to combine the commit messages of any `squash`ed commits (for example, if the commit is just a typo fix) use `fixup` instead.
It's also a good idea to add the line `exec just verify all` after every set of commits to ensure every individual commit passes all tests.
See [here](https://gitcheatsheet.dev/docs/advanced/interactive-rebase) for more information on interactive rebases.

Once you've properly rebased your local branch, run `git log origin/main..HEAD --oneline` and check that the first lines follow [scoped commits](https://scopedcommits.com).
You should also run `git log origin/main..HEAD` and make sure the full commit messages include a detailed body.

Then, run `git push --force-with-lease` and open a pull request.
Add a comment to the pull request noting you would like to rebase and explain why you think it is necessary.

## Style
These conventions should be followed as much as possible, but none are absolutely set in stone.
If you feel a convention shouldn't apply to your work or you are confused on how to apply it, just make a note in your pull request and a maintainer will help.

### Code
Most of the code styling is enforced by formatters, linters, and analyzers via GitHub Actions during a pull request.
Using the tools specified below before committing will speed up the review process, but if you are having difficulties submit a pull request as-is and a maintainer will assist you.

#### Markdown
Use a separate line for each sentence.
This makes git diffs a lot easier to read and ensures that small changes don't end up affecting many lines of code when a paragraph is reformatted.

#### C++
- `clang-format`
- `clang-tidy`
The enforced code style more or less follows the LLVM standard with a few exceptions.
The most important thing to note is that functions, methods, and variables follow `snake_case`.

#### Python
- `ruff`
- `ty`
Google docstring conventions are followed.

#### Other
- `yamllint`

### Pull requests
Pull request titles should follow [scoped commits](https://scopedcommits.com) for squash merging.
Related issues must be included like so: `scope(#1): description`, where `#1` is the issue number.

For rebase merging, use a descriptive title that starts with a capital letter and doesn't end with a period.

### Commits
We follow [scoped commits](https://scopedcommits.com).
Following the convention on individual branches is often unnecessary as typically pull requests will use the squash strategy.
However, good commit descriptions are still always a good idea and will help with writing the pull request description.
If you use the squash strategy just make sure your pull request title follows the [Pull requests](#pull-requests) section.

If the rebase strategy is used, follow the [Rebase merging](#rebase-merging) section and make sure every remaining commit message follows [scoped commits](https://scopedcommits.com).

### Branch naming
We follow [conventional branch v1.0.0](https://conventionalbranch.org/v1.0.0).
We don't use v1.1.0 because we do not accept purely LLM-generated contributions.
Use the short versions of purpose prefixes (`feat/` and `fix/`).
We will additionally use the `ci/` prefix for branches related to continuous integration features and `docs/` for branches that will only have documentation changes.
If the branch is associated with an issue (it does not necessarily need to close the issue), include that in the branch name, for example: `feat/issue-1-add-some-feature`.

If multiple people are working on the same branch, they may add additional branches with names that end with respective team members names if they find it necessary.
For example, if Violet and Tyler are working together and want to keep their changes separate initially, they may use the branches `feat/issue-9-add-diff-drive-controller-violet` and `feat/issue-9-add-diff-drive-controller-tyler` respectively.
However, these branches should not be used for pull requests into `main`.
First, Violet and Tyler should merge their changes into `feat/issue-9-add-diff-drive-controller` then submit a pull request to merge `feat/issue-9-add-diff-drive-controller` into `main`.

## AI Agents
Purely LLM-generated pull requests are not accepted.
For now, no other hard rules are in place for LLM usage, but this is subject to change if we have problems with low quality pull requests.
If you are going to use AI, limit how much code it actually writes for you (especially in single blocks), keep pull-requests small, and don't submit any code you don't understand and you should be fine.
