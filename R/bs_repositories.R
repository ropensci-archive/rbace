#' List repositories
#'
#' @export
#' @param coll (character) collection code. For existing, pre-defined
#' collections see Appendix, section "Collection-related queries" in
#' the Appendix of
#' https://www.base-search.net/about/download/base_interface.pdf
#' @param ... curl options passed on to [crul::verb-GET]
#' @return a data.frame of two columns: "name", "internal_name"
#' @examples \dontrun{
#' res <- bs_repositories(coll = "ceu")
#' bs_repositories(coll = "ceu")
#' bs_repositories(coll = "denw")
#' bs_repositories(coll = "de")
#' }
bs_repositories <- function(coll, ...) {
  enforce_rate_limit()
  on.exit(Sys.setenv(rbace_time = as.numeric(Sys.time())))
  assert(coll, "character")
  query <- ct(list(func = 'ListRepositories', coll = coll))
  res <- bs_GET(query, list(...))
  bs_parse_repo(res)
}
