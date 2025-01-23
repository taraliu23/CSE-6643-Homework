# This function takes in a matrix A and a vector v and writes their product into the vector v
function u_is_A_times_v!(u, A, v)
    # Write your function here! 

    # --------------------------------
    # product = A * v
    # for i in 1:length(u)
    #     u[i] = product[i]
    # end
    # --------------------------------

    # optimize: ensure 0 allocation of memory
    # order of loop: i, j
    # time: 5.149 ms
    for i in 1:size(A,1)
        u[i] = 0
        for j in 1:size(A,2)
            u[i] += A[i,j] * v[j]
        end
    end

    # order of loop: j, i
    # time: 548.968 μs
    # load error: u ≈ A * v

    # for j in 1:size(A,2)
    #     for i in 1:size(A,1)
    #         u[i] = 0
    #         u[i] += A[i,j] * v[j]
    #     end
    # end

    return u
end

# This function takes in matrices ABC and writes B times C into the matrix A
function A_is_B_times_C!(A, B, C)
    # Write your function here! 

    # --------------------------------
    # product = B * C
    # for i in 1:size(A, 1)
    #     for j in 1:size(A, 2)
    #         A[i, j] = product[i, j]
    #     end
    # end
    # --------------------------------

    # optimize: ensure 0 allocation of memory

    # loop order: i, j, k
    # time: 5.197s
    # for i in 1:size(B,1)
    #     for j in 1:size(C,2)
    #         A[i,j] = 0
    #         for k in 1:size(B,2)
    #             A[i,j] += B[i,k] * C[k,j]
    #         end
    #     end
    # end
    # return A

    # optimize: change loop order
    # loop order: j, i, k
    # time: 4.27s
    for j in 1:size(C,2)
        for i in 1:size(B,1)
            A[i,j] = 0
            for k in 1:size(B,2)
                A[i,j] += B[i,k] * C[k,j]
            end
        end
    end

    
end

