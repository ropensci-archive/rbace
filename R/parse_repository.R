parse_coll <- function(x) {
  tibble::tibble(
    name = xml2::xml_text(xml2::xml_find_all(x, "//repository//name")),
    internal_name =
      xml2::xml_text(xml2::xml_find_all(x, "//repository//internal_name"))
  )
}

parse_prof <- function(x) {
  z <- xml2::xml_children(x)
  tibble::enframe(stats::setNames(xml2::xml_text(z), xml2::xml_name(z)))
}

bs_parse_repo <- function(x) {
  xml <- xml2::read_xml(x)
  parse_coll(xml)
}

bs_parse_profile <- function(x) {
  xml <- xml2::read_xml(x)
  parse_prof(xml)
}
