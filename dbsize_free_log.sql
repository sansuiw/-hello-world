select db_name(d.dbid) as db_name,
ceiling(sum(case when u.segmap != 4 then u.size/1048576.*@@maxpagesize end )) as data_size_MB,
ceiling(sum(case when u.segmap != 4 then size - curunreservedpgs(u.dbid, u.lstart, u.unreservedpgs) end)/1048576.*@@maxpagesize) as data_used_MB,
ceiling(100 * (1 - 1.0 * sum(case when u.segmap != 4 then curunreservedpgs(u.dbid, u.lstart, u.unreservedpgs) end) / sum(case when u.segmap != 4 then u.size end))) as data_used_PCT,
ceiling(sum(case when u.segmap = 4 then u.size/1048576.*@@maxpagesize end)) as log_size_MB,
ceiling(sum(case when u.segmap = 4 then u.size/1048576.*@@maxpagesize end) - lct_admin("logsegment_freepages",d.dbid)/1048576.*@@maxpagesize) as log_used_MB,
ceiling(100 * (1 - 1.0 * lct_admin("logsegment_freepages",d.dbid) / sum(case when u.segmap in (4, 7) then u.size end))) as log_used_PCT 
from master..sysdatabases d, master..sysusages u
where u.dbid = d.dbid  and d.status != 256
group by d.dbid
order by db_name(d.dbid)
