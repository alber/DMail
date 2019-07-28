UPDATE messages SET is_sent=0,is_received=0,jump=0;
DELETE FROM messages WHERE final_destination_id=1;
