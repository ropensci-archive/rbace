#' Search BASE
#'
#' @export
#' @param query (character) query string. For syntax details see Appendix,
#' section "Query syntax"
#' @param target (character) Internal name of a single repository as
#' delivered in [bs_list()]
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
#' @param raw (logical) If `TRUE` returns raw XML, default: `FALSE`
#' @param parse (character) One of 'list' or 'df'
#' @param ... curl options passed on to [crul::HttpClient()]
#' @param x input to `bs_meta`
#'
#' @return XML as character string if `parse = FALSE` or data.frame
#'
#' @details BASE asks that requests are not more frequent than 1 per second,
#' so we enforce the rate limit internally. if you do a single request not
#' in a for loop/lapply type situation, this won't be inoked, but will
#' if doing a for loop/lapply call, and there's no sleep invoked
#'
#' @examples \dontrun{
#' # repository "ftubbiepub" containing the terms
#' # "lossau" and "summann" (search in the whole document)
#' res <- bs_search(target = 'ftubbiepub', query = 'lossau summann')
#' res
#' res$dcsubject
#' res$dccreator
#' res$dcidentifier
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
#' }
bs_search <- function(query = NULL, target = NULL, coll = NULL, boost_oa = FALSE,
                      hits = NULL, offset = NULL, fields = NULL, sortby = NULL,
                      raw = FALSE, parse = "df", ...) {
  enforce_rate_limit()
  on.exit(Sys.setenv(rbace_time = as.numeric(Sys.time())))
  if (!is.null(fields)) fields <- paste(fields, collapse = ",")
  query <- ct(list(func = 'PerformSearch', query = query,
                coll = coll, target = target,
                boost = if (boost_oa) "oa" else NULL,
                fields = fields, hits = hits, offset = offset,
                sortby = sortby))
  res <- bs_GET(query, ...)
  if (raw) return(res) else return(bs_parse(res, parse))
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
