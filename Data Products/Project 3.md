Prediction of Displacement of the car from "mtcars" dataset.
========================================================
author: SK
date: 31/07/19
autosize: true

Introduction
========================================================

This shiny application predicts the displacement done by cars according to variations in factors affecting the displacement.

The User chooses the the number of carborators , the horsepower and the weight of th car.

The app then shows the plots of the points and regression lines showing the relation between displacement and the factors affecting it.

Also the application predicts the value according to change in the values of the variables and also plot the predicted value in the plots.

More details can be found at :
-Deployed Application : https://zippysphinx.shinyapps.io/displacement/

Data
========================================================

This app uses the data from the datasets contained in datasets package.
The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models).


```r
str(mtcars)
```

```
'data.frame':	32 obs. of  11 variables:
 $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
 $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
 $ disp: num  160 160 108 258 360 ...
 $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
 $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
 $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
 $ qsec: num  16.5 17 18.6 19.4 17 ...
 $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
 $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
 $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
 $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

How application works !
========================================================

The user selects the following things :
- Horsepower of the car
- Number of carborators in car
- Weight of the car.

The application then uses 3 linear models to predict the value of the displacement from the data inputed by user.

The plots and prediction values are automatically refreshed as the values changes.

Documentation
========================================================
A documentation is created inside the shiny application in the documentation tab which contains following information :
- Why and which of the variables from the data are choosen for the models.
- The information of the linear models used to predict the displacement value.
- Units of the values used in the models.
- What information, plots represent and what they contain in them.
- How plots are working and made.

