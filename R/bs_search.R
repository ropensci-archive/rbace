#' Search BASE
#'
#' @export
#' @param query (character) query string. For syntax details see Appendix,
#' section "Query syntax"
#' @param target (character) Internal name of a single repository as
#' delivered in [bs_repositories()]
#' @param coll (character) collection code. For existing, pre-defined
#' collections see Appendix, section "Collection-related queries"
#' @param boost_oa (logical) Push open access documents upwards in the
#' result list. Default: `FALSE`
#' @param hits (integer) number of results to return. Default: 10. Max: 100
#' @param offset (integer) record to start at. Default: 0. Max: 1000
#' @param fields (character) Fields to return. This doesn't appear to be
#' working though. The result records only contain fields listed in the
#' comma-separated field list. For existing, pre-defined fields see Appendix,
#' section "Fields"
#' @param sortby (character) field to sort by. A sort ordering must include
#' a single field name (see Appendix, section "Fields", table column
#' "Sorting"), followed by a whitespace (escaped as + or %20 in URL strings),
#' followed by sort direction (asc or desc). Default: sorts by relevance
#' @param facets (character) The response contains an extra section
#' "facet_counts/facet_fields" with fields from the comma-separated facets
#' list. This section provides a breakdown or summary of the results. From the
#' user's perspective, faceted search breaks up search results into multiple
#' categories, typically showing counts for each, and allows the user to
#' "drill down" or further restrict their search results based on those facets.
#' Use of faceting does not affect the results section of a search response.
#' For existing, pre-defined facet fields see Appendix, section "Fields",
#' table column "Facet".
#' @param facet_limit (numeric) Maximum number of constraint counts that
#' should be returned for the facet fields. Default: 100; min:1; max: 500
#' @param facet_sort (character) Ordering of the facet field constraints:
#' count - sort by count (highest count first);  index - alphabetical sorting.
#' Default: count
#' @param raw (logical) If `TRUE` returns raw XML, default: `FALSE`
#' @param parse (character) One of 'list' or 'df'
#' @param ... Facet field based query options (See Facet below) or curl
#' options passed on to [crul::verb-GET]
#' @param x input to `bs_meta`
#'
#' @return XML as character string if `parse = FALSE` or data.frame
#'
#' @details BASE asks that requests are not more frequent than 1 per second,
#' so we enforce the rate limit internally. if you do a single request not
#' in a for loop/lapply type situation, this won't be inoked, but will
#' if doing a for loop/lapply call, and there's no sleep invoked
#'
#' @section Facet:
#' You can optionally pass in search term for specific facet fields.
#' See example. For existing, pre-defined facet fields see Appendix at
#' <https://www.base-search.net/about/download/base_interface.pdf>,
#' section "Fields", table column "Facet"
#'
#' @examples \dontrun{
#' # repository "ftubbiepub" containing the terms
#' # "lossau" and "summann" (search in the whole document)
#' res <- bs_search(target = 'ftubbiepub', query = 'lossau summann')
#' res
#' res$docs$dcsubject
#' res$docs$dccreator
#' res$docs$dcidentifier
#' attributes(res)
#' bs_meta(res)
#'
#' # Italian repositories containing the term "manghi'
#' # in the "dccreator" field (author).  The flag "boost" pushes open
#' # access documents upwards in the result list
#' (res <- bs_search(coll = 'it', query = 'dccreator:manghi', boost_oa = TRUE))
#'
#' # terms "schmidt" in dccreator field (author) and "biology" in dctitle.
#' # The response starts after record 5 (offset=5) and contains max.
#' # 5 hits with the fields dctitle, dccreator and dcyear
#' (res <- bs_search(query = 'dccreator:schmidt dctitle:biology',
#'   hits = 5, offset = 5, fields = c('dctitle', 'dccreator', 'dcyear')))
#'
#' # term "unix" and published between 1983 and 2009, sorted by year
#' # of publication (dcyear) in descending order
#' (res <- bs_search(query = 'unix dcyear:[1983 TO 2009]',
#'   sortby = 'dcyear desc'))
#'
#' # raw XML output
#' bs_search(target = 'ftubbiepub', query = 'lossau summann', raw = TRUE)
#'
#' # list output
#' bs_search(target = 'ftubbiepub', query = 'lossau summann', parse = "list")
#'
#' out <- list()
#' system.time(
#'   for (i in 1:3) {
#'     out[[i]] <- bs_search(target = 'ftubbiepub', query = 'lossau summann',
#'       hits = 1)
#'   }
#' )
#' out
#'
#' # Faceting
#' bs_search(query = "unix", facets = c("dcsubject", "dcyear"),
#'   facet_limit = 10)
#'
#' bs_search(query = "unix", facets = c("dcsubject", "dcyear"),
#'   f_dcsubject = '"computer science"',
#'   facet_limit = 10, verbose = TRUE)
#' }
bs_search <- function(query = NULL, target = NULL, coll = NULL,
  boost_oa = FALSE, hits = NULL, offset = NULL, fields = NULL, sortby = NULL,
  facets = NULL, facet_limit = 100, facet_sort = NULL, raw = FALSE,
  parse = "df", ...) {

  enforce_rate_limit()
  on.exit(Sys.setenv(rbace_time = as.numeric(Sys.time())))

  assert(boost_oa, "logical")
  assert(raw, "logical")
  assert(hits, c("integer", "numeric"))
  assert(offset, c("integer", "numeric"))
  assert(facet_limit, c("integer", "numeric"))
  assert(facet_sort, "character")
  if (!is.null(fields)) fields <- paste(fields, collapse = ",")
  if (!is.null(facets)) facets <- paste(facets, collapse = ",")
  query <- ct(list(func = 'PerformSearch', query = query,
                coll = coll, target = target,
                boost = if (boost_oa) "oa" else NULL,
                fields = fields, hits = hits, offset = offset,
                sortby = sortby, facets = facets,
                facet_limit = facet_limit, facet_sort = facet_sort))

  # add any field specific facet parameters
  facpars <- capture_facet_params(...)
  query <- c(query, facpars)

  res <- bs_GET(query, drop_facet_params(...))
  if (raw) return(res) else return(bs_parse(res, parse))
}

capture_facet_params <- function(...) {
  tmp <- list(...)
  tmp[grep("f_", names(tmp))]
}

drop_facet_params <- function(...) {
  tmp <- list(...)
  tmp[grep("f_", names(tmp), invert = TRUE)]
}

#' @export
#' @rdname bs_search
bs_meta <- function(x) {
  tmp <- attributes(x)
  tmp$names <- NULL
  tmp$row.names <- NULL
  tmp$class <- NULL
  list(
    query = tibble::data_frame(q = tmp$q, fl = tmp$fl,
                               fq = tmp$fq, start = tmp$start),
    response = tibble::data_frame(status = tmp$status, num_found = tmp$numFound)
  )
}
