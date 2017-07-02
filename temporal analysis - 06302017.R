### Hayes 2017 - Temporal patterns of invasion analysis

## Mark A. Hayes
## June 30, 2017

## This approach uses polynomial regression to analyze patterns of invasion.
## See Kabacoff's (2011) "R in action" book for a discussion of use in R. 
## Also,  see Legendre and Legendre's (2012, p 568-569) "Numerical ecology" book for more discussion.
## Here I use the stepwise selection process they propose, but look at all models after the global model.
## If an error occurs in fitting one of the coefficients, I do not use that model.
## The model with lowest AIC and in which all coefficients are significant at p = 0.05 are preferred. 
## Crawley's (2013) "The R book" also provides some useful details. 

# Polynomial regression assumes approximately equal variance and normality in the residuals.
# However, repeated zeros in early years of invasions can cause violations of these assumptions.
# Thus for the training data, I set the first year as the next year after the last zero in the data. 

## Step 1. Pull in a csv file to use and name the "Years" and "Occurrences" columns.

remove() # Remove any object left over from previous analyses, as desired, or... 
rm(list=ls()) # ...remove all items from global environment


data = read.table(file.choose(), header=TRUE, sep=",") # Choose the csv to use (e.g., agag_locs.csv).
data
summary(data)

year <- data$Year
locs <- data$Occurrences

year # Make sure there aren't any NA's in the vectors. If so, remove them in the csv. 
sum(locs)

## Step 2. Fit data using 1st, 2nd, and 3rd order polynomials, and all possible models. 
## The order refers to the highest exponent.
## Then calculate AICs and look at model summaries. 

fit1 <- lm(locs ~ year + I(year^2) + I(year^3), data = data)
fit2 <- lm(locs ~ year + I(year^2), data = data)
fit3 <- lm(locs ~ year + I(year^3), data = data)
fit4 <- lm(locs ~ I(year^2) + I(year^3), data = data)
fit5 <- lm(locs ~ year, data = data)
fit6 <- lm(locs ~ I(year^2), data = data)
fit7 <- lm(locs ~ I(year^3), data = data)

AIC(fit1, fit2, fit3, fit4, fit5, fit6, fit7)

summary(fit1)
summary(fit2)
summary(fit3)
summary(fit4)
summary(fit5)
summary(fit6)
summary(fit7)

# Regression diagnostics plots (hit 'Ctrl+Enter' 4 times to see the 4 plots).
# See Kabakoff pp 190+ and Crawley 404+ for discussion of diagnostics. 

plot(fit2)

# In some cases removing early years may improve the model and reduce violations 
# of the normality and constant variance assumption, etc. This may also reduce leverage 
# and outliers in the data. For example, removing the first 5 years of the pymo data
# (1995-1999) improves the model. The code below removes the first 5 instances for the
# seven models.

data[-c(1:5),] # Note that first 5 years are removed.

fit1b <- lm(locs ~ year + I(year^2) + I(year^3), data = data[-c(1:5),])
fit2b <- lm(locs ~ year + I(year^2), data = data[-c(1:5),])
fit3b <- lm(locs ~ year + I(year^3), data = data[-c(1:5),])
fit4b <- lm(locs ~ I(year^2) + I(year^3), data = data[-c(1:5),])
fit5b <- lm(locs ~ year, data = data[-c(1:5),])
fit6b <- lm(locs ~ I(year^2), data = data[-c(1:5),])
fit7b <- lm(locs ~ I(year^3), data = data[-c(1:5),])

AIC(fit1b, fit2b, fit3b, fit4b, fit5b, fit6b, fit7b)

summary(fit1b)
summary(fit2b)
summary(fit3b)
summary(fit4b)
summary(fit5b)
summary(fit6b)
summary(fit7b)

# Regression diagnostics plots (hit 'Ctrl+Enter' 4 times to see the 4 plots):

plot(fit2b)

# Plotting the best model in terms of AIC. NOTE: Change main label as desired.

x <- 2011:2017
y <- predict(fit2, list(year=x))
y # The last number will be the prediction for year 2017
plot(year, locs,
     main = "",
     xlab = "Year",
     ylab = "Occurrences")
lines(x,y)



## Step 3. Derivatives analysis.

# Taking the first (slope) and second (acceleration) derivative of the best model, plugging in coefficients. 
# Note: I am getting implausible first derivatives when using 3rd order polynomials.
# To keep it simple for the time being, I'm only using second order polynomials.
# Just looking at second order polynomials may be reasonable and prudent,
# given the relatively small datasets. 


# First derivative:
fit2 # Use model to plug into the expression below.
D(expression( -1.151e+07  +  1.143e+04*x   -2.839e+00*x^2    ),"x")
 
# And evaluate at 2017:

11430 - 2.839 * (2 * 2017)

# Take the second derivative:

D(expression(11430 - 2.839 * (2 * x)), "x")

# And evaluate at 2017:

-(2.839 * 2)

## Record results as desired. 
## Repeat as necessary. 

## End.

