## Coursera - Exploratory Data Analysis - Plotting Assignment 2
##
## plot5.R - generates plot1.png

## First of all, we make sure we have the downloaded data available, we will
## put it in a file in the local working directory
filename = "exdata_plotting2.zip"
if (!file.exists(filename)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                         destfile = filename,
                         method = "auto")
}

## Load ggplot2 library
require(ggplot2)

## Reading the data from the contents of the zipped file
NEI <- readRDS(unzip(filename,"summarySCC_PM25.rds"))
SCC <- readRDS(unzip(filename,"Source_Classification_Code.rds"))

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips
Baltimore_onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
Baltimore_df <- aggregate(Baltimore_onroad[, 'Emissions'], by=list(Baltimore_onroad$year), sum)
colnames(Baltimore_df) <- c('year', 'Emissions')

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

# Generate the graph in the same directory as the source code
png('~/ass2_plot5.png')

ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
    ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
    ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))
dev.off()
