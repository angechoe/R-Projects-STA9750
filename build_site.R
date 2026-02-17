#!/usr/bin/env Rscript
if(!require("quarto")){
  install.packages("quarto")
}
library(quarto)
if(!quarto::quarto_binary_sitrep()){
  stop("Something is wrong with your quarto installation.")
}

# Render the website (this creates/updates the 'docs' folder)
quarto::quarto_render(".")

# Stage the rendered website
system("git add docs/*")

# Stage the configuration and homepage
if(file.exists("_quarto.yml")) system("git add _quarto.yml")
if(file.exists("index.qmd"))   system("git add index.qmd")

# Stage the project folders
if(dir.exists("r-projects"))      system("git add r-projects/*")
if(dir.exists("python-projects")) system("git add python-projects/*")

# Exit if not in RStudio
if(!any(grepl("rstudio", search()))){q("no")}