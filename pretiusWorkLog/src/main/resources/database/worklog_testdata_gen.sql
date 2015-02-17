DO $$
DECLARE 
	user_gen_amount integer;
	project_gen_amount_per_client integer;
	task_gen_amount_per_project integer;
	work_log_gen_amount_per_task integer;
	work_log_range_back_days integer;
	
	work_min_amount numeric(10,2);
	work_max_amount numeric(10,2);
	p_amount_hours numeric(10,2);
	
	clients varchar[] := ARRAY['company 1', 'ACME 2', 'softcode 3 ltd.'];

	p_client_name varchar(256);
	
	ret_client_id integer;
	ret_project_id integer;
	p_task_id integer;
	p_employee_id integer;
	
	i integer;
	j integer;
	k integer;
	
	p_work_date timestamp;
	
	
	p_admin_privilege boolean;

BEGIN


	-- cleanup
	delete from pwl.work_entry;
	delete from pwl.task;
	delete from pwl.project;
	delete from pwl.client;
	delete from pwl.employee;
	
	user_gen_amount := 5;
	project_gen_amount_per_client := 3;
	task_gen_amount_per_project := 3;
	work_log_gen_amount_per_task := 20;
	work_log_range_back_days := 365;
	
	work_min_amount:=0.25;
	work_max_amount:=10;
	
	p_admin_privilege := true;

	-- insert users loop
	FOR i IN 1..user_gen_amount LOOP
	
		-- insert employee
		insert into pwl.employee (first_name, last_name, username, pw_hash,admin_privilege) values ( 'first name '||i, 'last name '||i, 'username'||i, '', p_admin_privilege);
		
		p_admin_privilege := false;
	END LOOP;
	
	FOREACH p_client_name IN ARRAY clients LOOP
		-- insert client
		insert into pwl.client(client_id, client_name) values (default, p_client_name) returning client_id into ret_client_id;
		
		-- insert projects loop
		FOR i IN 1..project_gen_amount_per_client LOOP
		
			-- insert project
			insert into pwl.project(project_id, client_id, project_name) values (default, ret_client_id, 'project '||i||'@'||p_client_name) returning project_id into ret_project_id;
			
			-- insert tasks loop
			FOR j IN 1..task_gen_amount_per_project LOOP
				
				-- insert task
				insert into pwl.task(project_id, task_name) VALUES (ret_project_id, 'task '||j||'/'||i||'/'||p_client_name);
				
			
			END LOOP;
		
		end loop;
		
	END LOOP;
	
	
	FOREACH p_task_id IN ARRAY (select array_agg(task_id) from pwl.task) LOOP
		FOR i IN 1..work_log_gen_amount_per_task LOOP
			-- get random employee
			select employee_id from pwl.employee offset floor(random()*user_gen_amount) LIMIT 1 into p_employee_id;
			
			p_work_date := date(now() - trunc(random()  * work_log_range_back_days) * '1 day'::interval);
			
			p_amount_hours = random()*(work_max_amount-work_min_amount)+work_min_amount;
			p_amount_hours = p_amount_hours-(p_amount_hours%work_min_amount);
			
			insert into pwl.work_entry(employee_id, task_id, amount_hours, work_date) 
				VALUES(p_employee_id, p_task_id, p_amount_hours, p_work_date);
			
			
		END LOOP;
	END LOOP;

END;
$$;