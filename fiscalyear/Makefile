# fiscal year example 

table: fiscal-year-schema.sql
	psql -U postgres -d sqlpuzzles < $<

data: fiscal-year-insert-data.sql
	psql -U postgres -d sqlpuzzles -c $<

clean:
	psql -U postgres -d sqlpuzzles -c 'drop table fiscalyear;'

test: t/*.sql
	pg_prove -U postgres -d sqlpuzzles $^ --verbose
