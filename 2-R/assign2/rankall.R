source('rankhospital.R')

rankall <- function(outcome, num = "best") {
    ## Check that state and outcome are valid
    if (! is.Condition(outcome)) stop(ERROR_INV_OUTCOME)
    if (! is.Rank(num)) stop('wrong num rank type')
    
    ## Read outcome data
    data = read_data(OUTCOME_FILE, outcome)
    
    # sort 30-day mortality
    usrank = sapply(split(data, data$State), function(d) my_rankhospital(d, outcome, num))
    data.frame(state=names(usrank), hospital=usrank)
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the (abbreviated) state name
}

test_rankall = function(){
    head(rankall("heart attack", 20), 10)
    tail(rankall("pneumonia", "worst"), 3)
    tail(rankall("heart failure"), 10)
}

if (getOption('run.test', default=F)){
    # do test if options(run.test=True) is set before run
    library('testthat')
    test_rankall()
}
