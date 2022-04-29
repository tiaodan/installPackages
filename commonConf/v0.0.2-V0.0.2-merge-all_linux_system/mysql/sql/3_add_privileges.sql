grant all privileges on *.* to 'root'@'%' identified by 'sunkaisens';
grant all privileges on *.* to 'root'@'127.0.0.1' identified by 'sunkaisens';
grant all privileges on *.* to 'root'@'localhost' identified by 'sunkaisens';

grant all privileges on *.* to 'provision'@'%' identified by 'smg123';
grant all privileges on *.* to 'provision'@'127.0.0.1' identified by 'smg123';
grant all privileges on *.* to 'provision'@'localhost' identified by 'smg123';

flush privileges;
