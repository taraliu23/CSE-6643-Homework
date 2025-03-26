- 奇异矩阵和非奇异矩阵是属于方阵的概念，只要不是方阵，那这俩概念就免谈了。然后，再看此矩阵的行列式|A|是否等于0：|A|等于0，A就是奇异矩阵;反之则是非奇异矩阵。

- 可逆矩阵 = 非奇异矩阵 non-singular matrix

- 特征分解Eigendecomposition/谱分解Spectral decomposition: 将矩阵分解为由其特征值和特征向量表示的矩阵之积的方法。 

- 注意只有对可对角化矩阵才可以特征分解。

- 幂迭代法 Power Method Mechanics


- All eigenproblem methods must be iterative: they must consist of improving an initial guess, in successive steps, so that it converges towards the exact result to any desired accuracy, but never actually reaches the exact answer in general. 

- 标准正交基Orthonormal basis：一个内积空间的正交基是元素两两正交的基。称基中的元素为基向量。正交基基向量的模长都是单位长度1，则称这正交基为标准正交基或"规范正交基"。 

- QR iteration is known for being numerically stable and widely used in practice.

- LU iteration, especially without pivoting, is less stable — but her e it’s applied to a special case: symmetric positive-definite matrices.

- 单位矩阵Identity Matrix(I)主对角线上的元素全为1，其他元素全为0。

- Positive definite matrix has a unique positive definite square root.

- Every Hermitian positive-definite matrix (and thus also every real-valued symmetric positive-definite matrix) has a unique Cholesky decomposition