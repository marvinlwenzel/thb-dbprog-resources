## Gesprächsnotizen, nichts lauffähiges!

BEGIN
	SET new.Land = (
	    SELECT l.Name FROM rennen r, land l, rennstrecke rs
		WHERE r.StreckenID = rs.StreckenID
        AND rs.LandID = l.LandID
    	AND Jahr = '2013');
END

## Fehlermeldung dass ein subquery mehr als eine row returnt



BEGIN
	SET new.Land = (
		SELECT DISTINCT l.Name FROM rennen r, land l, rennstrecke rs
		WHERE r.StreckenID = rs.StreckenID
		AND rs.LandID = l.LandID
		AND new.StreckenID = r.StreckenID);
END


BEGIN
	SET new.Land = (
		SELECT l.Name FROM rennen r, land l, rennstrecke rs
		WHERE r.StreckenID = rs.StreckenID
		AND rs.LandID = l.LandID
		AND new.StreckenID = r.StreckenID);
END