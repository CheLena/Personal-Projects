library(ggvis)

# For dropdown menu
actionLink <- function(inputId, ...) {
        tags$a(href='javascript:void',
               id=inputId,
               class='action-button',
               ...)
}

fluidPage(
        titlePanel("Explore IMDb movie data"),
        fluidRow(
                column(3,
                       wellPanel(
                               h4("Filter"),
                               sliderInput("imdb_score", "Average IMDb score (on a scale of 1 to 10)",
                                           1, 10, c(5,10), step = 0.1),
                               sliderInput("title_year", "Year released", 1916, 2016, value = c(1990, 2016)
                                           ),
                               selectInput("content_rating", "Content Rating (e.g., PG-13)",
                                           c("Not Rated", "G", "PG", "PG-13", "R", "Other"), selected="PG"),
                               sliderInput("gross", "Dollars at Box Office ",
                                           0, 800000000, value = c(100000, 800000000), step = 100000),
                               sliderInput("budget", "Budget (US dollars)",
                                           0, 150000000, value = c(100000, 150000000), step = 100000)
                       ),
                       wellPanel(
                               selectInput("xvar", "X-axis variable", c(
                                       "Year of release" = "title_year",
                                       "IMDb Score" = "imdb_score",
                                       "Budget (in millions)" = "budget",
                                       "Dollars at box office (in millions)" = "gross"
                               ), selected = "title_year"),
                               selectInput("yvar", "Y-axis variable", c(
                                       "Year of release" = "title_year",
                                       "IMDb Score" = "imdb_score",
                                       "Budget (in millions)" = "budget",
                                       "Dollars at box office (in millions)" = "gross",
                                       "Profit" = "profit"
                               ), selected = "imdb_score")
                       )
                ),
                column(9,
                       ggvisOutput("plot1"),
                       wellPanel(
                               span("Number of movies selected:",
                                    textOutput("n_movies")
                               )
                       )
                )
        )
)