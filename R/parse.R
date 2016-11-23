nmtxt <- function(x) {
  as.list(stats::setNames(xml2::xml_text(x), xml2::xml_attr(x,
                                                            "name")))
}

parse_dat <- function(x, parse = "df") {
  temp <- xml2::xml_find_all(x, "//doc")
  tmptmp <- lapply(temp, function(z) {
    sapply(xml2::xml_children(z), nmtxt)
  })
  if (parse == "df") {
    dplyr::bind_rows(lapply(tmptmp, dplyr::as_data_frame))
  } else {
    tmptmp
  }
}

make_atts <- function(x) {
  lsts <- xml2::xml_find_first(x, "lst")
  status <- xml2::xml_children(lsts)[[1]]
  status <- as.list(
    stats::setNames(
      as.numeric(xml2::xml_text(status)), "status")
  )
  qtime <- xml2::xml_children(lsts)[[2]]
  qtime <- as.list(stats::setNames(xml2::xml_text(qtime), "QTime"))
  params <- sapply(
    xml2::xml_children(xml2::xml_find_first(lsts, "lst[@name=\"params\"]")), function(z) {
      as.list(stats::setNames(xml2::xml_text(z), xml2::xml_attr(z, "name")))
    })
  req_atts <- c(status, qtime, params)
  res_atts <- as.list(xml2::xml_attrs(xml2::xml_find_first(x, "result")))
  res_atts$numFound <- as.numeric(res_atts$numFound)
  res_atts$start <- as.numeric(res_atts$start)
  c(req_atts, res_atts)
}

add_attrs <- function(x, atts = NULL) {
  if (!is.null(atts)) {
    for (i in seq_along(atts)) {
      attr(x, names(atts)[i]) <- atts[[i]]
    }
    return(x)
  } else {
    return(x)
  }
}

# x = an xml object
bs_parse <- function(x, parse) {
  xml <- xml2::read_xml(x)
  add_attrs(parse_dat(xml, parse), make_atts(xml))
}
