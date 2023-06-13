library(tidyverse)
library(aws.s3)

# A function to put data from local machine to S3
put_to_s3 <- function(from, to) {
  aws.s3::put_object(
    file = from,
    object = to,
    bucket = "fbedecarrats",
    region = "",
    multipart = TRUE)
}

my_files <- list.files(path = ".", recursive = TRUE, full.names = TRUE) %>% 
  str_subset(pattern = ".*chirps.*")

dest_s3 <- my_files %>%
  str_replace("\\./", "mapme_biodiversity/" )

map2(my_files, dest_s3, put_to_s3)
