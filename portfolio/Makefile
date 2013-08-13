# portfolio example 

table: portfolio-schema.sql
	psql -U postgres -d sqlpuzzles < $<

data: portfolio-data.sql
	psql -U postgres -d sqlpuzzles < $<

clean:
	psql -U postgres -d sqlpuzzles -c 'drop table portfolios cascade;'
	psql -U postgres -d sqlpuzzles -c 'drop table succession;'

test: t/*.sql
	pg_prove -U postgres -d sqlpuzzles $^ --verbose
