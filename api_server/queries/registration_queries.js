exports.register = 'INSERT INTO tournament_registration_info (user_id, total_fee, \
                    discount, net_pay, reg_date, notes, payment_status) \
                    VALUES (%d, %d, %d, %d, \
                    NOW(), %d, %s, %s)';


