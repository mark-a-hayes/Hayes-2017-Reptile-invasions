############################
##
## Creating a bubble chart from Table 1 
##
##
## Temporal patterns of invasion
##
## Mark A. Hayes, 7/2/2017
##
############################

## Housekeeping

remove(data) # Removes a specific item


rm(list=ls()) # Removes all items

############################

## Import data using a file picker:

data = read.table(file.choose(), header=TRUE, sep=",")

############################

## Attach the dataframe, with the following simple structure:

attach(data)

## Sumarize the dataframe

summary(data)


####################
##
## Making a bubble chart using first and second derivatives
## and scaling bubbles based on number of occurrences recorded
## Using the following code
## http://blog.revolutionanalytics.com/2010/11/how-to-make-beautiful-bubble-charts-with-r.html
##
####################

## Draw some circles

## With just locations...

symbols(data$slope,data$accel, circles=data$locs)

## With locations scaled by radius...

symbols(slope,accel, circles=radius)

## These circles are way too big for this chart, so changing the size of the circles.

symbols(slope,accel, circles=radius, inches=0.25, 
        fg="white", bg="gray30", xlab="Slope", ylab="Acceleration",  ylim = c(-6,6))
abline(h = 0, v = 0, col = "gray60") # Adds a line at 0 for the x and y axis

## Before adding labels, print a copy of the figure without labels.

dev.print(tiff, "bubbleChart_no_labels.tiff", height=4, width=6, units='in', res=600)

## Now add labels

text(slope,accel,spp, cex=0.6)

## And print a copy with labels. Use Powerpoint or photoshop to label
## the bubbles as desired for the final figure.

dev.print(tiff, "bubbleChart_labels.tiff", height=4, width=6, units='in', res=600)

## End.
