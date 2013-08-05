# overlaps example 

table: overlaps-schema.sql
	psql -U postgres -d sqlpuzzles < $<

data: overlaps-data.sql
	psql -U postgres -d sqlpuzzles < $<

clean:
	psql -U postgres -d sqlpuzzles -c 'drop table overlapping cascade;'

test: t/*.sql
	pg_prove -U postgres -d sqlpuzzles $^ --verbose
