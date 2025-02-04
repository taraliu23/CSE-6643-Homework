# This macro helps optimize the innermost loop in the kernel on your machine. You should not need to use it anywhere else
using LoopVectorization: @turbo
# This function takes in matrices ABC and adds B times C to the matrix A
function add_to_A_B_times_C!(A, B, C)
    @turbo for j in axes(C, 2)
        for k in axes(B, 2)
            for i in axes(A, 1)
                A[i, j] += B[i, k] * C[k, j]
            end
        end
    end
end

# This function takes in matrices ABC and adds B times C to the matrix A
# It uses blocking into blocks of size bks
# Make sure that your function does not allocate memory
function add_to_A_B_times_C!(A, B, C, bks)

    #=
    Blocked/ tiled variant of add_to_A_B_times_C! that takes an integer bks as a fourth input

    input: A(matrix), B(matrix), C(matrix), bks(Integer)
    output: A

    params:
    A, B, C:matrix
    bks:integer

    process:
    1. get matrices' sizes
    2. loop over the matrices in blocks of size bks
    3. get block size
    4. get block
    5. call the original function with the block
    =#


    i_size = size(A, 1)
    j_size = size(C, 2)
    k_size = size(B, 2)

    # use j, i, k order for cache efficiency and avoid allocating memory
    for j = 1:bks:j_size
        for i = 1:bks:i_size
            for k = 1:bks:k_size

                i_end = min(i + bks - 1, i_size)
                j_end = min(j + bks - 1, j_size)
                k_end = min(k + bks - 1, k_size)

                A_block = view(A, i:i_end, j:j_end)
                B_block = view(B, i:i_end, k:k_end)
                C_block = view(C, k:k_end, j:j_end)

                add_to_A_B_times_C!(A_block, B_block, C_block)
            end
        end
    end
end

# Implements a recursive, cache oblivious algorithm
# complete this skeleton
function oblivious_add_to_A_B_times_C!(A, B, C, bks)

    #=
    Recursive, cache-oblivious variant of add_to_A_B_times_C! that takes an integer bks as a fourth input

    input: A(matrix), B(matrix), C(matrix), bks(Integer)
    output: A

    params:
    A, B, C:matrix
    bks:integer

    process:
    1. get matrices' sizes
    2. check if we can further subdivide
    3. get mpoints
    4. divide matrices into 4 parts
    5. divide matrices into blocks
    6. call the function recursively on the 8 subproblems

    =#

    i_size = size(A, 1)
    j_size = size(C, 2)
    k_size = size(B, 2)

    # If we want to further subdivide
    if min(i_size, j_size, k_size) > bks

        i_m = i_size ÷ 2
        j_m = j_size ÷ 2
        k_m = k_size ÷ 2

        A_11 = view(A, 1:i_m, 1:j_m)
        A_12 = view(A, 1:i_m, j_m+1:j_size)
        A_21 = view(A, i_m+1:i_size, 1:j_m)
        A_22 = view(A, i_m+1:i_size, j_m+1:j_size)

        B_11 = view(B, 1:i_m, 1:k_m)
        B_12 = view(B, 1:i_m, k_m+1:k_size)
        B_21 = view(B, i_m+1:i_size, 1:k_m)
        B_22 = view(B, i_m+1:i_size, k_m+1:k_size)

        C_11 = view(C, 1:k_m, 1:j_m)
        C_12 = view(C, 1:k_m, j_m+1:j_size)
        C_21 = view(C, k_m+1:k_size, 1:j_m)
        C_22 = view(C, k_m+1:k_size, j_m+1:j_size)

        oblivious_add_to_A_B_times_C!(A_11, B_11, C_11, bks)
        oblivious_add_to_A_B_times_C!(A_11, B_12, C_21, bks)
        oblivious_add_to_A_B_times_C!(A_12, B_11, C_12, bks)
        oblivious_add_to_A_B_times_C!(A_12, B_12, C_22, bks)

        oblivious_add_to_A_B_times_C!(A_21, B_21, C_11, bks)
        oblivious_add_to_A_B_times_C!(A_21, B_22, C_21, bks)
        oblivious_add_to_A_B_times_C!(A_22, B_21, C_12, bks)
        oblivious_add_to_A_B_times_C!(A_22, B_22, C_22, bks)

    else
        add_to_A_B_times_C!(A, B, C)

    end
end

