const Tournament = require("../models/tournaments");
if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');
const supabaseUrl = process.env.SUPABASE_URL;

const supabaseKey = process.env.SUPABASE_KEY;
var supabase;
function connect(){
    supabase =  client.createClient('https://ovjfjgtuhzwbqzjlbzex.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im92amZqZ3R1aHp3YnF6amxiemV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODIxODM2NzEsImV4cCI6MTk5Nzc1OTY3MX0.avFViqQymYP_5DwOzpmrkouqCZ9-mke3vhfeiZhc9Ak');
}

connect();

const { initializeApp } = require("firebase/app");
const { getFirestore, collection, doc, getDoc, setDoc, getDocs } = require( "firebase/firestore");
const {getAuth, signInWithPhoneNumber, RecaptchaVerifier} = require('firebase/auth');



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

// async function writeAdmins(){
//     // Add a new document in collection "cities"
//     const addedDocRef = await addDoc(collection(db, 'Admins'), {
//         admin_id: 1,
//         admin_fname: 'Ahmed',
//         admin_lname: 'Alghamdi',
//         phone_num: '0555555555'
//     });
//     console.log(addedDocRef);
// }

async function getAllFire(){
    const docSnap = await getDocs(collection(db, "Admins"));
    const phonenumber = '0540014988';
        var exists = false;
        docSnap.forEach((doc) => {
           console.log(doc.data().phone_num == phonenumber);
                
            })}
async function getAllSupa(){
    // const { data:counter, errorCounter, status } = await supabase
	// .from("admin")
	// .select("*") 
    

    // get all data from penalty shootout
    // const {data: penalties, error} = await supabase
    // .from('penalty_shootout')
    // .select(`*`);

    // const {data: penalty, penaltyError} = await supabase.from('penalty_shootout').insert({}).select();
    // console.log(penalties);
    // console.log(penalty);
    // console.log(penaltyError);

};

getAllSupa();

