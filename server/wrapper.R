library("reticulate")

sbg_cwl_upgrader <- reticulate::import("sbg_cwl_upgrader")
source_python("server/cwl_converter_no_prompt.py")
upgrade_cwl_py <- CWLConverterFacade

#' @examples
#' upgrade_cwl_r("www/wes_draft2.json", output = "wes_v1.cwl")
upgrade_cwl_r <- function(input, output) upgrade_cwl_py(input_ = input, output = output)
