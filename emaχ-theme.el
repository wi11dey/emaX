;;; emaχ-theme.el --- Minimalist, monochromatic theme inspired by TeX -*- lexical-binding: t; -*-

;; Author: Will Dey
;; Maintainer: Will Dey
;; Keywords: theme monochromatic tex
;; Version: 1.0.0
;; Created: November 2018
;; Package-Requires: ((olivetti "2.0.5") (org-appear "0.3.0") (org-modern "0.10") (outline-minor-faces "1.0.0"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(deftheme emaχ
  "Minimalist, monochromatic theme inspired by TeX.

Plays nice with colors from other themes.")

;;; Modes
;;;; Ligature
;; TODO: Do this manually since we need to edit `composition-function-table' manually anyway for compositions like \\, \\\, >>=, <=>, >=>, TeX, LaTeX, OPmac, &c.
;; (require 'ligature)

;;;; Olivetti
(defvar olivetti-mode nil)
(autoload 'olivetti-mode "olivetti")
(define-globalized-minor-mode global-olivetti-mode
  olivetti-mode
  (lambda ()
    (unless (minibufferp)
      (olivetti-mode)))
  :predicate '(not exwm-mode)
  :group 'org-appear)

;;;; Org
;;;;; Appear
(defvar org-appear-mode nil)
(autoload 'org-appear-mode "org-appear")
(define-global-minor-mode global-org-appear-mode
  org-appear-mode
  org-appear-mode
  :predicate '(org-mode))

;;;;; Modern
;; Not using the one included with org-modern so that `org-modern' (which in turn loads `org') doesn't have to be loaded when the theme loads:
(defvar org-modern-mode nil)
(autoload 'org-modern-mode "org-modern")
(define-global-minor-mode emaχ-global-org-modern-mode
  org-modern-mode
  org-modern-mode
  :group 'org-modern
  :predicate '(org-mode))

;;;; Outline Minor Mode
;;;;; Lisp
(autoload 'outline-minor-faces--syntactic-matcher "outline-minor-faces")
(defun emaχ-lisp-outline-minor-mode-indent-level ()
  (let ((match (match-string-no-properties 1)))
    (cond
     (match (length match))
     ((looking-at (rx ?\s (not blank))) 2)
     (t 1))))

(define-minor-mode emaχ-lisp-outline-minor-mode
  "Minor mode to enable emaχ-themed headings in Lisp source code.

Headings are comments with more than 2 starting semicolons. Their levels are determined by `emaχ-lisp-outline-minor-mode-indent-level', which see."
  :lighter nil
  (if emaχ-lisp-outline-minor-mode
      (rx-let (
               (indent (0+ (any ?\s ?\t)))
               (levels (and
                        ?\;
                        (group-n 3
                          ?\;
                          (group-n 1
                            (1+ ?\;)))
                        (not ?#))))
        (setq-local
         outline-regexp (rx indent levels)
         outline-minor-faces-regexp (rx line-start
                                        indent
                                        (group-n 2
                                          levels
                                          (0+ not-newline)
                                          (? ?\n)))
         outline-minor-faces--font-lock-keywords `(
                                                   (eval . '(,(outline-minor-faces--syntactic-matcher outline-minor-faces-regexp)
                                                             (2 `(face ,(outline-minor-faces--get-face)) t)
                                                             (3 `(face default invisible ,(list t)) t)))
                                                   (,(rx "-*-" (0+ not-newline) "-*-") 0 'outline-minor-file-local-prop-line t))
         outline-level #'emaχ-lisp-outline-minor-mode-indent-level
         font-lock-extra-managed-props (if (memq 'invisible font-lock-extra-managed-props)
                                           font-lock-extra-managed-props
                                         (cons 'invisible font-lock-extra-managed-props)))
        (outline-minor-mode)
        (outline-minor-faces-mode))
    (outline-minor-mode -1)
    (outline-minor-faces-mode -1)
    (kill-local-variable 'outline-regexp)
    (kill-local-variable 'outline-minor-faces-regexp)
    (kill-local-variable 'outline-level)
    (kill-local-variable 'outline-minor-faces--font-lock-keywords)
    (font-lock-flush)))

(define-globalized-minor-mode global-emaχ-lisp-outline-minor-mode
  emaχ-lisp-outline-minor-mode
  emaχ-lisp-outline-minor-mode
  :predicate '(emacs-lisp-mode)
  :group 'outlines)

;;;; emaχ
(defgroup emaχ nil
  ""
  :group 'faces)

(defun emaχ-prettify-font-lock-keyword (original newchar)
  `(,(format "\\(%s\\)+" (regexp-quote original))
    0
    `( face default
       display ,(make-string (/ (- (match-end 0) (match-beginning 0))
				,(length original))
			     ,newchar))))

(defconst emaχ-font-lock-keywords
  ;; (list (emaχ-prettify-font-lock-keyword "ff" ?ﬀ)
  ;;      (emaχ-prettify-font-lock-keyword "fi" ?ﬁ)
  ;;      (emaχ-prettify-font-lock-keyword "fl" ?ﬂ)
  ;;      (emaχ-prettify-font-lock-keyword "ffi" ?ﬃ)
  ;;      (emaχ-prettify-font-lock-keyword "ffl" ?ﬄ)
  ;;      (emaχ-prettify-font-lock-keyword )
  ;;      (emaχ-prettify-font-lock-keyword "AE" ?Æ)
  ;;      (emaχ-prettify-font-lock-keyword "*" ?∗)
  ;;      (emaχ-prettify-font-lock-keyword "st" ?ﬆ)
  ;;      '("^[ \t]+" 0 'fixed-pitch t append))
  '(("^[ \t]+" 0 'fixed-pitch t append)))

(defcustom emaχ-ligatures
  '("ff" "fi" "fl" "ffi" "ffl"
    ;; ("ae" . ?æ) ("AE" . ?Æ) ("st" . ?ﬆ) ;; TODO: These must be shaped manually.
    )
  "List of ligatures to enable."
  :type '(repeat string))

(define-minor-mode emaχ-mode
  "Minor mode to enable "
  :lighter nil
  (let (ligature-composition-table)
    (ligature-set-ligatures t emaχ-ligatures)
    (ligature-mode)))

;;; Fringe
;;;; Diff HL
(define-fringe-bitmap 'emaχ-diff-hl
  (make-vector 1 #b11000000)
  nil nil
  '(top :periodic))
(define-fringe-bitmap 'emaχ-diff-hl-delete
  (make-vector 2 #b11111111)
  nil nil
  'top)
(defun emaχ-diff-hl-bmp (type _pos)
  (if (eq type 'delete)
      'emaχ-diff-hl-delete
    'emaχ-diff-hl))

;;; Faces
(defconst emaχ-default-family "NewComputerModern10")
;;;; Fontset
(defun emaχ--setup-fontset (theme)
  "Add fontset overrides for the emaχ theme when THEME is `emaχ' and the current fontset"
  (when (eq theme 'emaχ)
    (let ((fontset (face-attribute 'default :fontset)))
      (when (string-match-p (concat emaχ-default-family ".*fontset-auto[[:digit:]]+$")
                            (face-attribute 'default :fontset))
        ;; Fallback font:
        (set-fontset-font fontset
			  'latin
			  (font-spec :family "Latin Modern Roman" :weight 'regular)
			  nil
			  'append)
        (set-fontset-font fontset
			  'symbol
			  (font-spec :family "NewComputerModernMath")
			  nil
			  'prepend)))))

(custom-theme-set-faces
 'emaχ
 ;;;; Base
 `(default ((default
	     :family ,emaχ-default-family
	     :height 140)
	    (((type mac))
	     ;; HiDPI:
	     :height 170)))
 '(cursor ((((background light))
	    :background "black")
	   (((background dark))
	    :background "white")))
 '(fixed-pitch ((default
		 :family "Latin Modern Mono"
		 :weight regular)))
 '(success ((default
	     :foreground unspecified)))
 '(fringe ((default
	    :background unspecified)))
 '(variable-pitch ((default
		    :family unspecified)))
 '(button ((default
	    :foreground unspecified
	    :underline t)))
 '(link ((default
	  :foreground unspecified
	  :underline t)))
 '(custom-button ((default
		   :box (:line-width (1 . 1) :color "black" :style released-button)
		   :inherit nil)))

  ;;;; Headings
 '(outline-minor-file-local-prop-line ((default
					:inherit nil)))
 '(outline-1 ((default
	       :height 1.25
	       :weight thin
	       :foreground unspecified
	       :inherit outline-2)))
 '(outline-2 ((default
	       :height 1.2
	       :inherit outline-3)))
 '(outline-3 ((default
	       :slant normal
	       :inherit outline-4)))
 '(outline-4 ((default
	       :height 1.2
	       :slant italic
	       :inherit outline-5)))
 '(outline-5 ((default
	       :slant normal
	       :inherit outline-6)))
 '(outline-6 ((default
	       :slant italic
	       :inherit outline-7)))
 '(outline-7 ((default
	       :inherit outline-8)))
 '(outline-8 ((default
	       :family "Latin Modern Roman"
	       :inherit bold)))
 '(outline-minor-0 ((default
		     :inherit nil)))

 ;;;; Org
 '(org-document-title ((default
			:inherit outline-1)))
 '(org-level-1 ((default
		 :inherit outline-2)))
 '(org-level-2 ((default
		 :inherit outline-3)))
 '(org-level-3 ((default
		 :inherit outline-4)))
 '(org-level-4 ((default
		 :inherit outline-5)))
 '(org-level-5 ((default
		 :inherit outline-6)))
 '(org-level-6 ((default
		 :inherit outline-7)))
 '(org-level-7 ((default
		 :inherit outline-8)))
 '(org-level-8 ((default
		 :inherit outline-7)))
 '(org-quote ((default
	       :inherit italic)))
 '(org-verse ((default
	       :inherit org-verse)))
 '(org-drawer ((default
		:height 0.9)))
 '(org-property-value ((default
			:inherit org-drawer)))
 ;; TODO: Need to fix variable-pitch indentation to get rid of this:
 '(org-block ((default
	       :inherit fixed-pitch)))

 ;;;; Mode line
 '(header-line ((default
		 :foreground unspecified
		 :background unspecified
		 :underline t)))
 '(mode-line ((default :inherit default)))
 '(minibuffer-line ((default :inherit nil)))

 ;;;; Help
 '(help-key-binding ((default
		      :inherit minibuffer-prompt)))

 ;;;; Dired
 ;;;;; Dired Subtree
 '(dired-subtree-line-prefix "    ")
 ;;;;; DiredFL
 '(diredfl-dir-heading ((default
			 :inherit outline-8)))
 '(diredfl-no-priv ((default
		     :inherit org-hide)))
 `(diredfl-file-name ((default
		       ;; Override `fixed-pitch':
		       :family ,emaχ-default-family)))
 '(diredfl-dir-name ((default
		      :inherit (underline diredfl-file-name))))
 '(diredfl-date-time ((default
		       :foreground unspecified)))

 ;;;; Minibuffer
 '(minibuffer-prompt ((default
		       :inherit bold)))
 ;;;;; Ivy
 '(ivy-current-match ((default
		       :inherit underline)))
 '(ivy-minibuffer-match-face-1 ((default
				 :inherit bold)))
 '(ivy-minibuffer-match-face-2 ((default
				 :inherit ivy-minibuffer-match-face-1)))
 '(ivy-minibuffer-match-face-3 ((default
				 :inherit ivy-minibuffer-match-face-1)))
 '(ivy-minibuffer-match-face-4 ((default
				 :inherit ivy-minibuffer-match-face-1)))

 ;;;; Font lock
 '(font-lock-keyword-face ((default
			    :foreground unspecified)))
 '(font-lock-builtin-face ((default
			    :foreground unspecified)))
 '(font-lock-function-name-face ((default
				  :foreground unspecified)))
 '(font-lock-variable-name-face ((default
				  :foreground unspecified)))
 '(font-lock-type-face ((default
			 :foreground unspecified
			 :inherit bold)))
 '(font-lock-comment-face ((default
			    :foreground unspecified
			    :inherit italic)))
 '(font-lock-string-face ((default
			   :family "Latin Modern Roman Unslanted"
			   :foreground unspecified)))
 '(font-lock-doc-face ((default
			:foreground unspecified
			:inherit font-lock-string-face)))
 '(font-lock-constant-face ((default
			     :foreground unspecified
			     :inherit default)))
 '(font-lock-warning-face ((default
			    :inherit bold)))

 ;;;; Parentheses
 '(show-paren-match ((default
		      :background unspecified
		      :inherit bold)))
 '(sp-pair-overlay-face ((default
			  :inherit nil)))

 ;;;; Keys
 '(transient-key ((default
		   :family "NewComputerModernMono10" ; Transient keys are never aligned, even with `transient-align-variable-pitch'.
		   :foreground unspecified)))
 '(modus-themes-key-binding ((default
                              :foreground unspecified)))
 
 ;;;; Magit
 '(magit-section-heading ((default
			   :foreground unspecified
			   :inherit (outline-8 variable-pitch))))
 '(magit-hash ((default
		:foreground unspecified
		:inherit fixed-pitch)))
 '(magit-branch-local ((default
			:foreground unspecified)))
 '(magit-diff-file-heading ((default
			     :foreground unspecified)))
 '(magit-branch-remote ((default
			 :foreground unspecified)))
 '(git-commit-summary ((default
			:foreground unspecified)))
 ;;;;; Log
 '(magit-log-author ((default
		      :foreground unspecified
		      :inherit fixed-pitch)))
 '(magit-log-date ((default
		    :foreground unspecified
		    :inherit fixed-pitch)))
 '(magit-log-graph ((default
		     :foreground unspecified
		     :inherit (shadow fixed-pitch))))

 ;;;; Compilation
 '(compilation-warning ((default
			 :weight bold)))

 ;;;; Eldoc
 '(eldoc-highlight-function-argument ((default
				       :inherit bold)))

 ;;;; Diff HL
 ;; The string "unspecified" here causes the face engine to use values from the `default' face, whereas the symbol `unspecified' will use face inheritance.
 '(diff-hl-change ((default
		    :inverse-video t
		    :foreground "unspecified")))
 '(diff-hl-delete ((default
		    :inverse-video t
		    :foreground "unspecified")))
 '(diff-hl-insert ((default
		    :inverse-video t
		    :foreground "unspecified")))
 '(diff-hl-reverted-hunk-highlight ((default
				     :inverse-video t
				     :foreground "unspecified")))

 ;;;; Rec
 '(rec-field-name-face ((default
			 :inherit outline-8)))

 ;;;; Info
 '(Info-quoted ((default
		 :inherit nit)))

 ;;;; Custom
 '(custom-variable-tag ((default
			 :foreground unspecified)))
 '(custom-state ((default
		  :foreground unspecified))))

