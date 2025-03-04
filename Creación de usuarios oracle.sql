alter session set "_oracle_script"=true;  
create user UNIVERSIDAD identified by UNIVERSIDAD;
GRANT CONNECT, RESOURCE, DBA TO UNIVERSIDAD;