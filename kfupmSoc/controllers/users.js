if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}

module.exports.newUser = (req, res) => {
    res.render("users/register");
}

const client = require('@supabase/supabase-js');
const supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);


module.exports.register = async (req, res) => {
        const { fname, lname, phonenumber, otp } = req.body;
        const { session, error } = await supabase.auth.verifyOtp({
            phone: phonenumber,
            token: otp,
            type: 'sms',
          })
        if (error) {
            console.log(error.message);
            req.flash("error", e.message);
            res.redirect("/register");
        } else {
            const { data, errorCount } = await supabase
            .from('admin')
            .select()
            const count = data.length;
            var phoneNum;
            if(phonenumber.charAt(0) == '+'){
                phoneNum = '0'+phonenumber.slice(4);
            } else {
                phoneNum = '0'+phonenumber.slice(3);
            }
            const { errorInsertion } = await supabase
            .from('admin')
            .insert({ admin_id: count+1, admin_fname: fname, admin_lname: lname, phone_num: phoneNum });
            if (errorInsertion) {
                console.log(errorInsertion.message);
                req.flash("error", errorInsertion.message);
                res.redirect("/register");
            } else {
                req.flash("success", "Verified! Welcome to KFUPMSOC"); 
                res.redirect("/tournaments");
            }
        }
}

module.exports.renderLogin = (req, res) => {
    res.render("users/login");
}

module.exports.userLogin = async(req, res) => {
    const { phonenumber, otp } = req.body;
    const { session, error } = await supabase.auth.verifyOtp({
        phone: phonenumber,
        token: otp,
        type: 'sms',
      })
    if (error) {
        console.log(error.message);
        req.flash("error", e.message);
        res.redirect("/login");
    } else {
        req.login(user, err => {
            if (err) return next(err);
            req.flash("success", "Welcome Back!");
            const url = req.session.returnTo || "/tournaments";
            delete req.session.returnTo;;
            res.redirect(url);
        });
    }
}
module.exports.logout = async(req, res) => {
    const { error } = await supabase.auth.signOut();
    req.logout((err) => {
        if (err) { return next(err); }
        req.flash("success", "See You Next Time");
        res.redirect('/tournaments');
    });
}

module.exports.verifyPhone = async(req, res) => {
    const {phoneNum} =  req.body;
    const { user, error } = await supabase.auth.signInWithOtp({
        phone: phoneNum,
    });
    if (error) {
        console.log(error.message);
        req.flash("error", e.message);
        res.redirect("/register");
    } else {
        req.login(user, err => {
            if (err){
                console.log(err.message);
            } else {
                req.flash("success", "Verified! Welcome to KFUPMSOC");
            }
            
        });
    }
}
// module.exports.verifyRegPhone = async(req, res) => {
//     const admin = req.body;
//     const { data, error } = await supabase
//     .from('admin')
//     .select('count(*)');
//     console.log(data);
//     // const count = data[0].count;
//     var phoneNum;
//     if(admin.phonenumber.charAt(0) == '+'){
//          phoneNum = '0' + admin.phonenumber.slice(4)
//     } else {
//         phoneNum = '0' + admin.phonenumber.slice(3)
//     }
//     console.log(phoneNum);
//     const { data: newUser, errorInesrt } = await supabase
//         .from('admin')
//         .insert([
//             { admin_id: count+1, admin_fname: admin.fname, admin_lname: admin.lname, phone_num: phoneNum, verified: false},
//         ]);

//     // const { user, errorVerification } = await supabase.auth.signInWithOtp({
//     //     phone: admin.phonenumber,
//     // });
//     // if(errorVerification){
//     //     req.flash("error", errorVerification.message);
//     //     res.redirect('/register');
        
//     // const { errorDelete } = await supabase
//     //     .from('countries')
//     //     .delete()
//     //     .eq('phone_num', admin.phonenumber)
//     // }else {
//         req.flash("success", "Verified!, check your phone for OTP message");
//         res.redirect('/reg-auth');
//     // }
// }