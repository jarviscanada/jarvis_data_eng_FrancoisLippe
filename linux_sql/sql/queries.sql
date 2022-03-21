--Querie #1
SELECT 
	cpu_number, id, total_mem
FROM 
	host_info
ORDER BY 
	total_mem DESC;
;

SELECT  
	 host_usage.host_id, hostname,
	 AVG(((total_mem - (memory_free * 1000)) / total_mem) * 100)  AS used_memory, 
 	 round5(host_usage.timestamp) AS "timestamp"
FROM 
	 host_usage JOIN host_info ON host_usage.host_id = host_info.id
GROUP BY 
	 round5(host_usage.timestamp), host_id, hostname
ORDER BY 
	 timestamp ASC;

--Querie #3
SELECT 
	id, timestamp,num_data_points
FROM
	(SELECT 
		id,
		round5 (host_usage.timestamp) AS "timestamp",
		count(host_usage.timestamp) AS num_data_points
	 FROM 
	 	host_usage
	 INNER JOIN 
	 	host_info ON host_usage.host_id = host_usage.host_id
	GROUP BY 
		round5(host_usage.timestamp), host_info.id
	ORDER BY 
		timestamp ASC) 
	AS test
WHERE 
	num_data_points < 3;



CREATE FUNCTION round5(ts timestamp) RETURNS timestamp AS
$$
BEGIN
    RETURN date_trunc('hour', ts) + date_part('minute', ts):: int / 5 * interval '5 min';
END;
$$
   LANGUAGE PLPGSQL;



