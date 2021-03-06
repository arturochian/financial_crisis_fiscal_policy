# ---------------------------------------------------------------------------- #
# Create figures from results of spending_regressions.R
# Version 2
# Christopher Gandrud
# MIT License
# ---------------------------------------------------------------------------- #

# Load required packages
library(devtools)
library(ggplot2)
library(gridExtra)

# Set working directory. Change as needed.
setwd('/git_repositories/financial_crisis_fiscal_policy/')

# Run regressions
source('analysis_data/spending_regressions_v2.R')

# Load plot function
source_gist('d270ff55c2ca26286e90')

##### Plot Liabilities/Stress 
plot1 <- plot_me(obj = m4_t0, term1 = 'election_year1', term2 = 'lpr_1',
        fitted2 = seq(0, 0.75, by = 0.05)) +
    scale_y_continuous(limits = c(-10, 10)) +
    xlab('\nElectoral Loss Probability') +
    ylab('Marginal Effect of Election Year\n') +
    ggtitle('Change in Off-Trend Spending\n')



plot2 <- plot_me(obj = m5_t1, term1 = 'election_year_11', term2 = 'lpr',
               fitted2 = seq(0, 0.75, by = 0.05)) +
    scale_y_continuous(limits = c(-10, 13)) +
    xlab('\nElectoral Loss Probability') +
    ylab('Marginal Effect of Post-Election Year\n') +
    ggtitle('Change in Off-Trend Liabilities\n')


pdf(file = 'paper/figures/me_stress.pdf', width = 9.3, height = 5)
    grid.arrange(plot1, plot2, ncol = 2)
dev.off()






m6_t1 <- lm(formula = rs_change_liab ~ election_year_1 * 
       rs_change_spend_1 + iso2c, data = subset(sub_gov_liab, country != 'Iceland'))

summary(m6_t1)

plot_me(obj = m6_t1, term1 = 'election_year_11', term2 = 'rs_change_spend_1',
        fitted2 = seq(-5, 5, by = 0.1)) +
    scale_y_continuous(limits = c(-20, 40)) +
    xlab('\nPrevious Year Off-Trend Spending') +
    ylab('Marginal Effect of Post-Election Year\n') +
    ggtitle('Change in Off-Trend Liabilities\n')



m7_t1 <- lm(rs_change_spend ~ election_year_1 + lpr + execrlc + polconiii + 
                fixed_exchange +  iso2c, data = sub_gov_spend)


