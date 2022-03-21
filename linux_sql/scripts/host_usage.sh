#! /bin/sh

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

if [ $# -ne 5 ]; then
    echo 'All fields must be entered'
    exit 1
fi

#Save machine statistics in MB and current machine hostname to variables
vmstat_mb=$(vmstat --unit M)
hostname=$(hostname -f)

#get memory free
memory_free=$(echo "$vmstat_mb" | awk '{print $4}'| tail -n1 | xargs)

#get cpu idle
cpu_idle=$(echo "$vmstat_mb" | awk '{print $15}'| tail -n1 | xargs)

#get cpu kernel
cpu_kernel=$(echo "$vmstat_mb" | awk '{print $14}'| tail -n1 | xargs)

#get disk io
disk_io=$(vmstat -d | awk '{print $10}'| tail -n1 | xargs)

#get disk available
disk_available=$(df -BM /home | awk '{print $4}'| tail -n1 | xargs)

#Get timestamp in UTC
timestamp=$(date '+%Y-%m-%d %T')


host_id=$hostname

export PGPASSWORD=$psql_password

insert_stmt="INSERT INTO host_usage (memory_free, cpu_idle, cpu_kernel, disk_io, disk_available, timestamp) VALUES('$memory_free', '$cpu_idle', '$cpu_kernel', '$disk_io', '$disk_available', '$timestamp');"
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?


