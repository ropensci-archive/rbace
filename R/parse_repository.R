parse_coll <- function(x, parse) {
  tibble::data_frame(
    name = xml2::xml_text(xml2::xml_find_all(x, "//repository//name")),
    internal_name =
      xml2::xml_text(xml2::xml_find_all(x, "//repository//internal_name"))
  )
}

bs_parse_repo <- function(x, parse) {
  xml <- xml2::read_xml(x)
  parse_coll(xml, parse)
}
