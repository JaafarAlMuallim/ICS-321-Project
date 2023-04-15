require("dotenv").config();

// const client = require('@supabase/supabase-js');
// const supabaseUrl = process.env.SUPABASE_URL;

// const supabaseKey = process.env.SUPABASE_KEY;
// var supabase;
// function connect(){
//     supabase =  client.createClient(supabaseUrl, supabaseKey);
// }

// connect();

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

async function getAll(){
    const docSnap = await getDocs(collection(db, "Admins"));
    const phonenumber = '0540014988';
        var exists = false;
        docSnap.forEach((doc) => {
           console.log(doc.data().phone_num == phonenumber);
                
            })}

getAll();

