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
                req.session.user = {
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

                req.session.user = {
                    admin_id: docRef.data().admin_id,
                    admin_fname: docRef.data().admin_fname,
                    admin_lname: docRef.data().admin_lname,
                    phoneNum: docRef.data().phone_num
                }
                req.flash("success", "Verified!, Welcome to KFUPMSOC");
                if(req.session.returnTo)
                    res.redirect(req.session.returnTo);
                else
                res.redirect('/tournaments');
            }
        } 
    

module.exports.logout = async(req, res) => {
        await auth.signOut();
        delete req.session.returnTo;
        delete req.session.user;
        req.flash("success", "See You Next Time");
        res.redirect('/login');
    }
