if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}

module.exports.newUser = (req, res) => {
    res.render("users/register");
}

const client = require('@supabase/supabase-js');
const supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);

const { initializeApp } = require("firebase/app");
const { getFirestore, collection, doc, getDoc, setDoc, getDocs } = require( "firebase/firestore");
const {getAuth, signInWithPhoneNumber, RecaptchaVerifier} = require('firebase/auth');
const {firestoreAutoId} = require('../public/js/generateID.js');


const firebaseConfig = {
    apiKey: "AIzaSyDtydeOBhnvL6v2WfcoAx4c0wvnq8wTYr4",
    authDomain: "ics-321-project-49853.firebaseapp.com",
    projectId: "ics-321-project-49853",
    storageBucket: "ics-321-project-49853.appspot.com",
    messagingSenderId: "247856903398",
    appId: "1:247856903398:web:9ba7d102ba45bccd36f727"
};

const firebaseApp = initializeApp(firebaseConfig);
const db = getFirestore(firebaseApp);
const auth = getAuth();
auth.useDeviceLanguage();




module.exports.register = async (req, res) => {
        var phoneNum;
        const { fname, lname, phonenumber } = req.body;
        const docSnap = await getDocs(collection(db, "Admins"));
        if(phonenumber.charAt(0) == '+'){
            phoneNum = '0'+phonenumber.slice(4);
        } else {
            phoneNum = '0'+phonenumber.slice(3);
        }
        await setDoc(doc(db, 'Admins', firestoreAutoId()), {
            admin_id : docSnap.size + 1,
            admin_fname: fname,
            admin_lname: lname,
            phoneNum: phoneNum || phonenumber,
        })
            const { errorInsertion } = await supabase
            .from('admin')
            .insert({ admin_id: docSnap.size+1, admin_fname: fname, admin_lname: lname, phone_num: phoneNum || phonenumber });
            
            if (errorInsertion) {
                console.log(errorInsertion.message);
                req.flash("error", errorInsertion.message);
                res.redirect("/register");
            } else {
                req.session.currentUser = {
                    admin_id: docSnap.size+1,
                    admin_fname: fname,
                    admin_lname: lname,
                    phoneNum: phoneNum || phonenumber,
                }
   
                req.flash("success", "Verified!, Welcome to KFUPMSOC");
                res.redirect('/tournaments');
            } 
        } 

module.exports.renderLogin = (req, res) => {
    res.render("users/login");
}

module.exports.userLogin = async(req, res) => {
    var phoneNum;
    const { phonenumber, otp } = req.body;
    const docSnap = await getDocs(collection(db, "Admins"));
    if(phonenumber.charAt(0) == '+'){
        phoneNum = '0'+phonenumber.slice(4);
    } else {
        phoneNum = '0'+phonenumber.slice(3);
    }
        var exists = false;
        var docRef = null
        docSnap.forEach((doc) => {
            if(doc.data().phone_num == phoneNum){
                exists = true;
                docRef = doc;
            }
        })
            if(!exists){
                req.flash("error", "You have to register first!");
                res.redirect('/register');
            } else {

                req.session.currentUser = {
                    admin_id: docRef.data().admin_id,
                    admin_fname: docRef.data().admin_fname,
                    admin_lname: docRef.data().admin_lname,
                    phoneNum: docRef.data().phone_num
                }
                req.flash("success", "Verified!, Welcome to KFUPMSOC");
                res.redirect('/tournaments');
            }
        } 
    

module.exports.logout = async(req, res) => {
        await auth.signOut();
        delete req.session.returnTo;
        delete req.session.currentUser;
        req.flash("success", "See You Next Time");
        res.redirect('/login');
    }

module.exports.verifyPhone = async(req, res) => {
    console.log('Called');
    const {phonenumber} = req.body.phonenumber;
    console.log(req.body);
    // window.recaptchaVerifier = new RecaptchaVerifier('verify', {
    //     'size': 'invisible',
    //     'callback': (response) => {
    //         console.log('XXX');
    //     }
    //   }, auth);
    //   const appVerifier = window.recaptchaVerifier;
//     recaptchaVerifier.render().then((widgetId) => {
//         window.recaptchaWidgetId = widgetId;
//         widget = widgetId;
//       });
//     const recaptchaResponse = grecaptcha.getResponse(widget);
//     const appVerifier = window.recaptchaVerifier;
//     signInWithPhoneNumber(auth, phoneNumber, appVerifier)
//     .then((confirmationResult) => { 
//         window.confirmationResult = confirmationResult;
//         confirmRes = confirmationResult
//         console.log(phoneNumber);
//     }).catch((error) => {
//         console.log(error.message);
//         grecaptcha.reset(window.recaptchaWidgetId);
//         window.recaptchaVerifier.render().then(function(widgetId) {
//         grecaptcha.reset(widgetId);
// });
//         });
    }

    // const {phoneNum} =  req.body;
    // const { user, error } = await supabase.auth.signInWithOtp({
    //     phone: phoneNum,
    // });
    // if (error) {
    //     console.log(error.message);
    //     req.flash("error", e.message);
    //     res.redirect("/register");
    // } else {
    //     req.login(user, err => {
    //         if (err){
    //             console.log(err.message);
    //         } else {
    //             req.flash("success", "Verified! Welcome to KFUPMSOC");
    //         }
            
    //     });
    // }

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