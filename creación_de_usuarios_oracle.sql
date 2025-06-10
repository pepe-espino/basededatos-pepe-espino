alter session set "_oracle_script"=true;  
create user caballos_recuperacion identified by caballos_recuperacion;
GRANT CONNECT, RESOURCE, DBA TO caballos_recuperacion;