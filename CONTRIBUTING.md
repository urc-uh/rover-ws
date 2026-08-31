# Contributing
Whether you're a member of the team or anyone else, thank you for taking the time to contribute!

This document is meant to help walk you through how you can request or submit additions and changes to the codebase.
If you haven't got your workspace up and running yet, start with the [Getting Started](README.md#getting-started) section in the README.

## Table of Contents
<!--ts-->
   * [How To](#how-to)
      * [File a bug report](#file-a-bug-report)
      * [Request a feature](#request-a-feature)
      * [Work on an ticket/issue](#work-on-an-ticketissue)
      * [Submit a pull request](#submit-a-pull-request)
         * [Interactive rebase](#interactive-rebase)
         * [Ensure commits pass](#ensure-commits-pass)
         * [Push to remote](#push-to-remote)
         * [Submit the pull request](#submit-the-pull-request)
   * [Style](#style)
      * [Branch naming](#branch-naming)
      * [Commits](#commits)
      * [Pull requests](#pull-requests)
   * [AI Agents](#ai-agents)
<!--te-->

## How To

### File a bug report
If something doesn't seem to be working right, 
1. Go to the [Issues tab](https://github.com/urc-uh/rover-ws/issues).
2. Click on the "New issue" button.
3. Select the "Bug report" option from the list.
4. Answer everything in the template as best you can.

### Request a feature
1. Go to the [Issues tab](https://github.com/urc-uh/rover-ws/issues).
2. Click on the "New issue" button.
3. Select the "Feature request" option from the list.
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
> You **do not** have to close the issue in a single pull request.
> In fact, in most cases, it is probably better not to.
> Any time you feel you have completed a logically connected set of changes (that do not break the build or functionality) you should submit a pull request.
> Simpler pull requests are easier to review and long-lived branches that make a lot of sweeping changes before being merged back in can cause a lot of complications and delay being able to actually use your code!
> As a general rule, try to keep your pull requests small enough that you think a reviewer will be able to understand the general idea of your changes in under thirty minutes and your changes can be effectively squashed into a single commit for merging without losing important history.

### Submit a pull request
After you've [worked on a ticket](#work-on-an-ticketissue) and have completed the issue or a logical set a changes working towards the issue (or have done some work unrelated to an issue), you'll need to submit a pull request.

The repository allows two merge strategies: squash and rebase.
Squash merge will combine all of the commits in the pull request into a single commit.
Rebase merge will add all of your commits to the `main` branch history.
Try to keep your pull requests small enough that a squash merge makes sense as a single logical addition.
Squash merges also have the benefit that you can keep a more detailed commit history visible in the pull request without polluting the `main` branch history with tons of small commits.
Rebase merges should very rarely add more than a few commits to the history.
The idea is to first and foremost have a clear, linear history in the `main` branch and include more details when necessary in pull requests and commit messages.

#### Interactive rebase
Either strategy will start the same way:
```console
$ git pull  # make sure no one has changed the remote branch
$ git push  # check github to see if any CI commits are made, and if so, `git pull` them before continuing
$ git fetch && git rebase origin/main  # ensure you are up to date with the main branch
```
Before continuing, read the warning in the [push to remote section](#push-to-remote) to check whether you should create a new branch before the interactive rebase.
If you decide you do need a new branch, run
```console
$ git switch --create prefix/new-branch-name
```
Next, you will start your interactive rebase
```console
$ git rebase --interactive origin/main
```
The file that is opened will give you some instructions on how to edit it for the interactive rebase.
The main commands you should be using are:
- `pick` to keep a commit
- `edit` to keep a commit but stop after applying it to allow you to make changes
- `reword` to keep a commit but allow you to edit the commit message
- `squash` and `fixup` to combine a commit with the last kept commit
You can also reorder and delete commits.

> [!IMPORTANT]
> At very least you should be using `fixup` on automatic commits from Github Actions.

The purpose of this step is to refactor the history to make it clear and easy to read.
This is _very important_ if you want to merge with rebase, as every commit will become part of the `main` branch history.
If you want to merge with rebase you should also be checking that every commit message follows the [commit style conventions](#commits) and has any other information that may be important included in the commit message body.
Squash merges should also follow the [commit style conventions](#commits) but failing to do so won't necessarily prevent a merge and commit message bodies won't be checked.
The commit from a squash merge comes from the pull request, so make sure the pull request title follows [our conventions](#pull-requests) and has a detailed description.

> [!NOTE]
> You can find more information about interactive rebase [here](https://gitcheatsheet.dev/docs/advanced/interactive-rebase).

> [!TIP]
> If your history is already logical and doesn't have small random fixes you can just run `git log origin/main..HEAD` (`git log --oneline origin/main..HEAD` is fine for squash merges) to make sure your history and commit messages look okay instead of doing a full interactive rebase.
> This is a good idea to do after an interactive rebase too to double check.
> **Do** still [ensure the commits pass](#ensure-commits-pass), especially for rebase merge.

#### Ensure commits pass
After completing the interactive rebase run
```console
$ git rebase --interactive origin/main --exec "colcon build"
```
This runs the command `colcon build` after each of the commits that make up the new history.
Use this to check that the workspace builds at every commit.
Rebase merges **must** build at every commit.
This step is still suggested for squash merge, but it is only required that the last commit build.
Basically, every commit that will end up in the `main` branch history must build properly.

#### Push to remote
After completing a rebase, you need to push your changes.
```console
$ git push --force-with-lease --force-if-includes
```
This will rewrite the remote history to match your local branches, with some protections that should prevent overwriting someone else's work in most cases.

> [!WARNING]
> `git push --force-with-lease --force-if-includes` is safer than `git push --force` (**NEVER** use this) and _should_ prevent overwriting someone else's work, but it still changes history and thus cannot be perfectly safe.
> From what I can find, the main concern is that if you are using an IDE (or chron job) that constantly `git fetch`es in the background you can still accidentally overwrite someone else.
> This can also happen if you `git fetch` changes to the branch and don't pull them.
> You may also cause issues for people working off the same branch.
> When in doubt, create a new branch before your interactive rebase as shown in the [interactive rebase section](#interactive-rebase).

#### Submit the pull request
Now, open your branch in the Github repo and click Contribute > Open Pull Request (or click the handy banner that typically pops up on the main page anytime you push).
Write your pull request, making sure you follow the [style guidelines](#pull-requests).
Include any detail you think may be relevant in the description.

Remember, for a squash merge your pull request title and description will become the commit message.

## Style
These conventions should be followed as much as possible, but none are absolutely set in stone.
If you feel a convention shouldn't apply to your work or you are confused on how to apply it, just make a note in your pull request and a maintainer will help.

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

### Commits
We follow [scoped commits](https://scopedcommits.com).
Capitalize the first word of the description
Keep a line width of 72 characters, with the first line under 60 characters if possible.

In the commit body explain anything that may be unclear or vague about the commit description and include any other details you think may be relevant.
Using bullet points and other formatting is encouraged.

Generally, you should only need to link to an issue in the body if you are specifying a completed Acceptance Criterion or Criteria (which you should do if applicable!).
However, if you find that you are contributing to multiple issues in what will be a single pull request (you probably shouldn't be and should submit multiple pull requests), you may want to link to the issue(s) each commit is relevant to for clarity.

### Pull requests
Pull request titles and descriptions should follow [scoped commits](https://scopedcommits.com) and the applicable [commit style guidelines](#commits).
The title should be of similar length, but the description does not have the same line width constraint.

At the end of the description, include
```markdown
Closes #1.
Contributes to #2, #3.
- [x] A completed acceptance criterion (#2)
```
for any issues your pull request fulfills acceptance criteria for.
Typically, this should only be a single issue (or no issue).
If only a single issue is listed, it does not need to be linked at the end of each listed criterion.
Don't list criteria if the pull request completes all of the criteria specified in the issue.

If you think the merge should use the rebase strategy make a note after the issue links and specify why you think the commits you are merging make sense to keep separate in the `main` branch history.

## AI Agents
Purely LLM-generated pull requests are not accepted.
For now, no other hard rules are in place for LLM usage, but this is subject to change if we have problems with low quality pull requests.
If you are going to use AI, limit how much code it actually writes for you (especially in single blocks), keep pull-requests small, and don't submit any code you don't understand and you should be fine.
