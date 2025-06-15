alter session set "_oracle_script"=true;  
create user repasoGPT identified by repasoGPT;
GRANT CONNECT, RESOURCE, DBA TO repasoGPT;