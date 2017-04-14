library(shinythemes)

shinyUI(fluidPage(theme=shinytheme("cosmo"),
    
  tags$title(
    tags$style(HTML("
                    @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                    
                    h1 {
                    font-family: 'Lobster', cursive;
                    font-weight: 500;
                    line-height: 1.1;
                    color: #48ca3b;
                    }
body {
  background-color: #fff;
                    }
                    
                    "))
    ),
  tags$img(src='background.jpg',height=400,width=1550),
  
  
    titlePanel(title=h1("University Predictor",align="center")),
  
    sidebarLayout(position="left",
    sidebarPanel(
      tags$style("body{background-color:linen;color:black}"),
      tags$style(".span12{font-style:oblique;border-style:solid}"),
      ("Enter the Information"),
    textInput("gre", "GRE SCORE", value = ""),
    textInput("toefl", "TOEFL SCORE", value = ""),
    textInput("gpa", "GPA (/10)", value = ""),
    sliderInput("sop", "SOP RATING",
                min = 1, max = 5, value = "1"),
    sliderInput("lor", "LOR RATING",
                min = 1, max = 5, value = "1"),
    
    selectInput("uni1", "Select University( Max: 5)", 
                c("Arizona State University",
                  "Arkansas State University",
                  "Binghamton University - SUNY",
                  "Bradley University",
                  "California State University East Bay",
                  "California State University Fullerton",
                  "California State University Long Beach",
                  "California State University Los Angeles",
                  "California State University Sacramento",
                  "California State University San Marcos",
                  "Carnigie Mellon University",
                  "Clemson University",
                  "Cleveland State University",
                  "Ferris State University",
                  "Florida Institute of Technology",
                  "Florida International University Miami",
                  "Florida State University",
                  "George Mason University",
                  "Georgia State University",
                  "Governors State University",
                  "Illinois Institute of Technology Chicago",
                  "Illinois Institute of Technology, Chicago",
                  "Indiana university - Bloomington",
                  "Indiana University - Purdue Univsersity",
                  "Indiana University, Bloomington",
                  "Kansas State University",
                  "Kent State University",
                  "Lamar University",
                  "Lewis University",
                  "Michigan State University",
                  "Michigan Technological University",
                  "Middle Tennessee State University",
                  "Midwestern State University",
                  "Missouri University of Science & Technology",
                  "Murray State University",
                  "New Jersey Institute of Technology",
                  "New York Institute of Technology",
                  "North Carolina State University",
                  "Northeastern University",
                  "Northern Illinois University",
                  "NorthWest Missouri State University",
                  "Northwestern Polytechnic University",
                  "NYU Polytechnic School of Engineering",
                  "Oakland University",
                  "Ohio State University",
                  "Oklahoma State University",
                  "Old Dominion University",
                  "Pennsylvania State University",
                  "Rochester Institute of Technology",
                  "Rutgers State University - New Brunswick",
                  "Sacred Heart University",
                  "San Diego State University",
                  "San Jose State University",
                  "Santa Clara University",
                  "South Dakota State University",
                  "Southern Illinois University Carbondale",
                  "Stevens Institute of Technology",
                  "SUNY - New Platz","SUNY Binghamton",
                  "SUNY Buffalo","SUNY Korea",
                  "Syracuse University",
                  "Texas A&M Commerce",
                  "Texas A&M International University - Laredo",
                  "Texas A&M University College Station",
                  "Texas A&M University Kingsville",
                  "Texas a&m university-corpus christi",
                  "Univeristy of New Orleans",
                  "University at Albany , SUNY",
                  "University at Albany, SUNY",
                  "University of Alabama at Huntsville",
                  "University of Arkansas at Little Rock",
                  "University of Bridgeport",
                  "University of California - Los Angeles",
                  "University of California - San Diego",
                  "University of California - Santa Cruz",
                  "University of California Berkeley",
                  "University of Central Florida",
                  "University of Central Missouri",
                  "University of Colorado - Boulder",
                  "University of Colorado - Denver",
                  "University of Dayton",
                  "University of Delaware",
                  "University of Florida",
                  "University of Georgia-Athens",
                  "University of Houston Clear Lake",
                  "University of Illinois Chicago",
                  "University of Illinois Springfield",
                  "University of Kansas",
                  "University of Louisiana at Lafayette",
                  "University of Maryland College Park",
                  "University of Massachusetts Amherst",
                  "University of Massachusetts Dartmouth",
                  "University of Massachusetts Lowell",
                  "University of Michigan - Flint",
                  "University of Michigan Dearborn",
                  "University of Minnesota - Twin Cities",
                  "University of Missouri Kansas City",
                  "University of Missouri St Louis",
                  "University of New Orleans",
                  "University of North Carolina at Charlotte",
                  "University of North Texas",
                  "University of Pennsylvania",
                  "University of Pittsburgh",
                  "University of South Carolina",
                  "University of South Florida",
                  "University of Southern California",
                  "University of Tennessee Chattanooga",
                  "University of Texas at Arlington",
                  "University of Texas at Dallas",
                  "University of Washington",
                  "University of Wisconsin - Madison",
                  "Valparaiso University",
                  "Virginia Tech University",
                  "Washington State University",
                  "Washington University in St. Loui",
                  "Wayne State University",
                  "West Virginia University",
                  "Western Illinois University",
                  "Western Michigan University",
                  "Wright State University"
                ),
                
                selected = ,multiple = TRUE,selectize = TRUE),
    actionButton("action","Submit"),
  
   
      h2(textOutput("text1")),
      tags$head(tags$style("#text1{color: green;
                           font-size: 20;
                           font-style: bold;
    }"
                         )
      ),
  
    h2(textOutput("text2")),
    tags$head(tags$style("#text2{color: green;
                                 font-size: 20;
                         font-style: bold;
                         }"
                         )
              ),
    h2(textOutput("text3")),
    tags$head(tags$style("#text3{color: green;
                                 font-size: 20;
                         font-style: bold;
                         }"
    )
    ),
   
    
    h2(textOutput("text4")),
    tags$head(tags$style("#text4{color: green;
                         font-size: 20;
                         font-style: bold;
                         }"
    )
    ),
    h2(textOutput("text5")),
    tags$head(tags$style("#text5{color: green;
                         font-size: 20;
                         font-style: bold;
                         }"
    )
    )
    
    ),
    
    

        mainPanel(
              #  tags$img(src='background.jpg',height=750,width=1040),
          plotOutput("results"),
          
                  
                 
                  textOutput("mylist"))
                  

    )
    ))
