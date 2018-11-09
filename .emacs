;; -----------------------------------------------------------------
;; MISC
(setq default-directory "H:")
;; Marked region is NOT deleted when pressing any key (only for backspace)
(delete-selection-mode 0)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(require 'saveplace)
(setq-default save-place t)
(global-set-key (kbd "M-/ ") 'hippie-expand)


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
(setq inferior-R-program-name "c:/Progra~1/R/R-3.4.3/bin/X64/Rterm")
;; Move focus to last evaluated line in R buffer
(setq comint-scroll-to-bottom-on-output 't)
(setq inferior-ess-r-help-command "help(\"%s\", help_type=\"text\")\n")

(defun my-ess-mode-hook ()
(local-set-key '[Ctrl-up] 'comint-previous-input)
(local-set-key '[C-down] 'comint-next-input))
(add-hook 'inferior-ess-mode-hook 'my-ess-mode-hook)

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

(setq org-agenda-files (list "H:/org/Work.org"))
;; Set to the name of the org file on local system
(setq org-directory "H:/org/")
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
