from dokusan import generators
import numpy as np

arr = np.array(list(str(generators.random_sudoku(avg_rank=150))))
arr = [eval(i) for i in arr]
print(arr)