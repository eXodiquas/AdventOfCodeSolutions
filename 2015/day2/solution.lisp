;;;; Advent of Code 2015 - Day 2 - Part 1 & 2 - Common Lisp SBCL

;;; Helper functions

(defun read-input (path)
"Reads a file at PATH line by line and returns a list of every line, trimmed by new-lines."
  (with-open-file (stream path)
    (loop for line = (read-line stream nil)
	  while line
	  collect (string-trim '(#\) line))))

(defun sanitize-line (line)
  "Sanitizes the input by transforming XxYxZ => (X Y Z)."
  (mapcar #'parse-integer (uiop:split-string line :separator '(#\x))))

;;; Solution to part 1 and 2. The trick was to sort the inputs.

(defun solve-0 (input)
  "Solves part 1 of the 2015 day 2 puzzle."
  (let* ((i (mapcar #'sanitize-line (read-input input))))
    (loop for line in i
	  summing (let* ((dim (sort line #'<)) ; the trick.
			 (d0 (first dim))
			 (d1 (second dim))
			 (d2 (third dim))
			 (shr (* d0 d1))
			 (s0 (* 2 d0 d1))
			 (s1 (* 2 d1 d2))
			 (s2 (* 2 d0 d2)))
		    (+ s0 s1 s2 shr)))))

(defun solve-1 (input)
  "Solves part 2 of the 2015 day 2 puzzle."
  (let* ((i (mapcar #'sanitize-line (read-input input))))
    (loop for line in i
	  summing (let* ((dim (sort line #'<)) ; the trick again.
			 (d0 (first dim))
			 (d1 (second dim))
			 (d2 (third dim))
			 (vol (* d0 d1 d2))
			 (s0 (* 2 d0))
			 (s1 (* 2 d1)))
		    (+ s0 s1 vol)))))
