#' Search BASE
#'
#' @export
#' @param query (character) query string
#' @param target (character) target code
#' @param coll (character) collection code
#' @param boost (character) boost string
#' @param hits (integer) number of results to return
#' @param offset (integer) record to start at
#' @param fields Fields to return. This doesn't appear to be working though.
#' @param raw (logical) If \code{TRUE} returns raw XML, default: \code{FALSE}
#' @param parse (character) One of 'list' or 'df'
#'
#' @return XML as character string if \code{parse=FALSE} or data.frame
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
#' attributes(res)
#' bs_meta(res)
#'
#' # Italian repositories containing the term "manghi'
#' # in the "dccreator" field (author).  The flag "boost" pushes open
#' # access documents upwards in the result list
#' (res <- bs_search(coll = 'it', query = 'dccreator:manghi', boost = "oa"))
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
#' for (i in 1:3) {
#'   out[[i]] <- bs_search(target = 'ftubbiepub', query = 'lossau summann', hits = 1)
#' }
#' )
#' out
#' }
bs_search <- function(query = NULL, target = NULL, coll = NULL, boost = NULL,
                      hits = NULL, offset = NULL, fields = NULL, sortby = NULL,
                      raw = FALSE, parse = "df", ...) {
  enforce_rate_limit()
  on.exit(Sys.setenv(rbace_time = as.numeric(Sys.time())))
  if (!is.null(fields)) fields <- paste(fields, collapse = ",")
  query <- ct(list(func = 'PerformSearch', query = query,
                   coll = coll, target = target, boost = boost,
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

# enforce rate limits
enforce_rate_limit <- function() {
  if (!Sys.getenv('rbace_time') == "") {
    timesince <- as.numeric(Sys.time()) - as.numeric(Sys.getenv('rbace_time'))
    if (timesince < 1) Sys.sleep(1 - timesince)
  }
}
