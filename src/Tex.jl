module Tex

function update_space(te)

    replace(strip(te), r" +" => ' ')

end

function make_low(te)

    replace(lowercase(te), r"[^._0-9a-z]" => '_')

end

function make_title(te)

    replace(
        titlecase(te; strict = false),
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

end

function make_count(um, no)

    if 1 < abs(um)

        no =
            if lastindex(no) == 3 && endswith(no, "ex") ||
               endswith(no, "us") ||
               endswith(no, 'o')

                "$(no)es"

            elseif endswith(no, 'y')

                "$(no[1:(end - 1)])ies"

            elseif endswith(no, "ex")

                "$(no[1:(end - 2)])ices"

            else

                "$(no)s"

            end

    end

    "$um $no"

end

end
