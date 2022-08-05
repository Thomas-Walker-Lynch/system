
;;--------------------------------------------------------------------------------
;; Melpa
;;
  (require 'package)
  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                      (not (gnutls-available-p))))
         (proto (if no-ssl "http" "https")))
    (when no-ssl (warn "\
  Your version of Emacs does not support SSL connections,
  which is unsafe because it allows man-in-the-middle attacks.
  There are two things you can do about this warning:
  1. Install an Emacs version that does support SSL and be safe.
  2. Remove this warning from your init file so you won't see it again."))
    (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
    ;; and `package-pinned-packages`. Most users will not need or want to do this.
    ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
    )
  (package-initialize)

  ;(global-set-key (kbd "M-o") 'switch-window)
  (global-set-key (kbd "M-o") 'ace-window)
  (setq aw-background nil)
  ;(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Sans Mono CJK JP" :foundry "GOOG" :slant normal :weight normal :height 98 :width normal))))
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 2.0)))))

  ;; (use-package ace-window
  ;;     :init
  ;;     (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  ;;     (setq aw-background nil))

;;--------------------------------------------------------------------------------
;; set the title at the top of the frame
;;
  (defun frame-title (s)
    "sets the frame title"
    (interactive "stitle: ")
    (setq frame-title-format s)
    )

;;--------------------------------------------------------------------------------
;; neotree
;;
  ; now installed via Melpa
  ;(add-to-list 'load-path "~/projects/neotree")
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-window-fixed-size nil)
  (setq neo-smart-open t)
  (setq neo-window-width 45)

;;--------------------------------------------------------------------------------
;; get buffer filename -- emacs does not have a built in functin for this.
;;
  (defun filename-get ()
    "Gets the name of the file the current buffer is based on."
    (buffer-file-name (window-buffer (minibuffer-selected-window))))
    
  (defun filename-insert ()
    "Inserts the name of the file the current buffer is based on."
    (interactive)
    (insert (filename-get)))

  (global-set-key (kbd "C-c f") 'filename-insert)

  (defun filename ()
    "Gets the name of the file the current buffer is based on."
    (interactive)
    (message (filename-get))
    )

;;--------------------------------------------------------------------------------     
;; Tramp
;;
;;;https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html
;;
  (setq tramp-completion-reread-directory-timeout nil)

  (defun shell-make (dir buffer-name)
    (let* (
           (default-directory dir)
           (buffer (get-buffer-create buffer-name))
           )
      (set-buffer buffer)
      (shell buffer)
      ))

  (defun shell~       () (interactive) (shell-make "~" "shell~"))
  (defun shell-root   () (interactive) (shell-make "/sudo::/root" "shell-root"))
  (defun shell-rt     () (interactive) (shell-make "/ssh:thomas_lynch@reasoningtechnology.com:~" "shell-rt"))
  ;(defun shell-rt-root() (interactive) (shell-make "/ssh:thomas_lynch@reasoningtechnology.com|sudo:reasoningtechnology.com:" "shell-rt-root"))
  (defun shell-rt-root() (interactive) (shell-make "/ssh:root@reasoningtechnology.com:~" "shell-rt-root"))

  (defun shell-LFS      () (interactive) (shell-make "/ssh:lfs@192.168.122.115:~" "shell-LFS"))
  (defun shell-LFS-root () (interactive) (shell-make "/ssh:root@192.168.122.115:~" "shell-LFS-root"))

  (defun shell-Shihju () (interactive) (shell-make "/sudo:Shihju@localhost:/home/Shihju" "shell-Shihju"))
  (defun shell-Wendell () (interactive) (shell-make "/ssh:Morpheus@Wendell:~" "shell-Wendell"))
  (defun shell-Wendell-root () (interactive) (shell-make "/ssh:Morpheus@Wendell|sudo:Wendell:" "shell-Wendell-root"))
  (defun shell-Wendell-Shihju () (interactive) (shell-make "/ssh:Morpheus@Wendell|sudo:Shihju@Wendell:" "shell-Wendell-Shihju"))


  (defun dired-rt ()
    (interactive)
    (dired "/ssh:thomas_lynch@reasoningtechnology.com:")
    )

  (defun dired-rt-root ()
    (interactive)
    (dired "/ssh:thomas_lynch@reasoningtechnology.com|sudo:reasoningtechnology.com:")
    )

;;--------------------------------------------------------------------------------
;; gdb
;; use gud-gdb instead of gdb and we won't need this.
;; fix 'feature' of broken gdb where it takes control of an
;; emacs window, and locks the user out from switching from it
;;
  (defun unlock-window ()
    "Turns off window dedication."
    (interactive)
    (set-window-dedicated-p (get-buffer-window (current-buffer)) nil)
    )


;;--------------------------------------------------------------------------------
;; json
;;
  (setq json-encoding-pretty-print t)
  (setq json-encoding-lisp-style-closings t)
  ;(setq json-encoding-lisp-style-closings nil)
  (defun wrap-comma ()
    "wrap end of line comma to first of next line"
    (interactive) 
    (while (re-search-forward "\\(.*\\), *\n\\( *\\)" nil t) (replace-match "\\1\n\\2,"))
    )

;;--------------------------------------------------------------------------------
;; rust
;;
;; (require 'package)
;; (add-to-list 'package-archives
;;            '("melpa-stable" . "https://stable.melpa.org/packages/"))
;; (package-initialize)
;; (package-refresh-contents)
;;
;;;  (setq rust-indent-offset 2)
;;;  (require 'rust-mode)

;;--------------------------------------------------------------------------------
;; python
;;
  (add-hook 'python-mode-hook '(lambda () (setq python-indent 2)))

;;--------------------------------------------------------------------------------
;; Lisp
;;
  (setq lisp-indent-offset 2)
  (setq inferior-lisp-program "sbcl")      

  (modify-syntax-entry ?\[ "(]" lisp-mode-syntax-table)
  (modify-syntax-entry ?\] ")[" lisp-mode-syntax-table)
  (modify-syntax-entry ?{ "(}" lisp-mode-syntax-table)
  (modify-syntax-entry ?} "){" lisp-mode-syntax-table)

;;--------------------------------------------------------------------------------
;; Javascript
;;
  (setq js-indent-level 2)
  (setq css-indent-offset 2)    

;;--------------------------------------------------------------------------------
;; C
;;
  (add-hook 'c-mode-hook (lambda () (modify-syntax-entry ?· "_")))
  ; in customer variables '(c-offsets-alist (quote ((label . 2))))

;;--------------------------------------------------------------------------------
;; shell scripting
;;
  (setq sh-basic-offset 2)

;;--------------------------------------------------------------------------------
;; extended character set for programming examples in the TTCA book
;;
;; preferable to have keys for the characters, but the keyboard is already overloaded ..
;; (define-key key-translation-map (kbd "<f9> p") (kbd "¬"))
;; (set-input-method “latin-9-prefix)

  (global-set-key [f1] 'help-command)
  (global-set-key "\C-h" 'nil)
  (define-key key-translation-map (kbd "M-S") (kbd "§"))

  (global-set-key (kbd "C-x g phi SPC") [?φ]) ; phi for phase
  (global-set-key (kbd "C-x g Phi SPC") [?Φ]) 

  (global-set-key (kbd "C-x g d SPC") [?δ])
  (global-set-key (kbd "C-x g D SPC") [?Δ]) ; this is 'delta' is not 'increment'!
  (global-set-key (kbd "C-x g delta SPC") [?δ])
  (global-set-key (kbd "C-x g Delta SPC") [?Δ]) ; this is 'delta' is not 'increment'!

  (global-set-key (kbd "C-x g g SPC") [?γ])
  (global-set-key (kbd "C-x g G SPC") [?Γ])
  (global-set-key (kbd "C-x g gamma SPC") [?γ])
  (global-set-key (kbd "C-x g Gamma SPC") [?Γ])

  (global-set-key (kbd "C-x g l SPC") [?λ])
  (global-set-key (kbd "C-x g L SPC") [?Λ])
  (global-set-key (kbd "C-x g lambda SPC") [?λ])
  (global-set-key (kbd "C-x g Lambda SPC") [?Λ])

  (global-set-key (kbd "C-x g p SPC") [?π])
  (global-set-key (kbd "C-x g P SPC") [?Π])
  (global-set-key (kbd "C-x g pi SPC") [?π])
  (global-set-key (kbd "C-x g Pi SPC") [?Π])

  (global-set-key (kbd "C-x g > = SPC") [?≥])
  (global-set-key (kbd "C-x g < = SPC") [?≤])
  (global-set-key (kbd "C-x g ! = SPC") [?≠])
  (global-set-key (kbd "C-x g neq SPC") [?≠])
      
  (global-set-key (kbd "C-x g nil SPC") [?∅])

  (global-set-key (kbd "C-x g not SPC") [?¬])

  (global-set-key (kbd "C-x g and SPC") [?∧])
  (global-set-key (kbd "C-x g or SPC") [?∨])

  (global-set-key (kbd "C-x g exists SPC") [?∃])
  (global-set-key (kbd "C-x g all SPC") [?∀])

  (global-set-key (kbd "C-x g do SPC") [?⟳]) ; do
  (global-set-key (kbd "C-x g rb SPC") [?◨])
  (global-set-key (kbd "C-x g lb SPC") [?◧])

  (global-set-key (kbd "C-x g cont SPC") [?➜]) ; continue
  (global-set-key (kbd "C-x g thread SPC") [?☥]) ; thread

  (global-set-key (kbd "C-x g in SPC") [?∈]) ; set membership

  (global-set-key (kbd "C-x g times SPC") [?×]) ; set membership

  (global-set-key (kbd "C-x g cdot SPC") [?·]) ; scoping sepearator for gcc C


;;--------------------------------------------------------------------------------
;; turn off the annoying bell
;;
;; (setq ring-bell-function (lambda ()
;;                            (call-process-shell-command
;;                              "xset led 3; xset -led 3" nil 0 nil)))
;;
;; (setq ring-bell-function nil)

 (setq ring-bell-function
       (lambda ()
	 (call-process-shell-command "xset led named 'Scroll Lock'")
	 (call-process-shell-command "xset -led named 'Scroll Lock'")))


;;--------------------------------------------------------------------------------
;; dirtrack
;;
;; get the pwd in shell mode from the prompt rather than guessing by
;; watching the commands typed .. yes! now shell variables and source
;; scripts will work
;;   in bashrc: export PS1='\n$(/usr/local/bin/Z)\u@\h§\w§\n> '
;;
  (add-hook 'shell-mode-hook
           (lambda ()
             (shell-dirtrack-mode -1)
             (dirtrack-mode 1)))

  (add-hook 'dirtrack-directory-change-hook
            (lambda ()
              (message default-directory)))

;;  (setq dirtrack-list '("§\\(.*\\)§\n[>#] " 1))
  (setq dirtrack-list '("§\\([^§]*\\)§" 1))

;;--------------------------------------------------------------------------------
;; emacs behavior

  ;; use a backrevs dir rather than leaving ~file droppings everywhere
  ;;
    (setq backup-directory-alist `(("." . "~/emacs_backrevs")))
    (setq backup-by-copying t)

  ;; stop the 'tab' character polution
  ;;
    (setq-default indent-tabs-mode nil)

  ;; turn off the poison C-z key.  Use C-x C-z or the command suspend-emacs
  ;;
    (global-set-key (kbd "C-z") nil)

  ;; truncate rather than wrapping lines (use horizontal scroll to see to the right)
  ;;
    (set-default 'truncate-lines t)
    (setq truncate-partial-width-windows nil)
    (setq-default fill-column 80)
    (setq fill-column 120)

  ;; recover some window real estate - note also F11 to rid of the top window splash bar
  ;;
    ;;(set-face-attribute 'mode-line nil  :height 75)

    ;; c-x mode-line to toggle the mode-line on and off
    (defun mode-line () "toggles the modeline on and off"
      (interactive) 
      (setq mode-line-format
        (if (equal mode-line-format nil)
            (default-value 'mode-line-format)) )
      (redraw-display))

    ;(setq-default mode-line-format nil) 
    (tool-bar-mode -1)
    (menu-bar-mode -1)

  (put 'upcase-region 'disabled nil)
  (put 'narrow-to-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'set-goal-column 'disabled nil)
  (put 'erase-buffer 'disabled nil)

;(setq browse-url-browser-function 'browse-url-firefox)
(setq browse-url-browser-function 'browse-url-chrome)
;(setq browse-url-browser-function 'browse-url-chromium)



;; vertical split for ediff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(ansi-color-names-vector
     ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(c-offsets-alist '((label . 2)))
 '(column-number-mode t)
 '(custom-enabled-themes '(wheatgrass))
 '(direx:closed-icon "╞")
 '(direx:leaf-icon "┝")
 '(direx:open-icon "╘")
 '(ediff-diff-options "-w")
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(geiser-racket-binary "racket")
  '(package-selected-packages
     '(ace-window switch-window dired-git ztree dirtree-prosjekt dired-sidebar dirtree direx neotree treemacs markdown-mode rust-mode))
 '(send-mail-function 'smtpmail-send-it)
 '(tool-bar-mode nil))

;;--------------------------------------------------------------------------------
;; direx
;;
;;  (add-to-list 'load-path "~/.emacs.d/lisp/direx")
;;  (require 'direx)
;;  (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
;; (push '(direx:direx-mode :position left :width 75 :dedicated t)
;;      popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

    ;; (define-key map (kbd "R") 'direx:do-rename-file)
    ;; (define-key map (kbd "C") 'direx:do-copy-files)
    ;; (define-key map (kbd "D") 'direx:do-delete-files)
    ;; (define-key map (kbd "+") 'direx:create-directory)
    ;; (define-key map (kbd "M") 'direx:do-chmod-file)
    ;; (define-key map (kbd "L") 'direx:do-load-file)
    ;; (define-key map (kbd "B") 'direx:do-byte-compile-file)
    ;; (define-key map (kbd "G") 'direx:do-chgrp)
    ;; (define-key map (kbd "O") 'direx:do-chown)
    ;; (define-key map (kbd "T") 'direx:do-touch)


;;----------

;(add-to-list 'tramp-connection-properties
;             (list (regexp-quote "/ssh:thomas_lynch@reasoningtechnology.com:")
;               "remote-shell" "/usr/bin/bash"))
;
;(customize-set-variable 'tramp-encoding-shell "/usr/bin/bash")

(connection-local-set-profile-variables
  'remote-bash
  '((explicit-shell-file-name . "/bin/bash")
     (explicit-bash-args . ("-i"))))

;(add-to-list 'tramp-connection-properties
;             (list (regexp-quote "/ssh:thomas_lynch@reasoningtechnology.com:")
;               "remote-shell" "/usr/bin/bash"))
;
;(customize-set-variable 'tramp-encoding-shell "/usr/bin/bash")

;; (connection-local-set-profile-variables
;;   'remote-bash
;;   '((explicit-shell-file-name . "/bin/bash")
;;     (explicit-bash-args . ("-i"))))

;; (connection-local-set-profiles
;;   '(:application tramp :protocol "ssh" :machine "localhost")
;;   'remote-bash)

;; (connection-local-set-profiles
;;   '(:application tramp :protocol "ssh" :machine "reasoningtechnology.com")
;;   'remote-bash)

;;(add-to-list 'tramp-connection-properties
;;             (list nil "remote-shell" "/bin/bash"))

(setq inhibit-startup-screen t)
