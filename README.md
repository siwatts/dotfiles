# Dotfiles and Misc.

A collection of dotfiles and configuration files / themes etc.

Some helper scripts are also included which can diff local files against
dotfiles using `vim -d`, or import settings or entire files themselves.

## Quick Start

- General [linux installation instructions and information](linux.md).
- Guide to [configuring xfce with config files](xfce4/README.md).
- Guide to [installing and configuring openbox window manager](openbox/README.md).
- Guide to [installing and configuring i3 window manager](i3wm/README.md).
- Diff all CLI workflow / environment dotfiles with [diff-all.sh](diff-all.sh).
- Diff only CLI workflow / environment dotfiles relevant to working on a remote
  server with [diff-server.sh](diff-server.sh).
- Import some colourschemes:
    - vim:
        - `mkdir -p ~/.vim/colors && cp -a vim/colors/. ~/.vim/colors`
        - `cp -a vim/custom_colors/. ~/.vim/colors`
    - xfce4-terminal:
        - `mkdir -p ~/.local/share/xfce4/terminal/colorschemes/ && cp -a terminal/xfce4-terminal/custom_colorschemes/. ~/.local/share/xfce4/terminal/colorschemes/`
    - mintty:
        - `mkdir -p ~/.mintty/themes/ && cp -a terminal/mintty/custom_themes/. ~/.mintty/themes/`

## Git

### Config

Can use `~/.gitconfig` file for these settings, or override on an individual
basis:

Identity.
- `git config --global user.email "me@email.com"`
- `git config --global user.name "username"`

Cache password.
- `git config --global credential.helper cache`
	- 15 min.
- `git config --global credential.helper "cache --timeout=3600"`
	- 3600s (1h).

Editor setup.
- `git config --global core.editor vim`
- `git config --global diff.tool vimdiff`
- `git config --global merge.tool vimdiff`
- `git config --global merge.conflictstyle diff3`
	- 3 way merge (LOCAL REMOTE and BASE).
- `git config --global mergetool.prompt false`
	- Disable prompt before opening each conflicted file for merging.

Push only current branch.
- `git config --global push.default simple`

Set username for repository.
- *Obsolete, use ssh to avoid typing user+password*
- Open `repo/.git/config`
- Add username to repo url
    - `url = https://username@repository-url.com`

Line endings.
- `git config --global core.autocrlf true`
    - Always convert to CRLF on checkout, and to LF when adding to index.
- `git config --global core.autocrlf input`
    - Convert to CRLF on checkout if Windows, else convert to LF on checkout.
    Always convert to LF when adding to index.
- `git config --global core.autocrlf false`
    - Do nothing. CRLF are added as CRLF etc.

### GitHub SSH

SSH access:

- Add ssh public key to GitHub under user settings
- Can then use ssh auth. on this device, instead of https
- Test: `ssh -T git@github.com` -> `Hi <user>! You've successfully authenticated, but GitHub does not provide shell access.`

Change existing remote 'origin' from https to ssh:

- `git remote -v`, see current remotes
- `git remote set-url origin git@github.com:user/repository.git`
    - Where repo was of form `https://github.com/user/repository`

### Rebasing

- Rebase work relative to a target commit that shares a common ancestor
commit (which can be the same as the target commit), incorporating the 
work since the divergence.
    - `git rebase master` from current location.
    - `git rebase master branchName`
    - `git rebase oldestcommit newestcommit`
- Commits applied one by one.
- If conflicts, either resolve and continue or abort:
    - `git add file`
    - `git rebase --continue`
    - `git rebase --abort`
- Interactive rebase `-i` allows reordering and squashing of commits.
    - `git rebase -i master`, all commits that have diverged from master.
    - Commits listed from oldest to newest.
        - `pick`: Keep commit unchanged.
        - `reword`: Keep commit and prompt to change commit message.
        - `edit`: Pause to amend commit.
        - `squash`: Roll commit into previous commit (ie. upwards). Prompt for a new
commit message.
        - `message`.
        - `fixup`: As squash, but exclude commit message. If only fixups then will
          automatically take the picked commit's message.
        - `exec`: Run command using shell?
- If history has branched off between current and rebase target, will only
affect commits this side of the branch point. Target always left unaffected.

### Traversing history

- The primary parent of a merge commit is the target of the merge (that had the
  second parent merged into it).

