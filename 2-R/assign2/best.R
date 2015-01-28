# Implementing best hospital searcher


OUTCOME_FILE = "outcome-of-care-measures.csv"


ERROR_INV_STATE = 'invalid state'
ERROR_INV_OUTCOME = 'invalid outcome'

# Data

# Outcome is one of
OUTCOME_LIST = list(
    "heart attack",
    "heart failure",
    "pneumonia"
)
# interp. the clinical condition

# State is one of "NJ", "NY"...
# interp. two letter abbreviation the states in the US
STATES_LIST = unique(outcome$State)


# Methods

# find best hospital in a given state based on 30-day mortality
# var[2], Outcome -> string
best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv(OUTCOME_FILE, colClasses = "character")
    data[, 11] <- as.numeric(data[, 11])
    
    ## Check that state and outcome are valid
    if (! outcome %in% OUTCOME_LIST) stop(ERROR_INV_OUTCOME)
    if (! state %in% STATES_LIST) stop(ERROR_INV_STATE)
    
    ## Return hospital name in that state with lowest 30-day death
    
    
    ## rate
}


# test functionality of this module
# None -> None
test_best = function(){
    test_that('input validation works', {
        expect_error(best("BB", "heart attack"), ERROR_INV_STATE)
        expect_error(best("NY", "hert attack"), ERROR_INV_OUTCOME)        
    })
}

if (getOption('run.test', default=F)){
    # do test if options(run.test=True) is set before run
    library('testthat')
    test_best()
}
