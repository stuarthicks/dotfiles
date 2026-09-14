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
(setq doom-font (font-spec :family "Berkeley Mono" :size 16 :weight 'semi-light)
  doom-variable-pitch-font (font-spec :family "Berkeley Mono" :size 17))
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

(setq org-agenda-files
  (list "~/org/agenda.org"
    "~/org/projects.org"
    "~/org/inbox.org"))

(after! org
  (setq org-capture-templates
    '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
        "* TODO %?\n  %i\n  %a"))))

;; Org outline sidebar. Docked right, since treemacs owns the left side.
;; `SPC m O' in any org buffer toggles it. The tree is a live outline: moving
;; point in it follows in the source buffer, and structure edits (M-arrows, TODO
;; cycling) are applied to the real buffer.
(use-package! org-side-tree
  :defer t
  :init
  (map! :after org :map org-mode-map
    :localleader
    :desc "Outline sidebar" "O" #'org-side-tree-toggle)
  :config
  (setq org-side-tree-display-side 'right
    org-side-tree-width 35
    org-side-tree-narrow-on-jump nil
    ;; Keep the sidebar across `delete-other-windows' (SPC w o)
    org-side-tree-no-delete-other-windows t)

  ;; The package creates its own side window; keep Doom's popup manager out of it.
  (set-popup-rule! "^\\(?:<tree>\\|\\*Org-Side-Tree\\*\\)" :ignore t)

  ;; Upstream v0.5 bug: `org-side-tree-overlays-to-text' hands this function ranges
  ;; that overrun the heading's newline whenever an overlay on that heading does —
  ;; which hl-line and the `pulse-momentary-highlight-one-line' in
  ;; `org-side-tree-jump' both do. Result is "Invalid search bound" out of every
  ;; tree update, or a stray blank line in the tree. Every caller wants one line.
  (defadvice! +org-side-tree-clamp-to-line-a (fn beg end)
    :around #'org-side-tree-buffer-substring
    (let ((end (min end (save-excursion (goto-char beg) (line-end-position)))))
      (if (> beg end) "" (funcall fn beg end))))

  (map! :map org-side-tree-mode-map
    :nm "RET"       #'push-button
    :nm "j"         #'org-side-tree-next-heading
    :nm "k"         #'org-side-tree-previous-heading
    :nm "TAB"       #'outline-cycle
    :nm [backtab]   #'outline-cycle-buffer
    :nm "t"         #'org-side-tree-next-todo
    :nm "T"         #'org-side-tree-previous-todo
    :nm "M-<down>"  #'org-side-tree-move-subtree-down
    :nm "M-<up>"    #'org-side-tree-move-subtree-up
    :nm "M-<left>"  #'org-side-tree-promote-subtree
    :nm "M-<right>" #'org-side-tree-demote-subtree
    :nm "q"         #'quit-window))

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

;; Fish is non-POSIX; subprocess helpers (diff-hl, TRAMP, etc.) need a POSIX
;; shell internally. Interactive terminals below stay on $SHELL (fish).
(setq shell-file-name (executable-find "bash"))
(setq-default explicit-shell-file-name (getenv "SHELL"))

(use-package! pi-coding-agent
  :commands (pi-coding-agent pi-coding-agent-toggle)
  :bind ("C-§" . pi-coding-agent-toggle)
  :init
  (defalias 'pi 'pi-coding-agent))

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
  ;; Pin to $SHELL (fish) — independent of the POSIX `shell-file-name' above
  (setq ghostel-shell (getenv "SHELL"))

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

