;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "FirstName LastName"
      user-mail-address "firstlast@example.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;(setq doom-font (font-spec :family "monospace" :size 16))
;(setq doom-font (font-spec :family "Source Code Pro" :size 13))
(setq doom-font (font-spec :family "IBM Plex Mono" :size 13 :weight 'regular))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;(setq doom-theme 'doom-one)
;(setq doom-theme 'doom-dracula)
(setq doom-theme 'doom-molokai)
;(setq doom-theme 'doom-monokai-classic)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Org mode timer:
;;(setq org-clock-sound "/home/user/Documents/AlarmSounds/analog-watch-alarm_daniel-simion.wav")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Custom key mappings:
;; Insert mode jk/kj adjust timeout
(after! evil-escape
  (setq evil-escape-unordered-key-sequence t
        evil-escape-delay 0.5))

;; Starting window size
(add-to-list 'initial-frame-alist '(width  . 130))
(add-to-list 'initial-frame-alist '(height . 45))
(add-to-list 'default-frame-alist '(width  . 130))
(add-to-list 'default-frame-alist '(height . 45))

;; Stop the annoying auto-complete suggestions unless triggered manually
(setq company-idle-delay nil)

;; MELPA package to disable the mouse
;; https://github.com/purcell/disable-mouse
;; Add (package! disable-mouse) to packages.el to install this
(global-disable-mouse-mode)
(mapc #'disable-mouse-in-keymap
  (list evil-motion-state-map
        evil-normal-state-map
        evil-visual-state-map
        evil-insert-state-map))

; Disable cursor blink in terminal (emacs -nw)
(setq visible-cursor nil)