- `~`: Ancestors of commit. Will traverse back through history down primary
  parent commits.
    - `HEAD~1`, primary parent.
    - `HEAD~2`, primary parent's primary parent.

- `^`: Parents of commit. Does not traverse back in history but accesses alternate parent commits.
    - `HEAD^1`, `HEAD^2`, both merge parent commits.

- Can combine `~` and `^`.
    - `HEAD~1^1`, `HEAD~1^2`, both parent commits on a merge commit that was the
      ancestor to the current HEAD location.
    - `HEAD~1^1~2`, `HEAD~1^2~2`, each parent commit's second ancestor.

- `HEAD^^` is not `HEAD^2`, but `HEAD^1^1` (ie. `(HEAD^1)^1` or `HEAD~2`).

- `@{x}`: Previous git `reflog` locations.
    - `HEAD@{0}`, current.
    - `HEAD@{1}`, previous.

### Other Commands

- `git diff`, `git difftool`, diff of working tree from HEAD
- `git diff --cached`, diff of staged from unstaged (see what will be committed
  with `git commit`)
- Delete a branch
    - `git branch -d`, local
    - `git branch -D`, local **force delete** (lose commits left without any
      branch pointer)
    - `git push origin --delete branchname`, remote
- `git log --all --graph --pretty --decorate`, git log with some added detail
- `git status -uno`, git status without showing untracked files
- `git merge --no-ff branchname`, merge in branchname making an explicit merge
  commit and not fast-forward commit
- `gitk --all`, simple gui of git log, `--all` for all branches not just current

## XTerm / URxvt

- Config in `~/.Xresources`

- After modifying, `xrdb -merge ~/.Xresources` to bring in changes, then reopen xterm.

- Change URxvt font while running:
    - `printf '\33]50;%s\007' "8x13"`
    - `printf '\33]50;%s\007' "xft:Monospace:size=10"`

- X11 fixed fonts:
    - 5x7
    - 5x8
    - 6x9
    - 6x10
    - 6x12
    - 6x13
    - 7x13
    - 7x14
    - 8x13
    - 8x16
    - 9x15
    - 9x18
    - 10x20
    - 12x24
    - `-*-fixed-medium-r-normal-*-15-*`
    - `-*-courier-medium-r-normal-*-14-*`
    - `-adobe-*-medium-r-*-14-*-m-*`
    - `-adobe-courier-medium-r-normal-*-14-*-*-*-*-*-*-*`
    - `-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*`
    - `-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*`
    - `-*-clean-medium-r-normal-*-14-*-*-*-*-*-*-*`
    - `-*-clean-medium-r-normal-*-15-*-*-*-*-*-*-*`
    - `-*-clean-medium-r-normal-*-16-*-*-*-*-*-*-*`
    - `-*-lucidatypewriter-medium-r-normal-*-14-*-*-*-*-*-*-*`

## Mintty

- Themes location `~/.mintty/themes/`

- Config location `~/.minttyrc`

- Keyboard shortcuts
    - Paste: `Shift+Insert`
    - Copy: `Ctrl+Insert`
    - Font size: `Ctrl+-`, `Ctrl++`

## Redshift

- Config location `~/.config/redshift.conf`

## Cygwin

To connect to a running XWin Server with a separately invoked cygwin terminal, add to cygwin local
`.bashrc`.

- `export DISPLAY=:0`

Start Cygwin/X XWin Server followed by a cygwin terminal in cmder by creating Task:
```
C:\cygwin64\bin\run.exe --quote /usr/bin/bash.exe -l -c "cd; exec /usr/bin/startxwin"

set CHERE_INVOKING=1 & %ConEmuDrive%\cygwin64\bin\bash.exe --login -i
-new_console:C:"%ConEmuDrive%\cygwin64\Cygwin.ico"
```

## Fonts

- `.ttf`, `.otf` into font location, then rebuild font cache.
- Local user installation:
    - `~/.fonts`
    - `fc-cache`
- System wide installation:
    - `/usr/share/fonts/opentype`
    - `/usr/share/fonts/truetype`
    - `sudo fc-cache`
- Fonts can be placed anywhere in these folders, typically make a top level
  directory for the font name.
- For `Source Code Pro`, opentype only does nothing, adding truetype works.
    - Just truetype alone may be enough?

## Vim

### Scripting vim

- For simple regex use sed.
    - Convert files to unix style line endings: `sed -i 's/\r//g' *.py`

