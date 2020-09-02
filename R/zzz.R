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

bs_RETRY <- function(query, opts, ret) {
  cli <- crul::HttpClient$new(url = bs_base(),
    headers = list(`User-Agent` = rbace_ua(), `X-USER-AGENT` = rbace_ua()),
    opts = opts)
  temp <- cli$retry("GET", query = query,
    pause_base = ret$pause_base,
    pause_cap = ret$pause_cap,
    pause_min = ret$pause_min,
    times = ret$times,
    terminate_on = ret$terminate_on,
    retry_only_on = ret$retry_only_on,
    onwait = ret$onwait
  )
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

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
        paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

make_values <- function() {
  return(5)
}

gbh <- function(query) {
  list(
    query = query,
    docs = list(
      dcsubject = "Mathematics",
      dccreator = "Samuel Jones",
      dcidentifier = 23423423234
    )
  )
}

