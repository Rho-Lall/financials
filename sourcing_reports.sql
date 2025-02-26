-- SIC codes
select distinct i.sic, i.sic_code_category, i.sic_code_description
from cybersyn.sec_cik_index i
order by 1
;

-- find cik ID
select i.cik, i.company_name, i.sic, i.sic_code_category, i.sic_code_description
from cybersyn.sec_cik_index i
-- where company_name ilike '%Amazon%'
where i.cik = 0001018724
;

-- DATA COLLECTION
set cik_value = 0001018724
;

select $cik_value; -- check

-- check date range, it is appears to be 10 years, that should be 40 quarters. It might be only 5 years of quarterly data.
SELECT distinct period_start_date
FROM cybersyn.sec_cik_index AS i
JOIN cybersyn.sec_report_attributes AS r ON (r.cik = i.cik)
where i.cik = $cik_value
order by period_start_date
;

-- Gather all the data
SELECT r.tag, r.measure_description, r.period_start_date, r.period_end_date, value::float as amount, r.statement
FROM cybersyn.sec_cik_index AS i
JOIN cybersyn.sec_report_attributes AS r ON (r.cik = i.cik)
where i.cik = $cik_value
and r.statement in ('Income Statement', 'Balance Sheet', 'Cash Flow')
and metadata is null
;
