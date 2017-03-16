# enforce rate limits
enforce_rate_limit <- function() {
  if (!Sys.getenv('rbace_time') == "") {
    timesince <- as.numeric(Sys.time()) - as.numeric(Sys.getenv('rbace_time'))
    if (timesince < 1) Sys.sleep(1 - timesince)
  }
}
