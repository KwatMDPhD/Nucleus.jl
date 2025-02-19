module SimultaneousMatrixFactorization

using LinearAlgebra: mul!, norm

using StatsBase: sqL2dist

using ..Omics

function get_coefficient(A_)

    um = lastindex(A_)

    co_ = Vector{Float64}(undef, um)

    no = norm(A_[1])

    co_[1] = 1.0

    for id in 2:um

        co_[id] = no / norm(A_[id])

    end

    co_

end

function get_objective(A, WH)

    sqL2dist(A, WH) * 0.5

end

function converged(W1, W2, H1, H2, to)

    for i1 in axes(W1, 2)

        d1 = s1 = d2 = s2 = 0.0

        for i2 in axes(W1, 1)

            d1 += (W1[i2, i1] - W2[i2, i1])^2

            s1 += (W1[i2, i1] + W2[i2, i1])^2

        end

        for i2 in axes(H1, 2)

            d2 += (H1[i1, i2] - H2[i1, i2])^2

            s2 += (H1[i1, i2] + H2[i1, i2])^2

        end

        if to * sqrt(s1) < sqrt(d1) || to * sqrt(s2) < sqrt(d2)

            return false

        end

    end

    true

end

function go_wide(
    A_,
    u1;
    W = Omics.MatrixFactorization.initialize(A_[1], u1),
    H_ = [Omics.MatrixFactorization.initialize(u1, A) for A in A_],
    co_ = get_coefficient(A_),
    to = 0.01,
    u2 = 100,
)

    B_ = map(H -> W * H, H_)

    ob_ = map(get_objective, A_, B_)

    W2 = Matrix{Float64}(undef, size(W))

    H2_ = [Matrix{Float64}(undef, size(H)) for H in H_]

    AHt_ = [Matrix{Float64}(undef, size(A_[1], 1), u1) for _ in A_]

    BHt_ = [Matrix{Float64}(undef, size(A_[1], 1), u1) for _ in A_]

    WtA_ = [Matrix{Float64}(undef, u1, size(A, 2)) for A in A_]

    WtB_ = [Matrix{Float64}(undef, u1, size(A, 2)) for A in A_]

    bo = false

    ep = sqrt(eps())

    u3 = 0

    while !bo && (u3 += 1) < u2

        copyto!(W2, W)

        for id in eachindex(A_)

            copyto!(H2_[id], H_[id])

        end

        for id in eachindex(A_)

            Ht = transpose(H_[id])

            mul!(AHt_[id], A_[id], Ht)

            mul!(BHt_[id], B_[id], Ht)

        end

        for i1 in eachindex(W)

            nu = de = 0

            for i2 in eachindex(A_)

                nu += co_[i2] * AHt_[i2][i1]

                de += co_[i2] * BHt_[i2][i1]

            end

            W[i1] *= nu / (de + ep)

        end

        for id in eachindex(A_)

            mul!(B_[id], W, H_[id])

        end

        Wt = transpose(W)

        for i1 in eachindex(A_)

            mul!(WtA_[i1], Wt, A_[i1])

            mul!(WtB_[i1], Wt, B_[i1])

            for i2 in eachindex(H_[i1])

                H_[i1][i2] *= WtA_[i1][i2] / (WtB_[i1][i2] + ep)

            end

            mul!(B_[i1], W, H_[i1])

        end

        map!(get_objective, ob_, A_, B_)

        bo = all(converged(W, W2, H_[id], H2_[id], to) for id in eachindex(A_))

    end

    Omics.MatrixFactorization.lo(
        bo,
        u3,
        map(id -> ob_[id] / lastindex(A_[id]), eachindex(A_)),
    )

    W, H_

end

end
