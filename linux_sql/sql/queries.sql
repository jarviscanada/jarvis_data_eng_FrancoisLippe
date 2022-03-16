select 
	cpu_number, id, total_mem
from 
	host_info
order by total_mem desc;
;

select 
	 (select total_mem from host_info) - (select memory_free from host_usage)
	 as 
	 	used_memory;

