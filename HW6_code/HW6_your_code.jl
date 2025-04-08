#----------------------------------------
# Problem a
#----------------------------------------
# This function takes in a matrix T and modifies it 
# in place to Hessenberg form using Householder reduction.
function hessenberg_form!(T)

        #=
        input:
            T: matrix of size m x m

        output:
                T: matrix of size m x m in Hessenberg form

        params:
                m: size of the matrix T
                k: index of the current processing column
                x: vector of size m-k+1
                v: Householder vector
                nv: norm of the vector v

        =#

        m = size(T, 1)

        for k in 1:m-2
                @views x = T[k+1:end, k]

                v = (v = copy(x); v[1] += sign(x[1]) * norm(x); v ./= norm(v); v)

                @views begin
                        T[k+1:end, k:end] .-= 2v * (v' * T[k+1:end, k:end])
                        T[:, k+1:end] .-= 2 * (T[:, k+1:end] * v) * v'
                        T[k+2:end, k] .= 0
                end
        end
        return T
end

#----------------------------------------
# Problem b
#----------------------------------------
# This funciton takes in a matrix T in Hessenberg form
# and runs a single iteration of the unshifted QR Algorithm 
# using Givens rotations

# function givens_qr!(T)

#=
input:
        T: matrix of size m x m in Hessenberg form
output:
        T: matrix of size m x m in Hessenberg form after one QR iteration

params:
        a, b: elements of the matrix T to be rotated
        r: norm of the vector (a, b)
        c, s: cosine and sine of the rotation angle
        m: size of the matrix T
=#

function givens_qr!(T)
        @assert size(T, 1) == size(T, 2) "Matrix must be square"
        m = size(T, 1)

        for j in 1:m
                for i in m:-1:j+1
                        a, b = T[i-1, j], T[i, j]
                        if b == 0.0
                                continue
                        end

                        r = hypot(a, b)
                        c, s = a / r, -b / r

                        for k in j:m
                                t1, t2 = T[i-1, k], T[i, k]
                                T[i-1, k] = c * t1 - s * t2
                                T[i, k] = s * t1 + c * t2
                        end
                end
        end

        return T
end


#----------------------------------------
# Problem c
#----------------------------------------
# This function takes in a matrix T in Hessenberg form and 
# implements the practical QR algorithm with shifts. 
# The input shift dictates which shift type your 
# algorithm should use. For shift = "single" implement the single shift 
# and for shift = "wilkinson" implement the Wilkinson shift
function practical_QR_with_shifts!(T, shift)

        A = deepcopy(T)
        m = size(A, 1)


        if shift == "single"
                #Set single shift here
                μ = A[m, m]
        elseif shift == "wilkinson"
                #Set wilkinson shift here
                a, b, c = A[m-1, m-1], A[m-1, m], A[m, m]
                d = (a - c) / 2
                μ = c - sign(d) * b^2 / (abs(d) + sqrt(d^2 + b^2))
        end
end


#----------------------------------------
# Problem d
#----------------------------------------


