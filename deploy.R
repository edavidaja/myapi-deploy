library(rsconnect)

deployAPI(
  "myapi",
  account = "svc_rsc_hlds",
  server = "rstudio-connect.awscmh2.k8s.indeed.tech"
)
