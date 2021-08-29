;;;; Advent of Code 2015 - Day 3 - Part 1 & 2 - Common Lisp SBCL

;;; Helper functions

(defun read-input (path)
"Reads a file at PATH line by line and returns a list of every line, trimmed by new-lines."
  (with-open-file (stream path)
    (loop for line = (read-line stream nil)
	  while line
	  collect (string-trim '(#\) line))))

;;; Solution part 1
;;; Basically solved by a hash table, inserting the current position of santa and incrementing the present count at that position in a hash table. After all presents were inserted into the hash table we just count the number of entries and that's the result.
(defun solve-0 (path)
  (let ((inp (read-input path))
	(hsh (make-hash-table :test 'equal)))
    (loop for d across (car inp)
	  with x = 0
	  with y = 0 do
	    (setf (gethash (list x y) hsh) (1+ (gethash (list x y) hsh 0)))
	    (cond ((char= #\^ d) (incf y))
		  ((char= #\> d) (incf x))
		  ((char= #\< d) (decf x))
		  ((char= #\v d) (decf y))))
    (hash-table-count hsh)))

;;; Solution part 2
;;; Same as the solution to part 1 but with the difference that we iterated the input in pairs. So every iteration we have two directions. One for santa and one for robo santa. We do exactly what we did in part 1 for both santas and at the end we count the entries in the hash table. Because my input has an odd number of characters we have to add 1 at the end because my loop stopped one iteration too early.
(defun solve-1 (path)
  (let ((inp (read-input path))
	(hsh (make-hash-table :test 'equal)))
    (loop for (sd rd) on (coerce (car inp) 'list) by #'cddr
	  with sx = 0
	  with sy = 0
	  with rx = 0
	  with ry = 0 do
	    (setf (gethash (list sx sy) hsh) (1+ (gethash (list sx sy) hsh 0)))
	    (setf (gethash (list rx ry) hsh) (1+ (gethash (list rx ry) hsh 0)))
	    (cond ((char= #\^ sd) (incf sy))
		  ((char= #\> sd) (incf sx))
		  ((char= #\< sd) (decf sx))
		  ((char= #\v sd) (decf sy)))
	    (cond ((char= #\^ rd) (incf ry))
		  ((char= #\> rd) (incf rx))
		  ((char= #\< rd) (decf rx))
		  ((char= #\v rd) (decf ry))))
    (1+ (hash-table-count hsh)))) ; because of an uneven number of input characters
