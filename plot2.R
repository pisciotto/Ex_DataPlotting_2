## Coursera - Exploratory Data Analysis - Plotting Assignment 2
##
## plot2.R - generates plot2.png

## First of all, we make sure we have the downloaded data available, we will
## put it in a file in the local working directory
filename = "exdata_plotting2.zip"
if (!file.exists(filename)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                         destfile = filename,
                         method = "auto")
}

## Reading the data from the contents of the zipped file
NEI <- readRDS(unzip(filename,"summarySCC_PM25.rds"))
SCC <- readRDS(unzip(filename,"Source_Classification_Code.rds"))

# Subset data and append two years in one data frame
Baltimore <- subset(NEI, fips=='24510')

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Generate the graph in the same directory as the source code
png(filename='~/ass2_plot2.png')

barplot(tapply(X=Baltimore$Emissions, INDEX=Baltimore$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))
dev.off()
