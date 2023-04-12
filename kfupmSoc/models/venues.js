class Venue {
    constructor(venue_id, venue_name, venue_status, aud_capacity){
        this.venue_id = venue_id;
        this.venue_name = venue_name;
        this.venue_status = venue_status;
        this.aud_capacity = aud_capacity;
    }
}

// venue_id numeric NOT NULL,
// venue_name varchar(30) NOT NULL, 
// venue_status char(1) NOT NULL, 
// aud_capacity numeric NOT NULL,