alter session set "_oracle_script"=true;  
create user triggersScott identified by triggersScott;
GRANT CONNECT, RESOURCE, DBA TO triggersScott;