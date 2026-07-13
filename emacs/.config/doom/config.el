;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "BerkeleyMono Nerd Font" :size 16 :weight 'semi-light)
  doom-variable-pitch-font (font-spec :family "BerkeleyMono Nerd Font" :size 17))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(after! org
  (setq org-directory "~/org/"
    org-agenda-files (list "~/org/agenda.org"
                       "~/org/projects.org"
                       "~/org/inbox.org")))
(after! org
  (setq org-capture-templates
    '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
        "* TODO %?\n  %i\n  %a"))))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Configure fill width
(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

(defun my/org-present-start ()
  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun my/org-present-end ()
  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0))

;; Register hooks with org-present
(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)

(use-package! ghostel
  :bind (("C-x m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s" . consult-line)
         ("M-<backspace>" . ghostel-backward-kill-word)
         ;; Go up/down shell history with M-n/M-p (as in eshell) by sending C-p/C-n
         ("M-p" . (lambda () (interactive) (ghostel-send-key "p" "ctrl")))
         ("M-n" . (lambda () (interactive) (ghostel-send-key "n" "ctrl")))
         :map project-prefix-map
         ("m" . ghostel-project)
         ("M" . ghostel-project-list-buffers))
  :config
  (defun ghostel-send-C-k-and-kill ()
    "Send `C-k' to ghostel.
Like normal Emacs `C-k': kill to end of line and put content in kill-ring."
    (interactive)
    (kill-ring-save (point) (line-end-position))
    (ghostel-send-key "k" "ctrl"))

  (add-to-list 'project-switch-commands '(ghostel-project "Ghostel") t)
  (add-to-list 'project-switch-commands '(ghostel-project-list-buffers "Ghostel buffers") t)
  (add-to-list 'ghostel-eval-cmds '("magit-status-setup-buffer" magit-status-setup-buffer)))

;; Bundled extensions — part of the ghostel package, no extra package! needed
(use-package! ghostel-eshell
  :hook (eshell-load . ghostel-eshell-visual-command-mode))

(use-package! ghostel-compile
  :hook (after-init . ghostel-compile-global-mode))

(use-package! ghostel-comint
  :hook (after-init . ghostel-comint-global-mode))

(use-package! evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))

;; C-` toggles a dedicated ghostel terminal docked at the bottom of the frame.
;; Deliberately NO `set-popup-rule!' — the docking is scoped to this one command
;; via a let-bound `display-buffer-overriding-action', so `C-x m', `SPC p m' and
;; the other ghostel commands keep their current same-window behaviour untouched.
(defvar +ghostel-panel-buffer nil
  "Dedicated ghostel terminal shown as the bottom panel by `+ghostel/toggle'.")

(defvar +ghostel-panel-display-action
  '((display-buffer-in-side-window)
    (side . bottom)
    (slot . 0)
    (window-height . 0.3))
  "`display-buffer' action docking the ghostel panel at the bottom of the frame.")

(defun +ghostel/toggle ()
  "Toggle a dedicated ghostel terminal panel at the bottom of the frame.
Hide it if visible; otherwise reveal it, creating the terminal on first use.
Leaves the other ghostel commands and their windows unaffected."
  (interactive)
  (let ((win (and (buffer-live-p +ghostel-panel-buffer)
                  (get-buffer-window +ghostel-panel-buffer))))
    (if win
        (delete-window win)
      (let ((display-buffer-overriding-action +ghostel-panel-display-action))
        (if (buffer-live-p +ghostel-panel-buffer)
            (pop-to-buffer +ghostel-panel-buffer)
          (let ((ghostel-buffer-name "*ghostel-panel*"))
            (setq +ghostel-panel-buffer (ghostel))))))))

(map! "C-`" #'+ghostel/toggle)
;; Also hide from inside the terminal (default semi-char mode forwards most keys)
(map! :after ghostel :map ghostel-semi-char-mode-map "C-`" #'+ghostel/toggle)
