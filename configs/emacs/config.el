;;; .doom.d/config.el -*- lexical-binding: t; -*-

(setq mac-command-modifier 'super)
(setq ns-use-native-fullscreen t)
(setq company-idle-delay 0)
(setq company-lsp-cache-candidates 'auto)
(defun nick-mac-hide-last-frame (orig-fun &rest args)
    "Check if last visible frame is being closed and hide it instead."
    (if (and (featurep 'ns)
              (display-graphic-p nil)
              (= 1 (length (frame-list)))) (progn
        (when (eq (frame-parameter (selected-frame) 'fullscreen) 'fullboth)
          (set-frame-parameter (selected-frame) 'fullscreen nil)
          (sit-for 1.2))
        (ns-hide-emacs t)
        (sit-for 1.5)
        (modify-frame-parameters (selected-frame) default-frame-alist)
        (delete-other-windows))
      (apply orig-fun args)))

(defun nick-handle-delete-frame (event)
    "Hide last visible frame when clicking frame close button."
    (interactive "e")
    (let ((frame (posn-window (event-start event))))
      (delete-frame frame t)))

(defun nick-save-buffers-kill-terminal (&optional arg)
    "Hide last visible frame instead of closing Emacs."
    (interactive "P")
    (delete-frame (selected-frame) t))

(advice-add 'delete-frame :around #'nick-mac-hide-last-frame)
(advice-add 'handle-delete-frame :override #'nick-handle-delete-frame)
(advice-add 'save-buffers-kill-terminal :override
    #'nick-save-buffers-kill-terminal)

; (setq menu-bar-mode 1)
;; Place your private configuration here
