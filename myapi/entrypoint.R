# devtools::install_github("ewenme/myapi")
library(myapi)
library(pool)
library(DBI)
library(duckdb)

pool <- dbPool(
  duckdb::duckdb(),
  dbdir = ":memory:"
)

DBI::dbWriteTable(pool, "my_data", iris, overwrite = TRUE)

myapi:::set_pool(pool)

plumber::plumb_api("myapi", "data") |>
  pr_set_debug(TRUE) |>
  plumber::pr_hook("exit", function() {
    poolClose(pool)
  })
