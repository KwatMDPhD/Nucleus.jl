module Entropy

function ge(pr)

    -pr * log2(pr)

end

function ge(ea, jo)

    sum(pr_ -> ge(sum(pr_)), ea(jo))

end

end
