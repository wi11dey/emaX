;;; emaχ
(deftheme emaχ
  "Monochromatic theme inspired by TeX. Plays nice with colors from other themes.")

(require 'org-modern)
(require 'olivetti)

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

(defun turn-on-olivetti-mode ()
  (unless (minibufferp)
    (olivetti-mode)))

(define-global-minor-mode global-olivetti-mode
  olivetti-mode
  turn-on-olivetti-mode
  :predicate '(not exwm-mode))

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
 '(success ((default
	     :foreground "unspecified")))
 '(cursor ((default
	    :background "black")))
 '(fringe ((default
	    :background "unspecified")))
 '(variable-pitch ((default
		    :family "unspecified")))
 '(button ((default
	    :foreground "unspecified"
	    :underline t)))
 '(link ((default
	  :foreground "unspecified"
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

 ;;;; Mode line
 '(header-line ((default
		 :foreground "unspecified"
		 :background "unspecified"
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
			    :foreground "unspecified")))
 '(font-lock-builtin-face ((default
			    :foreground "unspecified")))
 '(font-lock-function-name-face ((default
				  :foreground "unspecified")))
 '(font-lock-variable-name-face ((default
				  :foreground "unspecified")))
 '(font-lock-type-face ((default
			 :foreground "unspecified"
			 :inherit bold)))
 '(font-lock-comment-face ((default
			    :foreground "unspecified"
			    :inherit italic)))
 '(font-lock-string-face ((default
			   :family "Latin Modern Roman Unslanted"
			   :foreground "unspecified")))
 '(font-lock-doc-face ((default
			:foreground "unspecified"
			:inherit font-lock-string-face)))
 '(font-lock-constant-face ((default
			     :foreground "unspecified"
			     :inherit default)))

 ;;;; Parentheses
 '(show-paren-match ((default
		      :background unspecified
		      :inherit bold)))
 '(sp-pair-overlay-face ((default
			  :inherit nil)))

 ;;;; Transient
 '(transient-key ((default
		   :family "NewComputerModernMono10" ; Transient keys are never aligned, even with `transient-align-variable-pitch'.
		   :foreground "unspecified")))
 
 ;;;; Magit
 '(magit-section-heading ((default
			   :foreground "unspecified"
			   :inherit outline-8)))
 '(magit-hash ((default
		:foreground "unspecified")))
 '(magit-branch-local ((default
			:foreground "unspecified")))

 ;;;; Compilation
 '(compilation-warning ((default
			 :weight bold)))

 ;;;; Eldoc
 '(eldoc-highlight-function-argument ((default
				       :inherit bold)))

 ;;;; Diff HL
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
 '(ivy-count-format "")
 '(prettify-symbols-alist
   ;; TODO: These should be font-lock-keywords, either to match within symbols or to set the font to NewComputerModernMath.
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
 ;;;; Margin
 ;; The following are minimums:
 '(left-margin-width 2)
 '(right-margin-width 2)
 ;; '(cursor-type '(bar . 2))
 ;;;; Diff HL
 '(diff-hl-fringe-bmp-function #'emaχ-diff-hl-bmp)
 '(diff-hl-draw-borders nil)
 ;;;; Org Modern
 '(global-org-modern-mode t)
 ;;;; Pixel Scroll Precision
 '(pixel-scroll-precision-mode t))

(provide-theme 'emaχ)
