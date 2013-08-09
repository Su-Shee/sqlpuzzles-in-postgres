# hotel reservations example 

table: hotel-reservation-schema.sql
	psql -U postgres -d sqlpuzzles < $<

clean:
	psql -U postgres -d sqlpuzzles -c 'drop table hotel;'

test: t/*.sql
	pg_prove -U postgres -d sqlpuzzles $^ --verbose
