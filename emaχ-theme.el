;;; emaχ
(deftheme emaχ
  "Distraction-free, monochromatic theme inspired by TeX. Plays nice with other themes.")

(require 'olivetti)
(defvar org-appear-mode nil)
(autoload 'org-appear-mode "org-appear"
  "A minor mode that automatically toggles elements in Org mode.

This is a minor mode.  If called interactively, toggle the
`Org-Appear mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `org-appear-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t)
(defvar org-modern-mode nil)
(autoload 'org-modern-mode "org-modern"
  "Modern looks for Org.

This is a minor mode.  If called interactively, toggle the
`Org-Modern mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `org-modern-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled." t)

(define-fringe-bitmap 'emaχ-diff-hl
  (make-vector 1 #b00000011)
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

(defun turn-on-olivetti-mode ()
  (unless (minibufferp)
    (olivetti-mode)))

(define-global-minor-mode global-olivetti-mode
  olivetti-mode
  turn-on-olivetti-mode
  :predicate '(not exwm-mode))

(define-global-minor-mode global-org-appear-mode
  org-appear-mode
  org-appear-mode
  :predicate '(org-mode))

;; Not using the one included with org-modern so that org-modern (which in turn, loads org) doesn't have to be loaded when the theme loads:
(define-global-minor-mode emaχ-global-org-modern-mode
  org-modern-mode
  org-modern-mode
  :group 'org-modern
  :predicate '(org-mode))

;;; Faces
(custom-theme-set-faces
 'emaχ
 ;;;; Base
 '(default ((default
	     :family "NewComputerModern10"
	     :weight book
	     :height 140)
	    (((type mac))
	     ;; HiDPI:
	     :height 170)))
 '(fixed-pitch ((default
		 :family "NewComputerModernMono10"
		 :weight regular
		 :height 1.05)))
 '(success ((default
	     :foreground unspecified)))
 '(cursor ((default
	    :background "black")))
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
	       :family "Latin Modern Roman"
	       :weight thin
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
	       :inherit bold)))
 '(outline-minor-0 ((default
		     :inherit nil)))

 ;;;; Org
 ;; TODO: Need to fix variable-pitch indentation to get rid of this:
 '(org-document-title ((default
			:inherit outline-1)))
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

 ;;;; Transient
 '(transient-key ((default
		   :family "NewComputerModernMono10" ; Transient keys are never aligned, even with `transient-align-variable-pitch'.
		   :foreground unspecified)))
 
 ;;;; Magit
 '(magit-section-heading ((default
			   :foreground unspecified
			   :inherit outline-8)))
 '(magit-hash ((default
		:foreground unspecified)))
 '(magit-branch-local ((default
			:foreground unspecified)))
 '(git-commit-summary ((default
			:foreground unspecified)))

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
				     :foreground "unspecified"))))

;;; Variables
(custom-theme-set-variables
 'emaχ
 '(cursor-in-non-selected-windows nil)
 '(ivy-count-format "")
 '(prettify-symbols-alist
   ;; TODO: These should be font-lock-keywords, either to match within symbols or to set the font to NewComputerModernMath:
   '(("<=" . ?⩽)
     (">=" . ?⩾)
     ("==" . ?≡)
     ("===" . ?≣)
     ("in" . ?∈)
     ("ff" . ?ﬀ)
     ("fi" . ?ﬁ)
     ("fl" . ?ﬂ)
     ("ffi" . ?ﬃ)
     ("ffl" . ?ﬄ)
     ("ae" . ?æ)
     ("*" .  ?∗)))
 '(mode-line-format nil)
 '(dired-async-message-function #'message)
 '(transient-align-variable-pitch t)
 '(indicate-empty-lines nil)
 ;; '(cursor-type '(bar . 2))
 '(global-olivetti-mode t)
 ;;;; Diff HL
 '(diff-hl-fringe-bmp-function #'emaχ-diff-hl-bmp)
 '(diff-hl-draw-borders nil)
 ;;;; Org
 '(org-hide-emphasis-markers t)
 '(org-link-descriptive t)
 '(org-pretty-entities t)
 '(org-hidden-keywords '(title))
 ;;;;; Modern
 '(emaχ-global-org-modern-mode t)
 ;;;;; Appear
 '(global-org-appear-mode t)
 '(org-appear-autoemphasis t)
 '(org-appear-autolinks t)
 '(org-appear-autosubmarkers t)
 '(org-appear-autoentities t)
 '(org-appear-autokeywords t)
 '(org-appear-inside-latex t)
 ;;;; Pixel Scroll Precision
 '(pixel-scroll-precision-mode t))

(provide-theme 'emaχ)
