



(def x (+ 5 
               (comp 
                  (partial + 10)
                  (partial + 10)
                  (partial + 10)
                  (partial + 1))))
