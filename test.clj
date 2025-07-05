



(+ 5 
               ((comp 
                  (partial + 10)
                  (partial + 10)
                  (partial + 10)
                  (fn [x] (partial + 1))
                  ) 5))
