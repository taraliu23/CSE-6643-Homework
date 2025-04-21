
#----------------------------------------
# Problem a
#----------------------------------------
# This function takes in a matrix A and returns the 
# kmax × kmax supmatrix of itsupper Hessenberg form 
# The matrix A should be only accessed through 
# (kmax - 1) matrix-vector products
function arnoldi(A, q1, kmax)

        H = zeros(kmax, kmax)
        r = copy(q1[:, 1])

        # q1[:1] = r / norm(r)
        n = size(A, 1)
        q1 = zeros(n, kmax)
        q1[:, 1] = r / norm(r)

        for k = 1:kmax
                if k > 1
                        q1[:, k] = r / H[k, k-1]
                end

                r = A * q1[:, k]
                for i = 1:k
                        #  vector orthogonalization
                        H[i, k] = dot(q1[:, i], r)
                        r -= H[i, k] * q1[:, i]
                end

                if k < kmax
                        H[k+1, k] = norm(r)
                end
        end
        return H
end


#----------------------------------------
# Problem b
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
        T = zeros(kmax, kmax)
        r = copy(q1[:, 1])
        α = 0
        β = norm(r)
        n = size(A, 1)
        q1 = zeros(n)

        for k = 1:kmax
                q0 = copy(q1)
                q1 = r / β
                r = A * q1
                α = dot(q1, r)
                T[k, k] = α

                if k > 1
                        T[k-1, k] = β
                        T[k, k-1] = β
                end

                r = r - α * q1 - β * q0
                β = norm(r)
        end

        return α, β
end