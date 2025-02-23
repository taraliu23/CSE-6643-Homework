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
    y = similar(x)  # Temporary vector for forward substitution

    # Apply permutation to x (Pb)
    x_permuted = x[P]

    # Forward substitution (Ly = Pb)
    # for i in 1:m
    #     y[i] = x_permuted[i] - dot(LU[i, 1:i-1], y[1:i-1])
    # end

    for i in 1:m
        dot_product = 0.0
        for j in 1:i-1
            dot_product += LU[i, j] * y[j]
        end
        y[i] = x_permuted[i] - dot_product
    end

    # Backward substitution (Ux = y)
    # for i in m:-1:1
    #     x[i] = (y[i] - dot(LU[i, i+1:m], x[i+1:m])) / LU[i, i]
    # end

    for i in m:-1:1
        dot_product = 0.0
        for j in i+1:m
            dot_product += LU[i, j] * x[j]
        end
        x[i] = (y[i] - dot_product) / LU[i, i]
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
    # returns the array representing the permutation


    # m = size(A, 1)
    m = size(A, 1)
    for k in 1:m-1
        # Find pivot row
        pivot_row = argmax(abs.(A[k:m, k])) + k - 1
        if pivot_row != k
            # Swap rows in A and P
            A[[k, pivot_row], :] = A[[pivot_row, k], :]
            P[k], P[pivot_row] = P[pivot_row], P[k]
        end

        # Perform elimination
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