- Execute ex commands on multiple buffers at once:
    - `:bufdo %s/one/two/ge|write`
    - `:tabdo %s/one/two/ge`
    - `:windo`
    - `:argdo`

- Pass in ex commands with `-c`, or `+`.
    - `vim file.txt +200`, go to line 200
    - `vim file.txt +sort`
    - Vim remains open and interactive if file not closed by end of script.
    - `vim -c "g/^\s*$/d" file.txt`
    - `vim -O *list.txt -c "windo sort"`

- Pass in script containing ex commands with `-S`.
    - Vim remains open and interactive if file not closed by end of script.
    - `vim myfile.c -S script.vim`
    - Same as `:source script.vim`

- Pass in script containing normal commands with `-s`.
    - Vim remains open and interactive if file not closed by end of script.
    - `vim myfile.c -s script.vim`
    - Same as `:source! script.vim`

- Run batch jobs containing ex commands with `-e -s`, this is not the same `-s`
as above, but 'silent mode'. Didn't leave vim open interactively when script
completed without exiting (contradicting vim docs?).
    - `vim -e -s < script.vim file.txt`
    - Outputs `:print`, `:list`, `:number`, `:set` commands to stdout.
    Everything else hidden.

### Example: Alphabetically sort and diff

sort_and_diff.vim:
```
windo g/^\s*$/d
windo sort
windo diffthis
```

- Call on foo_list.txt and bar_list.txt or similar:
    - `vim -O *list* -S sort_and_diff.vim`
- Call as above on every subdirectory in current directory, one by one:
    - `for D in */; do vim -O $D*list* -S script.vim; done`

### Vim Diff

- `vim -d`, `vimdiff`, Enter vimdiff mode
- `:diffthis`, Enable diff mode for one buffer
- `:diffoff`, Disable diff mode for one buffer
- `]c`, Jump to next change
- `[c`, Jump to previous change
- `do`, Diff obtain (take change from other buffer for change under cursor)
- `dp`, Diff put (put this change onto other buffer for change under cursor)

### Other Vim

- Open vim on stdin contents with `-` (add `-R` to use as readonly pager and not
  be prompted to save)
    - `ls -al | vim -`
    - `logfile.txt | grep 'phrase' -C5 | vim -`
    - `diff -r dir1/ dir2/ | vim -R -`, `:set syntax=diff`
- `:g/match/d`
- `:g/match/s$dir/file$dir/newfilename$ge`
- `:g/match/norm 0f=lC 0;`
- `:g/match/m$`
- `:%sort n`
    - Sort lines numerically
- `:%sort u`
    - Keep unique lines only
- `:%s/foo/bar/ge`
    - `e` to not error when no match found, good for `:tabdo` `:bufdo` macros
      and `-s` scripting etc.
- `gq` + motion (or on visual selection)
    - Format paragraph according to text rules (eg. textwidth)
- `=` + motion (or on visual selection)
    - Format text according to programming language rules (eg. indentation)
- Folds:
    - Enable folding by language
        - `set foldmethod=syntax`
    - Or create them manually
        - `set foldmethod=manual` (the default unless overridden using `.vimrc`?)
        - `zf<motion>`, create new fold from here to motion destination
        - `zd`, delete fold under cursor
        - `zD`, recursively delete folds under cursor
    - Opening and closing folds
        - `zr`, open folds one level
        - `zR`, open all folds
        - `zm`, make folds one level
        - `zM`, make all folds
        - `:%foldc`, make/close folds one level from outside (e.g. all methods)
        - `zc`, close fold at cursor
        - `zo`, open fold at cursor
        - `za`, toggle fold at cursor
- Navigating
    - `^w T`, send buffer to new tab
- Autocompletion
    - `^n`, `^p`, next, previous match
    - `^x^f`, filepath completion
- Tags
    - Make ctags recursively at root of C/C++ project
        - `ctags -R .`, makes a `tags` file.
    - Follow tag
        - `Ctrl+]`
        - `Ctrl+w Ctrl+]`, open in split window
        - `Ctrl+w }`, in preview split
        - `Ctrl+t`, jump back
- External command into doc
    - `:r! pwd`, execute command `pwd` and insert below current line
    - `'<,'>! pwd`, replace selected lines with external command output
- Go to file under cursor
    - `gf`, open in the same window ("goto file")
    - `^w f`, open in a new window
    - `^w gf`, open in a new tab
