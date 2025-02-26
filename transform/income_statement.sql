-- create or replace view transform.amzn_income_statements as 
WITH is_src as (select * from source.amzn_financials)

, measure_mapping (tag, gl_number, gl_account) AS (
    VALUES
        ('CostOfGoodsAndServicesSold', 4010, 'Cost of revenue'),
        ('CostsAndExpenses', 5900, 'Total operating expenses'),
        ('EarningsPerShareBasic', 9100, 'Earnings per share, basic'),
        ('EarningsPerShareDiluted', 9101, 'Earnings per share, diluted'),
        ('FulfillmentExpense', 5050, 'Fulfillment'),
        ('GeneralAndAdministrativeExpense', 5021, 'General and administrative'),
        ('IncomeLossFromContinuingOperationsBeforeIncomeTaxesMinorityInterestAndIncomeLossFromEquityMethodInvestments', 8010, 'Income before taxes'),
        ('IncomeLossFromEquityMethodInvestments', 7030, 'Income from equity investments'),
        ('IncomeTaxExpenseBenefit', 8020, 'Benefit (provision) for income taxes'),
        ('InterestExpense', 5060, 'Interest expense'),
        ('InterestExpenseNonoperating', 7060, 'Interest expense, non-operating'),
        ('InvestmentIncomeInterest', 7060, 'Investment income'),
        ('MarketingExpense', 5010, 'Marketing'),
        ('NetIncomeLoss', 9000, 'Net profit'),
        ('NonoperatingIncomeExpense', 7020, 'Other income'),
        ('OperatingIncomeLoss', 6000, 'Operating profit'),
        ('OtherComprehensiveIncome', 9001, 'Other comprehensive income'),
        ('OtherCostAndExpenseOperating', 5040, 'Operations and support'),
        ('OtherNonoperatingIncomeExpense', 7010, 'Change in fair value of liabilities'),
        ('OtherOperatingIncome', 7070, 'Other operating income'),
        ('OtherOperatingIncomeExpenseNet', 7080, 'Other operating income (expense), net'),
        ('RevenueFromContractWithCustomerExcludingAssessedTax', 4000, 'Revenue'),
        ('TechnologyAndContentExpense', 5030, 'Technology and development'),
        ('TechnologyAndInfrastructureExpense', 5030, 'Technology and development'),
        ('WeightedAverageNumberOfDilutedSharesOutstanding', 9111, 'Weighted average number of diluted shares outstanding'),
        ('WeightedAverageNumberOfSharesOutstandingBasic', 9110, 'Weighted average number of shares outstanding, basic')

), reclass as (  
 
    SELECT DISTINCT
        mm.gl_number,
        mm.gl_account,
        s.period_start_date,
        s.period_end_date,
        MAX(s.amount) AS amount
    FROM is_src s
    JOIN measure_mapping mm 
        ON s.tag = mm.tag
    where s.statement = 'Income Statement'
    GROUP BY mm.gl_number, mm.gl_account, s.period_start_date, s.period_end_date

), pivot AS (
    SELECT 
          gl_number
        , gl_account

        -- -- Year 2015
        -- , MAX(CASE WHEN period_end_date = '2015-03-31' AND period_start_date = '2015-01-01' THEN amount ELSE null END) AS "2015-03-31"
        -- , MAX(CASE WHEN period_end_date = '2015-06-30' AND period_start_date = '2015-04-01' THEN amount ELSE null END) AS "2015-06-30"
        -- , MAX(CASE WHEN period_end_date = '2015-09-30' AND period_start_date = '2015-07-01' THEN amount ELSE null END) AS "2015-09-30"
        -- , MAX(CASE WHEN period_end_date = '2015-12-31' AND period_start_date = '2015-01-01' THEN amount ELSE null END) AS "2015-12-31"

        -- -- Year 2016
        -- , MAX(CASE WHEN period_end_date = '2016-03-31' AND period_start_date = '2016-01-01' THEN amount ELSE null END) AS "2016-03-31"
        -- , MAX(CASE WHEN period_end_date = '2016-06-30' AND period_start_date = '2016-04-01' THEN amount ELSE null END) AS "2016-06-30"
        -- , MAX(CASE WHEN period_end_date = '2016-09-30' AND period_start_date = '2016-07-01' THEN amount ELSE null END) AS "2016-09-30"
        -- , MAX(CASE WHEN period_end_date = '2016-12-31' AND period_start_date = '2016-01-01' THEN amount ELSE null END) AS "2016-12-31"

        -- -- Year 2017
        -- , MAX(CASE WHEN period_end_date = '2017-03-31' AND period_start_date = '2017-01-01' THEN amount ELSE null END) AS "2017-03-31"
        -- , MAX(CASE WHEN period_end_date = '2017-06-30' AND period_start_date = '2017-04-01' THEN amount ELSE null END) AS "2017-06-30"
        -- , MAX(CASE WHEN period_end_date = '2017-09-30' AND period_start_date = '2017-07-01' THEN amount ELSE null END) AS "2017-09-30"
        -- , MAX(CASE WHEN period_end_date = '2017-12-31' AND period_start_date = '2017-01-01' THEN amount ELSE null END) AS "2017-12-31"

        -- -- Year 2018
        -- , MAX(CASE WHEN period_end_date = '2018-03-31' AND period_start_date = '2018-01-01' THEN amount ELSE null END) AS "2018-03-31"
        -- , MAX(CASE WHEN period_end_date = '2018-06-30' AND period_start_date = '2018-04-01' THEN amount ELSE null END) AS "2018-06-30"
        -- , MAX(CASE WHEN period_end_date = '2018-09-30' AND period_start_date = '2018-07-01' THEN amount ELSE null END) AS "2018-09-30"
        -- , MAX(CASE WHEN period_end_date = '2018-12-31' AND period_start_date = '2018-01-01' THEN amount ELSE null END) AS "2018-12-31"

        -- Year 2019
        , MAX(CASE WHEN period_end_date = '2019-03-31' AND period_start_date = '2019-01-01' THEN amount ELSE null END) AS "2019-03-31"
        , MAX(CASE WHEN period_end_date = '2019-06-30' AND period_start_date = '2019-04-01' THEN amount ELSE null END) AS "2019-06-30"
        , MAX(CASE WHEN period_end_date = '2019-09-30' AND period_start_date = '2019-07-01' THEN amount ELSE null END) AS "2019-09-30"
        , MAX(CASE WHEN period_end_date = '2019-12-31' AND period_start_date = '2019-01-01' THEN amount ELSE null END) AS "2019-12-31"

        -- Year 2020
        , MAX(CASE WHEN period_end_date = '2020-03-31' AND period_start_date = '2020-01-01' THEN amount ELSE null END) AS "2020-03-31"
        , MAX(CASE WHEN period_end_date = '2020-06-30' AND period_start_date = '2020-04-01' THEN amount ELSE null END) AS "2020-06-30"
        , MAX(CASE WHEN period_end_date = '2020-09-30' AND period_start_date = '2020-07-01' THEN amount ELSE null END) AS "2020-09-30"
        , MAX(CASE WHEN period_end_date = '2020-12-31' AND period_start_date = '2020-01-01' THEN amount ELSE null END) AS "2020-12-31"

        -- Yearamount
        , MAX(CASE WHEN period_end_date = '2021-03-31' AND period_start_date = '2021-01-01' THEN amount ELSE null END) AS "2021-03-31"
        , MAX(CASE WHEN period_end_date = '2021-06-30' AND period_start_date = '2021-04-01' THEN amount ELSE null END) AS "2021-06-30"
        , MAX(CASE WHEN period_end_date = '2021-09-30' AND period_start_date = '2021-07-01' THEN amount ELSE null END) AS "2021-09-30"
        , MAX(CASE WHEN period_end_date = '2021-12-31' AND period_start_date = '2021-01-01' THEN amount ELSE null END) AS "2021-12-31"

        -- Year 2022
        , MAX(CASE WHEN period_end_date = '2022-03-31' AND period_start_date = '2022-01-01' THEN amount ELSE null END) AS "2022-03-31"
        , MAX(CASE WHEN period_end_date = '2022-06-30' AND period_start_date = '2022-04-01' THEN amount ELSE null END) AS "2022-06-30"
        , MAX(CASE WHEN period_end_date = '2022-09-30' AND period_start_date = '2022-07-01' THEN amount ELSE null END) AS "2022-09-30"
        , MAX(CASE WHEN period_end_date = '2022-12-31' AND period_start_date = '2022-01-01' THEN amount ELSE null END) AS "2022-12-31"

        -- Year 2023
        , MAX(CASE WHEN period_end_date = '2023-03-31' AND period_start_date = '2023-01-01' THEN amount ELSE null END) AS "2023-03-31"
        , MAX(CASE WHEN period_end_date = '2023-06-30' AND period_start_date = '2023-04-01' THEN amount ELSE null END) AS "2023-06-30"
        , MAX(CASE WHEN period_end_date = '2023-09-30' AND period_start_date = '2023-07-01' THEN amount ELSE null END) AS "2023-09-30"
        , MAX(CASE WHEN period_end_date = '2023-12-31' AND period_start_date = '2023-01-01' THEN amount ELSE null END) AS "2023-12-31"

        -- Year 2024
        , MAX(CASE WHEN period_end_date = '2024-03-31' AND period_start_date = '2024-01-01' THEN amount ELSE null END) AS "2024-03-31"
        , MAX(CASE WHEN period_end_date = '2024-06-30' AND period_start_date = '2024-04-01' THEN amount ELSE null END) AS "2024-06-30"
        , MAX(CASE WHEN period_end_date = '2024-09-30' AND period_start_date = '2024-07-01' THEN amount ELSE null END) AS "2024-09-30"
        , MAX(CASE WHEN period_end_date = '2024-12-31' AND period_start_date = '2024-01-01' THEN amount ELSE null END) AS "2024-12-31"

    FROM reclass
    where gl_number is not null
    GROUP BY 
          gl_number
        , gl_account

)
select
    gl_number
    , gl_account
    , "2024-09-30"

from pivot
order by gl_number
;