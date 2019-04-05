library(ggvis)
library(dplyr)
if (FALSE) {
        library(RSQLite)
        library(dbplyr)
}

# Set up data on app start
df <- read.csv("movie_metadata.csv", header=TRUE)
df <- mutate(df, id = rownames(df))
df <- mutate(df, profit = gross - budget)

# Join tables, filtering out those with <10 reviews, and select specified columns
all_movies <- df %>%
        select(id, gross, content_rating, movie_title, budget, title_year, imdb_score, profit)


function(input, output, session) {
        
        # Filter the movies, returning a data frame
        movies <- reactive({
                # Due to dplyr issue #318, we need temp variables for input values
                minscore <- input$imdb_score[1]
                maxscore <- input$imdb_score[2]
                contentRating <- input$content_rating
                minyear <- input$title_year[1]
                maxyear <- input$title_year[2]
                minbudget <- input$budget[1] / 1e6
                maxbudget <- input$budget[2] / 1e6
                mingross <- input$gross[1] / 1e6
                maxgross <- input$gross[2] / 1e6
                
                # Apply filters
                m <- all_movies %>%
                        filter(
                                imdb_score >= minscore,
                                imdb_score <= maxscore,
                                content_rating == contentRating,
                                title_year >= minyear,
                                title_year <= maxyear,
                                gross >= mingross *1e6,
                                gross <= maxgross * 1e6,
                                budget >= minbudget *1e6,
                                budget <= maxbudget *1e6
                        ) 

                
                
                m <- as.data.frame(m)
                

        })

        # Function for generating tooltip text
        movie_tooltip <- function(x) {
                if (is.null(x)) return(NULL)

                # Pick out the movie with this ID
                all_movies <- isolate(movies())
                movie <- all_movies[all_movies$movie_title == x$movie_title, ]
                
                paste0("<b>", movie$movie_title, "</b><br>",
                       movie$title_year, "<br>", "IMDb score:", movie$imdb_score, "<br>",
                       "Box Office Gross: $", format(movie$gross, big.mark = ",", scientific = FALSE)
                )
        }        

        # A reactive expression with the ggvis plot
        vis <- reactive({
                
                
                # Normally we could do something like props(x = ~BoxOffice, y = ~Reviews),
                # but since the inputs are strings, we need to do a little more work.
                xvar <- prop("x", as.symbol(input$xvar))
                yvar <- prop("y", as.symbol(input$yvar))
                
                movies %>%
                        ggvis(x = xvar, y = yvar) %>%
                        layer_points(size := 50, size.hover := 200,
                                     fillOpacity := 0.2, fillOpacity.hover := 0.5,
                                     key := ~movie_title) %>%
                        add_tooltip(movie_tooltip, "hover") %>%
                        add_axis("x") %>%
                        add_axis("y") %>%
                        set_options(width = 700, height = 700)
        })
        
        vis %>% bind_shiny("plot1")
        
        output$n_movies <- renderText({ nrow(movies()) })
}
