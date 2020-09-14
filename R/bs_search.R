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
#' @param filter (character) a string with the value to be used. html escaping
#' will be automatically done; embed string in `I()` to avoid html escaping.
#' This parameter gets used by `fq` solr parameter on the server
#' @param raw (logical) If `TRUE` returns raw XML, default: `FALSE`
#' @param parse (character) One of 'list' or 'df'
#' @param retry (list) use [bs_retry_options()] to make a named list of 
#' retry options to pass on to the HTTP request. default values are passed
#' for you, but you can change them by setting an option in
#' `bs_retry_options()`
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
#' https://www.base-search.net/about/download/base_interface.pdf,
#' section "Fields", table column "Facet"
#'
#' @examples \donttest{
#' # repository "ftubbiepub" containing the terms
#' # "lossau" and "summann" (search in the whole document)
#' res <- bs_search(target = 'ftubbiepub', query = 'lossau summann', hits = 3)
#' res$docs$dcsubject
#' res$docs$dccreator
#' res$docs$dcidentifier
#' }
bs_search <- function(query = NULL, target = NULL, coll = NULL,
  boost_oa = FALSE, hits = NULL, offset = NULL, fields = NULL, sortby = NULL,
  facets = NULL, facet_limit = 100, facet_sort = NULL, filter = NULL,
  raw = FALSE, parse = "df", retry = bs_retry_options(), ...) {

  enforce_rate_limit()
  on.exit(Sys.setenv(rbace_time = as.numeric(Sys.time())))

  assert(boost_oa, "logical")
  assert(raw, "logical")
  assert(hits, c("integer", "numeric"))
  assert(offset, c("integer", "numeric"))
  assert(facet_limit, c("integer", "numeric"))
  assert(facet_sort, "character")
  assert(filter, c("character", "AsIs"))
  if (!is.null(fields)) fields <- paste(fields, collapse = ",")
  if (!is.null(facets)) facets <- paste(facets, collapse = ",")
  query <- ct(list(func = 'PerformSearch', query = query,
                coll = coll, target = target,
                boost = if (boost_oa) "oa" else NULL,
                fields = fields, hits = hits, offset = offset,
                sortby = sortby, facets = facets,
                facet_limit = facet_limit, facet_sort = facet_sort,
                filter = filter))

  # add any field specific facet parameters
  facpars <- capture_facet_params(...)
  query <- c(query, facpars)

  # res <- bs_GET(query, drop_facet_params(...))
  res <- bs_RETRY(query, drop_facet_params(...), retry)
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
    query = tibble::tibble(q = tmp$q, fl = tmp$fl,
                               fq = tmp$fq, start = tmp$start),
    response = tibble::tibble(status = tmp$status, num_found = tmp$numFound)
  )
}

#' bs_search retry options
#' @export
#' @param times the maximum number of times to retry.
#' @param pause_base,pause_cap,pause_min basis, maximum, and minimum for
#' calculating wait time for retry.
#' @param terminate_on,retry_only_on a vector of HTTP status codes.
#' @param onwait a callback function if the request will be retried and
#' a wait time is being applied.
#' @details see [crul::HttpClient] for more detailed explanation of these 
#' parameters
#' @return a named list with the parameters given to this function
bs_retry_options <- function(pause_base = 1, pause_cap = 60, pause_min = 1,
  times = 3, terminate_on = NULL, retry_only_on = NULL, onwait = NULL) {
  list(
    pause_base = pause_base,
    pause_cap = pause_cap,
    pause_min = pause_min,
    times = times,
    terminate_on = terminate_on,
    retry_only_on = retry_only_on,
    onwait = onwait
  )
}
