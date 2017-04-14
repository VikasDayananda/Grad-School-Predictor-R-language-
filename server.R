
library(shinythemes)
library(dplyr)
library(scales)
library(ggplot2)
score1=c()
point =0;
shinyServer(
  function(input,output){
    
    output$mygre<- renderText(input$gre)
    output$mytoefl <- renderText(input$toefl)
    output$mygpa<- renderText(input$gpa)
    output$mysop<- renderText(input$sop)
    output$mylor<- renderText(input$lor)
    output$mylist<- renderText(input$unilist1)
    
    observeEvent(input$action, {
      GRE_input = input$gre #Input parameters
      TOEFL_input = as.numeric(input$toefl)#Input parameters
      GPA_input = as.numeric(input$gpa) #Input parameters
     
      sop <- input$sop #Input parameters
      lor <- input$lor #Input parameters
      
      
      University_input =c(input$uni1) #Input parameters
      #University_input[1]=input$uni1
      #University_input[2]=input$uni2
      points = c(30,10,30,20,10)
      input_file <- read.csv("C:/Users/VIKAS/Documents/R/input_cs_new.csv",header=TRUE,colClasses=c("character","character","character","character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.strings=c("."))
      n <- nrow(input_file)
      n
      m = length(University_input)
      m
      University_List = input_file$University
      
      
      
      # GPA MODULE
      
      score = input_file$UG_Score
      GPA <- function(GPA_input,input_file,University_List,n,University_input,points, score)
      {
        gpa_score =c()
        
        j=1;
        
        for(i in 1:n)
        {
          if(University_List[i] == University_input)
          {
            
            if(score[i]<=10)
            {
              gpa_score[j]=score[i]
              j =j+1
            }  
            
          }
        }
        
        gpa_score = sort(gpa_score)
        gpa_score
        
        
        l = length(gpa_score)
        l
        
        m = median(gpa_score)
        high = max(gpa_score)
        low = min(gpa_score)
        high
        m 
        low
        
        if((GPA_input > m) &&(GPA_input <=10))
        {
          point = 80 + (( (GPA_input-m) / (10-m) ) *20)
        }
        
        if(GPA_input==m)
        {
          point = 80
        }
        
        if((GPA_input<m) && (GPA_input>=low))
        {
          point = 30 +  (( (GPA_input - low) / (m-low) ) *50)
        }
        
        if(GPA_input <low )
        {
          point = 30 - (((low - GPA_input)/low )*30)
        }
        
        point = point * (30/100)
        m
        low 
        high
        point
      }
      
      # SOP MODULE
      
      SOP <- function(sop)
      { 
        sop_points <- (sop/5)*20
      }
      
      LOR <- function(lor)
      {
        lor_points <- (lor/5)*10
      }
      
      # TOEFL MODULE
      
      TOEFLPOINTS <- function(TOEFL_input,input_file,University_List,n,University_input,points)
      {
        TOEFL_Score = input_file$TOEFL
        j=1
        TOEFL_marks = c()
        for(i in 1:n)
        {
          if(University_List[i] == University_input)
          {
            TOEFL_marks[j] = TOEFL_Score[i]	
            j = j+1
          }
        }
        
        TOEFL_marks
        Sorted_TOEFL_Marks = sort(TOEFL_marks)
        Sorted_TOEFL_Marks
        l = length(Sorted_TOEFL_Marks)
        l
        
        
        TOEFL_median = median(Sorted_TOEFL_Marks)
        TOEFL_median
        TOEFL_min = min(Sorted_TOEFL_Marks)
        TOEFL_max = max(Sorted_TOEFL_Marks)
        TOEFL = c()
        Weightage = c()
        n = (TOEFL_max-TOEFL_min+1)
        for(i in 1:n)
        {
          if(i == 1)
          {
            TOEFL[i] = TOEFL_min
          }else if(i == n)
          {
            TOEFL[i] = TOEFL_max
          }
          else
          {
            TOEFL[i] = TOEFL[i-1] + 1
          }
        }
        TOEFL_min
        TOEFL_max
        TOEFL
        m = length(TOEFL)
        m
        u = floor(TOEFL_median)
        v = ceiling(TOEFL_median)
        u
        v
        j = 0
        if(u != v)
        { 
          for(i in 1:n)
          {	
            if(TOEFL[i] == u)
            {
              Weightage[i] = 80
              u_index = i
            }
            if(TOEFL[i] == v)
            {
              Weightage[i] = 80
              v_index = i
            }
            if(TOEFL[i] == TOEFL_min)
            {
              Weightage[i] = 1.0
            }
            if(TOEFL[i] == TOEFL_max)
            {
              Weightage[i] = 100.0
            }
          }
          diff = u_index - 1
          percent_decrease = 80/diff
          weight = 80	
          for(i in diff:2)
          {
            weight = weight - percent_decrease
            Weightage[i] = weight
          }
          diff = n - v_index 
          percent_increase = 20/diff
          weight = 80	
          for(i in (v_index+1):n)
          {
            weight = weight + percent_increase
            Weightage[i] = weight
          }
        }
        if(u == v)
        {
          for(i in 1:n)
          {	
            if(TOEFL[i] == u)
            {
              Weightage[i] = 80
              u_index = i
            }
            if(TOEFL[i] == TOEFL_min)
            {
              Weightage[i] = 1.0
            }
            if(TOEFL[i] == TOEFL_max)
            {
              Weightage[i] = 100.0
            }
          }
          diff = u_index - 1
          percent_decrease = 80/diff
          weight = 80	
          for(i in diff:2)
          {
            weight = weight - percent_decrease
            Weightage[i] = weight
          }
          diff = n - u_index 
          percent_increase = 20/diff
          weight = 80	
          for(i in (u_index+1):n)
          {
            weight = weight + percent_increase
            Weightage[i] = weight
          }
        }	
        
        Weightage		
        u_index
        n
        
        if(TOEFL_input < TOEFL_min)
        {
          TOEFL_input_Weightage = 0.0
        }
        
        if(TOEFL_input > TOEFL_max)
        {
          TOEFL_input_Weightage = 100.0
        }
        if(TOEFL_input >= TOEFL_min && TOEFL_input <= TOEFL_max)
        {
          for(i in 1:n)
          {
            if(TOEFL_input == TOEFL[i])
            {
              TOEFL_input_Weightage = Weightage[i]
            }
          }	
        }
        
        TOEFL_input_Weightage
        
        TOEFL_points = (points[2]/100) * TOEFL_input_Weightage
        
        return(TOEFL_points)
      }
      
      # GRE MODULE
      
      GREPOINTS <- function(GRE_input,input_file,University_List,n,University_input,points)
      {
        GRE_Score = input_file$GRE_Total
        j=1
        GRE_marks = c()
        for(i in 1:n)
        {
          if(University_List[i] == University_input)
          {
            GRE_marks[j] = GRE_Score[i]	
            j = j+1
          }
        }
        
        GRE_marks
        Sorted_GRE_Marks = sort(GRE_marks)
        Sorted_GRE_Marks
        l = length(Sorted_GRE_Marks)
        l
        
        
        GRE_median = median(Sorted_GRE_Marks)
        GRE_median
        GRE_min = min(Sorted_GRE_Marks)
        GRE_max = max(Sorted_GRE_Marks)
        GRE = c()
        Weightage = c()
        n = (GRE_max-GRE_min+1)
        for(i in 1:n)
        {
          if(i == 1)
          {
            GRE[i] = GRE_min
          }else if(i == n)
          {
            GRE[i] = GRE_max
          }
          else
          {
            GRE[i] = GRE[i-1] + 1
          }
        }
        GRE_min
        GRE_max
        GRE
        m = length(GRE)
        m
        u = floor(GRE_median)
        v = ceiling(GRE_median)
        u
        v
        j = 0
        if(u != v)
        { 
          for(i in 1:n)
          {	
            if(GRE[i] == u)
            {
              Weightage[i] = 80
              u_index = i
            }	
            if(GRE[i] == v)
            {
              Weightage[i] = 80
              v_index = i
            }
            if(GRE[i] == GRE_min)
            {
              Weightage[i] = 1.0
            }
            if(GRE[i] == GRE_max)
            {
              Weightage[i] = 100.0
            }
          }
          diff = u_index - 1
          percent_decrease = 80/diff
          weight = 80	
          for(i in diff:2)
          {
            weight = weight - percent_decrease
            Weightage[i] = weight
          }
          diff = n - v_index 
          percent_increase = 20/diff
          weight = 80	
          for(i in (v_index+1):n)
          {
            weight = weight + percent_increase
            Weightage[i] = weight
          }
        }
        if(u == v)
        {
          for(i in 1:n)
          {	
            if(GRE[i] == u)
            {
              Weightage[i] = 80
              u_index = i
            }
            if(GRE[i] == GRE_min)
            {
              Weightage[i] = 1.0
            }
            if(GRE[i] == GRE_max)
            {
              Weightage[i] = 100.0
            }
          }
          diff = u_index - 1
          percent_decrease = 80/diff
          weight = 80	
          for(i in diff:2)
          {
            weight = weight - percent_decrease
            Weightage[i] = weight
          }
          diff = n - u_index 
          percent_increase = 20/diff
          weight = 80	
          for(i in (u_index+1):n)
          {
            weight = weight + percent_increase
            Weightage[i] = weight
          }
        }
        
        Weightage		
        u_index
        n
        
        if(GRE_input < GRE_min)
        {
          GRE_input_Weightage = 0.0
        }
        
        if(GRE_input > GRE_max)
        {
          GRE_input_Weightage = 100.0
        }
        if(GRE_input >= GRE_min && GRE_input <= GRE_max)
        {
          
          for(i in 1:n)
          {
            if(GRE_input == GRE[i])
            {
              GRE_input_Weightage = Weightage[i]
            }
          }
        }
        GRE_input_Weightage
        
        GRE_points = (points[1]/100) * GRE_input_Weightage
        
        return(GRE_points)
      }
      
      
      
      
      x=c()
      
      for(i in 1:m)
      {
        grepoints = GREPOINTS(GRE_input,input_file,University_List,n,University_input[i],points)
        #Output parameters
        print(paste0("GRE :", grepoints))
        toeflpoints <- TOEFLPOINTS(TOEFL_input,input_file,University_List,n,University_input[i],points)
        #Output parameters
        print(paste0("TOEFL :",toeflpoints))
        SOP_points <- SOP(sop)
        #Output parameters
        print(paste0("SOP :",SOP_points))
        LOR_points <- LOR(lor)
        #Output parameters
        print(paste0("LOR :",LOR_points))	
        GPA_points <- GPA(GPA_input,input_file,University_List,n,University_input[i],points, score)
        print(paste0("GPA :",GPA_points))
        Total_points = grepoints + toeflpoints + SOP_points + LOR_points +GPA_points
        x[i]=Total_points
        if(x[i]<50)
        {
          score1[i]="ambitious"
        }
        else if( x[i]> 50 && x[i] < 75)
        {
          score1[i]="Moderate"
        }
        else
        {
          score1[i]="safe"
        }
        #Output parameters
        print(paste0("TOTAL :",Total_points))
        print(paste0("Chances are ", Total_points))
        
      }
      
      if(length(University_input)==1)
      {
        output$text1 <- renderText({ 
          paste(University_input[1], ":" , score1[1] )
        })
        
        
      }
      else if (length(University_input)==2)
      {
        output$text1 <- renderText({ 
          paste(University_input[1], ":" , score1[1] )
        })
        output$text2 <- renderText({ 
          paste(University_input[2], ":" , score1[2] )
        })
        
      }
      else if (length(University_input)==3)
      {
        output$text1 <- renderText({ 
          paste(University_input[1], ": " , score1[1] )
        })
        output$text2 <- renderText({ 
          paste(University_input[2], ":" , score1[2] )
        })
        output$text3 <- renderText({ 
          paste(University_input[3], ":" , score1[3] )
        })
      }
      else if (length(University_input)==4)
      {
        output$text1 <- renderText({ 
          paste(University_input[1], ": " , score1[1] )
        })
        output$text2 <- renderText({ 
          paste(University_input[2], ":" , score1[2] )
        })
        output$text3 <- renderText({ 
          paste(University_input[3], ":" , score1[3] )
        })
        output$text4 <- renderText({ 
          paste(University_input[4], ":" , score1[4] )
        })
      }
      else 
      {
        output$text1 <- renderText({ 
          paste(University_input[1], ": " , score1[1] )
        })
        output$text2 <- renderText({ 
          paste(University_input[2], ":" , score1[2] )
        })
        output$text3 <- renderText({ 
          paste(University_input[3], ":" , score1[3] )
        })
        output$text4 <- renderText({ 
          paste(University_input[4], ":" , score1[4] )
        })
        output$text5 <- renderText({ 
          paste(University_input[5], ":" , score1[5] )
        })
      }
      University<-c(University_input)
      Points<-c(x)
      df=data.frame(University,Points)
    output$results<-renderPlot({
      ggplot(df, aes(x=factor(paste(as.character(df$University))),y=df$Points))+geom_bar(stat="identity",width = 0.2,fill="blue")+ylim(c(0,100))+xlab("University")+ylab("Possibility")
     
      

    }   , height = 600, width = 800)
      
    })
  })
