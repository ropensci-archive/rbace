#' Get the profile for a repository
#'
#' @export
#' @param target (character) Internal name of a single repository as
#' delivered in [bs_repositories()]
#' @param ... curl options passed on to [crul::verb-GET]
#' @return a data.frame, of two columns: "name", "value".
#' "name" holds the "value" description. you can pivot the 
#' data.frame to wide by e.g., `tidyr::pivot_wider(x)`
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
  assert(target, "character")
  query <- ct(list(func = 'ListProfile', target = target))
  x <- bs_GET(query, list(...))
  bs_parse_profile(x)
}