- Jumplist:
    - `^o`, jump back in jumplist (movement commands)
    - `^i`, jump forward in jumplist
    - `g;`, jump back in changelist
    - `g,`, jump forward in changelist
- VimGrep, grep from within vim
    - `:vimgrep`, `:vim "searchterm" src/**`, search for 'searchterm' in `src/` directory
      recursively
    - *Opens quickfix list of results*
- Make, make from within vim
    - `:make`, or from bash `$ vim +make`
    - *Opens quickfix list of warnings/errors*
- Quickfix list navigation
    - `:copen`, Open quickfix list
    - `:cclose`, Open quickfix list
    - `:cn`, `]q`, Go to next result
    - `:cp`, `[q`, Go to previous result
    - `:.cc`, Go to quickfix result under cursor
- Buffer navigation
    - `:bn`, `]b`, Go to next buffer
    - `:bp`, `[b`, Go to previous buffer
    - `:bd`, Delete buffer (close file)
    - `:ls`, List all buffers
- Integrated terminal
    - `:!echo Hello`, one off command
    - `:sh`, Open new shell session, vim to background, vim resumes on shell
      close
    - `:term`, Integrated terminal (certain neovim + vim versions)
        - In Neovim: Replaces current buffer with a terminal buffer in normal
          mode
        - In Vim: Opens split below current buffer with a terminal buffer in
          insert mode
        - `^\ ^n`, Neovim & Vim: Default command to return to normal mode
          (mapped to ESC by my `.vimrc`).
        - `^w N`, Vim: Return to normal mode
        - `^w :`, Vim: Open ex command bar, while in INSERT mode in terminal
          without leaving INSERT mode
            - Other `^w` commands also work, eg. leave open terminal under code
              and move up to code buffer with `^w k`
- `:cq`, quit with error code

### Window splits

By default when a new split is opened or closed, vim resizes all splits to have
equal dimensions. To stop this and set a more tmux like behaviour (split only
current window dimensions and on close give space back to upper/left window)
turn 'equalalways' ('ea') off:
- `set equalalways!`

Alternatively, restrict it with `eadirection`. Default is `both`.
- `ver` will only equalise heights of windows. Ie. set the widths of splits as
  desired then horizontally split them and the heights of the splits will be
  equalised.
- `hor` for constant heights, equalising widths of splits.

Manipulating windows:
- `C-w [N]_`, set height of window to N (default maximum).
- `C-w [N]|`, set width of window to N (default maximum).
- `C-w [N]-`, `+`, change height of window (default 1).
- `C-w [N]<`, `>`, change width of window (default 1).
- `C-w =`, equalise all windows, all directions.
- `C-w H`, `J`, `K`, `L`, move current window to that screen edge and split all
  windows in that direction. (ie. `H` make this window the leftmost split in a
  set of vertical splits).
- `C-w r`, `C-r`, rotate window splits. Only works within single column/row. `R`
  to reverse direction.
- `C-w x`, `C-x`, exchange current window with next. Only works within single
  column/row.
- `C-w T`, move current window to another tab.
- `C-w o`, show `:only` the current window, closing all others

## Tmux

- Attach a new tmux session to the same windows as an existing session
    - `tmux new-session -t 'original session name or number' [-s 'name']`

## Screen

- `screen -r`, reattach to running session
- Prefix: `^a`
- Hack to get colours in a pane: `export TERM=xterm-256color`

Inside session, prefix followed by:
- `d`: Detatch
- `c`: Create new windwo
- `0-9`: Change to window:
- `n`: Next
- `k`: Kill
- `A`: Change window title
- `?`: Command options

## Misc. Linux

Linux command expansion
- `mv dir1/filename-{old,new}` executes `mv dir1/filename-old dir1/filename-new`
- `echo dir1/file{11,12,13}` executes `echo dir1/file11 dir1/file12 dir1/file13`

Edit current bash command in default editor
- `^x ^e`, open for editing
    - **WARNING**: Will execute all commands instantly on save-close
    - **WARNING**: On close without saving *will run original command as it
      looked before editor was opened for editing, and not cancel*.

Use less as a better tail
- `less -RX +F mylogfile.txt`
    - `^c` to interrupt follow
    - `F` to reapply follow
- `command &> file & less -RX +F file`

Grep for all matches recursively.
- `grep -irn "search string"`
- `grep -irn "search string" directory/ --include="*.c"`

