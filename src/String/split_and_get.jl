function split_and_get(st, de, id)

    if id == 1

        li = 2

    else

        li = id

    end

    split(st, de, limit = li)[id]

end