using Plotly: Layout, Style

function use_style!()::Style

    return use_style!(
        Style(
            layout = Layout(
                autosize = false,
                template = "plotly_white",
                hovermode = "closest",
            ),
        ),
    )

end

export use_style!