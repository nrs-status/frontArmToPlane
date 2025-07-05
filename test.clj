



(def x (+ 1 (+ 5 
               (comp 
                  (partial + 10)
                  (partial + 10)
                  (partial + 10)
                  (partial + 1)))))
