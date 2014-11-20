exports.register = 'INSERT INTO tournament_registration_info (user_id, total_fee, \
                    discount, net_pay, reg_date, invoice_id, notes, payment_status) \
                    VALUES (%d, %d, %d, %d, \
                    NOW(), %s, %s, %s)';

exports.getUserData = 'SELECT auth_user.id uid, tournament_tournaments.amount,\
tournament_tournaments.discount FROM  auth_user, tournament_tournaments WHERE \
tournament_tournaments.id=%d AND auth_user.username=%s';
