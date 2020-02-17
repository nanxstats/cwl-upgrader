source("server/wrapper.R", local = TRUE)

#' @examples
#' upgrade_cwl("www/wes_draft2.json", "cwl")
upgrade_cwl <- function(input_path, output_format) {
  input_path <- normalizePath(input_path)
  output_path <- paste0(dirname(input_path), "/", "out.", output_format)

  upgrade_cwl_r(input_path, output_path)
  output <- readr::read_file(output_path)

  lst <- list("output" = output)
  lst
}

get_input <- reactive({
  if (is.null(input$input_file)) {
    list(
      "msg" = "{\"Message\": \"Please upload the sbg:draft2 file.\"}",
      "ext" = "yaml"
    )
  } else {
    list(
      "msg" = readr::read_file(input$input_file$datapath),
      "ext" = switch(tools::file_ext(input$input_file$datapath), "json" = "json", "cwl" = "yaml", "yaml" = "yaml") # for syntax highlighting
    )
  }
})

observeEvent(get_input(), {
  updateAceEditor(session, "ace_input", value = get_input()$msg, mode = get_input()$ext)
})

get_output <- reactive({
  if (is.null(input$input_file)) {
    list("msg" = "{\"Message\": \"Please upload the sbg:draft2 file.\"}", ext = "yaml")
  } else {
    list(
      "msg" = readr::read_file(upgrade_cwl(input$input_file$datapath, input$output_format)$output),
      "ext" = switch(input$output_format, "json" = "json", "cwl" = "yaml") # for syntax highlighting
    )
  }
})

observeEvent(get_output(), {
  updateAceEditor(session, "ace_output", value = get_output()$msg, mode = get_output()$ext)
})

output$output_download <- downloadHandler(
  filename = function() {
    pb <- Sys.time()
    attributes(pb)$tzone <- "America/New_York" # convert to EST
    paste("cwl-upgrader-", gsub(" ", "-", gsub(":", "-", pb)), ".", input$output_format, sep = "")
  },
  content = function(file) {
    tmp <- tempfile(fileext = input$output_format)
    readr::write_file(get_output()$msg, tmp)
    file.rename(tmp, file)
  }
)
