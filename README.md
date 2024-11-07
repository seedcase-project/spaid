

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
