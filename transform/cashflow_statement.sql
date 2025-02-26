-- create or replace view transform.amzn_cashflow_statements as 
WITH cf_src as (select * from source.amzn_financials)

, measure_mapping (tag, gl_number, gl_account) AS (
    VALUES
        -- Operating Activities (1700–1800)
        ('NetCashProvidedByUsedInOperatingActivities', 1700, 'Net cash provided by operating activities'),
        ('NetIncomeLoss', 1710, 'Net income (loss)'),
        ('DepreciationDepletionAndAmortization', 1720, 'Depreciation and amortization'),
        ('ShareBasedCompensation', 1730, 'Stock-based compensation'),
        ('DeferredIncomeTaxExpenseBenefit', 1740, 'Deferred tax expense (benefit)'),
        ('OtherNoncashIncomeExpense', 1750, 'Other non-cash adjustments'),
        ('IncreaseDecreaseInInventories', 1760, 'Change in inventories'),
        ('IncreaseDecreaseInAccountsPayable', 1770, 'Change in accounts payable'),
        ('IncreaseDecreaseInAccruedLiabilitiesAndOtherOperatingLiabilities', 1780, 'Change in accrued liabilities'),
        ('IncreaseDecreaseInContractWithCustomerLiability', 1790, 'Change in contract liabilities'),
        ('IncreaseDecreaseInOtherNoncurrentAssets', 1800, 'Change in other non-current assets'),

        -- Investing Activities (2700–2800)
        ('NetCashProvidedByUsedInInvestingActivities', 2700, 'Net cash used in investing activities'),
        ('PaymentsToAcquireMarketableSecurities', 2710, 'Purchases of investments'),
        ('ProceedsFromSaleAndMaturityOfMarketableSecurities', 2720, 'Maturities and sales of investments'),
        ('PaymentsToAcquireProductiveAssets', 2730, 'Purchases of property and equipment'),
        ('ProceedsFromPropertyPlantAndEquipmentSalesAndIncentives', 2740, 'Proceeds from asset sales and incentives'),
        ('PaymentsToAcquireBusinessesNetOfCashAcquired', 2750, 'Acquisition of business, net of cash acquired'),
        ('PaymentsToAcquireBusinessesNetOfCashAcquiredAndOther', 2760, 'Acquisition of business and other assets'),
        ('PaymentsToAcquireBusinessesNetOfCashAcquiredAndPaymentsToAcquireNonmarketableSecuritiesAndOther', 2770, 'Acquisition of business and nonmarketable securities'),
        ('PropertyandEquipmentObtainedinExchangeforFinancingObligations', 2780, 'Property & equipment obtained in financing exchange'),

        -- Financing Activities (3700–3800)
        ('NetCashProvidedByUsedInFinancingActivities', 3700, 'Net cash used in financing activities'),
        ('ProceedsFromIssuanceOfLongTermDebt', 3710, 'Proceeds from long-term debt issuance'),
        ('RepaymentsOfDebt', 3720, 'Repayments of debt'),
        ('ProceedsFromShortTermDebt', 3730, 'Proceeds from short-term debt'),
        ('RepaymentsOfShortTermDebt', 3740, 'Repayments of short-term debt'),
        ('RepaymentsOfLongTermDebt', 3750, 'Repayments of long-term debt'),
        ('RepaymentsOfLongTermFinancingObligations', 3760, 'Repayments of long-term financing obligations'),
        ('RepaymentsOfShortTermDebtAndOtherFinancingActivities', 3770, 'Repayments of short-term debt and other financing activities'),
        ('OperatingLeasePayments', 3780, 'Payments on operating lease obligations'),
        ('FinanceLeasePrincipalPayments', 3790, 'Finance lease principal payments'),
        ('FinanceLeaseInterestPaymentOnLiability', 3800, 'Finance lease interest payments'),
        ('InterestPaidOnLongTermDebt', 3801, 'Interest paid on long-term debt'),
        ('InterestPaidFinancingObligations', 3802, 'Interest paid on financing obligations'),
        ('PaymentsForRepurchaseOfCommonStock', 3803, 'Repurchases of common stock'),

        -- Net Cash Flow & Closing Cash Balances (9700–9800)
        ('TotalCashCashEquivalentsRestrictedCashAndRestrictedCashEquivalents', 9700, 'Total cash and restricted cash'),
        ('EffectOfExchangeRateOnCashAndCashEquivalents', 9710, 'Effect of exchange rate on cash'),
        ('EffectOfExchangeRateOnCashCashEquivalentsRestrictedCashAndRestrictedCashEquivalents', 9720, 'Effect of exchange rate on restricted cash'),
        ('EffectOfExchangeRateOnCashCashEquivalentsRestrictedCashAndRestrictedCashEquivalentsIncludingDisposalGroupAndDiscontinuedOperations', 9730, 'Exchange rate effect on discontinued operations'),
        ('CashCashEquivalentsRestrictedCashAndRestrictedCashEquivalents', 9740, 'Cash, cash equivalents, and restricted cash'),
        ('CashCashEquivalentsRestrictedCashAndRestrictedCashEquivalentsPeriodIncreaseDecreaseIncludingExchangeRateEffect', 9750, 'Increase (decrease) in cash, cash equivalents, and restricted cash'),
        ('CashPaidForTaxes', 9760, 'Cash paid for taxes'),
        ('RightOfUseAssetObtainedInExchangeForOperatingLeaseLiability', 9770, 'Right-of-use asset obtained for operating lease liability'),
        ('RightOfUseAssetObtainedInExchangeForFinanceLeaseLiability', 9780, 'Right-of-use asset obtained for finance lease liability'),
        ('OtherOperatingActivitiesCashFlowStatement', 9790, 'Other operating activities in cash flow statement'),
        ('ProceedsFromRebatesOnPurchasesOfProductiveAssets', 9791, 'Proceeds from rebates on productive assets'),
        ('ProceedsFromShortTermDebtAndOtherFinancingActivities', 9792, 'Proceeds from short-term debt and other financing activities'),
        ('PaymentsToAcquireBusinessesNetOfCashAcquiredAndOther', 9793, 'Payments to acquire businesses and other assets'),
        ('PaymentsForAcquisitionRelatedEarnOutConsideration', 9794, 'Payments for acquisition-related earn-out consideration')

), cashflow_statements_src AS (
 
    SELECT
          gl_number
        , gl_account
        , period_start_date
        , period_end_date
        , max(amount) as amount

    FROM cf_src s
    JOIN measure_mapping mm 
        ON s.tag = mm.tag
    GROUP BY mm.gl_number, mm.gl_account, s.period_end_date, s.period_start_date

), pivot AS (
    SELECT 
          gl_number
        , gl_account
            
        -- Year 2019
        -- , MAX(CASE WHEN period_end_date = '2019-12-31' AND period_start_date = '2019-07-01' THEN amount ELSE null END) AS "2019-12-31"
       
        -- Year 2020
        , MAX(CASE WHEN period_end_date = '2020-12-31' AND period_start_date = '2020-01-01' THEN amount ELSE null END) AS "2020-12-31"

        -- Year 2021
        , MAX(CASE WHEN period_end_date = '2021-12-31' AND period_start_date = '2021-01-01' THEN amount ELSE null END) AS "2021-12-31"


        -- Year 2022
        , MAX(CASE WHEN period_end_date = '2022-12-31' AND period_start_date = '2022-01-01' THEN amount ELSE null END) AS "2022-12-31"

        -- Year 2023
        , MAX(CASE WHEN period_end_date = '2023-12-31' AND period_start_date = '2023-01-01' THEN amount ELSE null END) AS "2023-12-31"

        -- Year 2024
        , MAX(CASE WHEN period_end_date = '2024-09-30' AND period_start_date = '2024-01-01' THEN amount ELSE null END) AS "2024-09-30"        


    FROM cashflow_statements_src
    where gl_number is not null
    GROUP BY 
          gl_number
        , gl_account
)

select * from pivot
order by gl_number
;