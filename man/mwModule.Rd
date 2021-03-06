% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/module_ui.R, R/mw_ui.R
\name{mwModule}
\alias{mwModule}
\alias{mwModuleUI}
\title{Add a manipulateWidget to a shiny application}
\usage{
mwModule(id, controller, fillPage = FALSE, ...)

mwModuleUI(
  id,
  border = TRUE,
  okBtn = FALSE,
  saveBtn = TRUE,
  exportBtn = TRUE,
  allowCompare = TRUE,
  margin = 0,
  width = "100\%",
  height = 400,
  header = NULL,
  footer = NULL
)
}
\arguments{
\item{id}{A unique string that identifies the module}

\item{controller}{Object of class \code{\link{MWController}} returned by
\code{\link{manipulateWidget}} when parameter \code{.runApp} is
\code{FALSE}.}

\item{fillPage}{: \code{logical}. Render in a fillPage or not ? Defaut to FALSE}

\item{...}{named arguments containing reactive values. They can be used to send data from
the main shiny application to the module.}

\item{border}{Should a border be added to the module ?}

\item{okBtn}{Should the UI contain the OK button ?}

\item{saveBtn}{Should the UI contain the save button ? For saving output as html}

\item{exportBtn}{Should an export button be added to the controls ? For saving output as png}

\item{allowCompare}{If \code{TRUE} (the default), then the user can use the
UI to add or remove charts and choose which variables to compare}

\item{margin}{Margin to apply around the module UI. Should be one two or four valid css
units.}

\item{width}{Width of the module UI.}

\item{height}{Height of the module UI.}

\item{header}{Tag or list of tags to display as a common header above all tabPanels.}

\item{footer}{Tag or list of tags to display as a common footer below all tabPanels}
}
\value{
\code{mwModuleUI} returns the required HTML elements for the module. mwModule is only
used for its side effects.
}
\description{
These two functions can be used to include a manipulateWidget object in a shiny application.
\code{mwModuleUI} must be used in the UI to generate the required HTML elements and add
javascript and css dependencies. \code{mwModule} must be called once in the server function
of the application.
}
\examples{
if (interactive() & require("dygraphs")) {
  require("shiny")
  ui <- fillPage(
  fillRow(
    flex = c(NA, 1),
    div(
      textInput("title", label = "Title", value = "glop"),
      selectInput("series", "series", choices = c("series1", "series2", "series3"))
    ),
    mwModuleUI("ui", height = "100\%")
  ))

  server <- function(input, output, session) {
    mydata <- data.frame(
      year = 2000+1:100,
      series1 = rnorm(100),
      series2 = rnorm(100),
      series3 = rnorm(100)
    )

    c <- manipulateWidget(
      {
        dygraph(mydata[range[1]:range[2] - 2000, c("year", series)], main = title)
      },
      range = mwSlider(2001, 2100, c(2001, 2050)),
      series = mwSharedValue(),
      title = mwSharedValue(), .runApp = FALSE,
      .compare = "range"
    )
    #
    mwModule("ui", c, title = reactive(input$title), series = reactive(input$series))
  }

  shinyApp(ui, server)


}

}
