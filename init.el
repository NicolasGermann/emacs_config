(keymap-global-set "M-5" (lambda () (interactive) (insert "[")))
(keymap-global-set "M-6" (lambda () (interactive) (insert "]")))
(keymap-global-set "M-7" (lambda () (interactive) (insert "|")))
(keymap-global-set "M-/" (lambda () (interactive) (insert "\\")))
(keymap-global-set "M-8" (lambda () (interactive) (insert "{")))
(keymap-global-set "M-9" (lambda () (interactive) (insert "}")))
(keymap-global-set "M-L" (lambda () (interactive) (insert "@")))
(keymap-global-set "M-n" (lambda () (interactive) (insert "~")))
(keymap-global-set "M-&" (lambda () (interactive) (insert "^")))

(setq ns-command-modifier 'meta)

(with-eval-after-load 'doc-view
  (setq doc-view-resolution 300))
(add-hook 'doc-view-mode-hook (lambda () (display-line-numbers-mode -1)))
(setq auto-save-default nil)
(setq-default truncate-lines t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(which-key-mode)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(global-hl-line-mode t)

(electric-pair-mode 1)

(set-fringe-mode 10)


(setq-default line-spacing 0.12)

(set-face-attribute 'default nil :font "SF Mono Terminal" :height 180)

(setq inhibit-startup-screen t)    ; Begrüßung deaktivieren
(setq initial-scratch-message ";;Willkommen") ; Scratch-Buffer komplett leeren

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(use-package base16-theme	    
  :ensure t			    
  :config			    
  (load-theme 'base16-everforest 0))

(use-package golden-ratio
  :ensure t
  :init
  (golden-ratio-mode 1))

(defun my-balance-windows-and-disable-golden-ratio ()
  "Balanciert die Fenster aus und schaltet den golden-ratio-mode aus."
  (interactive)
  ;; 1. Golden-Ratio ausschalten, falls er aktiv ist
  (when (bound-and-true-p golden-ratio-mode)
    (golden-ratio-mode -1))
  ;; 2. Fenster ausbalancieren
  (balance-windows))

;; Die neue Funktion auf C-+ legen
;; Hinweis: In manchen Terminals/Systemen ist C-+ eigentlich C-=
(global-set-key (kbd "C-x +") #'my-balance-windows-and-disable-golden-ratio)

;; (use-package moody
;;   :ensure t
;;   :config
;;   (setq x-underline-at-descent-line t)
;;   (setq moody-mode-line-height 25)
;;   (moody-replace-mode-line-buffer-identification)
;;   (moody-replace-eldoc-minibuffer-message-function)
;;   (moody-replace-vc-mode)
;;   )

;; (use-package minions
;;   :ensure t
;;   :config
;;   (minions-mode 1))

(use-package avy
  :ensure t
  :bind ("C-ö" . avy-goto-word-1)
  :config
  (setq avy-all-windows 'all-frames)
  :custom-face
  (avy-lead-face ((t (:background unspecified :foreground "#ff0000" :weight bold :underline t))))
  (avy-lead-face-0 ((t (:background unspecified :foreground "#af00ff" :weight bold))))
  )

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :config
  ;; Optik: Zeige 10 Ergebnisse auf einmal
  (setq vertico-count 10)
  ;; Ermöglicht es, mit der Eingabetaste ein Verzeichnis auszuwählen
  (setq vertico-cycle t))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package corfu
  :ensure t
  ;; Optionale Einstellungen für eine bessere Erfahrung:
  :custom
  (corfu-cycle t)                ; Ermöglicht das Kreisen durch die Liste
  (corfu-auto t)                 ; Aktiviert automatische Vervollständigung beim Tippen
  (corfu-auto-prefix 1)          ; Startet nach 2 getippten Zeichen
  (corfu-auto-delay 0.1)         ; Wie schnell das Popup erscheint
  (corfu-quit-at-boundary 'separator) ; Beendet Corfu bei Leerzeichen
  :init
  (global-corfu-mode))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-use-icons nil)
  (kind-icon-default-face 'corfu-default) ; Passt sich deinem Theme an
  (kind-icon-blend-background t)         ; Das ist der entscheidende Schalter
  (kind-icon-blend-fraction 0.00)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package corfu-terminal
  :ensure t
  :unless (display-graphic-p)
  :config
  (corfu-terminal-mode 1))

(use-package eglot
  :ensure t
  :pin gnu
  :config
  (setq eldoc-documentation-strategy #'eldoc-documentation-compose-effectively)
  (setq eldoc-idle-delay 0)
  :bind
  (("C-x c" . eglot-code-actions)))

(use-package mason
  :ensure t
  :init
  (mason-setup))

(use-package org
  :ensure nil
  :config
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.5 :weight bold))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.3 :weight bold))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.1 :weight bold))))
   '(org-document-title ((t (:height 1.7 :weight bold :underline t)))))
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇" "⁖")))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status))

(setq org-directory "~/org")

(setq org-agenda-files '("~/org/"))

(setq org-default-notes-file "~/org/inbox.org")

(setq org-capture-templates
      '(
        ("n" "Notiz" entry (file+headline "~/org/inbox.org" "Notizen")
         "* %? :NOTE:\n  %U\n  %a")
       ))

