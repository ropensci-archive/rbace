#' Search BASE
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' bs_search(target = 'ftubbiepub', query = 'lossau summann')
#' }
bs_search <- function(query = NULL, target = NULL, coll = NULL, parse = TRUE, ...) {
  query <- ct(list(func = 'PerformSearch', query = query, coll = coll, target = target))
  bs_GET(query, ...)
}
