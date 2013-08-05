# absentees example 

table: absentees-schema.sql
	psql -U postgres -d sqlpuzzles < $<

data: absentees-data-insert.sql
	psql -U postgres -d sqlpuzzles < $<

clean:
	psql -U postgres -d sqlpuzzles -c 'drop table absence;'
	psql -U postgres -d sqlpuzzles -c 'drop table personell;'

test: t/*.sql
	pg_prove -U postgres -d sqlpuzzles $^ --verbose
