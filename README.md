# spaid: Seedcase Project aid --- a toolkit for developing Seedcase

## Installation

Clone this repo to somewhere on your computer. Then open a terminal in
the newly created folder and run:

``` bash
just install
```

After that is finished, check to make sure that the `~/.local/bin`
folder is on your execution path (so your Terminal can find the
installed commands) by running:

``` bash
echo $PATH | grep -o "\.local/bin"
```

The output should give this:

```         
.local/bin:
```

Then you don't need to do anything else. If you don't see that folder,
find your `~/.zshrc`, open it in a text editor, and add this line to
that file:

``` bash
export PATH=$HOME/.local/bin:$PATH
```

Close your terminal and re-run the code to check that it worked.

If it worked and you now see the folder, you have installed the spaid helper functions!
