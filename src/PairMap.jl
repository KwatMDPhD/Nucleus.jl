module PairMap

function make(fu, bo_, nu_)

    # TODO: Benchmark findall.
    fu(nu_[map(!, bo_)], nu_[bo_])

end

end
