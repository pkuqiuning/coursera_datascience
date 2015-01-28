source('rankhospital.R')

rankall <- function(outcome, num = "best") {
    ## Check that state and outcome are valid
    if (! is.Condition(outcome)) stop(ERROR_INV_OUTCOME)
    if (! is.Rank(num)) stop('wrong num rank type')
    
    mort_col = MORTALITY_COL_LOOKUP[[outcome]]
    
    ## Read outcome data
    alldata <- read.csv(OUTCOME_FILE, colClasses = "character")
    alldata[,mort_col] = as.numeric(alldata[,mort_col])
    
    # only rank in given clinical condition, with valid mortality
    data = alldata[! is.na(alldata[[mort_col]]), ]
    
    # sort 30-day mortality
    
    usrank = sapply(split(data, data$State), function(d) my_rankhospital(d, mort_col, num))
    data.frame(state=names(usrank), hospital=usrank)
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the (abbreviated) state name
}

test_rankall = function(){
    head(rankall("heart attack", 20), 10)
    tail(rankall("pneumonia", "worst"), 3)
    tail(rankall("heart failure"), 10)
}