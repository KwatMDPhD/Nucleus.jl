module MatrixFactorization

using LinearAlgebra: mul!, norm

using NMF: nnmf

using NonNegLeastSquares: nonneg_lsq

using StatsBase: mean, sqL2dist

using ..Omics

function lo(bo, um, ob)

    if bo

        @info "Converged in $um." ob

    else

        @warn "Failed to converge in $um." ob

    end

end

function go(A, um; ke_ar...)

    re = nnmf(A, um; ke_ar...)

    lo(re.converged, re.niters, re.objvalue / lastindex(A))

    re.W, re.H

end

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

function scale!(A, um, N)

    sc = sqrt(mean(A) / um * lastindex(A))

    map!(nu -> nu * sc, N, N)

end

function initialize(A, um::Integer)

    W = rand(size(A, 1), um)

    foreach(Omics.RangeNormalization.do_sum!, eachcol(W))

    scale!(A, um, W)

end

function initialize(um::Integer, A)

    H = rand(um, size(A, 2))

    foreach(Omics.RangeNormalization.do_sum!, eachrow(H))

    scale!(A, um, H)

end

function get_objective(A, WH)

    0.5 * sqL2dist(A, WH)

end

function converged(W, Wp, H, Hp, to)

    for i1 in axes(W, 2)

        wd = ws = hd = hs = 0.0

        for i2 in axes(W, 1)

            wd += (W[i2, i1] - Wp[i2, i1])^2

            ws += (W[i2, i1] + Wp[i2, i1])^2

        end

        for i2 in axes(H, 2)

            hd += (H[i1, i2] - Hp[i1, i2])^2

            hs += (H[i1, i2] + Hp[i1, i2])^2

        end

        if to * sqrt(ws) < sqrt(wd) || to * sqrt(hs) < sqrt(hd)

            return false

        end

    end

    true

end

function go_wide(
    A_,
    u1;
    W = initialize(A_[1], u1),
    H_ = [initialize(u1, A) for A in A_],
    co_ = get_coefficient(A_),
    u2 = 100,
    to = 0.01,
)

    WH_ = map(H -> W * H, H_)

    ob_ = map(get_objective, A_, WH_)

    Wp = Matrix{Float64}(undef, size(W))

    Hp_ = [Matrix{Float64}(undef, size(H)) for H in H_]

    AHt_ = [Matrix{Float64}(undef, size(A_[1], 1), u1) for _ in A_]

    WHHt_ = [Matrix{Float64}(undef, size(A_[1], 1), u1) for _ in A_]

    WtA_ = [Matrix{Float64}(undef, u1, size(A, 2)) for A in A_]

    WtWH_ = [Matrix{Float64}(undef, u1, size(A, 2)) for A in A_]

    bo = false

    ep = sqrt(eps())

    u3 = 0

    while !bo && u3 < u2

        u3 += 1

        copyto!(Wp, W)

        for id in eachindex(A_)

            copyto!(Hp_[id], H_[id])

        end

        for id in eachindex(A_)

            Ht = transpose(H_[id])

            mul!(AHt_[id], A_[id], Ht)

            mul!(WHHt_[id], WH_[id], Ht)

        end

        for i1 in eachindex(W)

            nu = de = 0

            for i2 in eachindex(A_)

                nu += co_[i2] * AHt_[i2][i1]

                de += co_[i2] * WHHt_[i2][i1]

            end

            W[i1] *= nu / (de + ep)

        end

        for id in eachindex(A_)

            mul!(WH_[id], W, H_[id])

        end

        Wt = transpose(W)

        for i1 in eachindex(A_)

            mul!(WtA_[i1], Wt, A_[i1])

            mul!(WtWH_[i1], Wt, WH_[i1])

            for i2 in eachindex(H_[i1])

                H_[i1][i2] *= WtA_[i1][i2] / (WtWH_[i1][i2] + ep)

            end

            mul!(WH_[i1], W, H_[i1])

        end

        ob_ .= get_objective.(A_, WH_)

        bo = all(converged(W, Wp, H_[id], Hp_[id], to) for id in eachindex(A_))

    end

    lo(bo, u3, ob_ ./ lastindex.(A_))

    W, H_

end

function solve(W, A)

    AWi = Matrix{Float64}(undef, size(W, 2), size(A, 2))

    for id in axes(A, 2)

        AWi[:, id] = nonneg_lsq(W, view(A, :, id); alg = :nnls)

    end

    AWi

end

end
