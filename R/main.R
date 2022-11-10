library(blogdown)
library(here)
## Always run serve_site to start the Hugo server
blogdown::serve_site()
## Show in new window

## Make a new post and an Rmarkdown file will open
## Make changes to the file, and Knit
## Knitted changes will show automatically in Viewer
## and in browser (from Show in new window)
blogdown::new_post(title = "R Aesthetics, Extensions, and Tidy Examples",
                   ext = '.Rmarkdown',
                   subdir = "post")

blogdown::config_Rprofile()
blogdown::check_gitignore()
blogdown::check_content()

rstudioapi::navigateToFile(here("config", "_default", "config.yaml"),
                           line = 8)

blogdown::config_netlify()
blogdown::check_netlify()
blogdown::check_hugo()
blogdown::remove_hugo()
rstudioapi::navigateToFile(here("config", "_default", "menus.yaml"))
blogdown::check_config()

rstudioapi::navigateToFile(here("content", "authors", "admin", "_index.md"))

blogdown::check_site()

blogdown::new_post(title = "The Monism of Presocratics, Starting with Heraclitus' 'Fire-Order'",
                   ext = '.Rmarkdown',
                   subdir = "post")

rstudioapi::navigateToFile(here("config", "_default", "params.yaml"))


## This site was first made by
# new_site(theme = "wowchemy/starter-academic")
## Then some config...
# blogdown::config_Rprofile()
# options(
#   # to automatically serve the site on RStudio startup, set this option to TRUE
#   blogdown.serve_site.startup = FALSE,
#   # to disable knitting Rmd files on save, set this option to FALSE
#   blogdown.knit.on_save = FALSE     <- change
#   blogdown.author = "Alison Hill",  <- add
#   blogdown.ext = ".Rmarkdown",      <- add
#   blogdown.subdir = "post"          <- add
# )

## Then some config for Git
# file.edit(".gitignore")

# Add this content:
#
#   .Rproj.user
# .Rhistory
# .RData
# .Ruserdata
# .DS_Store
# Thumbs.db
