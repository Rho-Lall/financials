-- asserts the tags in the data pull are accounted for in my tag mapping.

select distinct tag from source.amzn_financials
except
select * from transform.tag_store
;