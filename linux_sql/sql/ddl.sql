CREATE TABLE PUBLIC.host_info
(
    id               SERIAL NOT NULL,
    hostname         VARCHAR NOT NULL,
    cpu_number       INT NOT NULL,
    cpu_architecture VARCHAR NOT NULL,
    cpu_model        VARCHAR NOT NULL,
    cpu_mhz          FLOAT NOT NULL,
    L2_cache         VARCHAR NOT NULL\,
    total_mem        INT NOT NULL,
    timestamp        TIMESTAMP NOT NULL
);

--INSERT INTO host_info (id, hostname, cpu_number, cpu_architecture, cpu_model, L2_cache, total_mem, timestamp)

CREATE TABLE PUBLIC.host_usage
(
    timestamp        TIMESTAMP NOT NULL,
    host_id          SERIAL NOT NULL,
    memory_free      INT NOT NULL,
    cpu_idle         INT NOT NULL,
    cpu_kernel       INT NOT NULL,
    disk_io          INT NOT NULL,
    disk_available   VARCHAR NOT NULL
);

--INSERT INTO host_usage (timestamp, host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available)