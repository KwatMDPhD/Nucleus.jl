module Tex

function update_space(st)

    replace(strip(st), r" +" => ' ')

end

function make_low(st)

    replace(lowercase(st), r"[^._0-9a-z]" => '_')

end

function make_title(st)

    st = titlecase(st; strict = false)

    for pa in (
        '_' => ' ',
        r"'m"i => "'m",
        r"'re"i => "'re",
        r"'s"i => "'s",
        r"'ve"i => "'ve",
        r"'d"i => "'d",
        r"1st"i => "1st",
        r"2nd"i => "2nd",
        r"3rd"i => "3rd",
        r"(?<=\d)th"i => "th",
        r"(?<= )a(?= )"i => 'a',
        r"(?<= )an(?= )"i => "an",
        r"(?<= )and(?= )"i => "and",
        r"(?<= )as(?= )"i => "as",
        r"(?<= )at(?= )"i => "at",
        r"(?<= )but(?= )"i => "but",
        r"(?<= )by(?= )"i => "by",
        r"(?<= )for(?= )"i => "for",
        r"(?<= )from(?= )"i => "from",
        r"(?<= )in(?= )"i => "in",
        r"(?<= )into(?= )"i => "into",
        r"(?<= )nor(?= )"i => "nor",
        r"(?<= )of(?= )"i => "of",
        r"(?<= )off(?= )"i => "off",
        r"(?<= )on(?= )"i => "on",
        r"(?<= )onto(?= )"i => "onto",
        r"(?<= )or(?= )"i => "or",
        r"(?<= )out(?= )"i => "out",
        r"(?<= )over(?= )"i => "over",
        r"(?<= )the(?= )"i => "the",
        r"(?<= )to(?= )"i => "to",
        r"(?<= )up(?= )"i => "up",
        r"(?<= )vs(?= )"i => "vs",
        r"(?<= )with(?= )"i => "with",
    )

        st = replace(st, pa)

    end

    st

end

function make_count(um, st)

    if 1 < abs(um)

        st =
            if lastindex(st) == 3 && endswith(st, "ex") ||
               endswith(st, "us") ||
               endswith(st, 'o')

                "$(st)es"

            elseif endswith(st, 'y')

                "$(st[1:(end - 1)])ies"

            elseif endswith(st, "ex")

                "$(st[1:(end - 2)])ices"

            else

                "$(st)s"

            end

    end

    "$um $st"

end

end
