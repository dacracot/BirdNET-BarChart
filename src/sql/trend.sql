select
	json_group_array(CHART)
from
	(
	select
		json_object('bird', BIRD, 'sum', TOTAL_EVER, 'data', LINE) as CHART
	from
		(
		select
			BIRD, sum(TOTAL_WEEK) as TOTAL_EVER, json_group_array(json_object('week', WEEK, 'total', TOTAL_WEEK)) as LINE
		from
			(
			select
				commonName as BIRD,
				strftime('%Y-%W',hourOfDay) as WEEK,
				sum(howMany) as TOTAL_WEEK
			from
				heardSumByHour
			where
				commonName in
					(
					select
						commonName
					from
						heardRaw
					group by
						commonName
					having
						count(commonName) > 100
					)
			group by
				WEEK,
				commonName
			order by
				commonName
			)
		group by
			BIRD
		)
	);
