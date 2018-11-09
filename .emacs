;; -----------------------------------------------------------------
;; MISC
(setq default-directory "var3")
;; Marked region is NOT deleted when pressing any key (only for backspace)
(delete-selection-mode 0)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(require 'saveplace)
(setq-default save-place t)
(global-set-key (kbd "M-/ ") 'hippie-expand)
;; ;; Scroll one line with cursor
(setq scroll-step 1)
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-conservatively most-positive-fixnum)
;;;;; If you want all help buffers to go into one frame do
(setq column-number-mode t)
(savehist-mode t)
;;Drop Emacs welcome screen on startup
(setq inhibit-startup-message t)
(toggle-frame-maximized)
(set-message-beep 'silent)

(when (eq window-system 'w32)
  (defun open-externally (file-name)
    (interactive "fOpen externally: ")
    (w32-shell-execute "open" file-name)))

(global-set-key (kbd "C-u") 'open-externally)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key [C-f1] 'show-file-name)

;; -----------------------------------------------------------------
;; Font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight bold :height 151 :width normal)))))


;; -----------------------------------------------------------------
;; Display settings
(setq display-time-24hr-format t) ; 24 hour format
(display-time) ; Display the time
(setq-default auto-fill-function 'do-auto-fill) ; Autofill in all modes
(setq fill-column 83) ; wordwrap in this column

(setq default-frame-alist '(
 (top . 0) (left . 0)
 (width . 93) (height . 26)
 (cursor-color . "red")
 (background-color . "gray5")
 (foreground-color . "gray85")
 (vertical-scroll-bars . right)
 ))

;; -----------------------------------------------------------------
;; R and ESS settings:
(require 'ess-site)
(require 'ess-eldoc)
(setq inferior-R-program-name "var2")
;; Move focus to last evaluated line in R buffer
(setq comint-scroll-to-bottom-on-output 't)
(setq inferior-ess-r-help-command "help(\"%s\", help_type=\"text\")\n")

(defun my-ess-mode-hook ()
(local-set-key '[Ctrl-up] 'comint-previous-input)
(local-set-key '[C-down] 'comint-next-input))
(add-hook 'inferior-ess-mode-hook 'my-ess-mode-hook)

(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(setq-default inferior-R-args "--no-save ")

;; Automagically delete trailing whitespace when saving R script
;; files. One can add other commands in the ess-mode-hook below.
(add-hook 'ess-mode-hook
 '(lambda()
 (add-hook 'write-file-functions
 (lambda ()
 (ess-nuke-trailing-whitespace)))
 (setq ess-nuke-trailing-whitespace-p t)))

;; -----------------------------------------------------------------
;; SAS settings:
; ms-dos default
; (setq ess-sas-submit-pre-command "start")
; (setq ess-sas-submit-post-command "-rsasuser -icon")
; Make f5-f8 and more 'SAS-keys' available in ESS-SAS mode
;(ess-sas-global-pc-keys)
; Submit region
;(global-set-key [(control f8)] 'ess-sas-submit-region)

;; -----------------------------------------------------------------
;; Redefine some keys
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [C-home] 'beginning-of-buffer)
;;(global-set-key [C-end] 'end-of-buffer)
(global-set-key [f1] 'goto-line) ; goto line
(global-set-key [f11] 'TeX-next-error) ; goto next found LaTeX error
(global-set-key [f12] 'next-error) ; goto next found lacheck
; error (run Check first)
(global-set-key [f5] 'fill-region) ; Wrap current region
;;(global-set-key [delete] 'delete-char) ; delete character under cursor

;; Move between windows
(global-set-key [M-left] 'windmove-left) ; move to left windnow
(global-set-key [M-right] 'windmove-right) ; move to right window
(global-set-key [M-up] 'windmove-up) ; move to upper window
(global-set-key [M-down] 'windmove-down) ; move to downer window

;; Both C-y and C-v are working
(global-set-key (kbd "C-v") 'yank) 
;; Comment/out comment region
(global-set-key "\C-c;" 'comment-region)
(global-set-key "\C-c:" 'uncomment-region)
;; Windows Style Undo
(global-set-key [(control z)] 'undo)

;; -----------------------------------------------------------------
;; Some translation problems between unix and dos
;; prevent echoing ^M in the shell
(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)
;; if you encounter a file with ^M or ... at the end of every line,
;; this means a wrong copy by samba or floppy disk of the DOS file to UNIX.
;; get rid of them by pressing [F6]
(global-set-key [f6] 'cut-ctrlM) ; cut all ^M.
(defun cut-ctrlM ()
 "Cut all visible ^M."
 (interactive)
 (beginning-of-buffer)
 (while (search-forward "\r" nil t)
 (replace-match "" nil t)))

;; -----------------------------------------------------------------
;; Org-mode START
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Force Emacs to open folder links in Emacs (and not in finder)
(add-to-list 'org-file-apps '(directory . emacs))

(setq org-agenda-files (list "var4"))
;; Set to the name of the org file on local system
(setq org-directory "var5")
;;----
;; fontify code in code blocks
(setq org-src-fontify-natively t)

(org-babel-do-load-languages
'org-babel-load-languages
'((R . t)))

;; Unset M-up, and more in org-mode. Works partially
(defun org-mode-is-intrusive ()
;; Make something work in org-mode:
;; (local-unset-key (kbd "something I use"))
(local-unset-key (kbd "<M-up>"))
(local-unset-key (kbd "<M-down>"))
(local-unset-key (kbd "<M-left>"))
(local-unset-key (kbd "<M-right>"))
)
(add-hook 'org-mode-hook 'org-mode-is-intrusive)

;; ;; Automatically indent lists and similar structures of Org buffers
(setq org-startup-indented t); Use virtual indentation for all files

;; Org-mode END

;; -----------------------------------------------------------------
;; Tex
;; Add standard Sweave file extensions to the list of files recognized
;; by AUCTeX.
(setq TeX-file-extensions
 '("Rnw" "rnw" "Snw" "snw" "tex" "sty" "cls" "ltx" "texi" "texinfo" "dtx"))

;; -----------------------------------------------------------------
;; Emacs Packages
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ;;("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)
(load-theme 'material t) ;; load material theme
(elpy-enable)

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'tramp)
(set-default 'tramp-auto-save-directory "var1")
(set-default 'tramp-default-method "plink")


;; -----------------------------------------------------------------
;; ;; GPG encryption
;; (require 'epa-file)
;; (epa-file-enable)
;; (setq epa-file-select-keys nil)

(define-minor-mode sensitive-mode
 "For sensitive files like password lists.
It disables backup creation and auto saving.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
 ;; The initial value.
 nil
 ;; The indicator for the mode line.
 " Sensitive"
 ;; The minor mode bindings.
 nil
 (if (symbol-value sensitive-mode)
 (progn
;; disable backups
(set (make-local-variable 'backup-inhibited) t)
;; disable auto-save
(if auto-save-default
 (auto-save-mode -1)))
 ;resort to default value of backup-inhibited
 (kill-local-variable 'backup-inhibited)
 ;resort to default auto save setting
 (if auto-save-default
(auto-save-mode 1))))

(setq auto-mode-alist
(append '(("\\.gpg$" . sensitive-mode))
 auto-mode-alist))

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)
