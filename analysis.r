library('RMySQL')
library('lme4')

args = commandArgs(trailingOnly=TRUE)

con = dbConnect(RMySQL::MySQL(), 
    host = "db.tychio.net",
    user = "psychio",
    password = args[1],
    dbname = "psychio",
    port = 62992
)

res = dbGetQuery(con, "
    SELECT * FROM experiment_trials WHERE kind = 0 LIMIT 10000
")

fm = lmer(key ~ speed + 1 | name, REML = FALSE, data = res)

anova(fm)