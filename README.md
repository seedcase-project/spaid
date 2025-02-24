

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

``` bash
spaid_lint_commits_on_branch -h
```

Usage: spaid_lint_commits_on_branch \[-h\]

Run this command on a development Git branch to check if commit messages
follow the Conventional Commit standard. This will only work if:

- you are in a local Git repository
- the repository is a Python project managed by Poetry
- the Poetry project has commitizen installed
- you are on a branch that isn’t main

Otherwise, you’ll get an error or nothing will happen.

``` bash
spaid_setup_dev_workspace -h
```

Usage: spaid_setup_dev_workspace \[-h\]

Run this command to either setup up or update your development workspace
to have any helper packages or tools installed and configured. These are
the actions it does currently:

- Installs Python package dependencies (if in a Poetry project)
- Installs pre-commit hooks
- Runs pre-commit hooks on all the files

This command only works if:

- you are in a local Git repository
- the repository has a file called ‘.pre-commit-config.yaml’

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

Examples: \$ spaid_pr_list seedcase-project

Positional argument:

- org: The name of the GitHub organization.

``` bash
spaid_pr_merge_rebase -h
```

Usage: spaid_pr_merge_rebase \[-h\]

Do a merge rebase on multiple PRs in a single repository. Requires admin
privilege, so not everyone can use this command.

Examples:

    # Do merge rebase on (fake) PRs 1, 2, and 3.
    $ spaid_pr_merge_rebase seedcase-project seedcase-theme 1 2 3

Positional arguments:

- org: The name of the GitHub organization.
- repo: The name of the repository in the GitHub organization.
- PR number(s): One or more PR numbers to do the merge rebase for.

### GitHub organization management

``` bash
spaid_gh_org_invite -h
```


    Usage: spaid_gh_org_invite [-h]

    Invite a GitHub user to a GitHub organization.

    Example:

        $ spaid_gh_org_invite seedcase-project lwjohnst86

    Positional arguments:

    1. organization: The GitHub organization name.
    2. username: The GitHub username of the person you want to invite.

``` bash
spaid_gh_teams_list -h
```


    Usage: spaid_gh_teams_list [-h]

    Run this script to get a list of teams (their 'slug', not the human-readable
    name) within a specific organization.

    Example:

        $ spaid_gh_list_teams seedcase-project
        admin
        developers

    Positional arguments:

    1. organization: The GitHub organization name.

``` bash
spaid_gh_teams_invite -h
```


    Usage: spaid_gh_teams_invite [-h]

    Add a GitHub user to a team in a GitHub organization.

    Example:

        $ spaid_gh_teams_invite seedcase-project admin lwjohnst86

    Positional arguments:

    1. organization: The GitHub organization name.
    2. team_slug: The GitHub organization team 'slug' name.
    3. username: The GitHub username of the person you want to invite.

### GitHub repository management

``` bash
spaid_gh_set_repo_settings -h
```

    /home/luke/.local/bin/spaid_gh_set_repo_settings:3: command not found: main

    Usage: spaid_gh_set_repo_settings [<org>] [<repo>] [-h]

    Set up a repository with our Seedcase Project defaults. Settings used are:

    - Delete branches after they've been merged.
    - Omit the wiki.
    - Disable discussions.
    - Allow PR's to have an option to auto-merge after approval.
    - Allow PR's to have an option to easily update with the  branch.
    - Allow merge commits as well as rebase and squash merges.

    Examples:

        $ spaid_gh_set_repo_settings seedcase-project team

    Positional arguments:

    - org: The name of the GitHub organization.
    - repo: The name of the repository in the GitHub organization.

``` bash
spaid_gh_create_repo_from_local -h
```


    Usage: spaid_gh_create_repo_from_local [<org>] [<repo>] [<description>] [-h]

    Create a GitHub repository from a local (working directory) Git repository.
    This function will then

    - Sets the repo to public.
    - Uses the working directory as the root for the local Git repository.
    - Includes a description of the newly created repository.
    - Pushes the local repo to the new repo.
    - Disables the wiki.
    - Sets the URL for the homepage following the pattern 'https://REPO.ORG.org'
      (assuming you use '.org' as your domain ending and that you manage your
      website build via something like Netlify).
    - Runs 'spaid_gh_setup_new_repo'.

    Examples:

        $ spaid_gh_create_repo_from_local seedcase-project seedcase-theme 'Seedcase theme repo'

    Positional arguments:

    - org: The name of the GitHub organization.
    - repo: The name of the repository you want created in the GitHub organization.
      Should match the folder this is run in.
    - description: The description of the contents of the repository that is display
      in the repository's listing.
