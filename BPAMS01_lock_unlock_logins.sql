select distinct a.suid,b.name from sysprocesses a,syslogins b 
where a.suid=b.suid

select distinct b.name from sysprocesses a,syslogins b 
where a.suid=b.suid


# user process on Feb 16,2020

name
'baadmin'
'bamsx01'
'bappcrm'
'bappivr'

******************** LOCK BPAMS01 USERS

sp_locklogin 'baadmin',"lock"
go
sp_locklogin 'bamsx01',"lock"
go
sp_locklogin 'bappcrm',"lock"
go
sp_locklogin 'bappivr',"lock"
go

*************************************************

sp_locklogin 'brepar01',"lock"
go
sp_locklogin 'bara003',"lock"
go



******************** UNLOCK BPAMS01 USERS

sp_locklogin 'baadmin',"unlock"
go
sp_locklogin 'bamsx01',"unlock"
go
sp_locklogin 'bappcrm',"unlock"
go
sp_locklogin 'bappivr',"unlock"
go

*****************************************************
sp_locklogin 'brepar01',"unlock"
go
sp_locklogin 'bara003',"unlock"
go


******************************************************

use master
go
sp_dboption db_aadmin, "single user", true
go

*******************************************************

dbcc tablealloc(syslogs, full, fix)
go > tablealloc.txt

check the tablealloc.txt. if no error then trun back to Multi-user mode.

**************************************************************************
sp_dboption db_aadmin, "single user", false
go



