tabPanel(
  tags$head(tags$link(rel = "shortcut icon", href = "favicon.png")),
  title = "CWL Upgrader",

  # use shinydashboard components
  includeCSS(path = "www/AdminLTE.css"),
  includeCSS(path = "www/shinydashboard.css"),

  # customize bootstrap and ace editor
  includeCSS(path = "www/ace.css"),
  includeCSS(path = "www/custom.css"),

  shinydashboard::box(
    width = 6,
    title = "Upload sbg:draft2", status = "primary", solidHeader = TRUE,

    fluidRow(
      column(
        width = 12,
        fileInput("input_file", label = "Input format: .json, .yaml, or .cwl", accept = c("yaml", "yml", "json", "cwl"))
      ),

      column(
        width = 12,
        aceEditor(
          "ace_input",
          height = "500px",
          mode = "json", theme = "dracula", fontSize = 14, readOnly = TRUE
        )
      )
    )
  ),

  shinydashboard::box(
    width = 6,
    title = "Download v1.0", status = "primary", solidHeader = TRUE,

    fluidRow(
      column(
        width = 6,
        selectInput(
          "output_format",
          label = "Output format",
          choices = c("CWL" = "cwl", "JSON" = "json")
        )
      ),
      column(
        width = 6,
        downloadButton(
          "output_download",
          label = "Download",
          class = "btn btn-sm btn-block"
        ),
        tags$style(type = "text/css", "a#output_download { margin-top:27px; }"),
        br(), br()
      ),
      column(
        width = 12,
        aceEditor(
          "ace_output",
          height = "500px",
          mode = "json", theme = "dracula", fontSize = 14, readOnly = TRUE
        )
      )
    )
  ),

  fluidRow(
    column(
      width = 12
    )
  ),

  fluidRow(
    HTML('<p align="center">&copy; 2020 <a href="https://www.cancergenomicscloud.org/" target="_blank">Cancer Genomics Cloud</a> by <a href="https://www.sevenbridges.com/" target="_blank">Seven Bridges</a></p>'),
    HTML('<p align="center">Licensed under the GNU Affero GPL v3</p>')
  ),

  tags$script(HTML("var header = $('.navbar > .container-fluid'); header.append('<div style=\"float:right;margin:15px;\"><a href=\"https://github.com/nanxstats/cwl-upgrader\" target=\"_blank\" style=\"color:white\">Source Code</a>&nbsp;&nbsp;<font color=\"white\">|</font>&nbsp;&nbsp;<a href=\"https://github.com/sbg/sevenbridges-cwl-draft2-upgrader\" target=\"_blank\" style=\"color:white\">Python Package</a>&nbsp;&nbsp;<font color=\"white\">|</font>&nbsp;&nbsp;<a href=\"wes_draft2.json\" target=\"_blank\" style=\"color:white\">Example Draft2 App</a>&nbsp; </div>'); console.log(header)"))
)
