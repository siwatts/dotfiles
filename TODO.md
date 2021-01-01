# TODO

## Vim

- 16/8 color term vim fixes
    - Overhaul the vim colourscheme stuff and make more resilient
    - Default enhanced & default theme tweaks '.vimrc' weren't looking good in 8/16 colour
    - 'default.vim' does a better job so just go back to this.
    - Keep some supplemental changes. E.g. folds look like the ':sp' window bar and it is confusing
- Get the basic notes plugin for vim, see if we can tidy and commit
- Org mode plugin, tidy and commit, just syntax highlighting at least
    - Incorporate into a vim setup script, copy over colourschemes and org mode plugin
- basic.vim is from work, basic-new.vim needs finishing (diff etc.) then can commit back to wiki and here
- SOFTLINK the vimrc for ease of maintenance
- Detect neovim terminal support more smartly, move neovim config to init.vim?
- Twilight256 is better than `_jb`. Fix `_jb` or just use 256 further modded slightly (linenr?)
    - Errors in `_jb`:
        - Operator links to Structure by mistake, and Structure is blue
        - Should be Structure -> Type, and Operator -> Statement
- Fix `set syntax=diff` colours for:
    - default enhanced
    - twilight256
- Fix dracula diff highlighting (use Dracula Orange and Green instead of linking to Diff syntax which is for file diffs and not set syntax=diff)

## Other

- Get fixes to tmux made on this user account to support truecolour, disable warnings etc. and propagate them forwards
- Add jellybeans colours to dracula term theme, lower 8 colours. Use to improve string, constant, statement, etc.
- VS Code settings
- Bash
    - 'shift' use and document
    - Argument passing, pass all of args. at once
    - Capturing and using return code
- Document how to run command without sudo password prompt
- Lessons learned from lovelace configure
    - Fix vim default-enhanced.vim issue, remove that and use as custom theme
    - Bashrc overhaul, colours
- Understand `bash_profile` (sometimes not needed)
- Create a setup script that automates new system setup, better than the diff
  script

## Bashrc

- Get updated git PS1 formulation and finish it or abandon
