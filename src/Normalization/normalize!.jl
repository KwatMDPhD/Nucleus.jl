function normalize!(te, ho)

    go_ = [!isnan(nu) for nu in te]

    if any(go_)

        te[go_] = normalize(te[go_], ho)

    end

    nothing

end