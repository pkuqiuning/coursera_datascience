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

# find best hospital in a given state based on 30-day mortality
# State, Condition -> string
best <- function(state, outcome) {
    ## Check that state and outcome are valid
    if (! is.Condition(outcome)) stop(ERROR_INV_OUTCOME)
    if (! is.State(state)) stop(ERROR_INV_STATE)
   
    mort_col = MORTALITY_COL_LOOKUP[[outcome]]
    
    ## Read outcome data
    alldata <- read.csv(OUTCOME_FILE, colClasses = "character")
    alldata[,mort_col] = as.numeric(alldata[,mort_col])
    
    # only rank in given state and clinical condition, with valid mortality
    data = alldata[alldata$State == state & ! is.na(alldata[[mort_col]]), ]

    mort_rates = data[[mort_col]]
    # hospital names in that state with lowest 30-day mortality
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

