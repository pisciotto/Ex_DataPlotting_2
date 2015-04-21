## Coursera - Exploratory Data Analysis - Plotting Assignment 2
##
## plot6.R - generates plot1.png

## First of all, we make sure we have the downloaded data available, we will
## put it in a file in the local working directory

##Load ggplot2 library
require(ggplot2)

filename = "exdata_plotting2.zip"
if (!file.exists(filename)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                         destfile = filename,
                         method = "auto")
}

## Reading the data from the contents of the zipped file
NEI <- readRDS(unzip(filename,"summarySCC_PM25.rds"))
SCC <- readRDS(unzip(filename,"Source_Classification_Code.rds"))

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland
# Los Angeles County, California
Baltimore_onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
LA_onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate
Baltimore_DF <- aggregate(Baltimore_onroad[, 'Emissions'], by=list(Baltimore_onroad$year), sum)
colnames(Baltimore_DF) <- c('year', 'Emissions')
Baltimore_DF$City <- paste(rep('MD', 4))

LA_DF <- aggregate(LA_onroad[, 'Emissions'], by=list(LA_onroad$year), sum)
colnames(LA_DF) <- c('year', 'Emissions')
LA_DF$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(Baltimore_DF, LA_DF))

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time 
# in motor vehicle emissions?

# Generate the graph in the same directory as the source code
png('~/ass2_plot6.png')

ggplot(data=DF, aes(x=year, y=Emissions)) +
  geom_point()+ 
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) +
  xlab('Year') + 
  theme(legend.position='none') + 
  facet_grid(. ~ City)  
dev.off()
