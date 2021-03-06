# cwl-upgrader

A shiny app to upgrade Common Workflow Language (CWL) apps from `sbg:draft2` to `v1.0` using the Python package sevenbridges-cwl-draft2-upgrader.

## Dependencies

This app uses [reticulate](https://rstudio.github.io/reticulate/) to call Python and the Python package [sevenbridges-cwl-draft2-upgrader](https://github.com/sbg/sevenbridges-cwl-draft2-upgrader). Follow its readme to install the Python package either using pip or from GitHub.

After the Python package is installed, modify `.Rprofile` to give a hint to reticulate on where to find Python and the installed package. The default location is for a macOS Homebrew Python 3. Relaunch the RStudio session to use this profile.

If you encountered an error on unable to import the Python module, please consult the articles [Python Version Configuration](https://rstudio.github.io/reticulate/articles/versions.html) and [Installing Python Packages](https://rstudio.github.io/reticulate/articles/python_packages.html), then add a few lines to `server/wrapper.R` before `reticulate::import` to help reticulate locate the Python package. For example, if we use virtualenv:

```r
use_python("/your/path/to/bin/python3")

virtualenv_create("venv", python = "/your/path/to/bin/python3")
virtualenv_install("venv", packages = c("sevenbridges-cwl-draft2-upgrader"), ignore_installed = FALSE)
use_virtualenv("venv", required = TRUE)
```

## Related apps

- [cwl-formatter](https://github.com/nanxstats/cwl-formatter) - Shiny app to format Common Workflow Language apps.
- [cwl-exploder](https://github.com/nanxstats/cwl-exploder) - Shiny app to unpack monolithic CWL workflows and split them into smaller components.

## Copyright

© 2020 Seven Bridges Genomics, Inc. All rights reserved.

This project is licensed under the [GNU Affero General Public License v3](LICENSE).
