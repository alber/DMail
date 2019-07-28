DELETE FROM messages WHERE final_destination_id=3;
UPDATE messages SET is_received=0,is_sent=0,jump=0;
