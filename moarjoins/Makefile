# moarjoins example 

table: 01-moarjoins-schema.sql 02-moarjoins-schema.sql
	psql -U postgres -d sqlpuzzles < 01-moarjoins-schema.sql
	psql -U postgres -d sqlpuzzles < 02-moarjoins-schema.sql

data: 01-moarjoins-data-insert.sql 02-moarjoins-data-insert.sql
	psql -U postgres -d sqlpuzzles < 01-moarjoins-data-insert.sql
	psql -U postgres -d sqlpuzzles < 02-moarjoins-data-insert.sql

clean:
	psql -U postgres -d sqlpuzzles -c 'drop table classes cascade;'
	psql -U postgres -d sqlpuzzles -c 'drop table exams cascade;'
	psql -U postgres -d sqlpuzzles -c 'drop table subjects cascade;'
	psql -U postgres -d sqlpuzzles -c 'drop table students cascade;'
	psql -U postgres -d sqlpuzzles -c 'drop table employees;'
	psql -U postgres -d sqlpuzzles -c 'drop table departments cascade;'


test: t/*.sql
	pg_prove -U postgres -d sqlpuzzles $^ --verbose
