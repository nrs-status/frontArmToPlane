



(def x (+ 1 (+ 5 
               ((comp 
                  (partial + 10)
                  (partial + 5)
                  (partial + 1)) 7))))
