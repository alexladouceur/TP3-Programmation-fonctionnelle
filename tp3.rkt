#lang racket

(provide make-object!)

; ***************** IFT359 / TP3
; ***************** Ladouceur, Alexandre - 22 114 588
; ***************** Gagnon, Alexandre - 22 145 858

(define (make-object! name . props)
  (define (pair-up lst)
    (if (null? lst)
        '()
        (cons (cons (first lst) (second lst))
              (pair-up (cddr lst)))))
  
  (define state (make-hash (pair-up props)))
  (define methods (make-hash))

  (define (get-name) name)

  (define (set-name! new-name)
    (set! name new-name)
    name)

  (define (get-state var)
    (hash-ref state var 'undefined))

  (define (set-state! var value)
    (hash-set! state var value)
    var)

  (define (delete-state! var)
    (if (hash-has-key? state var)
        (begin
          (hash-remove! state var)
          var)
        'undefined))

  (define (understand? selector)
      (hash-has-key? methods selector))

  (define (add-method! selector method)
    (hash-set! methods selector method)
    selector)

  (define (delete-method! selector)
    (if (understand? selector)
        (begin
          (hash-remove! methods selector)
          selector)
        'undefined))

  (define (dispatch m . args) 
    (cond ((eq? m 'get-name) (get-name)) 
          ((eq? m 'set-name!) (apply set-name! args)) 
          ((eq? m 'get-state) (apply get-state args)) 
          ((eq? m 'set-state!) (apply set-state! args))
          ((eq? m 'delete-state!) (apply delete-state! args)) 
          ((eq? m 'understand?) (apply understand? args)) 
          ((eq? m 'add-method!) (apply add-method! args)) 
          ((eq? m 'delete-method!) (apply delete-method! args)) 
          [else
           (let ([method (hash-ref methods m #f)])
             (if method
                 (apply method args)
                 'doesNotUnderstand))]))

  (hash-set! methods 'get-name get-name)
  (hash-set! methods 'set-name! set-name!)
  (hash-set! methods 'get-state get-state)
  (hash-set! methods 'set-state! set-state!)
  (hash-set! methods 'delete-state! delete-state!)
  (hash-set! methods 'understand? understand?)
  (hash-set! methods 'add-method! add-method!)
  (hash-set! methods 'delete-method! delete-method!)
  
  dispatch)