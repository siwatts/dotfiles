# Dotfiles and Misc.

## Github

Can use `~/.gitconfig` for settings.

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
- Open `repo/.git/config`
- Add username to repo url
    - `url = https://username@repository-url.com`

# Rebase

- Rebase onto an updated master branch
    - `git rebase master` from current location.
    - `git rebase master branchName`
    - `git rebase oldestcommit newestcommit`
- Commits applied one by one.
- If conflicts, either resolve and continue or abort:
    - `git add file`
    - `git rebase --continue`
    - `git rebase --abort`
- Interactive rebase `-i` allows reordering and squashing of commits.
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

## XTerm / URxvt

- Config in `~/.Xresources`

- After modifying, `xrdb -merge ~/.Xresources` to bring in changes, then reopen xterm.

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

## Vim

# Scripting vim:

- For simple regex use sed.
    - Convert files to unix style line endings: `sed -i 's/\r//g' *.py`

- Execute ex commands on multiple buffers at once:
    - `:argdo`
    - `:bufdo`
    - `:tabdo`
    - `:windo`

- Pass in ex commands with `-c`.
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
    - vim -e -s < script.vim file.txt
    - Outputs :print, :list, :number, :set commands to stdout. Everything else
      hidden.

# Alphabetically sort and diff example

sort_and_diff.vim:
```
windo g/^\s*$/d
windo sort
windo diffthis
```

- Call on foo_list.txt and bar_list.txt or similar:
    - `vim -O *list* -S sort_and_diff.vim`
- Call as above on every subdirectory in current directory:
    - `for D in */; do vim -O $D*list* -S script.vim; done`

# Other vim:

- Open vim on stdin contents with `-`
    - `ls -al | vim -`
    - `logfile.txt | grep 'phrase' -C5 | vim -`

# Tmux

- Attach a new tmux session to the same windows as an existing session
    - `tmux new-session -t 'original session name or number' [-s 'name']`

## Vim colors

Twilight256.vim
- Set background colour by changing hex value and letting 256 converter generate 256 equivalent.
- `call <SID>X("Normal", "e8e8d3", "212121", "")`

Desert256.vim
- Set background colour by changing hex value and letting 256 converter generate 256 equivalent.
- `call <SID>X("Normal", "cccccc", "303030", "")`
