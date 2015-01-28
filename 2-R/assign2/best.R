# Implementing best hospital searcher


OUTCOME_FILE = "outcome-of-care-measures.csv"
ERROR_INV_STATE = 'invalid state'
ERROR_INV_OUTCOME = 'invalid outcome'


# Data

# State is one of 
STATES_LIST_STR = "AK,AL,AR,AZ,CA,CO,CT,DC,DE,FL,GA,GU,HI,IA,ID,IL,IN,KS,KY,LA,MA,MD,ME,MI,MN,MO,MS,MT,NC,ND,NE,NH,NJ,NM,NV,NY,OH,OK,OR,PA,PR,RI,SC,SD,TN,TX,UT,VA,VI,VT,WA,WI,WV,WY"
STATES_LIST = unlist(strsplit(STATES_LIST_STR, ','))
# interp. two letter abbreviation the states in the US
is.State = function(state) state %in% STATES_LIST

# STATES_LIST = sort(unique(data$State))
# paste(STATES_LIST, collapse = ',')


# Condition is one of
CONDITION_LIST = list(
    "heart attack",
    "heart failure",
    "pneumonia"
)
# interp. the clinical condition
is.Condition = function(cond) cond %in% CONDITION_LIST

MORTALITY_COL_LOOKUP = c(11,17,23)
names(MORTALITY_COL_LOOKUP) = CONDITION_LIST


# Methods

# Load data from given file, leave good cases of given column
# String, Condition -> DataFrame
read_data = function(datafile, condition){
    mort_col = MORTALITY_COL_LOOKUP[[condition]]
    alldata <- read.csv(datafile, colClasses = "character")
    alldata[,mort_col] = as.numeric(alldata[,mort_col])
    
    # only use data with valid mortality
    alldata[! is.na(alldata[[mort_col]]), ]
}


# find best hospital in a given state based on 30-day mortality
# State, Condition -> string
best <- function(state, outcome) {
    ## Check that state and outcome are valid
    if (! is.State(state)) stop(ERROR_INV_STATE)
    if (! is.Condition(outcome)) stop(ERROR_INV_OUTCOME)
   
    ## Read outcome data
    alldata = read_data(OUTCOME_FILE, outcome)

    # only rank in given state 
    data = alldata[alldata$State == state, ]
    
    # find hospital names in that state with lowest 30-day mortality
    mort_rates = data[[MORTALITY_COL_LOOKUP[[outcome]]]]
    lows = data$Hospital.Name[mort_rates == min(mort_rates, na.rm=1)]

    # select the first hospital according to alphabetical order
    sort(lows)[[1]]
}


# test functionality of this module
# None -> None
test_best = function(){
    # library('testthat')
    # source('best.R'); test_best()
    test_that('input validation works', {
        expect_error(best("BB", "heart attack"), ERROR_INV_STATE)
        expect_error(best("NY", "hert attack"), ERROR_INV_OUTCOME)        
    })
    
    test_that('produces best hospital correctly',{
        expect_equal(best("TX", "heart attack"), "CYPRESS FAIRBANKS MEDICAL CENTER")
        expect_equal(best("TX", "heart failure"), "FORT DUNCAN MEDICAL CENTER")
        expect_equal(best("MD", "heart attack"), "JOHNS HOPKINS HOSPITAL, THE")
        expect_equal(best("MD", "pneumonia"), "GREATER BALTIMORE MEDICAL CENTER")        
    })
}


if (getOption('run.test', default=F)){
    # do test if options(run.test=True) is set before run
    library('testthat')
    test_best()
}
