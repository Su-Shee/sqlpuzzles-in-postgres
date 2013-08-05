# security badges example 

table: security-badges-schema.sql
	psql -U postgres -d sqlpuzzles < $<

data: security-badges-data.sql
	psql -U postgres -d sqlpuzzles < $<

clean:
	psql -U postgres -d sqlpuzzles -c 'drop table employees cascade;'
	psql -U postgres -d sqlpuzzles -c 'drop table badges;'

test: t/*.sql
	pg_prove -U postgres -d sqlpuzzles $^ --verbose
