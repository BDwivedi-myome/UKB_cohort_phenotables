library(jsonlite)

convert_to_json <- function(df, json_file_path){
  # convert the data frame to json
  converted_json <- toJSON(df, pretty=TRUE)
  # save the converted json file
  write_json(converted_json, path=json_file_path)
}

validate_json <- function(json_schema, json_file_path){
  ## validate the json schema
  jsonvalidate::json_validator(json_schema)
  jsonvalidate::json_validate(json_file_path, json_schema, verbose = TRUE, greedy = TRUE)
}
