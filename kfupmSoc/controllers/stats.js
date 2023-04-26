if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');
const supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);


module.exports.index = async (req, res)  =>  {
    const {data: mvps} = await supabase.rpc('count_mvps');
    const {data: goals} = await supabase.rpc('count_goals');
    const {data: cards} = await supabase.rpc('get_cards');
    res.render("stats/index", {mvps, goals, cards});
}