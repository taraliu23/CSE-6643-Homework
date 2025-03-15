#----------------------------------------
# Problem a
#----------------------------------------
# This function takes in a matrix A and returns 
# a reduced QR factorization with factors Q and R.
# It should not modify A
function classical_gram_schmidt(A)
    # YOUR CODE HERE
    #=

    input:  matrix A
    output: matrices Q and R

    params: 
    m, n = size(A)
    Q = similar(A, m, n)
     R = zeros(n, n)

    process: classical gram-schmidt algorithm
    =#

    m, n = size(A)

    Q = similar(A, m, n)
    R = zeros(n, n)

    # loop through columns of A
    for j in 1:n

        v = A[:, j]

        # loop through columns of Q
        for i in 1:j-1
            R[i, j] = sum(Q[:, i] .* A[:, j])

            v .-= R[i, j] .* Q[:, i]

        end

        R[j, j] = norm(v)
        Q[:, j] = v / R[j, j]

    end


    return Q, R
end

#----------------------------------------
# Problem b
#----------------------------------------
# This function takes in a matrix A and returns 
# a reduced QR factorization with factors Q and R.
# It should not modify A
function modified_gram_schmidt(A)
    # YOUR CODE HERE

    #=

    input:  matrix A
    output: matrices Q and R

    params: 
    m, n = size(A)
    Q = similar(A, m, n)
    R = zeros(n, n)

    process: 


    =#

    m, n = size(A)
    Q = deepcopy(A)
    R = zeros(n, n)

    for j in 1:n

        R[j, j] = norm(Q[:, j])

        Q[:, j] ./= R[j, j]

        for i in (j+1):n

            R[j, i] = sum(Q[:, j] .* Q[:, i])

            Q[:, i] .-= R[j, i] .* Q[:, j]
        end
    end

    return Q, R
end

#----------------------------------------
# Problem c
#----------------------------------------
# This function takes in a matrix A 
# and computes its QR factorization in place,
# using householder reflections.
# It should not allocate any memory.  
function householder_QR!(A)
    # YOUR CODE HERE

end

#----------------------------------------
# Problem d
#----------------------------------------
# These two functions take in the housholder
# QR factorization from part c and multiply them
# to a vector (mul) or solve the least squares 
# problem in A (div), in place.
# They should not allocate any memory and instead
# use the preallocated output vector to record the result. 
function householder_QR_mul!(out, x, QR)
    # YOUR CODE HERE

end

function householder_QR_div!(out, b, QR)
    # YOUR CODE HERE

end