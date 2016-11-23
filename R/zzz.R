ct <- function(l) Filter(Negate(is.null), l)

bs_GET <- function(query, ...){
  cli <- HttpClient$new(url = bs_base(), opts = list(...))
  cli$opts$useragent <- rbace_ua()
  cli$headers$`X-USER-AGENT` <- rbace_ua()
  temp <- cli$get(query = query)
  if (temp$status_code > 201) {
    stop(sprintf("(%s) - %s", temp$status_code, temp$status_http()$message), call. = FALSE)
  }
  #bs_err_catcher(temp)
  temp$parse()
}

# bs_err_catcher <- function(x) {
#   xx <- xml2::fromJSON(x$parse())
#   if (any(vapply(c("message", "error"), function(z) z %in% names(xx), logical(1)))) {
#     stop(xx[[1]], call. = FALSE)
#   }
# }

bs_base <- function() "https://api.base-search.net/cgi-bin/BaseHttpSearchInterface.fcgi"

rbace_ua <- function() {
  versions <- c(
    paste0("r-curl/", utils::packageVersion("curl")),
    paste0(
      "crul/",
      utils::packageVersion("crul")),
    sprintf("rOpenSci(rbace/%s)",
            utils::packageVersion("rbace"))
  )
  paste0(versions, collapse = " ")
}