;; Magnus drives each agent through a vterm buffer. Run those terminals in
;; ghostel instead: override the one buffer factory, and route the three vterm
;; send calls to ghostel whenever the current buffer is a ghostel buffer.
(use-package! magnus
  :commands (magnus magnus-create-instance magnus-create-codex magnus-doctor)
  :bind (("C-c m" . magnus)
         ("C-c M" . magnus-create-instance))
  :config
  ;; Magnus binds single letters in its own special-mode maps; evil normal
  ;; state shadows them. Use Emacs state so the documented keys work.
  (set-evil-initial-state!
    '(magnus-status-mode magnus-trace-mode magnus-doctor-mode
      magnus-review-ui-mode magnus-process-headless-mode)
    'emacs)
  ;; Emacs state loses evil's j/k. Restore them; archive moves from k to K.
  (map! (:map magnus-status-mode-map
         "j" #'magnus-status-next
         "k" #'magnus-status-previous
         "K" #'magnus-status-archive)
        (:map (magnus-trace-mode-map magnus-doctor-mode-map
               magnus-review-ui-mode-map magnus-process-headless-mode-map)
         "j" #'next-line
         "k" #'previous-line))

  ;; Magnus can archive an agent but never forgets one. Archive it, then drop
  ;; it from the registry; the registry hook saves state.el. The agent's memory
  ;; file under .claude/agents/ stays on disk.
  (defun +magnus/delete-agent ()
    "Stop the agent at point and remove it from the Magnus registry."
    (interactive)
    (let ((instance (magnus-status--get-instance-at-point)))
      (unless instance
        (user-error "No agent at point"))
      (when (yes-or-no-p (format "Delete agent '%s' from Magnus? "
                                 (magnus-instance-name instance)))
        (unless (eq (magnus-instance-status instance) 'purged)
          (magnus-process-archive instance))
        (magnus-instances-remove instance)
        (magnus-status-refresh)
        (message "Deleted '%s'" (magnus-instance-name instance)))))
  (map! :map magnus-status-mode-map "D" #'+magnus/delete-agent)
  ;; The dispatcher had D for the doctor. Move the doctor to ! so D matches the
  ;; status buffer, and list delete next to archive.
  (after! magnus-transient
    (transient-replace-suffix 'magnus-dispatch "D"
      '("!" "Diagnose installation" magnus-doctor))
    (transient-append-suffix 'magnus-dispatch "k"
      '("D" "Delete instance" +magnus/delete-agent)))

  (defun +magnus-ghostel--create-buffer (buffer-name &optional environment)
    "Create a ghostel shell buffer named BUFFER-NAME for a Magnus agent.
ENVIRONMENT is a list of NAME=VALUE strings added to the shell's environment."
    (ghostel--load-module t)
    (let ((buffer (ghostel--create buffer-name)))
      (condition-case err
          (with-current-buffer buffer
            (setq-local ghostel-environment
                        (append environment ghostel-environment))
            (setq ghostel-identity '((kind . magnus)))
            (ghostel--start-process)
            buffer)
        (error
         (when (buffer-live-p buffer) (kill-buffer buffer))
         (signal (car err) (cdr err))))))

  (defun +magnus-ghostel--send-string (string &optional paste-p)
    (if paste-p (ghostel-paste-string string) (ghostel-send-string string)))

  (defun +magnus-ghostel--send-return ()
    (ghostel-send-key "return"))

  (defun +magnus-ghostel--send-key (key &optional shift meta ctrl _accept-proc-output)
    "Send vterm-style KEY, such as \"<escape>\" or \"C-c\", through ghostel's encoder."
    (let ((name (string-trim key "<" ">"))
          (mods (delq nil (list (and shift "shift") (and meta "meta") (and ctrl "ctrl")))))
      (when (string-match "\\`C-\\(.\\)\\'" name)
        (setq name (match-string 1 name)
              mods (cons "ctrl" mods)))
      (ghostel-send-key name (and mods (string-join mods ",")))))

  ;; vterm.el is installed as a Magnus dependency, but its native module is not
  ;; built, so a `require' would prompt to compile it. Give the three send
  ;; functions a definition to hang the advice on; a later real vterm load
  ;; replaces the stub and keeps the advice.
  (dolist (vterm-fn '(vterm-send-string vterm-send-return vterm-send-key))
    (unless (fboundp vterm-fn)
      (defalias vterm-fn (lambda (&rest _) (user-error "vterm is not loaded")))))

  (defun +magnus-ghostel--dispatch (ghostel-fn orig args)
    (if (derived-mode-p 'ghostel-mode) (apply ghostel-fn args) (apply orig args)))
  (define-advice vterm-send-string (:around (orig &rest args) +magnus-ghostel)
    (+magnus-ghostel--dispatch #'+magnus-ghostel--send-string orig args))
  (define-advice vterm-send-return (:around (orig &rest args) +magnus-ghostel)
    (+magnus-ghostel--dispatch #'+magnus-ghostel--send-return orig args))
  (define-advice vterm-send-key (:around (orig &rest args) +magnus-ghostel)
    (+magnus-ghostel--dispatch #'+magnus-ghostel--send-key orig args))

  (advice-add #'magnus-terminal-create-buffer :override #'+magnus-ghostel--create-buffer)

  ;; Magnus installs its own process sentinel, which would drop ghostel's:
  ;; ghostel's sentinel reaps the native child and closes the buffer on exit.
  (defun +magnus-ghostel--chained-sentinel (process event)
    (funcall (process-get process '+magnus-ghostel-magnus-sentinel) process event)
    (when-let* ((ghostel-sentinel (process-get process '+magnus-ghostel-ghostel-sentinel)))
      (funcall ghostel-sentinel process event)))

  (defun +magnus-ghostel--keep-sentinel (orig instance buffer)
    (let* ((process (get-buffer-process buffer))
           (before (and process (process-sentinel process))))
      (funcall orig instance buffer)
      (when (and process
                 (not (memq (process-sentinel process)
                            (list before #'+magnus-ghostel--chained-sentinel))))
        (unless (eq before #'+magnus-ghostel--chained-sentinel)
          (process-put process '+magnus-ghostel-ghostel-sentinel before))
        (process-put process '+magnus-ghostel-magnus-sentinel (process-sentinel process))
        (set-process-sentinel process #'+magnus-ghostel--chained-sentinel))))
  (advice-add #'magnus-process--setup-sentinel :around #'+magnus-ghostel--keep-sentinel)
  (advice-add #'magnus-codex--setup-tui-sentinel :around #'+magnus-ghostel--keep-sentinel)

  ;; Ghostel draws into the buffer only while a window shows it, and Magnus
  ;; polls agent buffers that are usually hidden. Read the terminal text from
  ;; the native grid instead, for prompt detection, health and idle tracking.
  (defun +magnus-ghostel--text (&optional buffer)
    "Return the terminal text of ghostel BUFFER from the native grid, else nil."
    (with-current-buffer (or buffer (current-buffer))
      (and (derived-mode-p 'ghostel-mode)
           ghostel--term
           (ghostel--copy-all-text ghostel--term))))

  (define-advice magnus-attention--tail-text (:around (orig) +magnus-ghostel)
    (if-let* ((text (+magnus-ghostel--text)))
        (when-let* ((lines (last (split-string text "\n" t "[ \t]+")
                                 magnus-attention-scan-lines)))
          (string-join lines "\n"))
      (funcall orig)))

  (define-advice magnus-health--compute-hash (:around (orig buffer) +magnus-ghostel)
    (if-let* ((text (and (buffer-live-p buffer) (+magnus-ghostel--text buffer))))
        (secure-hash 'md5 (substring text (max 0 (- (length text) magnus-health-hash-chars))))
      (funcall orig buffer)))

  ;; The idle tracker compares `buffer-modified-tick', which never moves for a
  ;; hidden ghostel buffer. Stand in a hash of the grid text for the poll.
  (defalias '+magnus-ghostel--real-buffer-modified-tick (symbol-function 'buffer-modified-tick))
  (defun +magnus-ghostel--buffer-tick (&optional buffer)
    (if-let* ((text (+magnus-ghostel--text buffer)))
        (sxhash-equal text)
      (+magnus-ghostel--real-buffer-modified-tick buffer)))
  (define-advice magnus-coord--update-buffer-ticks (:around (orig) +magnus-ghostel)
    (cl-letf (((symbol-function 'buffer-modified-tick) #'+magnus-ghostel--buffer-tick))
      (funcall orig))))

(setq fancy-splash-image (concat doom-private-dir "doom-emacs-color.png"))

;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
(select-frame-set-input-focus (selected-frame))
(server-start)
