module Information

function make(n1, n2)

    n1 * log2(n1 / n2)

end

function make_thermodynamic_depth(n1, n2)

    make(n1, n2) - make(n2, n1)

end

function make_thermodynamic_breadth(n1, n2)

    make(n1, n2) + make(n2, n1)

end

function make_antisymmetric_kullback_leibler_divergence(n1, n2, n3, n4 = n3)

    make(n1, n3) - make(n2, n4)

end

function make_symmetric_kullback_leibler_divergence(n1, n2, n3, n4 = n3)

    make(n1, n3) + make(n2, n4)

end

function make_jensen_shannon_divergence(n1, n2)

    make_symmetric_kullback_leibler_divergence(n1, n2, (n1 + n2) * 0.5)

end

end
