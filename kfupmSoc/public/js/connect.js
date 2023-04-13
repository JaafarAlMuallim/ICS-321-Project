module.exports.connect = ()=> {
if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');


const supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);
}