Pipe color to less.
- `grep --color=always "foo" file.c | less -R`

Diff recursively on directories, with colours (by piping into vim).
- `diff -r dir1/ dir2/ | vim -R -`
    - If vim doesn't auto-detect the diff output: `:set syntax=diff`

Find all files matching pattern recursively.
- `find directory/ -name "*.c"`
- `find directory/ -name "*.c" -type f`
- `find directory/ -name "*.c" -not -name "keepme*" -type f`
- `find directory/ -name "*.c" -not -name "keepme*" -type f -delete`

Use find to execute arbitrary commands.
- `find . -name "*.c" -exec echo {} \;`
    - executes `echo one.c; echo two.c; echo three.c`
- `find . -name "*.c" -exec echo {} +`
    - executes `echo one.c two.c three.c`

Rename files according to a pattern.
- ``for f in *.txt; do mv "$f" "`echo $f | sed s/txt/csv/`"; done``

Tar and zip
- `tar czf mytar.tar.gz dir1/ dir2/ file1 ...`
- `tar xzf mytar.tar.gz`
- `tar xzf mytar.tar.gz -C outputdir/`
- `zip -r name.zip *.png`
- `unzip name.zip`
- `unzip name.zip -d outputdir/`
- Vim can open compressed tarballs and zip files to explore them and open files
  inside them readonly

Filespace
- `du -sh`, used
- `du -h --max-depth=1`
- `df -h`, free

Rsync
- `rsync -avP sourcedir/ targetdir/ --dry-run`, Copy recursively the *contents*,
  archive mode (preserve perms. etc.), of `sourcedir/` into `targetdir/`.
  Verbose. Partial/progress indicator
- `rsync -avP sourcedir targetdir/ --dry-run`, As above, but the entire
  directory and contents
- `--delete`, delete any file at destination not present at source
    - Useful for creating and updating an exact mirror of one dir. at another
      location
- `--exclude`, don't send matches, e.g. specific files or patterns like
  '*.tar.gz'

### Python Scripts

Quick and easy standalone python executables

Shebang:
```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
```

Only execute when directly executed as a script or with `python -m`

```python
if __name__ == "__main__":
    # execute only if run as a script
    do_stuff()
```

### Bash Scripts

Shebang:
- `#!/bin/bash`

Redirecting output
- `cmd &> /dev/null`, throw away stdout and stderr (`> /dev/null 2>&1`)
- `cmd > file`, stdout to file, overwrites (`1>`)
- `cmd 2> file`, stderr
- `cmd 1> output 2> error`
- `cmd >> file`, append to existing file

Colours in bash scripts
- `tput setaf 1`, red
- `tput setaf 1; tput bold`, bold / bright red
- `tput sgr0`, clear

Get location of bash script
- `cd "$(dirname "$(readlink -f "$0")")"`
- `cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"`, even if softlinked
  (location of original source linked file)

Does a file exist
```bash
if [ ! -f "$fname" ]; then
    touch "$fname"
fi
```

Input argument parsing
```bash
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "ERROR: Please give two arguments {arg1} {arg2}"
    exit 1
fi
```

Interactive input
```bash
read -p 'Please enter myvar: ' MYVAR
if [[ -z "$MYVAR" ]]; then
    # Also catches whitespace
    echo "Error: Cannot be blank."
    exit 1
fi
```

User prompt y/[N]?
```bash
read -r -p 'Ask user a question? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Doing the thing..."
        THING='yes'
        ;;
    *)
        ;;
esac

read -r -p 'PRESS ENTER TO CONTINUE...' response
```

Capture return code of a previous command
```bash
successfulcommand
retVal=$?
if [ $retVal -eq 0 ]; then
    echo "SUCCESS"
fi

unsuccessfulcommand
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "FAIL"
fi
```

Get the datetime
- `"$(date)"`, generic
- `"$(date '+%d/%m/%Y %H:%M:%S')"`, arbitrary formatting

## Vim colors

Twilight256.vim
- Set background colour by changing hex value and letting 256 converter generate 256 equivalent.
    - `call <SID>X("Normal", "e8e8d3", "212121", "")`
- Function group to lilac like GUI twilight.vim (ctermfg=139):
    - `call <SID>X("Function", "a999ac", "", "")`
