# Introduction
This Linux/SQL project is meant to record hardware specifications and resource usages (e.g. CPU/Memory) in real-time of each node of a Linux cluster managed by the Jarvis Linux Cluster Administration (LCA). This will be very useful for the LCA team (Jarvis Cluster Administration) who manage a Linux cluster of 10 nodes/servers running on CentOS 7.
The servers that the LCA uses are internally connected through a switch and able to communicate through internal IPv4 addresses. The collected data is stored in an RDBMS database. This database will be used to generate reports for future resource planning purposes (e.g. add/remove servers).

For this project, we used Intellij IDE for a big part of the BASH coding phase. Furthermore, we
used a docker container to store our SQL database. The queries for this database were programmed with DBeaver.
Finally, everything was constantly saved and sent to GitHub, where the senior devs were able to proofread our code.*******testing*****again
# Quick Start
- Start a psql instance using psql_docker.sh
```
./scripts/psql_docker.sh start
```
- Create tables using ddl.sql
```
psql -h localhost -U postgres -d host_agent -f sql/ddl.sql
psql -h localhost -U postgres -d host_usage -f sql/ddl.sql
```
- Insert hardware specs data into the DB using host_info.sh
```
bash scripts/host_usage.sh localhost 5432 host_agent postgres password
```
- Insert hardware usage data into the DB using host_usage.sh
```
bash scripts/host_usage.sh localhost 5432 host_usage postgres password
```
- Crontab setup
```
* * * * * bash /home/centos/dev/jrvs/bootcamp/linux_sql/host_agent/scripts/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log
```

# Implemenation
To begin the project, we started by setting up our GitHub repo to save every version of our project. Then we continued by setting up a docker instance for us to store our database. Then we proceeded to set up our tables where we would store the data received from our nodes. The next step was to code our script to fetch the required data from said nodes (host_info and host_usage). Once everything was verified and working, the crontab was implemented to periodically get the resource usage of the node. We could then proceed to create the SQL queries to filter the data and simplify the information received. Finally, we created the README file.
## Architecture

![Cluster_Diagram.PNG](/home/centos/dev/jarvis_data_eng_Francois/linux_sql/assets/Cluster_Diagram.PNG)
## Scripts
Shell script description and usage (use markdown code block for script usage)
- psql_docker.sh

The script is used to create, stop and start the docker instance.
```
./scripts/psql_docker.sh create db_username db_password
./scripts/psql_docker.sh start
./scripts/psql_docker.sh stop
```
- host_info.sh

This script is meant to generate the node hardware specifications to the tables.
```
psql -h localhost -U postgres -d host_agent -f sql/ddl.sql
```
- host_usage.sh

When using host usage, the script will generate periodically the ressource usage of each node, every one minute, to the table.
```
psql -h localhost -U postgres -d host_usage -f sql/ddl.sql
```
- crontab

When using crontab, we will first initialise the periodic generation of data with this code:
```
* * * * * bash /home/centos/dev/jrvs/bootcamp/linux_sql/host_agent/scripts/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log
```
- queries.sql

We use the queries to filter out undesired data. The first query is meant to order the nodes in memory size.

The second query is used to show the memory usage of a node on average, every 5 minutes.

Finally. the third query is used to find host failures. If a node stops generating a time stamp for three minutes, it will be shown as failure.

These queries are meant to help better manage clusters and plan for future resources.

## Database Modeling
Describe the schema of each table using markdown table syntax (do not put any sql code)
- `host_info`
```
| id | hostname | cpu_number | cpu_archetecture | cpu_model | cpu_mhz | l2_cache | total_mem | timestamp |
|----|----------|------------|------------------|-----------|---------|----------|-----------|-----------|
|    |          |            |                  |           |         |          |           |           |
|    |          |            |                  |           |         |          |           |           |
|    |          |            |                  |           |         |          |           |           |
```

- `host_usage`
```
| Timstamp | host_id | memory_free | cpu_idle | cpu_kernel | disk_io | disk_available |
|----------|---------|-------------|----------|------------|---------|----------------|
|          |         |             |          |            |         |                |
|          |         |             |          |            |         |                |
|          |         |             |          |            |         |                |
```

# Test

For testing the scripts, I ran them using IntelliJ IDE to see where their errors were produced. Once the script was good, I ran both of them and checked in the table to see if the data was going in the right way. For the queries, I was using Dbeaver, where I could see the data changing with the queries I was writing. Every time I would write a query, I would run it to see the output and correct it from there. In the end, the results were as asked in the project.
# Deployment

The program will be using crontab for the repetitive input of the data to the tables. The source code is managed with GitHub. The database is in the docker instance.

# Improvements

- Time management
- Effectively coding
- Optimising my searches when stuck.