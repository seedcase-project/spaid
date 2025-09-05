

- [spaid: Seedcase Project aid — a toolkit for developing
  Seedcase](#spaid-seedcase-project-aid--a-toolkit-for-developing-seedcase)
  - [Installation](#installation)
  - [Commands](#commands)
    - [Pull requests](#pull-requests)
    - [GitHub organization management (invitations,
      teams)](#github-organization-management-invitations-teams)
    - [Rulesets](#rulesets)
    - [GitHub repository management](#github-repository-management)

<!-- Don't edit README.md directly, edit README.qmd and render to Markdown via `just build-readme` -->

# spaid: Seedcase Project aid — a toolkit for developing Seedcase

## Installation

Many of these commands depend on the `gh` CLI tool, so you will need to
install that first. See the [GitHub CLI](https://cli.github.com/) for
installation instructions.

Then, while in your Terminal, `cd` to a directory you want to store this
repository and clone it with:

``` bash
gh repo clone seedcase-project/spaid
```

Then, `cd` into the newly created `spaid` folder and run:

``` bash
just install
```

After that is finished, check to make sure that the `~/.local/bin`
folder is on your execution path (so your Terminal can find the
installed commands) by running the below code, which should give the
output below:

``` bash
echo $PATH | grep -o "\.local/bin" | uniq
```

    .local/bin

Then you don’t need to do anything else. If you don’t see that folder,
find your `~/.zshrc` , open it in a text editor, and add this line to
that file:

``` bash
export PATH=$HOME/.local/bin:$PATH
```

We use [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) as
the default shell because it is the default on MacOS and is more
powerful than the default Bash shell on many Linux distributions.

Close your terminal and re-run the `echo` code above to check that it
worked. If it worked and you now see the folder, you have installed the
spaid helper functions!

## Commands

Many commands are designed to be used with `xargs` to process multiple
commands at once. A note is given below the relevant commands for how.

### Pull requests

#### `spaid_pr_list`

``` bash
spaid_pr_list -h
```

Usage: spaid_pr_list \[-h\]

Lists all open PRs in an organization.

Examples:

    spaid_pr_list seedcase-project

Positional argument:

- org: The name of the GitHub organization.

#### `spaid_pr_merge_rebase`

``` bash
spaid_pr_merge_rebase -h
```

Usage: spaid_pr_merge_rebase \[-h\]

Approve and do a merge rebase on one PRs in a single repository.
Requires admin privilege, so not everyone can use this command.

Examples:

    # Do merge rebase on (fake) PRs 1, 2, and 3.
    spaid_pr_merge_rebase seedcase-project seedcase-theme 1 2 3

Positional arguments:

- repo_spec: The GitHub repository spec, in the format of ‘owner/repo’.
- PR number: A PR number to do the merge rebase for.

#### `spaid_pr_merge_chores`

``` bash
spaid_pr_merge_chores -h
```

Usage: spaid_pr_merge_chores \[-h\]

Go through all open PRs in a GitHub organization (or optionally in only
one repo) and do a merge rebase on them if they contain the string
‘chore(sync):’ or ‘ci(pre-commit):’ in the title. Requires admin
privilege, so not everyone can use this command.

Examples:

    spaid_pr_merge_chores seedcase-project

Positional arguments:

- org: Required. The name of the GitHub organization.
- repo: Optional. The name of the repository in the GitHub organization.
  If not given, the command will run on all repositories in the
  organization.

### GitHub organization management (invitations, teams)

#### `spaid_gh_org_invite`

``` bash
spaid_gh_org_invite -h
```

Usage: spaid_gh_org_invite \[-h\]

Invite a GitHub user to a GitHub organization.

Example:

    $ spaid_gh_org_invite seedcase-project lwjohnst86

Positional arguments:

1.  organization: The GitHub organization name.
2.  username: The GitHub username of the person you want to invite.

#### `spaid_gh_teams_list`

``` bash
spaid_gh_teams_list -h
```

Usage: spaid_gh_teams_list \[-h\]

Run this script to get a list of teams (their ‘slug’, not the
human-readable name) within a specific organization.

Example:

    $ spaid_gh_list_teams seedcase-project
    admin
    developers

Positional arguments:

1.  organization: The GitHub organization name.

#### `spaid_gh_teams_invite`

``` bash
spaid_gh_teams_invite -h
```

Usage: spaid_gh_teams_invite \[-h\]

Add a GitHub user to a team in a GitHub organization.

Example:

    $ spaid_gh_teams_invite seedcase-project admin lwjohnst86

Positional arguments:

1.  organization: The GitHub organization name.
2.  team_slug: The GitHub organization team ‘slug’ name.
3.  username: The GitHub username of the person you want to invite.

### Rulesets

#### `spaid_gh_ruleset_list`

``` bash
spaid_gh_ruleset_list -h
```

Usage: spaid_gh_ruleset_list \[-h\]

Lists the rulesets of a repository.

Examples:

    spaid_gh_ruleset_list seedcase-project team

Positional argument:

- repo_spec: The GitHub repository spec, in the format of ‘owner/repo’.
- ruleset_id: Optional. The ID of the ruleset to list. If not provided,
  all rulesets will be listed. If provided, the command will return all
  the details of the ruleset.

#### `spaid_gh_ruleset_basic_protect_main`

``` bash
spaid_gh_ruleset_basic_protect_main -h
```

Usage: spaid_gh_ruleset_basic_protect_main \[-h\]

Lists all open PRs in an organization. It provides basic protection of
the main (default) branch. Organisation and repository admin can bypass
the rules. Specifically:

- Stop force pushes
- Can’t delete
- Can’t create

Examples:

    spaid_gh_ruleset_basic_protect_main seedcase-project/team

Positional argument:

- repo spec: The GitHub repository spec, in the format of ‘owner/repo’.

Can do multiple repos at once with `xargs`:

``` bash
spaid_gh_ruleset_list seedcase-project | xargs -n 1 spaid_gh_ruleset_basic_protect_main
```

#### `spaid_gh_ruleset_basic_protect_tags`

``` bash
spaid_gh_ruleset_basic_protect_tags -h
```

Usage: spaid_gh_ruleset_basic_protect_tags \[-h\]

Creates a ruleset to provide basic protection of any tags. No one can
bypass the rules, which are specifically:

- Stop force pushes
- Can’t delete
- Can’t update

Examples:

    spaid_gh_ruleset_basic_protect_tags seedcase-project/team

Positional argument:

- repo spec: The GitHub repository spec, in the format of ‘owner/repo’.

Can do multiple repos at once with `xargs`:

``` bash
spaid_gh_ruleset_list seedcase-project | xargs -n 1 spaid_gh_ruleset_basic_protect_tags
```

### GitHub repository management

#### `spaid_gh_repo_list`

``` bash
spaid_gh_repo_list -h
```

Usage: spaid_gh_repo_list \[-h\]

Run this script to get a list of repositories within a specific
organization. Outputs a repo spec in the format of ‘org/repo’ for each
repository.

Example:

    spaid_gh_repo_list seedcase-project

Positional arguments:

1.  organization: The GitHub organization name.

#### `spaid_gh_set_repo_settings`

``` bash
spaid_gh_set_repo_settings -h
```

Usage: spaid_gh_set_repo_settings \[<org>\] \[<repo>\] \[-h\]

Set up a repository with our Seedcase Project defaults. Settings used
are:

- Delete branches after they’ve been merged.
- Omit the wiki.
- Disable discussions.
- Allow PR’s to have an option to auto-merge after approval.
- Allow merge commits as well as rebase and squash merges.
- Allow PR branch updates from ‘main’.

Examples:

    $ spaid_gh_set_repo_settings seedcase-project/team

Positional arguments:

- repo spec: The GitHub repository spec, in the format of ‘owner/repo’.

Can do multiple repos at once with `xargs`:

``` bash
spaid_gh_repo_list seedcase-project | xargs -n 1 spaid_gh_set_repo_settings
```

#### `spaid_gh_create_repo_from_local`

``` bash
spaid_gh_create_repo_from_local -h
```

Usage: spaid_gh_create_repo_from_local \[<org>\] \[<repo>\]
\[<description>\] \[-h\]

Create a GitHub repository from a local (working directory) Git
repository. This function will then

- Sets the repo to public.
- Uses the working directory as the root for the local Git repository.
- Includes a description of the newly created repository.
- Pushes the local repo to the new repo.
- Disables the wiki.
- Sets the URL for the homepage following the pattern
  ‘https://REPO.ORG.org’ (assuming you use ‘.org’ as your domain ending
  and that you manage your website build via something like Netlify).

Afterwards, it’s good practice to run ‘spaid_gh_set_repo_settings’ to
set some default settings for the newly created repository.

Examples:

    $ spaid_gh_create_repo_from_local seedcase-project seedcase-theme 'Seedcase theme repo'

Positional arguments:

- org: The name of the GitHub organization.
- repo: The name of the repository you want created in the GitHub
  organization. Should match the folder this is run in.
- description: The description of the contents of the repository that is
  display in the repository’s listing.
