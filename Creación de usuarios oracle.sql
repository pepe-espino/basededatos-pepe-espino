ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER boletinTriggers IDENTIFIED BY boletinTriggers;
GRANT CONNECT, RESOURCE, DBA TO boletinTriggers;