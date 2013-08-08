# allow only characters example 

table: characters-only-schema.sql
	psql -U postgres -d sqlpuzzles < $<

clean:
	psql -U postgres -d sqlpuzzles -c 'drop table sometext;'

test: t/*.sql
	pg_prove -U postgres -d sqlpuzzles $^ --verbose
