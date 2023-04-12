class Tournament {
    constructor(tr_id, tr_name, start_date, end_date, adminstrator){
        this.tr_id = tr_id;
        this.tr_name = tr_name;
        this.start_date = start_date;
        this.end_date = end_date;
        this.adminstrator = adminstrator;
    }
    get tr_id(){
        return this.tr_id;
    }
    get tr_name(){
        return this.tr_name;
    }
    get start_date(){
        return this.start_date;
    }
    get end_date(){
        return this.end_date;
    }
    get adminstrator(){
        return this.adminstrator;
    }       
}