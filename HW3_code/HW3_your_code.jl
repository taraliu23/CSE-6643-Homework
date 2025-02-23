#----------------------------------------
# Problem a
#----------------------------------------
# This function takes in the LU factorization
# together with the permutation P (in the form of
# an array of integers such that P[i] = j means that multiplication with P moves the i=th row to the j-th position)
# It should modify the input variable x in place


function substitution!(x, LU, P=1:size(x, 1))
    # YOUR CODE HERE

    m = size(LU, 1)
    y = similar(x)

    x_p = x[P]

    for i in 1:m
        d_p = 0.0
        for j in 1:i-1
            d_p += LU[i, j] * y[j]
        end
        y[i] = x_p[i] - d_p
    end

    for i in m:-1:1
        d_p = 0.0
        for j in i+1:m
            d_p += LU[i, j] * x[j]
        end
        x[i] = (y[i] - d_p) / LU[i, i]
    end

    return x


end

#----------------------------------------
# Problem b
#----------------------------------------
# This function takes in a matrix A and modifies
# it in place, such that is contains the stricly
# lower triangular part of L together with the
# upper triangular part of U.
function unpivoted_LU!(A)
    # YOUR CODE HERE

    m = size(A, 1)

    for k in 1:m-1
        for i in k+1:m
            A[i, k] /= A[k, k]  # Compute L[i, k]
            for j in k+1:m
                A[i, j] -= A[i, k] * A[k, j]  # Update U[i, j]
            end
        end
    end

    return A
end

#----------------------------------------
# Problem d
#----------------------------------------
# This function takes in a matrix A and modifies
# it in place, such that is contains the stricly
# lower triangular part of L together with the
# upper triangular part of U.
# It uses row-pivoting and stores the resulting 
# row permutation in the array P
function pivoted_LU!(A)
    # The array that will be used to keep track of the permutation
    P = collect(1:size(A, 1))
    # YOUR CODE HERE

    # m = size(A, 1)
    m = size(A, 1)
    for k in 1:m-1


        p_row = argmax(abs.(A[k:m, k])) + k - 1
        if p_row != k

            A[[k, p_row], :] = A[[p_row, k], :]
            P[k], P[p_row] = P[p_row], P[k]
        end

        for i in k+1:m
            A[i, k] /= A[k, k]
            for j in k+1:m
                A[i, j] -= A[i, k] * A[k, j]
            end
        end
    end

    return P
end

#----------------------------------------
# Problem e
#----------------------------------------
# Creates an m × m matrix with a particularly 
# large growth factor
function growth_matrix(m)
    # YOUR CODE GOES HERE
    A = zeros(m, m)
    for i in 1:m
        for j in 1:m
            if j == m
                A[i, j] = 1
            elseif i == j
                A[i, j] = 1
            elseif i > j
                A[i, j] = -1
            end
        end
    end
    return A

end
