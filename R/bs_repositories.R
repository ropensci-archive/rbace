#' List repositories for a collection
#'
#' @export
#' @param coll (character) collection code. For existing, pre-defined
#' collections see Appendix, section "Collection-related queries" in
#' the Appendix of
#' https://www.base-search.net/about/download/base_interface.pdf
#' @param ... curl options passed on to [crul::verb-GET]
#' @return a data.frame of two columns: "name", "internal_name"
#' @examples \donttest{
#' bs_repositories(coll = "ceu")
#' }
bs_repositories <- function(coll, ...) {
  return(make_values())
  enforce_rate_limit()
  on.exit(Sys.setenv(rbace_time = as.numeric(Sys.time())))
  assert(coll, "character")
  query <- ct(list(func = 'ListRepositories', coll = coll))
  res <- bs_GET(query, list(...))
  bs_parse_repo(res)
}
