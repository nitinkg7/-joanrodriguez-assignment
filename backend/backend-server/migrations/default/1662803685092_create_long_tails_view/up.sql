CREATE VIEW long_tails AS
SELECT type as tail, details->>'id' as json_id FROM "tails";
