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

## XTerm

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

## Vim colors

Twilight256.vim
- Set background colour by changing hex value and letting 256 converter generate 256 equivalent.
- `call <SID>X("Normal", "e8e8d3", "212121", "")`

Desert256.vim
- Set background colour by changing hex value and letting 256 converter generate 256 equivalent.
- `call <SID>X("Normal", "cccccc", "303030", "")`
