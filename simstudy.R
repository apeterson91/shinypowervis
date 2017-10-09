library(tidyverse)
library(broom)


## Simulation Function

sim.study <- function(n1 = 30, n2 = 30, baseline_mean = 5.4, differential = 1.2, base_sd = 3.4){
    
    y_base <- rnorm(n = n1+n2, mean = baseline_mean,sd = base_sd)
    y_end <- y_base
    y_end[1:n1] <- y_end[1:n1] + differential
    tx <- c(rep(1,n1),rep(0,n2))
    df <- data.frame(Outcome = y_end, Baseline = y_base, Treatment = tx)
    fit <- lm( Outcome ~ Treatment,data=df)
    
    
    out <- c(n1+n2,(broom::tidy(fit)[2,]$p.value<0.05))
    return(out)
}


run.sims <- function(reps = 100, args){
  results <- t(replicate(n = reps,do.call(sim.study,args = args)))
  colnames(results) <- c("n","effect")
  results
}


