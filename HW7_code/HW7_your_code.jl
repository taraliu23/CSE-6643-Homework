
#----------------------------------------
# Problem a
#----------------------------------------
# This function takes in a matrix A and returns the 
# kmax × kmax supmatrix of itsupper Hessenberg form 
# The matrix A should be only accessed through 
# (kmax - 1) matrix-vector products
function arnoldi(A, q1, kmax)
        
        # Your code here

        return H
end

#----------------------------------------
# Problem a
#----------------------------------------
# This function takes in a matrix A and returns the 
# kmax × kmax supmatrix of its tridiagonal form 
# computed by the Lanczos iteration.
# The matrix A should be only accessed through 
# (kmax - 1) matrix-vector products
# The output vectors should be the diagonal (α)
# and the offdiagonal (β) of the tridiagonal matrix
function lanczos(A, q1, kmax)

        # Your code here

        return α, β
end