#' List repositories
#'
#' @export
#' @param coll (character) collection code. For existing, pre-defined
#' collections see Appendix, section "Collection-related queries"
#' @param parse (character) One of 'list' or 'df'
#' @param ... curl options passed on to [crul::HttpClient()]
#' @return XML as character string if `parse = FALSE` or data.frame
#' @examples \dontrun{
#' res <- bs_repositories(coll = "ceu", raw = TRUE)
#' bs_repositories(coll = "ceu")
#'
#' bs_repositories(coll = "denw")
#' bs_repositories(coll = "de")
#' }
bs_repositories <- function(coll, parse = "df", ...) {
  enforce_rate_limit()
  on.exit(Sys.setenv(rbace_time = as.numeric(Sys.time())))
  query <- ct(list(func = 'ListRepositories', coll = coll))
  res <- bs_GET(query, list(...))
  bs_parse_repo(res, parse)
}
