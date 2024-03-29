module Graph

using JSON: json

using ..Nucleus

function plot(
    ht,
    el_;
    st_ = Dict{String, Any}(),
    la = Dict{String, Any}(),
    ba = "#fcfcfc",
    ex = "",
    sc = 1,
    ke_ar...,
)

    if isempty(ex)

        dw = ""

        re = ""

    else

        if isempty(ht)

            error("HTML path is empty.")

        end

        na = "$(splitext(basename(ht))[1]).$ex"

        dw = joinpath(homedir(), "Downloads", na)

        if isfile(dw)

            rm(dw)

        end

        if ex == "json"

            bl = "new Blob([JSON.stringify(cy.json(), null, 2)], {type: \"application/json\"})"

        elseif ex == "png"

            bl = "cy.png({full: true, scale: $sc, bg: \"$ba\"})"

        else

            error("`$ex` is not `json` or `png`.")

        end

        re = "cy.ready(function() {saveAs($bl, \"$na\")});"

    end

    id = "Cytoscape"

    Nucleus.HTML.make(
        ht,
        (
            "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js",
            "https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.0/FileSaver.js",
            "https://cdnjs.cloudflare.com/ajax/libs/cytoscape/3.26.0/cytoscape.min.js",
        ),
        id,
        """
        var cy = cytoscape({
            container: document.getElementById("$id"),
            elements: $(json(el_)),
            style: $(json(st_)),
            layout: $(json(merge(Dict("animate" => false), la))),
        });

        cy.on("mouseover", "node", function(ev) {
            ev.target.addClass("nodehover");
        });

        cy.on("mouseout", "node", function(ev) {
            ev.target.removeClass("nodehover");
        });

        cy.on("mouseover", "edge", function(ev) {
            ev.target.addClass("edgehover");
        });

        cy.on("mouseout", "edge", function(ev) {
            ev.target.removeClass("edgehover");
        });

        $re""";
        ba,
        ke_ar...,
    )

    if !isempty(dw)

        Nucleus.Path.wait(dw, 40)

        fi = joinpath(dirname(ht), na)

        if dw != fi

            if isfile(fi)

                rm(fi)

            end

            mv(dw, fi)

        end

    end

    nothing

end

function read(js)

    ty_el_ = Nucleus.Dict.read(js, Dict{String, Any})["elements"]

    el_ = ty_el_["nodes"]

    ke = "edges"

    if haskey(ty_el_, ke)

        append!(el_, ty_el_[ke])

    end

    el_

end

function position!(el_, el2_)

    id_el2 = Dict(el["data"]["id"] => el for el in el2_)

    for el in el_

        el["position"] = id_el2[el["data"]["id"]]["position"]

    end

end

end
