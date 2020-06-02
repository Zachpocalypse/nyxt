(in-package :next)

(defun get-text-from-external-editor ()
  "Open an external editor to capture text. Please note, this function
is blocking, invoke on a separate thread when possible."
  (uiop:with-temporary-file (:directory (uiop:xdg-data-home +data-root+) :pathname p)
    (let ((visual-editor (or (visual-editor *browser*)
                             (uiop:getenv "VISUAL"))))
      (log:debug "Visual Editor: ~a opening: ~a" (visual-editor *browser*) p)
      (uiop:run-program (list visual-editor (uiop:native-namestring p)))
      (uiop:read-file-string p))))