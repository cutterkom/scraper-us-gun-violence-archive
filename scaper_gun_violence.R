# Scraper for http://www.gunviolencearchive.org/

library(tidyverse)
library(rvest)


# Mass Shootings for 2018

BASE_URL <- "http://www.gunviolencearchive.org/reports/mass-shooting?page="

pages <- 0:1

df <-
  map_df(pages, function(i) {
    # keep calm!
    cat(".")
    path <- paste0(BASE_URL, i)
    page <- read_html(path, encoding = "utf-8")
    table <- html_table(page, fill = TRUE)

    data.frame(table, stringsAsFactors=FALSE)
    
  })

names(df) <- c("date", "state", "city", "address", "killed", "injured", "details")

write.table(df, "data/output.csv", row.names = F, quote = F, sep = "\t")
