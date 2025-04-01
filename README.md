# Code for Numerical Linear Algebra



## Run in your machine

Using hw4 as an example:

``` bash
cd HW4_code
```

``` bash
julia --project=. HW4_driver.jl
```
## Resources
<img 
  src="https://github.com/user-attachments/assets/34de3660-cd51-4254-8f5c-7284b2841219" 
  alt="drawing" 
  width="600"
  align="center"
  />

[数值线性代数](https://kuidu.github.io/nla.html)

[数值线性代数基础复习](http://faculty.bicmr.pku.edu.cn/~wenzw/optbook/lect/04-num_lin_alg-newl.pdf)

[通俗易懂：什么是正交矩阵](https://zhuanlan.zhihu.com/p/684677360)

## Review Notes (Chinese & English, messy)

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

- Every Hermitian positive-definite matrix (and thus also every real-valued symmetric positive-definite matrix) has a unique Cholesky decomposition.

- A matrix is diagonalizable if and only if there exists a factored polynomial of single roots at is 0 when you evaluate it with the matrix. For instance if (A-1)(A+2)A = 0, then A is diagonalizable and its eigenvalues are (+1, -2, 0), but you cannot say anything about their multiplicity.

- A singular matrix is a square matrix whose determinant is zero. Since the determinant is zero, a singular matrix is non-invertible, which does not have an inverse.