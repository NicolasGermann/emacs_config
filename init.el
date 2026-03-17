(keymap-global-set "M-5" (lambda () (interactive) (insert "[")))
(keymap-global-set "M-6" (lambda () (interactive) (insert "]")))
(keymap-global-set "M-7" (lambda () (interactive) (insert "|")))
(keymap-global-set "M-/" (lambda () (interactive) (insert "\\")))
(keymap-global-set "M-8" (lambda () (interactive) (insert "{")))
(keymap-global-set "M-9" (lambda () (interactive) (insert "}")))
(keymap-global-set "M-L" (lambda () (interactive) (insert "@")))
(keymap-global-set "M-n" (lambda () (interactive) (insert "~")))

(setq ns-command-modifier 'meta)

(with-eval-after-load 'doc-view
  (setq doc-view-resolution 300))
(add-hook 'doc-view-mode-hook (lambda () (display-line-numbers-mode -1)))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(which-key-mode)

(global-display-line-numbers-mode 1)

(global-hl-line-mode t)

(electric-pair-mode 1)

(set-fringe-mode 10)

(set-face-attribute 'mode-line nil :height 160)

(setq-default line-spacing 0.12)

(set-face-attribute 'default nil :font "SF Mono Terminal" :height 180)

(setq inhibit-startup-screen t)    ; Begrüßung deaktivieren
(setq initial-scratch-message ";;Willkommen") ; Scratch-Buffer komplett leeren

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package doom-themes					      ;;
;;   :ensure t							      ;;
;;   :config							      ;;
;;   (load-theme 'doom-one t)					      ;;
;;   ;; Korrekte Farben für die Modeline und andere Pakete aktivieren ;;
;;   (doom-themes-visual-bell-config)				      ;;
;;   (doom-themes-neotree-config)				      ;;
;;   (doom-themes-org-config))					      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

(use-package moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)
  (setq moody-mode-line-height 25)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-eldoc-minibuffer-message-function)
  (moody-replace-vc-mode)
  )

(use-package minions
  :ensure t
  :config
  (minions-mode 1))

(use-package avy
  :ensure t
  :bind ("C-ö" . avy-goto-word-1)
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
  :bind
  (("C-x c" . eglot-code-actions)))

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
  :config
  (setq eldoc-box-only-at-point t)
  )

(use-package vterm
  :ensure t
  :defer t)