- More legible comment colour (ctermfg=245 / #8a8a8a):
    - `call <SID>X("Comment", "949494", "", "")`
- Constant from wombat256mod.vim or twilight.vim (both ctermfg=173):
    - `call <SID>X("Constant", "e5786d", "", "")`
    - `call <SID>X("Constant", "d08356", "", "")`
- Uncomment `FoldColumn` and `Folded` for gui.
- Remove bold in gui by adding `none` to `Statement` and `Type`.
- Nicer looking parentheses matching:
    - `call <SID>X("MatchParen", "", "000000", "reverse")`

Desert256.vim
- Set background colour by changing hex value and letting 256 converter generate 256 equivalent.
    - `call <SID>X("Normal", "ffffff", "3a3a3a", "")`
        - Results in bg #303030 (cterm 236). Closest match to gvim desert.vim (#ffffff, #333333).
- NonText transparent to match altered background.
    - `call <SID>X("NonText", "addbe7", "", "bold")`
- Brighter PreProc / Title group (210).
    - `call <SID>X("PreProc", "ff8787", "", "")`
    - `call <SID>X("Title", "ff8787", "", "")`

Dracula.vim
- Add Special and Character group highlighting:
    - `hi Special ctermfg=215 ctermbg=NONE cterm=NONE guifg=#ffb86c guibg=NONE gui=NONE`
    - `hi Character ctermfg=215 ctermbg=NONE cterm=NONE guifg=#ffb86c guibg=NONE gui=NONE`
- Clearer terminal comment & line number colour:
    - `let s:comment   = ['#6272A4', 103]`, (#8787af).
- "Subtle" grouping that works on lighter background (original comment color):
    - `let s:subtle    = ['#424450', 61]`
- Visual selection colour that works on dark or lighter background:
    - `let s:selection = ['#44475A', 53]`, purple (#5f005f).
    - `let s:selection = ['#44475A', 19]` Base16 selection, is also blue for
      non-base16 (#0000af).

Gruvbox.vim
- Add additional `white` and `solarized` light contrast settings:
    - `let s:gb.light0_white = ['#eeeeee', 255]     " Almost white`
    - `let s:gb.light0_white = ['#ffffff', 231]     " White`
    - `let s:gb.light0_solarized = ['#fdf6e3', 230] " Solarized hex`
- Apply them:
```
elseif g:gruvbox_contrast_light == 'white'
  let s:bg0  = s:gb.light0_white
elseif g:gruvbox_contrast_light == 'solarized'
  let s:bg0  = s:gb.light0_solarized
```

Zenburn.vim
- Brighter string highlighting group:
    - 'Identifier' group from Seoul256.vim.
    - `hi String          guifg=#ffbfbd                              ctermfg=217`

Hybrid.vim
- Distinguishable light 256 comments:
    - Red: `let s:palette.cterm.comment    = { 'dark' : s:cterm_comment    , 'light'      : "160" }`
    - Grey: `let s:palette.cterm.comment    = { 'dark' : s:cterm_comment    , 'light'      : "102" }`
    - Steel: `let s:palette.cterm.comment    = { 'dark' : s:cterm_comment    , 'light'      : "103" }`
    - Green: `let s:palette.cterm.comment    = { 'dark' : s:cterm_comment    , 'light'      : "34" }`
    - Blue: `let s:palette.cterm.comment    = { 'dark' : s:cterm_comment    , 'light'      : "32" }`
- StatusLineNC and LineNr work better with comment colour changes:
    - `exe "hi! StatusLineNC"  .s:fg_window      .s:bg_background  .s:fmt_revr`
    - `exe "hi! LineNr"        .s:fg_comment     .s:bg_none        .s:fmt_none`

### Useful Vimdiff highlighting

Lots of vim colorschemes come without useful diff highlighting for some reason.
DiffChange is the lines that have been modified, DiffText is the actual
differing content within those lines.

Default 16 colour terminal diff:
```
hi DiffAdd      ctermfg=NONE    ctermbg=1   cterm=NONE  term=bold
hi DiffDelete   ctermfg=4       ctermbg=6   cterm=bold  term=bold
hi DiffChange   ctermfg=NONE    ctermbg=5   cterm=NONE  term=bold
hi DiffText     ctermfg=NONE    ctermbg=1   cterm=bold  term=reverse
```

jellybeans:
```
call s:X("DiffAdd","D2EBBE","437019","","White","DarkGreen")
call s:X("DiffDelete","40000A","700009","","DarkRed","DarkRed")
call s:X("DiffChange","","2B5B77","","White","DarkBlue")
call s:X("DiffText","8fbfdc","000000","reverse","Yellow","")
```
```
hi DiffAdd      guifg=#D2EBBE   guibg=#437019   ctermfg=193     ctermbg=22  gui=NONE    cterm=NONE
hi DiffDelete   guifg=#40000A   guibg=#700009   ctermfg=16      ctermbg=52  gui=NONE    cterm=NONE
hi DiffChange   guifg=NONE      guibg=#2B5B77   ctermfg=NONE    ctermbg=24  gui=NONE    cterm=NONE
hi DiffText     guifg=#8fbfdc   guibg=#000000   ctermfg=81      ctermbg=16  gui=reverse cterm=reverse
```

jellybeans, but white DiffChange text for legibility:
```
call s:X("DiffAdd","D2EBBE","437019","","White","DarkGreen")
call s:X("DiffDelete","40000A","700009","","DarkRed","DarkRed")
call s:X("DiffChange","FFFFFF","2B5B77","","White","DarkBlue")
call s:X("DiffText","8fbfdc","000000","reverse","Yellow","")
```
```
hi DiffAdd      guifg=#D2EBBE   guibg=#437019   ctermfg=193     ctermbg=22  gui=NONE    cterm=NONE
hi DiffDelete   guifg=#40000A   guibg=#700009   ctermfg=16      ctermbg=52  gui=NONE    cterm=NONE
hi DiffChange   guifg=#FFFFFF   guibg=#2B5B77   ctermfg=231     ctermbg=24  gui=NONE    cterm=NONE
hi DiffText     guifg=#8fbfdc   guibg=#000000   ctermfg=81      ctermbg=16  gui=reverse cterm=reverse
```

wombat256mod:
```
hi DiffAdd      ctermfg=NONE ctermbg=17  cterm=NONE  guifg=NONE      guibg=#2a0d6a   gui=NONE
hi DiffDelete   ctermfg=234  ctermbg=60  cterm=NONE  guifg=#242424   guibg=#3e3969   gui=NONE
hi DiffText     ctermfg=NONE ctermbg=53  cterm=NONE  guifg=NONE      guibg=#73186e   gui=NONE
hi DiffChange   ctermfg=NONE ctermbg=237 cterm=NONE  guifg=NONE      guibg=#382a37   gui=NONE
```

## Pycharm

- Import existing settings (including some imported colourschemes) under File,
  Import Settings.
- Import `.icls` colourschemes by making directory `~/.pycharm/config/colors/`
  and placing here? Or import colourscheme within the File, Settings, Editor,
  Color Scheme menu? (Test this)
- Some colourschemes (`.jar` or `.jar.zip` usually) must be imported by going
  File, Import Settings, instead of the Color Scheme import method.

## SSH

### SSH Config

An ssh config file allows for defining hosts and making easier connections with
`scp` and any ssh capable program.

`~/.ssh/config`:

```yaml
Host hostname
    HostName 255.255.255.255
    User username
    Port 22
```

The above config file allows `ssh username@255.255.255.255` to be replaced with
`ssh hostname`, as well as enabling commands like `scp file hostname:/dir/file`

### SSH Setup

Do this as the desired user on local system, or `chown` to them if making as
root

```bash
cd /home/user
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
# If made as root, chown to user
chown -R user:group .ssh
# Copy remote user public key
cat [...]/other-user/.ssh/id_rsa.pub >> .ssh/authorized_keys
```

Generate private/public key pair

```bash
ssh-keygen
ssh-copy-id -i .ssh/id_rsa # Test this, docs say to give the private key path even though public is sent
```

**TODO:** How to disable password login and test

### Text Editors over SSH

Use `hostname` from ssh config file, or replace with `IP:port`

Browse ssh files/directories through vim session (directories require trailing
slash):

- `:e scp://[user@]hostname/`
- `:e scp://[user@]hostname/.vimrc`
- `:e scp://[user@]hostname/Documents/`
- `:e scp://[user@]hostname//home/user/Documents/`

Browse directory over ssh using thunar:

- `sftp://[user@]hostname/`

Browse ssh files/directories through emacs

- `:e /ssh:[user@]host:filename`
- `:e /ssh:[user@]host:Documents`
- `:e /ssh:[user@]host:/home/user/Documents`

