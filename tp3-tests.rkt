#lang racket
(require "tp3.rkt")
; (displayln "Création d'un nouvel objet : Adam")
(define Adam (make-object! "Adam" 'age 21))
; (displayln "Variable d'état name codée en dur pour tous les objets")
(Adam 'understand? 'understand?)      ; #t
(Adam 'understand? 'get-name)         ; #t
(Adam 'get-name)                      ; "Adam"

; (displayln "Variable d'état définie à la création de l'objet")
(Adam 'get-state 'age)               ; 21
(Adam 'set-state! 'age 25)           ; 'age
(Adam 'get-state 'age)               ; 25

; (displayln "Variable d'état ajoutée après la création de l'objet")
(Adam 'get-state 'partner)              ; 'undefined
(Adam 'set-state! 'partner 'Eve)        ; 'partner
(Adam 'get-state 'partner)              ; 'Eve
(Adam 'delete-state! 'partner)          ; 'partner
(Adam 'get-state 'partner)              ; 'undefined

; (displayln "Ajout de méthodes")
(Adam 'understand? 'hi)                       ; #f
(Adam 'hi)                                    ; 'doesNotUnderstand
(Adam 'add-method! 'hi (lambda() "Bonjour"))  ; 'hi
(Adam 'understand? 'hi)                       ; #t
(Adam 'delete-method! 'hi)                    ; 'hi
(Adam 'understand? 'hi)                       ; #f
(Adam 'hi)                                    ; 'doesNotUnderstand
(Adam 'add-method! 'hi (lambda(self) (string-append "Bonjour, je m'appelle " (self 'get-name) )))  ; 'hi
(Adam 'hi Adam)                               ; "Bonjour, je m'appelle Adam"

; (displayln "Création d'un nouvel objet : Eve")
(define Eve (make-object! "Eve"))
(Eve 'understand? 'hi)                                                            ; #f
(Eve 'get-name)                                                                   ; "Eve"
(Eve 'add-method! 'saluer (lambda(self object)
                            (string-append "Bonjour " (object 'get-name)
                                           ", je m'appelle " (self 'get-name) ))) ; 'saluer
(Eve 'saluer Eve Adam)                                                            ; "Bonjour Adam, je m'appelle Eve"