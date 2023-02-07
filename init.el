;;===========================================================
;; *** NÄYTÖN ASETUKSET***
;;-----------------------------------------------------------

;; Koko näyttö aloituksessa.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Poistaa aloitusnäytön käytöstä.
(setq inhibit-splash-screen t)

;; Fontin asettaminen.
(set-face-attribute 'default nil :font "Liberation Mono-14")

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

;;===========================================================
;; ***PIKANÄPPÄIMET***
;;-----------------------------------------------------------

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
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-c p") 'transpose-lines)
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

;;===========================================================
;; *** PAKETIT ***
;;-----------------------------------------------------------
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
  (setq which-key-idle-delay 5))

;;===========================================================
;; ***LSP ja company***
;;-----------------------------------------------------------
;; *** Perus LSP paketti***
(straight-use-package 'lsp-mode)
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c l")
  :config (lsp-enable-which-key-integration t))

;; ***Tekstin täydennys***
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
(add-hook 'java-mode-hook 'lsp)
;;-----------------------------------------------------------
;; ***Rust***
;;(straight-use-package 'rust-mode)
;;(use-package rust-mode
;;:hook (rust-mode . lsp))
;;(lsp-rust-analyzer-inlay-hints-mode 1)

(straight-use-package 'rustic)
;;-----------------------------------------------------------
;; ***Python***
;;
;;-----------------------------------------------------------
