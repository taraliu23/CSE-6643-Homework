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

ref_x = A \ b
unpivoted_LU!(A)
substitution!(b, A)
@assert ref_x ≈ b

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
    ref_x = A \ b

    LU = deepcopy(A)
    unpivoted_LU!(LU)
    x = deepcopy(b)
    substitution!(x, LU)

    # relative error
    push!(errors, norm(x - ref_x) / norm(ref_x))

    # growth factor
    push!(growth_factors, norm(LU, Inf) / norm(A, Inf))
end


fig = Figure()

supertitle = Label(
    fig[0, :],
    "Relative Error and Growth Factor with Matrix Size",
    # fontsize=20,
    font="courier")

ax1 = Axis(
    fig[1, 1],
    xlabel="Matrix Size",
    ylabel="Relative Error",
    titlefont="courier",
    xlabelfont="courier",
    ylabelfont="courier",
    xticklabelfont="courier",
    yticklabelfont="courier",
)

ax2 = Axis(
    fig[2, 1],
    xlabel="Matrix Size",
    ylabel="Growth Factor",
    titlefont="courier",
    xlabelfont="courier",
    ylabelfont="courier",
    xticklabelfont="courier",
    yticklabelfont="courier",
)

hidespines!(ax1, :t, :r)
hidespines!(ax2, :t, :r)


sca = scatter!(
    ax1,
    m_values,
    errors,
    color=:orange,
    strokecolor=:orange,
    strokewidth=1,
    markersize=5
)

sca = scatter!(
    ax2,
    m_values,
    growth_factors,
    color=:purple,
    strokecolor=:purple,
    strokewidth=1,
    markersize=5
)

lines!(
    ax1,
    m_values,
    errors,
    label="Relative Error",
    color=:orange,
    linewidth=0.6
)

lines!(
    ax2,
    m_values,
    growth_factors,
    label="Growth Factor",
    color=:purple,
    linewidth=0.6
)


save("c.png", fig)

#----------------------------------------
# Problem d
#----------------------------------------
########################################
A = (randn(20, 20)+100*I)[randperm(20), :]
b = randn(20)
ref_x = A \ b
P = pivoted_LU!(A)
substitution!(b, A, P)
@assert ref_x ≈ b

#----------------------------------------
# Problem e
#----------------------------------------
# YOUR CODE GOES HERE
#----------------------------------------

m_values = 10:10:100
errors = Float64[]

for m in m_values
    A = growth_matrix(m)
    b = randn(m)
    ref_x = A \ b

    LU = deepcopy(A)
    P = pivoted_LU!(LU)
    x = deepcopy(b)
    substitution!(x, LU, P)

    # relative error
    push!(errors, norm(x - ref_x) / norm(ref_x))
end

fig = Figure()
ax = Axis(
    fig[1, 1],
    xlabel="Matrix Size",
    ylabel="Relative Error",
    title="Error for growth_matrix",
    titlefont="courier",
    xlabelfont="courier",
    ylabelfont="courier",
    xticklabelfont="courier",
    yticklabelfont="courier",
)

lines!(
    ax,
    m_values,
    errors,
    label="Relative Error",
    color=:blue,
    linewidth=1
)

sca = scatter!(
    ax,
    m_values,
    errors,
    color=:blue,
    strokecolor=:blue,
    strokewidth=1,
    markersize=10
)

hidespines!(ax, :t, :r)


save("e.png", fig)