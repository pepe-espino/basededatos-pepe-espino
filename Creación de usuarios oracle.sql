alter session set "_oracle_script"=true;  
create user repasoExamen identified by repasoExamen;
GRANT CONNECT, RESOURCE, DBA TO repasoExamen;