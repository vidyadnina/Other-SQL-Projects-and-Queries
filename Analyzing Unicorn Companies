-- find highest valuations (funding.valuation)
WITH industry_valuations AS (
	select 	industry, 
			extract (year from date_joined) as year_joined, 
			count(*) as num_unicorns, 
			round(avg(valuation)/1000000000,2) as average_valuation_billions
	from 	industries
	join 	public.dates
	on 		industries.company_id=dates.company_id
	join 	public.funding
	on 		industries.company_id=funding.company_id
	group by industry,year_joined)
	
	, rank_industry AS(
	select 	* , 
			rank() over(partition by year_joined order by num_unicorns desc)             as rank_n_unicorns
	from 	industry_valuations
	where 	year_joined in (2019,2020,2021)
	)
SELECT industry, year_joined as year,num_unicorns,average_valuation_billions
from rank_industry
WHERE	rank_n_unicorns in (1,2,3) 
order by year_joined desc,rank_n_unicorns;
