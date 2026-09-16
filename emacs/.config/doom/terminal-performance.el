;;; terminal-performance.el -*- lexical-binding: t; -*-

;; Description: Speed up Emacs terminals (vterm, eat, ghostel, term, and ansi-term)
;; Author: James Cherti
;; License: MIT
;; URL: https://www.jamescherti.com/emacs-terminal-performance-vterm-eat-ansi-term-ghostel/

(setq vterm-timer-delay 0.01)
(setq ghostel-timer-delay 0.01)
(setq eat-minimum-latency 0.01)
(setq eat-maximum-latency 0.05)

(setq vterm-max-scrollback 500)
(setq ghostel-max-scrollback (* 1024 1024))
(setq eat-term-scrollback-size (* 64 1024))

(setq eat-enable-shell-prompt-annotation nil)

;; Uncomment -DUSE_SYSTEM_LIBVTERM if you prefer system libvterm
(setq vterm-module-cmake-args
      (concat "-DCMAKE_C_FLAGS='-O3 -march=native -mtune=native' "
              "-DCMAKE_SHARED_LINKER_FLAGS='-Wl,-O2 -Wl,--as-needed' "
              ;; "-DUSE_SYSTEM_LIBVTERM=yes"
              ))

(defun my-speed-up-terminal-buffer ()
  "Reduce unnecessary Emacs features in terminal buffers."
  (let ((ghostel-buffer (derived-mode-p 'ghostel-mode)))
    (setq-local font-lock-defaults '(nil t))

    (setq-local fast-but-imprecise-scrolling t)
    (setq-local redisplay-skip-fontification-on-input t)
    (setq-local scroll-conservatively most-positive-fixnum)
    (setq-local hscroll-margin 0)
    (setq-local scroll-margin 0)
    (setq-local scroll-step 0)
    (setq-local hscroll-step 0)
    (setq-local auto-hscroll-mode nil)

    ;; Uncomment to disable scroll bars to save redisplay cycles
    ;; (setq-local vertical-scroll-bar nil)
    ;; (setq-local horizontal-scroll-bar nil)

    (setq-local truncate-lines t)
    (setq-local nobreak-char-display nil)
    (setq-local bidi-paragraph-direction 'left-to-right)
    (setq-local bidi-inhibit-bpa t)

    ;; Ghostel coordinates row height calculations via ghostel-line-spacing
    (unless ghostel-buffer
      (setq-local line-spacing 0)
      (setq-local mode-line-format nil))

    (setq-local echo-keystrokes 0)

    (setq-local process-adaptive-read-buffering nil)
    (let ((output-max (* 1024 1024)))
      (when (< read-process-output-max output-max)
        (setq-local read-process-output-max output-max)))

    (buffer-disable-undo)

    ;; Evil users
    (remove-hook 'pre-command-hook 'evil--jump-hook t)
    (remove-hook 'post-command-hook 'evil--jump-handle-buffer-crossing t)

    ;; Disable modes
    (let ((inhibit-redisplay t)
          (inhibit-message t)
          (modes '(electric-pair-local-mode
                   electric-indent-local-mode
                   display-line-numbers-mode
                   display-fill-column-indicator-mode
                   hl-line-mode
                   show-paren-local-mode
                   flymake-mode
                   ;; Third-party packages
                   ;; NOTE: Add more modes here
                   flycheck-mode
                   evil-surround-mode
                   evil-snipe-local-mode
                   yas-minor-mode
                   company-mode
                   corfu-mode)))
      ;; ghostel-comint, ghostel-compile, and ghostel-links register a function
      ;; in eldoc-documentation-functions to display target URLs and file under
      ;; point.
      ;;
      ;; Ghostel uses auto-composition-mode in the sync tty composition
      ;; function.
      (unless ghostel-buffer
        (push 'eldoc-mode modes)
        (push 'auto-composition-mode modes))

      (dolist (mode modes)
        (when (and (boundp mode)
                   (symbol-value mode)
                   (fboundp mode))
          (ignore-errors
            (funcall mode -1)))))))

(add-hook 'term-mode-hook 'my-speed-up-terminal-buffer t)
(add-hook 'vterm-mode-hook 'my-speed-up-terminal-buffer t)
(add-hook 'eat-mode-hook 'my-speed-up-terminal-buffer t)
(add-hook 'ghostel-mode-hook 'my-speed-up-terminal-buffer t)
