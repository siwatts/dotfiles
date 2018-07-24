# Dotfiles and Misc.

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

## Xfce4-terminal

- Themes location `~/.local/share/xfce4/terminal/colorschemes/`

- Config location `~/.config/xfce4/terminal/terminalrc`

- `xfce4-terminal --drop-down`, quake style dropdown terminal

- New tab: `Ctrl+T`

- Next/prev tab: `Ctrl+PgDn/PgUp`

## Mintty

- Themes location `~/.mintty/themes/`

- Config location `~/.minttyrc`

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

### Scripting vim

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

### Other vim

- Open vim on stdin contents with `-`
    - `ls -al | vim -`
    - `logfile.txt | grep 'phrase' -C5 | vim -`

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

## Tmux

- Attach a new tmux session to the same windows as an existing session
    - `tmux new-session -t 'original session name or number' [-s 'name']`

## Fedora

Adding a DNF / copr repository:
- `dnf config-manager --add-repo <repository_url>`
    - where `<repository_url>` is the path to a `.repo` file.

DNF configuration files live in `/etc/yum.repos.d/`
    - List all enabled: `dnf repolist`
    - Disable: `dnf config-manager --set-disabled <repoid>`
    - Disable copr: `dnf copr disable <name/project>`
    - Can manually set `enabled=0` in `.repo` file

## Misc. Linux

Grep for all matches recursively.
- `grep -irn "search string" directory/ --include="*.c"`

Pipe color to less.
- `grep --color=always "foo" file.c | less -R`

Find all files matching pattern recursively.
- `find directory/ -name "*.c"`
- `find directory/ -name "*.c" -type f`
- `find directory/ -name "*.c" -not -name "keepme*" -type f`
- `find directory/ -name "*.c" -not -name "keepme*" -type f -delete`

Rename files according to a pattern.
- ``for f in *.txt; do mv "$f" "`echo $f | sed s/txt/csv/`"; done``

Shebangs
- `#!/bin/bash`
- `#!/usr/bin/env python`

Fix X11 screentearing on AMD Radeon: `sudo vim /usr/share/X11/xorg.conf.d/20-radeon.conf`
```
Section "Device"
    Identifier "Radeon"
    Driver "radeon"
    Option "TearFree" "on"
EndSection
```

Fix X11 screentearing on Intel integrated graphics: `sudo vim /etc/X11/xorg.conf`
```
Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "AccelMethod" "sna"
    Option "TearFree" "true"
EndSection
```

Fix flashing backlight (Ubuntu 18.04 Thinkpad T420):
- `sudo vim /etc/default/grub`
- Line `GRUB_CMDLINE_LINUX_DEFAULT`, append ` acpi_backlight=native`. Eg.
    - `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=native"`

### XFCE

Keep `xfce4-panel` behind full screen applications.
Do this automatically using [panel_to_desktop.sh](bin/panel_to_desktop.sh):
- `sudo dnf install -y wmctrl`
- `wmctrl -l | grep "xfce4-panel$"`
- `wmctrl -i -r <hexadecimal ID> -b add,below`

Change xfce appearance theme with bash:
- `xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Darker-solid"`
- Set xfce theme depending on time of day using crontab and shell scripts in
  [misc/set_theme](misc/set_theme):
    - Copy `.sh` scripts to `~/bin`
    - Append `crontab.txt` contents using `crontab -e`

- Display volume percentage in panel:
    - `xfce4-genmon-plugin`
    - [print_vol.sh](bin/print_vol.sh).

- Change volume with keyboard. `Keyboard`, `Application Shortcuts`:
    - `pactl set-sink-volume 0 +5%`
    - `pactl set-sink-volume 0 -5%`
    - `pactl set-sink-mute 0 toggle`

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

Desert256.vim
- Set background colour by changing hex value and letting 256 converter generate 256 equivalent.
    - `call <SID>X("Normal", "cccccc", "303030", "")`
    - `call <SID>X("Normal", "ffffff", "3a3a3a", "")`

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

