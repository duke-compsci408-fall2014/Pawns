exports.generalTournaments =
'SELECT tournament_group.group_name FROM tournament_group';

exports.groupedTournaments =
'SELECT te.id, tt.name, te.date_play, ts.city \
FROM tournament_events te \
INNER JOIN tournament_group tg ON tg.id=te.tournaments_id \
INNER JOIN tournament_sites ts ON te.sites_id=ts.id \
INNER JOIN tournament_tournaments tt ON tt.category_type_id=te.tournaments_id \
WHERE te.status=1 AND tg.id=%d AND te.date_play>NOW() \
ORDER BY te.date_play ASC \
LIMIT 0,100';

exports.specificTournament =
'SELECT te.id, te.date_play, te.start_time, te.end_time, \
    tt.discount, tt.amount, tt.discount, tg.name, ts.name, \
    ts.city, ts.address, ts.zip, ts.state \
    FROM tournament_events te \
    INNER JOIN tournament_tournaments tt ON tt.id=te.tournaments_id \
    INNER JOIN tournament_groups tg ON tg.event_id=tt.id \
    INNER JOIN tournament_sites ts ON te.sites_id=ts.id \
    WHERE te.date_play>NOW() AND te.id=%d \
    ORDER BY te.date_play ASC \
    LIMIT 0, 100';
