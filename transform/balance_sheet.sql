
-- create or replace view transform.amzn_balance_sheets as 
WITH bs_src as (select * from source.amzn_financials where statement = 'Balance Sheet') 
, measure_mapping (tag, gl_number, gl_account) AS (
    VALUES
        ('AccountsPayableCurrent', 2010, 'Accounts payable'),
        ('AccountsReceivableNetCurrent', 1025, 'Accounts receivable'),
        ('AccruedLiabilitiesAndOtherCurrent', 2020, 'Accrued liabilities'),
        ('AccruedLiabilitiesCurrent', 2020, 'Accrued liabilities'),
        ('AccumulatedOtherComprehensiveIncomeLossNetOfTax', 3030, 'Accumulated other comprehensive income (loss)'),
        ('AdditionalPaidInCapital', 3020, 'Additional paid-in capital'),
        ('Assets', 1900, 'Total assets'),
        ('AssetsCurrent', 1050, 'Current assets'),
        ('CashAndCashEquivalentsAtCarryingValue', 1000, 'Cash and cash equivalents'),
        ('CommitmentsAndContingencies', 2105, 'Commitments and contingencies'),
        ('CommonStockParOrStatedValuePerShare', 3050, 'Common stock, par or stated value per share'),
        ('CommonStockSharesAuthorized', 3055, 'Common stock, shares authorized'),
        ('CommonStockSharesIssued', 3060, 'Common stock, shares issued'),
        ('CommonStockSharesOutstanding', 3065, 'Common stock, shares outstanding'),
        ('CommonStockValue', 3070, 'Common stock value'),
        ('ContractWithCustomerLiabilityCurrent', 2035, 'Contract liability (deferred revenue)'),
        ('Goodwill', 1060, 'Goodwill'),
        ('InventoryNet', 1030, 'Inventory'),
        ('LeaseLiabilityNoncurrent', 2100, 'Operating lease liabilities'),
        ('LiabilitiesAndStockholdersEquity', 2995, 'Total liabilities and stockholders’ equity'),
        ('LiabilitiesCurrent', 2090, 'Total current liabilities'),
        ('LongTermDebtNoncurrent', 2110, 'Long-term debt, non-current'),
        ('MarketableSecuritiesCurrent', 1020, 'Short-term investments'),
        ('OperatingLeaseRightOfUseAsset', 1090, 'Operating lease right-of-use assets'),
        ('OtherAssetsNoncurrent', 1110, 'Other long-term assets'),
        ('OtherLiabilitiesNoncurrent', 2120, 'Other long-term liabilities'),
        ('PreferredStockParOrStatedValuePerShare', 3200, 'Preferred stock, par or stated value per share'),
        ('PreferredStockSharesAuthorized', 3205, 'Preferred stock, shares authorized'),
        ('PreferredStockSharesIssued', 3210, 'Preferred stock, shares issued'),
        ('PreferredStockSharesOutstanding', 3215, 'Preferred stock, shares outstanding'),
        ('PreferredStockValue', 3220, 'Preferred stock value'),
        ('PropertyPlantAndEquipmentAndFinanceLeaseRightOfUseAssetAfterAccumulatedDepreciationAndAmortization', 1070, 'Property, plant, and equipment'),
        ('PropertyPlantAndEquipmentNet', 1070, 'Property, plant, and equipment'),
        ('RetainedEarningsAccumulatedDeficit', 3040, 'Retained earnings (Accumulated deficit)'),
        ('StockholdersEquity', 3990, 'Total stockholders’ equity'),
        ('TreasuryStockCommonValue', 3995, 'Treasury stock, common value'),
        ('TreasuryStockValue', 3996, 'Treasury stock, total value')


), balance_sheets_src AS (
 
    SELECT
          gl_number
        , gl_account
        , period_end_date
        , max(amount) as amount

    FROM bs_src s
    JOIN measure_mapping mm 
        ON s.tag = mm.tag
    where statement = 'Balance Sheet'
    GROUP BY mm.gl_number, mm.gl_account, s.period_end_date


), pivot AS (
    SELECT 
          gl_number
        , gl_account

        -- -- Year 2015
        -- , MAX(CASE WHEN period_end_date = '2015-03-31' THEN amount ELSE null END) AS "2015-03-31"
        -- , MAX(CASE WHEN period_end_date = '2015-06-30' THEN amount ELSE null END) AS "2015-06-30"
        -- , MAX(CASE WHEN period_end_date = '2015-09-30' THEN amount ELSE null END) AS "2015-09-30"
        -- , MAX(CASE WHEN period_end_date = '2015-12-31' THEN amount ELSE null END) AS "2015-12-31"

        -- -- Year 2016
        -- , MAX(CASE WHEN period_end_date = '2016-03-31' THEN amount ELSE null END) AS "2016-03-31"
        -- , MAX(CASE WHEN period_end_date = '2016-06-30' THEN amount ELSE null END) AS "2016-06-30"
        -- , MAX(CASE WHEN period_end_date = '2016-09-30' THEN amount ELSE null END) AS "2016-09-30"
        -- , MAX(CASE WHEN period_end_date = '2016-12-31' THEN amount ELSE null END) AS "2016-12-31"

        -- -- Year 2017
        -- , MAX(CASE WHEN period_end_date = '2017-03-31' THEN amount ELSE null END) AS "2017-03-31"
        -- , MAX(CASE WHEN period_end_date = '2017-06-30' THEN amount ELSE null END) AS "2017-06-30"
        -- , MAX(CASE WHEN period_end_date = '2017-09-30' THEN amount ELSE null END) AS "2017-09-30"
        -- , MAX(CASE WHEN period_end_date = '2017-12-31' THEN amount ELSE null END) AS "2017-12-31"

        -- -- Year 2018
        -- , MAX(CASE WHEN period_end_date = '2018-03-31' THEN amount ELSE null END) AS "2018-03-31"
        -- , MAX(CASE WHEN period_end_date = '2018-06-30' THEN amount ELSE null END) AS "2018-06-30"
        -- , MAX(CASE WHEN period_end_date = '2018-09-30' THEN amount ELSE null END) AS "2018-09-30"
        -- , MAX(CASE WHEN period_end_date = '2018-12-31' THEN amount ELSE null END) AS "2018-12-31"

        -- Year 2019
        , MAX(CASE WHEN period_end_date = '2019-03-31' THEN amount ELSE null END) AS "2019-03-31"
        , MAX(CASE WHEN period_end_date = '2019-06-30' THEN amount ELSE null END) AS "2019-06-30"
        , MAX(CASE WHEN period_end_date = '2019-09-30' THEN amount ELSE null END) AS "2019-09-30"
        , MAX(CASE WHEN period_end_date = '2019-12-31' THEN amount ELSE null END) AS "2019-12-31"

        -- Year 2020
        , MAX(CASE WHEN period_end_date = '2020-03-31' THEN amount ELSE null END) AS "2020-03-31"
        , MAX(CASE WHEN period_end_date = '2020-06-30' THEN amount ELSE null END) AS "2020-06-30"
        , MAX(CASE WHEN period_end_date = '2020-09-30' THEN amount ELSE null END) AS "2020-09-30"
        , MAX(CASE WHEN period_end_date = '2020-12-31' THEN amount ELSE null END) AS "2020-12-31"

        -- Year 2021
        , MAX(CASE WHEN period_end_date = '2021-03-31' THEN amount ELSE null END) AS "2021-03-31"
        , MAX(CASE WHEN period_end_date = '2021-06-30' THEN amount ELSE null END) AS "2021-06-30"
        , MAX(CASE WHEN period_end_date = '2021-09-30' THEN amount ELSE null END) AS "2021-09-30"
        , MAX(CASE WHEN period_end_date = '2021-12-31' THEN amount ELSE null END) AS "2021-12-31"

        -- Year 2022
        , MAX(CASE WHEN period_end_date = '2022-03-31' THEN amount ELSE null END) AS "2022-03-31"
        , MAX(CASE WHEN period_end_date = '2022-06-30' THEN amount ELSE null END) AS "2022-06-30"
        , MAX(CASE WHEN period_end_date = '2022-09-30' THEN amount ELSE null END) AS "2022-09-30"
        , MAX(CASE WHEN period_end_date = '2022-12-31' THEN amount ELSE null END) AS "2022-12-31"

        -- Year 2023
        , MAX(CASE WHEN period_end_date = '2023-03-31' THEN amount ELSE null END) AS "2023-03-31"
        , MAX(CASE WHEN period_end_date = '2023-06-30' THEN amount ELSE null END) AS "2023-06-30"
        , MAX(CASE WHEN period_end_date = '2023-09-30' THEN amount ELSE null END) AS "2023-09-30"
        , MAX(CASE WHEN period_end_date = '2023-12-31' THEN amount ELSE null END) AS "2023-12-31"

        -- Year 2024
        , MAX(CASE WHEN period_end_date = '2024-03-31' THEN amount ELSE null END) AS "2024-03-31"
        , MAX(CASE WHEN period_end_date = '2024-06-30' THEN amount ELSE null END) AS "2024-06-30"
        , MAX(CASE WHEN period_end_date = '2024-09-30' THEN amount ELSE null END) AS "2024-09-30"
        -- , MAX(CASE WHEN period_end_date = '2024-12-31' THEN amount ELSE null END) AS "2024-12-31"

    FROM balance_sheets_src
    -- where gl_number is not null
    GROUP BY 
          gl_number
        , gl_account
)

select * from pivot
order by gl_number
;




