;;; emaχ
(deftheme emaχ
  "Monochromatic theme inspired by TeX. Plays nice with colors from other themes.")

;;; Faces
(custom-theme-set-faces
 'emaχ
 ;;;; Base
 '(default ((default
	     :family "NewComputerModern10" ; Has slightly more weight than Latin Modern Roman.
	     :height 135)
	    (((type mac))
	     ;; HiDPI:
	     :height 170)))
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

 ;;;; Mode line
 '(header-line ((default
		 :foreground unspecified
		 :background unspecified
		 :underline t)))
 '(mode-line ((default :inherit default)))
 '(minibuffer-line ((default :inherit nil)))

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

 ;;;; Parentheses
 '(show-paren-match ((default
		      :background unspecified
		      :inherit (bold underline))))
 '(sp-pair-overlay-face ((default
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

 ;;;; Transient
 '(transient-key ((default
		   :family "NewComputerModernMono10" ; Transient keys are never aligned, even with `transient-align-variable-pitch'.
		   :foreground unspecified)))
 
 ;;;; Magit
 '(magit-hash ((default
		:foreground unspecified)))
 '(magit-branch-local ((default
			:foreground unspecified))))
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
 )

(provide-theme 'emaχ)
