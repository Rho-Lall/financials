This is a collection of files that build an alpha pipeline to process public financial data from the sec.


Sources
https://www.sec.gov/search-filings
https://www.investopedia.com/terms/e/edgar.asp#toc-what-is-electronic-data-gathering-analysis-and-retrieval-edgar

The data is made avaialable for FREE via a Snowflake dataShare from cybersyn.
cybersyn.com


# Sourcing
For now this is a manual data pull that identifies a specific company. Because. Reasons.

# Testing
One test to address mapping.
Pending test for a handful of income and cashflow accounts that present as negative in the data but are reported as positive, ie an expense that is actually a credit (income).

