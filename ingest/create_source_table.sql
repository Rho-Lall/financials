CREATE TABLE source.amzn_financials (
    tag VARCHAR,
	measure_description VARCHAR, 
	period_start_date DATE, 
	period_end_date DATE, 
	amount DECIMAL,  
	statement VARCHAR
);

copy source.amzn_financials from '/Volumes/stageTB/source/amzn_financials.csv' DELIMITER ',' CSV HEADER;