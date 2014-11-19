exports.baseQuery =
'SELECT * FROM `tournament_events` te \
    INNER JOIN tournament_tournaments tt \
ON te.`tournaments_id` = tt.id \
INNER JOIN membership_categorytype \
WHERE tt.category_type_id = 2 \
AND te.date_play > NOW() ORDER BY `te`.`date_play`  ASC \
limit 0, 100';

exports.queryString =
'SELECT tournament_events.date_play, \
    tournament_events.start_time, \
    tournament_events.end_time, \
    tournament_events.round_times, \
    tournament_sites.name, \
    tournament_sites.description, \
    tournament_sites.address, \
    tournament_sites.city, \
    tournament_sites.state, \
    tournament_sites.zip, \
    tournament_sections.name, \
    tournament_sections.rating_min, \
    tournament_sections.rating_max, \
    tournament_sections.grade_min, \
    tournament_sections.grade_max, \
    tournament_sections.rounds, \
    tournament_sections.prizes, \
    tournament_sections.prize_team \
FROM \
    tournament_sites \
INNER JOIN tournament_events ON tournament_events.sites_id=tournament_sites.id \
INNER JOIN tournament_sections ON tournament_sections.id=tournament_events.sections_id \
WHERE tournament_events.id=';
