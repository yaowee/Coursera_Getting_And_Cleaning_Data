#Downloads the data sets required and unzips it to the current directory
file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file.dest <- "UCI_HAR_Dataset.zip"
download.file(url=file.url,destfile = file.dest)
unzip("UCI_HAR_Dataset.zip",exdir=".")
#Step 1: