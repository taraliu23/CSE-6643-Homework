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
    a blocked/ tiled variant of add_to_A_B_times_C! that takes an integer bks as a fourth input

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
    a recursive, cache-oblivious variant of add_to_A_B_times_C! that takes an integer bks as a fourth input

    input: A(matrix), B(matrix), C(matrix), bks(Integer)
    output: A

    params:
    A, B, C:matrix
    bks:integer

    process:
    1. get matrices' sizes
    2. check if we can further subdivide
    3. get midpoints
    4. divide matrices into 4 parts
    5. divide matrices into blocks
    6. call the function recursively on the 8 subproblems

    =#


    i_size = size(A, 1)
    j_size = size(C, 2)
    k_size = size(B, 2)



    # If we want to further subdivide
    if min(i_size, j_size, k_size) > bks


        i_mid = i_size ÷ 2
        j_mid = j_size ÷ 2
        k_mid = k_size ÷ 2


        A11 = view(A, 1:i_mid, 1:j_mid)
        A12 = view(A, 1:i_mid, j_mid+1:j_size)
        A21 = view(A, i_mid+1:i_size, 1:j_mid)
        A22 = view(A, i_mid+1:i_size, j_mid+1:j_size)

        B11 = view(B, 1:i_mid, 1:k_mid)
        B12 = view(B, 1:i_mid, k_mid+1:k_size)
        B21 = view(B, i_mid+1:i_size, 1:k_mid)
        B22 = view(B, i_mid+1:i_size, k_mid+1:k_size)

        C11 = view(C, 1:k_mid, 1:j_mid)
        C12 = view(C, 1:k_mid, j_mid+1:j_size)
        C21 = view(C, k_mid+1:k_size, 1:j_mid)
        C22 = view(C, k_mid+1:k_size, j_mid+1:j_size)


        oblivious_add_to_A_B_times_C!(A11, B11, C11, bks)
        oblivious_add_to_A_B_times_C!(A11, B12, C21, bks)
        oblivious_add_to_A_B_times_C!(A12, B11, C12, bks)
        oblivious_add_to_A_B_times_C!(A12, B12, C22, bks)
        oblivious_add_to_A_B_times_C!(A21, B21, C11, bks)
        oblivious_add_to_A_B_times_C!(A21, B22, C21, bks)
        oblivious_add_to_A_B_times_C!(A22, B21, C12, bks)
        oblivious_add_to_A_B_times_C!(A22, B22, C22, bks)

    else
        add_to_A_B_times_C!(A, B, C)




    end
end

