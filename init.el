;;===========================================================
;; *** NÄYTÖN ASETUKSET***
;;-----------------------------------------------------------

;; Koko näyttö aloituksessa.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Poistaa aloitusnäytön käytöstä.
(setq inhibit-splash-screen t)

;; Fontin asettaminen.
(set-face-attribute 'default nil :font "Liberation Mono-16")

;; Asettaa sisennyksen.
(setq-default tab-width 4)

;; Automaattisesti täydentää suluille parin.
(electric-pair-mode 1)

;; Poistaa kolinakellon käytöstä.
(setq visible-bell t)

;; Poistaa yläpalkin ja valikon ruudun yläreunasta sekä sivurullan oikeasta reunasta.
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Asettaa lisää tilaa vasempaan reunaan tekstin ja ikkunan reunan väliin.
(set-fringe-mode 5)

;; Rivi- ja sarakenumerot alapaneelissa.
(line-number-mode 1)
(column-number-mode 1)

;; Näyttää rivinumerot.
(global-display-line-numbers-mode 1)

;;Poistaa osalta asetuksilta rivinumerot käytöstä.
(dolist (mode '(org-mode-hook
				term-mode-hook
				eshell-mode-hook
				treemacs-mode-hook))
  (add-hook mode (lambda ()(display-line-numbers-mode 0))))

;; Korostaa rivin jolla ollaan.
(global-hl-line-mode)

;; Poistaa vilkkuvan kursorin.
(blink-cursor-mode -1)

;; Kalenteria varten asetetaan viikko alkamaan maanantaista.
(setq calendar-week-start-day 1)

;;Näyttää rivinumerot rivillä.
(global-display-line-numbers-mode 1)

;; Ei rivitä rivejä vaan jatkaa ne ikkunan "ulkopuolelle"
(setq-default truncate-lines 1)

;; Parantaa näkyvyyttä
(setq-default global-visual-line-mode 1)

;;===========================================================
;; ***PIKANÄPPÄIMET***
;;-----------------------------------------------------------

