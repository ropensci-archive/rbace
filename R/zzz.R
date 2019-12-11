ct <- function(l) Filter(Negate(is.null), l)

bs_GET <- function(query, opts){
  cli <- crul::HttpClient$new(url = bs_base(),
    headers = list(`User-Agent` = rbace_ua(), `X-USER-AGENT` = rbace_ua()),
    opts = opts)
  temp <- cli$get(query = query)
  if (temp$status_code > 201) {
    stop(sprintf("(%s) - %s", temp$status_code, temp$status_http()$message),
         call. = FALSE)
  }
  temp$parse("UTF-8")
}

bs_base <- function() {
  "https://api.base-search.net/cgi-bin/BaseHttpSearchInterface.fcgi"
}

rbace_ua <- function() {
  versions <- c(paste0("r-curl/", utils::packageVersion("curl")),
    paste0("crul/", utils::packageVersion("crul")), sprintf("rOpenSci(rbace/%s)",
      utils::packageVersion("rbace")))
  paste0(versions, collapse = " ")
}

`%||%` <- function(x, y) if (is.null(x)) y else x
