require("dotenv").config();

const client = require('@supabase/supabase-js');
const supabaseUrl = process.env.SUPABASE_URL;
console.log(supabaseUrl);

const supabaseKey = process.env.SUPABASE_KEY;
var supabase;
function connect(){
    supabase =  client.createClient(supabaseUrl, supabaseKey);
}

connect();

async function writeAdmins(){
    const {data, error} = await supabase
    .from('admin')
    .insert({admin_id: 2, admin_fname: 'xx', admin_lname: 'yy', phone_num:'0540000000'});
    console.log(data, error);
}

writeAdmins();

