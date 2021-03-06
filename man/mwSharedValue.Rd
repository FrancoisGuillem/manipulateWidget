% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/inputs.R
\name{mwSharedValue}
\alias{mwSharedValue}
\title{Shared Value}
\usage{
mwSharedValue(expr = NULL)
}
\arguments{
\item{expr}{Expression used to compute the value of the input.}
}
\value{
An Input object of type "sharedValue".
}
\description{
This function creates a virtual input that can be used to store a dynamic
shared variable that is accessible in inputs as well as in output.
}
\examples{

if (require(plotly)) {
  # Plot the characteristics of a car and compare with the average values for
  # cars with same number of cylinders.
  # The shared variable 'subsetCars' is used to avoid subsetting multiple times
  # the data: this value is updated only when input 'cylinders' changes.
  colMax <- apply(mtcars, 2, max)

  plotCar <- function(cardata, carName) {
    carValues <- unlist(cardata[carName, ])
    carValuesRel <- carValues / colMax

    avgValues <- round(colMeans(cardata), 2)
    avgValuesRel <- avgValues / colMax

    plot_ly() \%>\%
      add_bars(x = names(cardata), y = carValuesRel, text = carValues,
               hoverinfo = c("x+text"), name = carName) \%>\%
      add_bars(x = names(cardata), y = avgValuesRel, text = avgValues,
               hoverinfo = c("x+text"), name = "average") \%>\%
      layout(barmode = 'group')
  }

  c <- manipulateWidget(
    plotCar(subsetCars, car),
    cylinders = mwSelect(c("4", "6", "8")),
    subsetCars = mwSharedValue(subset(mtcars, cylinders == cyl)),
    car = mwSelect(choices = row.names(subsetCars))
  )
}

}
\seealso{
Other controls: 
\code{\link{mwCheckboxGroup}()},
\code{\link{mwCheckbox}()},
\code{\link{mwDateRange}()},
\code{\link{mwDate}()},
\code{\link{mwGroup}()},
\code{\link{mwNumeric}()},
\code{\link{mwPassword}()},
\code{\link{mwRadio}()},
\code{\link{mwSelectize}()},
\code{\link{mwSelect}()},
\code{\link{mwSlider}()},
\code{\link{mwText}()}
}
\concept{controls}
