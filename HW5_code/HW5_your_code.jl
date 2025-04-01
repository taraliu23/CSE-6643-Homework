import Pkg.instantiate
instantiate()
using BenchmarkTools: @ballocated
using LinearAlgebra: I, norm, istriu, triu, qr, Diagonal, eigvals
using CairoMakie


#----------------------------------------
# Problem a
#----------------------------------------


function create_matrix(m::Int)

    #=

        input: m (Int) - matrix size
        output: A (Matrix) - matrix with eigenvalues 3^(i - 1) for i in 1:m

        params: lambda (Vector) - eigenvalues of A
                A (Matrix) - matrix with eigenvalues lambda
                Q (Matrix) - orthogonal matrix
                i (Int) - index for eigenvalues

        process:

            1. Init lambda as [3^(i - 1) for i in 1:m]
            2. Init A as a zero matrix of size m x m
            3. QR factorization of A
            4. Update A as Q * Diagonal(lambda) * Q'

        =#

    lambda = [3.0^(i - 1) for i in 1:m]
    A = zeros(m, m)
    Q, _ = qr(A)
    A = Q * Diagonal(lambda) * Q'

    println("A: ", A)
    println("Eigenvalues: ", [3.0^(i - 1) for i in 1:m])

    open("A.txt", "w") do io
        println(io, A)
    end

    return A
end

m = 8
A = create_matrix(m)


#----------------------------------------
# Problem b: 
# Implement the orthogonal iteration algorithm. 
# Print the values along the diagonal of Rk at each iteration k for k= 1,...,5. 
# Print each number using at most four significant digits.
#----------------------------------------

function iterate_orth(A::Matrix, k_max::Int; m::Int=size(A, 1))

    #=
    input: A (Matrix) - matrix
           k_max (Int) - maximum iteration
           m (Int) - matrix size

    output: None

    params:
            Q (Matrix) - orthogonal matrix
            Z (Matrix) - power iteration
            R (Matrix) - upper triangular matrix
            k (Int) - iteration index

    process:
        1. QR factorization of A
        2. Power iteration
        3. Orthogonalize
        4. Print the values along the diagonal of Rk at each iteration k

    =#

    Q = zeros(m, m)
    log = []
    for k in 1:k_max

        Z = A * Q # power
        Q, R = qr(Z) # orthogonalize
        push!(log, Diagonal(R))

        println("k = $k: ", round.(Diagonal(R), sigdigits=4))
        open("R.txt", "w") do io
            println(io, round.(Diagonal(R), sigdigits=4))
        end
    end
    return log

end

iterate_orth(A, 5)

#----------------------------------------
# Problem c
#----------------------------------------
