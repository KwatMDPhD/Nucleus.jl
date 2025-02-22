module Time

using Dates: @dateformat_str, Date

function make(st)

    Date(st, dateformat"yyyy mm dd")

end

end
