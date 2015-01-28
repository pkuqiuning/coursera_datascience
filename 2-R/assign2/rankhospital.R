source('best.R')

# Rank is one of
# - 'best'
# - 'worst'
# - integer[1, +Inf]
# 'best' indicate top rank, 'worst' indicate lowest rank, an integer correspond to a given rank
is.Rank = function(num) (num %in% list('best', 'worst')) | is.numeric(num)


# rank hospital on good dataset
# Dataset, Condition, Rank -> String
my_rankhospital = function(data, condition, num = 'best'){
    mort_col = MORTALITY_COL_LOOKUP[[condition]]
    ordered_data = order(data[[mort_col]], data$Hospital.Name)
    if (num == 'best'){
        num = 1
    }
    else if (num == 'worst'){
        num = length(ordered_data)
    }
    else if (num > length(ordered_data)){
        ## return NA if no such rank found
        return(NA)
    }
    ## Return hospital name in that state with the given rank in 30-day death rate
    return(data$Hospital.Name[ordered_data[num]])
}


# produce the hospital in a given state and mortality rank in given clinical condition
# State, Condition, Rank -> String
rankhospital <- function(state, outcome, num = "best") {
    ## Check that state and outcome are valid
    if (! is.State(state)) stop(ERROR_INV_STATE)
    if (! is.Condition(outcome)) stop(ERROR_INV_OUTCOME)
    if (! is.Rank(num)) stop('wrong num rank type')
    
    ## Read outcome data
    alldata = read_data(OUTCOME_FILE, outcome)

    # only rank in given state 
    data = alldata[alldata$State == state, ]
    
    # sort 30-day mortality
    my_rankhospital(data, outcome, num) 
}


# test functionality of this module
# None -> None
test_rankhospital = function(){
    # library('testthat')
    # source('rankhospital.R'); test_rankhospital()
    test_that('input validation works', {
        expect_error(rankhospital("BB", "heart attack"), ERROR_INV_STATE)
        expect_error(rankhospital("NY", "hert attack"), ERROR_INV_OUTCOME)        
    })
    
    test_that('produces hospital correctly',{
        expect_equal(rankhospital("TX", "heart failure", 1), "FORT DUNCAN MEDICAL CENTER")    
        expect_equal(rankhospital("TX", "heart failure", 2), "TOMBALL REGIONAL MEDICAL CENTER")    
        expect_equal(rankhospital("TX", "heart failure", 3), "CYPRESS FAIRBANKS MEDICAL CENTER")    
        expect_equal(rankhospital("TX", "heart failure", 4), "DETAR HOSPITAL NAVARRO")
        expect_equal(rankhospital("TX", "heart failure", 5), "METHODIST HOSPITAL,THE")
        expect_equal(rankhospital("TX", "heart failure", 6), "MISSION REGIONAL MEDICAL CENTER")
        expect_equal(rankhospital("MD", "heart attack", "worst"),  "HARFORD MEMORIAL HOSPITAL")
        expect_equal(rankhospital("MN", "heart attack", 5000), NA)
            
    })
}

if (getOption('run.test', default=F)){
    # do test if options(run.test=True) is set before run
    library('testthat')
    test_rankhospital()
}
 
