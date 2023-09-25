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

plumber::plumb_api("myapi", "data") |>
  plumber::pr_hook("exit", function(){
    poolClose(pool)
  }) |>
  plumber::pr_run()
