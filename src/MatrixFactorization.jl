module MatrixFactorization

using NMF: nnmf

using NonNegLeastSquares: nonneg_lsq

using ..Omics

function scale!(A, um, P)

    po = sqrt(sum(A) / um)

    map!(nu -> nu * po, P, P)

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

function solve(W, A)

    AWi = Matrix{Float64}(undef, size(W, 2), size(A, 2))

    for id in axes(A, 2)

        AWi[:, id] = nonneg_lsq(W, view(A, :, id); alg = :nnls)

    end

    AWi

end

end
