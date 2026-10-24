select *from dim_customer where outlet_name like '%alfa%'

select *from dim_customer where outlet_type like '%mtka%'

select *from auditdb.dbo.audit_job order by job_start_dt
select *from auditdb.dbo.audit_task order by task_start_dt
select *from auditdb.dbo.audit_task where task_start_dt>'2025-07-11'
  order by task_start_dt,task_end_dt,package_name

select *from auditdb.dbo.audit_task where task_start_dt>'2025-07-11'
  order by task_start_dt,task_end_dt,package_name

select *from auditdb.dbo.audit_task where task_start_dt>'2025-07-11' and task_name like '%audit%'
  order by task_start_dt,task_end_dt,package_name

select *from auditdb.dbo.audit_task where task_start_dt>'2025-07-11' and task_name like '%begin%'
  order by task_start_dt,task_end_dt,package_name

select *from auditdb.dbo.oltp_audit_job order by job_start_dt 
 
select *from auditdb.dbo.oltp_audit_job 
 where job_start_dt>'2025-01-01' order by job_start_dt 

select *from auditdb.dbo.oltp_audit_task
 where task_start_dt>'2025-07-11' order by task_start_dt,task_end_dt,package_name 

select count(*) from adventuresales.dbo.sttyr_18_19_tbl

select * into adventuresales.dbo.sttyr_yoy from sttyr_yoy

select * into sttyr_yoy from adventuresales.dbo.sttyr_18_19_tbl where year=2000

 sSQL = "INSERT INTO OLTP_AUDIT_TASK (audit_id, package_name,  "
 sSQL = sSQL & "task_name, task_status, task_start_dt, "
 sSQL = sSQL & "task_end_dt, records_processes) VALUES ("
 sSQL = sSQL & DTSGlobalVariables("giAuditId").Value & ", "
 sSQL = sSQL & "' " &oPackage.Name & "', "
 sSQL = sSQL & "' " & sStepName & "', 'Successful - "  &"', "
 sSQL = sSQL & "' " & oStep.StartTime & "', '" & oStep.FinishTime
 sSQL = sSQL & "' , " & vRecordsProcessed & ") "