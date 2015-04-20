## Coursera - Exploratory Data Analysis - Plotting Assignment 2
##
## plot3.R - generates plot1.png

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

# Baltimore City, Maryland == fips
Baltimore <- subset(NEI, fips == 24510)
Baltimore$year <- factor(Baltimore$year, levels=c('1999', '2002', '2005', '2008'))

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Generate the graph in the same directory as the source code
png(filename='~/ass2_plot3.png', width=800, height=500, units='px')

ggplot(data=Baltimore, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
    geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
    ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
    ggtitle('Emissions per Type in Baltimore City, Maryland') +
    geom_jitter(alpha=0.10)
dev.off()