(setq org-refile-targets
      '((org-agenda-files . (:maxlevel . 3))))

(setq org-refile-use-outline-path 'file)

(setq org-outline-path-complete-in-steps nil)

(setq org-refile-allow-creating-parent-nodes 'confirm)

(set-face-attribute 'line-number nil 
                    :height 0.8    ; 80% der normalen Textgröße
                    :slant 'normal)
(set-face-attribute 'line-number-current-line nil 
                    :height 0.8
                    :weight 'bold)

(use-package vc-fossil
  :ensure t
  :defer t)

(use-package eldoc-box
  :ensure t
  :defer t
  :bind (("C-h C-." . eldoc-box-help-at-point))
  )

(use-package vterm
  :ensure t
  :defer t)

(use-package evil
  :ensure t
  :defer t
  :init
  (setq evil-want-keybinding nil) ;; Wichtig für die Kompatibilität
  :config
  (define-key evil-insert-state-map (kbd "C-c C-c") 'evil-normal-state)
  (define-key evil-visual-state-map (kbd "C-c C-c") 'evil-normal-state)
  ;; Optional: Falls du C-c C-c auch im Minibuffer nutzen willst
  (define-key evil-emacs-state-map (kbd "C-c C-c") 'evil-normal-state)
  (evil-mode 0))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-multiedit
  :ensure t
  :defer t
  :after evil
  :config
  (evil-multiedit-default-keybinds))

(use-package languagetool
  :ensure nil
  :config
    (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-server-command "~/.languagetool/languagetool-server.jar"
        languagetool-console-command "~/.languagetool/languagetool-commandline.jar"))

(defun setup-languagetool ()
  "Einrichten des Languagtools für de-DE"
  (interactive)
  (languagetool-set-language 'de-DE)
  (languagetool-server-start)
  (sit-for 3)
  (languagetool-server-mode))


(defun meow-setup ()
  (setq meow-cheatsheet-physical-layout meow-cheatsheet-physical-layout-iso)
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwertz)

  (meow-thing-register 'angle
                       '(pair (";") (":"))
                       '(pair (";") (":")))

  (setq meow-char-thing-table
        '((?f . round)
          (?d . square)
          (?s . curly)
          (?a . angle)
          (?r . string)
          (?v . paragraph)
          (?c . line)
          (?x . buffer)))

  (meow-leader-define-key
    ;; Use SPC (0-9) for digit arguments.
    '("1" . meow-digit-argument)
    '("2" . meow-digit-argument)
    '("3" . meow-digit-argument)
    '("4" . meow-digit-argument)
    '("5" . meow-digit-argument)
    '("6" . meow-digit-argument)
    '("7" . meow-digit-argument)
    '("8" . meow-digit-argument)
    '("9" . meow-digit-argument)
    '("0" . meow-digit-argument)
    '("-" . meow-keypad-describe-key)
    '("_" . meow-cheatsheet))

  (meow-normal-define-key
    ;; expansion
    '("0" . meow-expand-0)
    '("1" . meow-expand-1)
    '("2" . meow-expand-2)
    '("3" . meow-expand-3)
    '("4" . meow-expand-4)
    '("5" . meow-expand-5)
    '("6" . meow-expand-6)
    '("7" . meow-expand-7)
    '("8" . meow-expand-8)
    '("9" . meow-expand-9)
    '("ä" . meow-reverse)

    ;; movement
    '("i" . meow-prev)
    '("k" . meow-next)
    '("j" . meow-left)
    '("l" . meow-right)

    '("z" . meow-search)
    '("-" . meow-visit)

    ;; expansion
    '("I" . meow-prev-expand)
    '("K" . meow-next-expand)
    '("J" . meow-left-expand)
    '("L" . meow-right-expand)

    '("u" . meow-back-word)
    '("U" . meow-back-symbol)
    '("o" . meow-next-word)
    '("O" . meow-next-symbol)

    '("a" . meow-mark-word)
    '("A" . meow-mark-symbol)
    '("s" . meow-line)
    '("S" . meow-goto-line)
    '("w" . meow-block)
    '("q" . meow-join)
    '("g" . meow-grab)
    '("G" . meow-pop-grab)
    '("m" . meow-swap-grab)
    '("M" . meow-sync-grab)
    '("p" . meow-cancel-selection)
    '("P" . meow-pop-selection)

    '("x" . meow-till)
    '("y" . meow-find)

    '("," . meow-beginning-of-thing)
    '("." . meow-end-of-thing)
    '(";" . meow-inner-of-thing)
    '(":" . meow-bounds-of-thing)

    ;; editing
    '("d" . meow-kill)
    '("f" . meow-change)
    '("t" . meow-delete)
    '("c" . meow-save)
    '("v" . meow-yank)
    '("V" . meow-yank-pop)

    '("e" . meow-insert)
    '("E" . meow-open-above)
    '("r" . meow-append)
    '("R" . meow-open-below)

    '("h" . undo-only)
    '("H" . undo-redo)

    '("b" . open-line)
    '("B" . split-line)

    '("ü" . indent-rigidly-left-to-tab-stop)
    '("+" . indent-rigidly-right-to-tab-stop)

    ;; ignore escape
    '("<escape>" . ignore)))

(use-package meow
  :ensure t
  :config
  (meow-setup)
  (meow-global-mode 1)
  )

(use-package echo-bar
  :ensure t
  :config
  (setq echo-bar-format '((" %+%@%b |%l| " mode-line-front-space
			   (:propertize ("") display (min-width (1.0)))
			   "|/" (vc-mode vc-mode) " >" mode-line-misc-info"< " )))
  (setq-default mode-line-format '(" "))
  (set-face-attribute 'mode-line nil :height 50)
  (set-face-attribute 'mode-line-inactive nil :height 50)
  (echo-bar-mode 1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons avy base16-theme centaur-tabs corfu-terminal echo-bar
		   eglot eldoc-box embark eshell-vterm evil-collection
		   evil-multiedit general golden-ratio kind-icon
		   languagetool lsp-mode magit marginalia mason
		   matlab-mode meow mini-modeline minions moody
		   nano-agenda nano-modeline nano-theme orderless
		   org-modern rust-mode vc-fossil vertico zig-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
