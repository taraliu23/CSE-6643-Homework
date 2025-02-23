import Pkg.instantiate
instantiate()
using BenchmarkTools: @ballocated
using Random: randperm
using LinearAlgebra: I, norm
using CairoMakie
include("HW3_your_code.jl")


#----------------------------------------
# Problem a + b
#----------------------------------------
########################################
A = randn(20, 20) + 100 * I
b = randn(20)
reference_x = A \ b
unpivoted_LU!(A)
substitution!(b, A)
@assert reference_x ≈ b

allocated_memory = @ballocated unpivoted_LU!(A)
allocated_memory += @ballocated substitution!(b, A)
@assert allocated_memory < 450

#----------------------------------------
# Problem c
#----------------------------------------
# YOUR CODE GOES HERE



m_values = 10:10:100
errors = Float64[]
growth_factors = Float64[]

for m in m_values
    A = randn(m, m) + 100 * I
    b = randn(m)
    reference_x = A \ b

    # Perform unpivoted LU factorization
    LU = copy(A)
    unpivoted_LU!(LU)
    x = copy(b)
    substitution!(x, LU)

    # Compute relative error
    push!(errors, norm(x - reference_x) / norm(reference_x))

    # Compute growth factor
    push!(growth_factors, norm(LU, Inf) / norm(A, Inf))
end


fig = Figure()
ax1 = Axis(fig[1, 1], xlabel="Matrix Size (m)", ylabel="Relative Error", title="Relative Error vs. Matrix Size")
ax2 = Axis(fig[1, 2], xlabel="Matrix Size (m)", ylabel="Growth Factor", title="Growth Factor vs. Matrix Size")

lines!(ax1, m_values, errors, label="Relative Error")
lines!(ax2, m_values, growth_factors, label="Growth Factor", color=:red)

save("error_growth_plot.png", fig)

#----------------------------------------
# Problem d
#----------------------------------------
########################################
A = (randn(20, 20)+100*I)[randperm(20), :]
b = randn(20)
reference_x = A \ b
P = pivoted_LU!(A)
substitution!(b, A, P)
@assert reference_x ≈ b

#----------------------------------------
# Problem e
#----------------------------------------
# YOUR CODE GOES HERE
#----------------------------------------
# Problem e
#----------------------------------------
# Test the growth_matrix function and compare errors
m_values = 10:10:100
errors = Float64[]

for m in m_values
    A = growth_matrix(m)
    b = randn(m)
    reference_x = A \ b

    # Perform pivoted LU factorization
    LU = copy(A)
    P = pivoted_LU!(LU)
    x = copy(b)
    substitution!(x, LU, P)

    # Compute relative error
    push!(errors, norm(x - reference_x) / norm(reference_x))
end

# Plot errors
fig = Figure()
ax = Axis(fig[1, 1], xlabel="Matrix Size (m)", ylabel="Relative Error", title="Error for growth_matrix")

lines!(ax, m_values, errors, label="Relative Error", color=:blue)

save("growth_matrix_error_plot.png", fig)