(global-set-key (kbd "C-c TAB") 'window-swap-states)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "C-ä") 'forward-char)
(global-set-key (kbd "C-ö") 'backward-char)
(global-set-key (kbd "M-ä") 'forward-word)
(global-set-key (kbd "M-ö") 'backward-word)
(global-set-key (kbd "C-M-ä") 'counsel-switch-buffer)
(global-set-key (kbd "C-c C-å") 'org-agenda)
(global-set-key (kbd "C-c å") 'org-capture)
(fset 'copy-whole-line
	  (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-w] 0 "%d"))

(global-set-key(kbd "M-å") 'copy-whole-line)
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c j") 'windmove-down)
(global-set-key (kbd "C-c k") 'windmove-up)
(global-set-key (kbd "C-c p") 'transpose-lines)
(global-set-key (kbd "C-f") 'find-file)
(global-set-key (kbd "C-u") 'undo)
(global-set-key (kbd "C-c e k") 'save-buffers-kill-emacs)

(global-set-key (kbd "C-c ö") "{")
(global-set-key (kbd "C-c ä") "[")
(global-set-key (kbd "C-x o") 'read-only-mode)
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-c"))

;;===========================================================
;; ***PAKETTIEN LATAUSJÄRJESTELMÄT***
;;-----------------------------------------------------------

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)
;;===========================================================
;; *** PAKETIT ***
;;-----------------------------------------------------------
;; ***prettier*** //NOTE(): ei toimi.
;; (straight-use-package 'prettier)
;; (add-hook 'typescript-mode-hook 'prettier-mode)
;; (setq prettier-mode-sync-config-flag nil)
;; (setenv "NODE_PATH" "/usr/local/lib/node_
;; ***use-package***
;; Use-package helpottaa pakettien asetusten määrittämistä.
(straight-use-package 'use-package)
;; Lisää automaattinen asennus.
(setq straight-use-package-by-default t)

;;-----------------------------------------------------------
;; ***rainbow delimeters***
(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode-enable)

;;-----------------------------------------------------------
;; ***HL-TODO***
;; Korostaa tekstistä TODO:t yms. tagit.

(straight-use-package 'hl-todo)
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode))
(setq hl-todo-keyword-faces
      '(("TODO" . "#FF0000")
        ("NOTE" . "#F5EC42")
        ("FIXME" . "#FFA703")))

;;-----------------------------------------------------------
;; ***Kuvakkeet doomia, treemacsia ja dirediä varten.
(straight-use-package 'all-the-icons)
(straight-use-package 'all-the-icons-dired)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

;;-----------------------------------------------------------
;; ***Doom-teemat ja alapalkki***
(straight-use-package 'doom-themes)
(use-package doom-themes)
(load-theme 'doom-gruvbox t)

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 20)))

;;-----------------------------------------------------------
;; ***Swiper parempaa hakua varten***
(straight-use-package 'swiper)

;;-----------------------------------------------------------
;; Ivy-täydennys hakuja yms varten. Counsel ja Ivy-rich tuo lisää ominaisuuksia.
(straight-use-package 'ivy)
(use-package ivy
  :diminish
	:bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-immediate-done)
         :map ivy-switch-buffer-map
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill)))
(ivy-mode 1)

(straight-use-package 'counsel)
(use-package counsel
  :bind (("M-x" . counsel-M-x)))

(straight-use-package 'ivy-rich)
(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1))

;;-----------------------------------------------------------
;; ***which-key***
(straight-use-package 'which-key)
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 6))

;;-----------------------------------------------------------
;; ***ORG-mode***

(straight-use-package 'org)
(defun oskarin-iso-org-hook ()
  (org-indent-mode) ; kauniimpi sisennys hierarkiatasojen mukaan.
  (variable-pitch-mode 0) ; Muuttaa fontin hassuksi - ehkä vähän luettavammaksi.
  (auto-fill-mode 0)
  (visual-line-mode 1)
  )
(use-package org
  :hook (org-mode . oskarin-iso-org-hook)
  :config
  (setq org-ellipsis " ▾" ; Vaihtaa kolmepistettä perästä nuoleksi.
		org-hide-emphasis-markers t)) ; Poistaa lihavoidun, kursivoidun ja linkkitekstin merkinnät.

(defun oskarin-org-keskitys ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(straight-use-package 'visual-fill-column)
(use-package visual-fill-column
  :hook (org-mode . oskarin-org-keskitys))

;; Magit
(straight-use-package 'magit)
(use-package magit)

;;===========================================================
;; ***LSP ja company***
;;-----------------------------------------------------------
;; *** Perus LSP paketti***
(straight-use-package 'lsp-mode)
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c z")
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 5.0)
  (lsp-eldoc-enable-hover t)
  (lsp-signature-render-documentation t)

  ;; This controls the overlays that display type and other hints inline. Enable
  ;; / disable as you prefer. Well require a `lsp-workspace-restart' to have an
  ;; effect on open projects.
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints t)
  (lsp-rust-analyzer-display-reborrow-hints t)
  :config
  (lsp-enable-which-key-integration t)
  )

;; Lisätään tehoja, että lsp jaksaa pyörittää isoja projekteja.
;; Lisää kaistaa => pitäisi kasvattaa nopeuttaa.
(setq read-process-output-max (* 1024 1024))
(setq gc-cons-threshold 100000000)

;; ***ELDOC***
(setq eldoc-echo-area-use-multiline-p t) ; Set to t maybe on pc?
(setq max-mini-window-height 8)

;; ***LSP-UI***
(straight-use-package 'lsp-ui)
(use-package lsp-ui
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-enable t)
  (lsp-ui-sideline-enable nil))

;; ***Tekstin täydennys company***
(straight-use-package 'company)
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map ("<backtab>" . company-complete-selection))
        (:map lsp-mode-map ("<backtab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; ***Esteettisempi company***
(straight-use-package 'company-box)
(use-package company-box
  :hook (company-mode . company-box-mode))

;; ***Treemacs***
(straight-use-package 'treemacs)
(straight-use-package 'lsp-treemacs)
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-c SPC") 'treemacs-select-window)

;;***FLYCHECK***
(straight-use-package 'flycheck)
(use-package flycheck
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode)
  (add-hook 'kotlin-mode-hook 'flycheck-mode))

;;***YASNIPPET****
(straight-use-package 'yasnippet)
(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

;;-----------------------------------------------------------
;; ***Command-log***
(straight-use-package 'command-log-mode)

;;===========================================================
;; ***Ohjelmointikielet***
;;-----------------------------------------------------------
;; ***C/C++***
;; C-tyyliasetukset.
(setq c-default-style "linux")
(setq c-basic-offset 4)

;;Korjaa automaattisen sisennyksen ainakin c:n switchissä.
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'case-label '+)))

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

;;-----------------------------------------------------------
;; ***Java***
(straight-use-package 'lsp-java)
(use-package lsp-java)
(add-hook 'java-mode-hook 'lsp-deferred)
  
;;-----------------------------------------------------------
;; ***Rust***
(straight-use-package 'rustic)
(add-hook 'rustic-mode-hook 'lsp-deferred)
(add-hook 'rustic-mode-hook 'lsp-rust-analyzer-inlay-hints-mode)
(add-hook 'rustic-mode-hook 'lsp-ui-mode)
(add-hook 'rustic-mode-hook 'yas-minor-mode-on)

;;-----------------------------------------------------------
;; ***Python***
;;
;;-----------------------------------------------------------
;; **Kotlin**
(straight-use-package 'kotlin-mode)
;;(add-hook 'kotlin-mode-hook 'lsp-deferred)
;; Optimization
(setq lsp-kotlin-debug-adapter-enabled nil)
(setenv "JAVA_OPTS" "-Xmx8g") ;; Lisää muistia
(straight-use-package 'flycheck-kotlin)

(eval-after-load 'flycheck
  '(progn
    (require 'flycheck-kotlin)
    (flycheck-kotlin-setup)))

;;-----------------------------------------------------------
;; **Typescript** https://gist.github.com/jadestrong/a42251d74f210be7f43744d5cca6bd1e
(straight-use-package 'web-mode)
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2
		
        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        )
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
		(setup-tide-mode))))
  ;; enable typescript-tslint checker
  (flycheck-add-mode 'typescript-tslint 'web-mode))

(straight-use-package 'typescript-mode)
(use-package typescript-mode
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode 'subword-mode))
  
(straight-use-package 'tide)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; if you use typescript-mode
(add-hook 'typescript-mode-hook 'setup-tide-mode)
(setq-default indent-tabs-mode nil)
