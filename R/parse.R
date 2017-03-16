nmtxt <- function(x) {
  if (xml2::xml_name(x) == "arr") {
    txt <- paste0(xml2::xml_text(xml2::xml_find_all(x, ".//str")),
                  collapse = "; ")
  } else {
    txt <- xml2::xml_text(x)
  }

  as.list(
    stats::setNames(
      txt,
      xml2::xml_attr(x, "name")
    )
  )
}

parse_dat <- function(x, parse = "df") {
  # docs
  temp <- xml2::xml_find_all(x, "//doc")
  tmptmp <- lapply(temp, function(z) {
    sapply(xml2::xml_children(z), nmtxt)
  })

  # facets
  facs <- list()
  if (
    xml2::xml_length(
      xml2::xml_find_first(x, "//lst[@name=\"facet_counts\"]")
    ) != 0
  ) {
    fac <- xml2::xml_children(
      xml2::xml_find_all(x, "//lst[@name=\"facet_fields\"]")
    )
    if (parse == "df") {
      facs <- stats::setNames(lapply(fac, function(z) {
        ch <- xml2::xml_children(z)
        tibble::data_frame(
          name = xml2::xml_attr(ch, "name"),
          value = xml2::xml_text(ch)
        )
      }), gsub("f_", "", xml2::xml_attr(fac, "name")))
    } else {
      facs <- stats::setNames(lapply(fac, function(z) {
        ch <- xml2::xml_children(z)
        as.list(stats::setNames(
          xml2::xml_attr(ch, "name"),
          xml2::xml_text(ch)
        ))
      }), gsub("f_", "", xml2::xml_attr(fac, "name")))
    }
  }

  if (parse == "df") {
    docs <- tibble::as_tibble(data.table::setDF(
      data.table::rbindlist(
        lapply(tmptmp, data.frame, stringsAsFactors = FALSE),
        use.names = TRUE, fill = TRUE
      )
    ))
    list(docs = docs, facets = facs)
  } else {
    list(docs = tmptmp, facets = facs)
  }
}

l2df <- function(x) {
  tibble::as_tibble(data.table::setDF(
    data.table::rbindlist(x, use.names = TRUE, fill = TRUE)
  ))
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
    xml2::xml_children(xml2::xml_find_first(lsts, "lst[@name=\"params\"]")),
    function(z) {
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
