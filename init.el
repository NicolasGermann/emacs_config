(keymap-global-set "M-5" (lambda () (interactive) (insert "[")))
(keymap-global-set "M-6" (lambda () (interactive) (insert "]")))
(keymap-global-set "M-7" (lambda () (interactive) (insert "|")))
(keymap-global-set "M-8" (lambda () (interactive) (insert "{")))
(keymap-global-set "M-9" (lambda () (interactive) (insert "}")))
(keymap-global-set "M-L" (lambda () (interactive) (insert "@")))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(which-key-mode)

(global-display-line-numbers-mode t)

(global-hl-line-mode t)

(set-fringe-mode 10)

(set-face-attribute 'mode-line nil :height 160)

(setq-default line-spacing 0.12)

(set-face-attribute 'default nil :font "SF Mono Terminal" :height 180)

(setq inhibit-startup-screen t)    ; Begrüßung deaktivieren
(setq initial-scratch-message ";;Willkommen") ; Scratch-Buffer komplett leeren

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  ;; Korrekte Farben für die Modeline und andere Pakete aktivieren
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

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
  :bind ("M-g w" . avy-goto-word-0)
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
  (corfu-auto-prefix 2)          ; Startet nach 2 getippten Zeichen
  (corfu-auto-delay 0.1)         ; Wie schnell das Popup erscheint
  (corfu-quit-at-boundary 'separator) ; Beendet Corfu bei Leerzeichen
  
  :init
  (global-corfu-mode))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; Passt sich deinem Theme an
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package corfu-terminal
  :ensure t
  :unless (display-graphic-p)
  :config
  (corfu-terminal-mode 1))

(use-package org
  :ensure nil
  :config
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.5 :weight bold))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.3 :weight bold))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.1 :weight bold))))
   '(org-document-title ((t (:height 1.7 :weight bold :underline t)))))
  :bind (("C-c a" . org-agenda)
	 ("C-c n" . org-capture)
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

(setq org-agenda-files '("~/org"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %U")
        
        ("n" "Leere Notiz (Datum)" entry 
         ;; Wir nutzen hier eine Funktion (file+function), 
         ;; um den dynamischen Pfad zu berechnen
         (file (lambda () 
                 (let ((name (format-time-string "note-%Y-%m-%d--%H-%M-%S.org")))
                   (expand-file-name name "~/org"))))
         "* %?\n  Erstellt am: %U")))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     default))
 '(package-selected-packages
   '(all-the-icons avy corfu corfu-terminal doom doom-themes kind-icon
		   magit marginalia minions modus-themes moody
		   orderless org-appear org-appearance org-modern
		   vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:height 1.7 :weight bold :underline t))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.5 :weight bold))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.3 :weight bold))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1 :weight bold)))))
