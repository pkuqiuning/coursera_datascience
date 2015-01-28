# Implementing best hospital searcher


OUTCOME_FILE = "outcome-of-care-measures.csv"


ERROR_INV_STATE = 'invalid state'
ERROR_INV_OUTCOME = 'invalid outcome'

# Data

# Condition is one of
CONDITION_LIST = list(
    "heart attack",
    "heart failure",
    "pneumonia"
)
# interp. the clinical condition

MORTALITY_COL_LOOKUP = c(11,17,23)
names(MORTALITY_COL_LOOKUP) = CONDITION_LIST

# State is one of "NJ", "NY"...
# interp. two letter abbreviation the states in the US

#
# STATES_LIST = sort(unique(data$State))
# paste(STATES_LIST, collapse = ',')
STATES_LIST_STR = "AK,AL,AR,AZ,CA,CO,CT,DC,DE,FL,GA,GU,HI,IA,ID,IL,IN,KS,KY,LA,MA,MD,ME,MI,MN,MO,MS,MT,NC,ND,NE,NH,NJ,NM,NV,NY,OH,OK,OR,PA,PR,RI,SC,SD,TN,TX,UT,VA,VI,VT,WA,WI,WV,WY"
STATES_LIST = unlist(strsplit(STATES_LIST_STR, ','))

# Methods

# find best hospital in a given state based on 30-day mortality
# State, Condition -> string
best <- function(state, outcome) {
    ## Check that state and outcome are valid
    if (! outcome %in% CONDITION_LIST) stop(ERROR_INV_OUTCOME)
    if (! state %in% STATES_LIST) stop(ERROR_INV_STATE)
    
    ## Read outcome data
    alldata <- read.csv(OUTCOME_FILE, colClasses = "character")
    
    # only rank in given state
    data = alldata[alldata$State == state,]
    
    # make the column numerical
    for (idx in MORTALITY_COL_LOOKUP){
        data[, idx] <- as.numeric(data[, idx])
    }    
    
    mort_idx = MORTALITY_COL_LOOKUP[[outcome]]
    # the 30-day mortalities for the given clinical condition
    mort_rates = data[[mort_idx]]
    low_morts = which(mort_rates == min(mort_rates, na.rm=1))
    # hospital names in that state with lowest 30-day mortality
    lows = data$Hospital.Name[low_morts]
    # select the first hospital according to alphabetical order
    sort(lows)[[1]]
}


# test functionality of this module
# None -> None
test_best = function(){
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
