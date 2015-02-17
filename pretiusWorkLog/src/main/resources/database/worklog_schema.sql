BEGIN;

-- user "workloguser" has to be created before running these scripts
-- all necessary privileges will be assigned to the user
-- password will not be set automatically
-- createuser -D -l -S -R workloguser
-- alter user workloguser password 'worklogpassword';

CREATE SCHEMA pwl;
GRANT USAGE ON SCHEMA pwl TO workloguser;


CREATE TABLE pwl.client (
	client_id serial primary key,
	client_name varchar(256) not null unique
);

GRANT insert,update,select ON pwl.client to workloguser;
GRANT usage on sequence pwl.client_client_id_seq to workloguser;


CREATE TABLE pwl.project (
	project_id serial primary key,
	client_id integer not null references pwl.client(client_id),
	project_name varchar(128) not null,
	UNIQUE (client_id, project_name)
);

GRANT insert,update,select ON pwl.project to workloguser;
GRANT usage on sequence pwl.project_project_id_seq to workloguser;


CREATE TABLE pwl.task (
	task_id serial primary key,
	project_id integer not null references pwl.project(project_id),
	task_name varchar(128) not null,
	UNIQUE(project_id, task_name)
);

GRANT insert,update,select ON pwl.task to workloguser;
GRANT usage on sequence pwl.task_task_id_seq to workloguser;



CREATE TABLE pwl.employee (
    employee_id serial primary key,
    first_name varchar(128) not null,
    last_name varchar(128) not null,
    username varchar(32) not null unique,
    pw_hash varchar(128),
	admin_privilege boolean not null default false
);

GRANT insert,update,select ON pwl.employee to workloguser;
GRANT usage on sequence pwl.employee_employee_id_seq to workloguser;



CREATE TABLE pwl.work_entry (
	work_entry_id serial primary key,
	employee_id integer not null references pwl.employee(employee_id),
	task_id integer not null references pwl.task(task_id),
	amount_hours numeric(10,2) not null,
	work_date timestamp not null default NOW()
);

GRANT insert,update,select, delete ON pwl.work_entry to workloguser;
GRANT usage on sequence pwl.work_entry_work_entry_id_seq to workloguser;



create view pwl.project_effort_report as 
select C.client_name, P.project_name, sum(WE.amount_hours) as "amount_hours", to_char(work_date, 'YYYY/MM') as "work_date" 
from pwl.work_entry WE
LEFT JOIN pwl.task T on T.task_id = WE.task_id
LEFT JOIN pwl.project P on P.project_id = T.project_id
LEFT JOIN pwl.client C on C.client_id = P.client_id
group by "client_name","project_name","work_date" 
order by "work_date","client_name","project_name";

GRANT select ON  pwl.project_effort_report to workloguser;



create view pwl.project_effort_report_human_readable as 
select client_name as "Nazwa klienta", project_name as "Nazwa projektu", amount_hours as "Ilość godzin w miesiącu", work_date as "Miesiąc z rokiem" 
from pwl.project_effort_report;


GRANT select ON  pwl.project_effort_report_human_readable to workloguser;



COMMIT;
