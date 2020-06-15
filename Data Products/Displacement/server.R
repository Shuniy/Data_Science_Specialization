#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyServer(function(input, output) {
    
    model1 <- lm(disp ~ wt, data = mtcars)
    model2 <- lm(disp ~ hp -1, data = mtcars)
    model3 <- lm(disp ~ wt + carb + hp , data = mtcars)
    
    model1pred <- reactive({
        HPInput <- input$sliderHP
        CarbInput <- input$sliderCarb
        WtInput <- input$sliderWt
        predict(model1, newdata = data.frame(hp = HPInput, carb = CarbInput,
                                             wt = WtInput))
    })
    
    model2pred <- reactive({
        HPInput <- input$sliderHP
        CarbInput <- input$sliderCarb
        WtInput <- input$sliderWt
        predict(model2, newdata = data.frame(hp = HPInput, carb = CarbInput,
                                             wt = WtInput))
    })
    
    model3pred <- reactive({
        HPInput <- input$sliderHP
        CarbInput <- input$sliderCarb
        WtInput <- input$sliderWt
        predict(model3, newdata = data.frame(hp = HPInput, carb = CarbInput,
                                             wt = WtInput))
    })
    
    output$plot1 <- renderPlot({
        
        HPInput <- input$sliderHP
        CarbInput <- input$sliderCarb
        WtInput <- input$sliderWt
        
        plot(mtcars$wt, mtcars$disp, pch = 16, xlab = "Weight of the car",
             ylab = "Displacement of the car")
        
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        
        if(input$showModel3){
            abline(model3, col = "blue", lwd = 2)
        }
        
        
        legend(4, 200, c("Model 1 Predict", "Model 3 Predict"),
               pch = 16, col = c("red", "blue"), cex = 1.2)
        
        
        points(WtInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(WtInput, model3pred(), col = "blue", pch = 16, cex = 2)
        
    })
    
    output$plot2 <- renderPlot({
        
        HPInput <- input$sliderHP
        CarbInput <- input$sliderCarb
        WtInput <- input$sliderWt
        
        plot(mtcars$hp, mtcars$disp, pch = 16, xlab = "Horsepower of the car",
             ylab = "Displacement of the car")
        
        if(input$showModel2){
            abline(model2, col = "red", lwd = 2)
        }
        
        if(input$showModel3){
            abline(model3, col = "blue", lwd = 2)
        }
        
        
        legend(250, 250, c("Model 2 Predict", "Model 3 Predict"),
               pch = 16, col = c("red", "blue"), cex = 1.2)
        
        points(HPInput, model2pred(), col = "red", pch = 16, cex = 2)
        points(HPInput, model3pred(), col = "blue", pch = 16, cex = 2)
        
    })
    
    output$plot3 <- renderPlot({
        
        HPInput <- input$sliderHP
        CarbInput <- input$sliderCarb
        WtInput <- input$sliderWt
        
        plot(mtcars$disp, pch = 16, xlab = "Index", ylab = "Displacement of car")
        
        points(HPInput, model3pred(), col = "red", pch = 16, cex = 2)
        points(CarbInput, model3pred(), col = "blue", pch = 16, cex = 2)
        points(WtInput, model3pred(), col = "green", pch = 16, cex = 2)
        
        if(input$showModel3){
            abline(model3, col = "black", lwd = 2)
        }
        
        legend(25, 250, c("HP", "Carb", "Wt"),
               pch = 16, col = c("red", "blue", "green"), cex = 1.2)
        
    })
    
    Documentations <- renderText(
        "In this web app we will predict the displacement of the Car.
        
        We took data data from the mtcars dataset which is available in r in the datasets package.
        After performing regression analysis we found that there is a high significance between displacement variable (disp)
        and Weigth of the car(wt), Horsepower of the car (hp) and number of carburators in the car (carb).
        
        You can see dataset using str(mtcars).
        
        This is why we selected variables carb, wt and hp for prediction of displacement of car.
        We fitted linear models with displacement dependent on weigth of the car , Displacement depending on hp of the car
        and displacement depending on carborators , weigth and horsepower of the car.
        
        The units of displacement are (cubic inches), weigth are (1 = 1000lbs), horsepower are (Gross Horsepower) and carborators are (Number of carborators i.e
        1 = 1 carborator).
        
        Next we predicted values of displacement from the 3 models with variable values of hp , wt and carb.
        
        After that we made plot with each linear model.
        
        Plot1 :- It is the plot of linear model with displacement depending on the Weigth of the car.
        
        In plot 1 points are plotted with weigth variable on x and displacement variable on y.
        
        Also the regression line is fitted for the model 1 in red color.
        
        A blue regression line is the line from model 3 which also contains wt variable shows what if the model 3 was predicted 
        in the same plot and points of wt values.
        
        Plot2 :- It is the plot of linear model with displacement depending on the Horsepower of the car.
        
        In plot 2 points are plotted with Horsepower variable on x and displacement variable on y.
        
        Also the regression line is fitted for the model 2 in red color.
        
        A blue regression line is the line from model 3 which also contains hp variable shows what if the model 3 was predicted 
        in the same plot and points of hp values. It may not be visible beacause it does not have good fit in the plot with same model.
        
        Plot3 :- It is the plot of linear model with displacement depending on the number of carborators , Horsepower and the 
        weight of the car.
        
        In plot 3 the all the displacement points are plotted with index.
        
        In plot3 there is a regression line from model 3 which contains all the variables on which displacement is highly dependent.
        
        In all three plots there are points in color Red , blue ,  green which is predicted value of the displacement 
        
        predicted from the different models.
        
        A legend has benn created to help differ the predicted value between models.
        
        In plot 3 there are different points which is the predicted value of displacement by each variable by keeping the other variables constant.
        
        These points are not very useful as we want the value predicted from the whole model.
        
        While doing the analysis we found that the model 3 has the perfect predicted value and very close to the real answer."
    )
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
    
    output$pred3 <- renderText({
        model3pred()
    })
    
    output$Documentation <- renderText({
        Documentations()
    })
    
})