% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slearner.R
\name{slearner_cv}
\alias{slearner_cv}
\title{S-learner using generic black-box machine learning model from caret}
\usage{
slearner_cv(x, w, y, model_specs, k_folds = 5, select_by = "best")
}
\arguments{
\item{x}{a numeric matrix of \strong{covariates}}

\item{w}{a logical vector indicating \strong{treatment}}

\item{y}{a numeric vector of \strong{outcomes}}

\item{model_specs}{specification for the model of \eqn{\mu(x,w) = E[Y|W=w,X=x]}. See \code{\link{learner_cv}}.}

\item{k_folds}{number of cross-validation folds to use in hyperparameter optimization for each model.}

\item{select_by}{optimization method to use for cross-validation in each model: either \code{"best"} for minimum cross-validation
error or \code{"oneSE"} for the one-standard-error (1-SE) rule. The implementaion of the 1-SE rule for learners with
multiple hyperparameters is governed by \pkg{caret} and may be ad-hoc for some learners. See: \code{\link[caret]{?caret::oneSE}}.}
}
\description{
S-learner, as proposed by Imai and Ratkovic (2013), using generic black-box machine learning model from caret
}
\examples{
\dontrun{
model_specs = list(
gbm = list(
    tune_grid = expand.grid(
        n.trees = seq(1,501,20),
        interaction.depth=3,
        shrinkage = 0.1,
        n.minobsinnode=3),
    extra_args = list(
        verbose=F,
        bag.fraction=1)),
glmnet = list(
    tune_grid = expand.grid(
       alpha=c(0,0.5,1),
       lambda=exp(seq(-5,2,0.2))),
    extra_args = list())
)
library(zeallot) # imports the \%<-\% operator, which is syntactic sugar that performs multiple assignment out of a list
c(x, w, y, ...) \%<-\% toy_data_simulation(500) # draw a sample

tau_hat_model = slearner_cv(x, w, y, model_specs)
tau_hat = predict(tau_hat_model, x)
}
}