;;; Variables
(custom-theme-set-variables
 'emaχ
 '(x-underline-at-descent-line nil)
 '(auto-dim-other-buffers-mode nil)
 '(dired-subtree-use-backgrounds nil)
 '(fringe-mode '(16 . 0))
 '(enable-theme-functions (cons #'emaχ--setup-fontset enable-theme-functions))
 '(indicate-buffer-boundaries nil)
 '(dired-free-space nil)
 '(cursor-in-non-selected-windows nil)
 '(ivy-count-format "")
 '(mode-line-format nil)
 '(dired-async-message-function #'message)
 '(transient-align-variable-pitch t)
 '(indicate-empty-lines nil)
 ;; '(cursor-type '(bar . 2))
 '(read-hide-char ?•)
 '(global-olivetti-mode t)
 ;;;; Prettify symbols
 '(global-prettify-symbols-mode t)
 '(prettify-symbols-alist
   '(("<=" . ?⩽)
     (">=" . ?⩾)
     ("==" . ?≡)
     ("!=" . ?≠)
     ("===" . ?≣)
     ("!==" . ?≢)
     ("&&" . ?∧)
     ("||" . ?∨)
     ("|>" . ?▷)
     ("<|" . ?◁)
     ("!" . ?¬)
     ("::" . ?∷)
     ("//" . ?⫽)
     ("///" . ?⫻)
     ("->" . ?→)
     ("<-" . ?←)
     ("=>" . ?⇒)
     ("??" . ?⁇)
     ("..." . ?⋯)
     ("++". ?⧺)
     ("--" . ?–)
     ("---" . ?—)))
 '(lisp-prettify-symbols-alist (cons '("lambda"  . ?λ)
				     (symbol-value 'prettify-symbols-alist)))
 ;;;; Window Divider
 '(window-divider-default-places t)
 '(window-divider-default-right-width 1)
 '(window-divider-default-bottom-width 1)
 '(window-divider-mode t)
 ;;;; Diff HL
 '(diff-hl-fringe-bmp-function #'emaχ-diff-hl-bmp)
 '(diff-hl-draw-borders nil)
 ;;;; Org
 '(org-startup-folded nil)
 '(org-hide-emphasis-markers t)
 '(org-link-descriptive t)
 '(org-pretty-entities t)
 '(org-hidden-keywords '(subtitle title))
 '(org-startup-indented nil)
 '(org-n-level-faces 8)
 '(org-fontify-quote-and-verse-blocks t)
 ;;;;; Modern
 '(emaχ-global-org-modern-mode t)
 '(org-modern-block-fringe 2)
 '(org-modern-star '("§"))
 ;;;;; Appear
 '(global-org-appear-mode t)
 '(org-appear-autoemphasis t)
 '(org-appear-autolinks t)
 '(org-appear-autosubmarkers t)
 '(org-appear-autoentities t)
 '(org-appear-autokeywords t)
 '(org-appear-inside-latex t)
 ;;;; Pixel Scroll Precision
 '(pixel-scroll-precision-mode (not (eq window-system 'mac)))
 ;;;; Outline Minor Mode
 ;;;;; Emacs Lisp
 '(global-emaχ-lisp-outline-minor-mode t))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'emaχ)

;;; emaχ-theme.el ends here
