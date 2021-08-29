;;;; Advent of Code 2015 - Day 4 - Part 1 & 2 - Common Lisp SBCL

;;; The input is just this string so I don't parse it from a file this time.
(defparameter *input* "ckczppom")

;;; Helper functions

;;; This problem needs the md5 hash. I use the ironclad package for the md5 hash.
(defun md5 (str)
  (ironclad:byte-array-to-hex-string
    (ironclad:digest-sequence :md5 
                              (ironclad:ascii-string-to-byte-array str))))

(defun concat-string-number (s n)
  "Concatenates a string and a number. Can concatenate more, but is used for string and number. :P"
  (format nil "~a~a" s n))

(defun solution5-foundp (sol)
  "Checks if the first 5 characters of a string are all zeroes."
  (equal (subseq sol 0 5) "00000"))

(defun solution6-foundp (sol)
  "Checks if the first 6 characters of a string are all zeroes."
  (equal (subseq sol 0 6) "000000"))


;;; Solution part 1

;;; Brute forces the solution to part 1 by appending a number to the input string and checks if the result starts with "00000", if so it returns the number i, if not it checks the next number. I have no idea if there is a shortcut because I have no idea how MD5 works, so I have to solve it like this. #sadlife => 117946 was pretty fast to find.
(defun solve-0 (input)
  (loop for i from 0
	when (solution5-foundp (md5 (concat-string-number input i)))
	  return i))

;;; Solution part 2
;;; Exactly the same as part 1, just a alternative solution-foundp function. => 3938038, took about 4,5 seconds.
(defun solve-1 (input)
  (loop for i from 0
	when (solution6-foundp (md5 (concat-string-number input i)))
	  return i))
