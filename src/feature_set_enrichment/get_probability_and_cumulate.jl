function get_probability_and_cumulate(ve)

    pr_ = ve / sum(ve)

    ep = eps()

    cur_ = cumsum(pr_) .+ ep

    cul_ = cumulate_sum_reverse(pr_) .+ ep

    pr_, cur_, cul_

end
