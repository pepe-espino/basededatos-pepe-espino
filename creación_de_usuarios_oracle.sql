alter session set "_oracle_script"=true;  
create user boletin1_recuperacion identified by boletin1_recuperacion;
GRANT CONNECT, RESOURCE, DBA TO boletin1_recuperacion;