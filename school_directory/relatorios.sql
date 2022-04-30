-- base de dados academicas:

--gerar um relatorio com todos os departamentos, professores,
--turmas e media das notas dos alunos em cada turma de 2006 a 2010



select * from department d 

select * from instructor i 

select * from course c where course_id = '604'

select * from "section" s where course_id = '237'

select * from teaches t 
select * from student s 

select * from takes t 



select c.dept_name, c.title, num_to_letter_grade(trunc(AVG(
    CASE t.grade
        WHEN 'A+' THEN 97
        WHEN 'A' THEN 95
        WHEN 'A-' THEN 92
        WHEN 'B+' THEN 87
        WHEN 'B' THEN 85
        WHEN 'B-' THEN 82
        WHEN 'C+' THEN 77
        WHEN 'C' THEN 75
        WHEN 'C-' THEN 72
        WHEN 'D+' THEN 67
        WHEN 'D' THEN 65
        WHEN 'D-' THEN 62
        WHEN 'F' THEN 50
    END
), 0)) as average_grade, t.semester, t."year", i."name" as instructor_name from course c 
join instructor i on i.dept_name = c.dept_name 
join teaches tc on tc.course_id = c.course_id 
join student s on s.dept_name = c.dept_name 
join takes t on c.course_id = t.course_id 
where t."year"::int  >= 2006 and t."year"::int <= 2010 
group by c.course_id, t.semester, i."name", t."year", c.dept_name 

--drop function num_to_letter_grade

create function num_to_letter_grade(int_year numeric)
returns varchar(2) as $$

begin
    if(int_year >= 97) then
    	return 'A+'; 
    elsif(int_year >= 95) then
   		return 'A';
    elsif(int_year >= 92) then
    	return 'A-';
   	elsif(int_year >= 87) then
    	return 'B+';
 	elsif(int_year >= 85) then
    	return 'B';  
    elsif(int_year >= 82) then 
    	return 'B-'; 
    elsif(int_year >= 77) then
    	return 'C+';  
    elsif(int_year >= 75) then
    	return 'C';  
    elsif(int_year >= 72) then
    	return 'C-';  
    elsif(int_year >= 67) then 
    	return 'D+';  
    elsif(int_year >= 65) then
    	return 'D'; 
    elsif(int_year >= 62) then
    	return 'D-';
    else
    	return 'F';
    end if;
    
end;

$$ language plpgsql;


--gerar relatorio com nome do aluno, disciplinas cursadas com 
--respectivos professores das turmas e notas e respectivo departamento dos professores

select * from student s 
select * from instructor i 
select * from teaches t 
select * from takes t

select distinct(s."name") as student, c.title, t.grade, t.semester, t."year", i.dept_name, i."name" as instructor 
from course c 
 join instructor i using(dept_name) 
 join teaches tc using(course_id)
 join student s using(dept_name)
 join takes t using(course_id) 
where t."year"::int  = 2010
group by s."name" , c.title, t.grade, t.semester, t."year", i.dept_name , i."name" 

--tentativa
select distinct(s."name") as student, c.title, t.grade, t."year"
from course c  
join takes t  using(course_id)
join student s using(dept_name)
where t."year"::int  = 2010

--tentativa
select i."name" as instructor, i.dept_name from course c 
join instructor i using(dept_name) 
join teaches tc using(course_id)


