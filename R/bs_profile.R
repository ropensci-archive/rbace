#' List repositories
#'
#' @export
#' @param target (character) Internal name of a single repository as
#' delivered in [bs_repositories()]
#' @param ... curl options passed on to [crul::HttpClient()]
#' @return XML as character string if `parse = FALSE` or data.frame
#' @examples \dontrun{
#' res <- bs_repositories(coll = "de")
#' bs_profile(target = res$internal_name[1])
#' bs_profile(target = res$internal_name[2])
#' bs_profile(target = res$internal_name[20])
#' bs_profile(target = res$internal_name[110])
#' }
bs_profile <- function(target, ...) {
  enforce_rate_limit()
  on.exit(Sys.setenv(rbace_time = as.numeric(Sys.time())))
  query <- ct(list(func = 'ListProfile', target = target))
  x <- bs_GET(query, list(...))
  unlist(xml2::as_list(xml2::read_xml(x)), FALSE)
}
