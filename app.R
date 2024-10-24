library(shiny)
library(shinydashboard)
#library(palmerpenguins)
library(tidyverse)

ui <- dashboardPage(
    skin = "yellow",
    dashboardHeader(title = "Example Palmer Penguins Dashboard",
                    titleWidth = 360),
    dashboardSidebar(
        width = 300,
        sidebarMenu(
            h3(HTML("Palmer Penguins dataset"),
               br(),
               h4(HTML("The goal of this app is to<br/>is to prototype reading<br/> data from ResearchDrive.")),
               br(),
               "erwin.lares@wisc.edu"))
    ),
    dashboardBody(
        fluidRow(
            box(
                title = "Number of Penguins", width = 4, solidHeader = TRUE, status = "primary",
                "344"
            ),
            box(
                title = "Number of Species", width = 4, solidHeader = TRUE,
                "3"
            ),
            box(
                title = "Number of Islands", width = 4, solidHeader = TRUE, status = "warning",
                "3"
            )
        ),
        fluidRow(
            box(plotOutput("plot1", height = 300),
                status = "warning",
                solidHeader = TRUE),
            box(plotOutput("plot2",
                           height = 300))
        ),
        fluidRow(
            img(src='https://allisonhorst.github.io/palmerpenguins/reference/figures/lter_penguins.png', align = "center", width = 500),
            box(plotOutput("plot3",
                           height = 300))
        )
    )
)

server <- function(input, output) {
    output$plot1 <- renderPlot({
        ggplot(data = read_csv("/mnt/researchdrive/lares/public_data/palmerpenguins.csv"),
               aes(x = flipper_length_mm,
                   y = bill_length_mm)) +
            geom_point(aes(color = species, 
                           shape = species),
                       size = 3,
                       alpha = 0.8) +
            geom_smooth(method = "lm", se = FALSE, aes(color = species)) +
            theme_minimal() +
            scale_color_manual(values = c("darkorange","purple","cyan4")) +
            labs(title = "Flipper and bill length",
                 subtitle = "Dimensions for Adelie, Chinstrap and Gentoo Penguins at Palmer Station LTER",
                 x = "Flipper length (mm)",
                 y = "Bill length (mm)",
                 color = "Penguin species",
                 shape = "Penguin species") +
            theme(legend.position = c(0.85, 0.15),
                  legend.background = element_rect(fill = "white", color = NA),
                  plot.title.position = "plot",
                  plot.caption = element_text(hjust = 0, face= "italic"),
                  plot.caption.position = "plot")
    })
    
    output$plot2 <- renderPlot({
        ggplot(data =  read_csv("/mnt/researchdrive/lares/public_data/palmerpenguins.csv"),
               aes(x = flipper_length_mm)) +
            geom_histogram(aes(fill = species),
                           alpha = 0.5,
                           position = "identity") +
            scale_fill_manual(values = c("darkorange", "purple", "cyan4")) +
            theme_minimal() +
            labs(x = "Flipper length (mm)",
                 y = "Frequency",
                 title = "Penguin flipper lengths")
    })
    
    output$plot3 <- renderPlot({
        ggplot(data =  read_csv("/mnt/researchdrive/lares/public_data/palmerpenguins.csv"), 
               aes(x = flipper_length_mm,
                   y = body_mass_g)) +
            geom_point(aes(color = species, 
                           shape = species),
                       size = 3,
                       alpha = 0.8) +
            theme_minimal() +
            scale_color_manual(values = c("darkorange","purple","cyan4")) +
            labs(title = "Penguin size, Palmer Station LTER",
                 subtitle = "Flipper length and body mass for Adelie, Chinstrap, and Gentoo Penguins",
                 x = "Flipper length (mm)",
                 y = "Body mass (g)",
                 color = "Penguin species",
                 shape = "Penguin species") +
            theme(legend.position = c(0.2, 0.7),
                  legend.background = element_rect(fill = "white", color = NA),
                  plot.title.position = "plot",
                  plot.caption = element_text(hjust = 0, face= "italic"),
                  plot.caption.position = "plot")
    })
    
}

shinyApp(ui, server)