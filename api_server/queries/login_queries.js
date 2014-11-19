exports.userViewQuery = 'SELECT auth_user.username, auth_user.first_name, auth_user.last_name, \
                        auth_user.email, auth_user.password, auth_user.date_joined, \
                        player_accounts_playerprofile.uscf_id, player_accounts_playerprofile.main_phone, \
                        player_accounts_playerprofile.address, player_accounts_playerprofile.city, player_accounts_playerprofile.state \
                    FROM auth_user \
                    INNER JOIN player_accounts_playerprofile ON auth_user.id=player_accounts_playerprofile .user_id \
                    WHERE auth_user.username=';

exports.insertQuery = 'INSERT INTO auth_user (username, first_name, \
                    last_name, email, password, is_staff, is_active, \
                    is_superuser, last_login, date_joined) \
                    VALUES (%s, %s, %s, %s, \
                    %s, %d, %d, %d, NOW(), NOW())';

exports.insertQueryTwo = 'INSERT INTO player_accounts_playerprofile \
                    (username, user_id) VALUES (%s, %d)';
