

<!-- Don't edit README.md directly, edit README.qmd and render to Markdown via `just build-readme` -->

# spaid: Seedcase Project aid — a toolkit for developing Seedcase

## Installation

Clone this repo to somewhere on your computer. Then open a terminal in
the newly created folder and run:

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
find your `~/.zshrc`, open it in a text editor, and add this line to
that file:

``` bash
export PATH=$HOME/.local/bin:$PATH
```

Close your terminal and re-run the `echo` code above to check that it
worked.

If it worked and you now see the folder, you have installed the spaid
helper functions!

## Commands

Many commands are designed to be used with `xargs` to process multiple
commands at once. A note is given below the relevant commands for how.

``` bash
spaid_setup_precommit -h
```

Usage: spaid_setup_precommit \[-h\]

Run this command to setup pre-commit on the repository. It will:

- Install pre-commit hooks
- Do an initial run of the pre-commit hooks on all the files

This command only works if:

- you are in a local Git repository
- the repository has a file called ‘.pre-commit-config.yaml’

Examples:

    spaid_setup_precommit

``` bash
spaid_create_python_files -h
```

Usage: spaid_create_python_files \[-h\]

Run this script to create a new function file with the corresponding
test file.

Example:

    $ spaid_create_python_files seedcase_sprout core properties
    Created:
    ./seedcase_sprout/core/properties.py
    ./tests/core/test_properties.py

Positional arguments:

- module: The folder of the module you want to create the new function
  in.
- submodule: The folder of the submodule or part, e.g. core vs cli, that
  you want to create the new function in.
- name: The name of the function you want to create.

### Pull requests

``` bash
spaid_pr_list -h
```

Usage: spaid_pr_list \[-h\]

Lists all open PRs in an organization.

Examples:

    spaid_pr_list seedcase-project

Positional argument:

- org: The name of the GitHub organization.

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
spaid_gh_ruleset_list seedcase-project | xargs spaid_gh_ruleset_basic_protect_main
```

### GitHub repository management

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
spaid_gh_repo_list seedcase-project | xargs spaid_gh_set_repo_settings
```

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
- Runs ‘spaid_gh_setup_new_repo’.

Examples:

    $ spaid_gh_create_repo_from_local seedcase-project seedcase-theme 'Seedcase theme repo'

Positional arguments:

- org: The name of the GitHub organization.
- repo: The name of the repository you want created in the GitHub
  organization. Should match the folder this is run in.
- description: The description of the contents of the repository that is
  display in the repository’s listing.
