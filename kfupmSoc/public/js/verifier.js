// initialize firebase
const regButton = document.querySelector("#verifyReg")
const logButton = document.querySelector("#verifyLog");
const otpDiv = document.querySelector("#otpDiv");
const regForm = document.querySelector("#first");
const logForm = document.querySelector("#second");
const regSubmit = document.querySelector('#regSubmit')
const logSubmit = document.querySelector('#logSubmit')
var confirmRes;

import {initializeApp} from 'https://www.gstatic.com/firebasejs/9.19.1/firebase-app.js'
import {getAuth, RecaptchaVerifier, signInWithPhoneNumber} from 'https://www.gstatic.com/firebasejs/9.19.1/firebase-auth.js'
const firebaseConfig = {
  apiKey: "AIzaSyDtydeOBhnvL6v2WfcoAx4c0wvnq8wTYr4",
  authDomain: "ics-321-project-49853.firebaseapp.com",
  projectId: "ics-321-project-49853",
  storageBucket: "ics-321-project-49853.appspot.com",
  messagingSenderId: "247856903398",
  appId: "1:247856903398:web:9ba7d102ba45bccd36f727"
};        
const firebase = initializeApp(firebaseConfig);

const auth = getAuth(firebase);
auth.languageCode = 'en';
if(regButton != null){


regButton.addEventListener('click', function() {
  const forms = document.querySelector('.validated-form');
  const fname = document.querySelector('#fname');
  const lname = document.querySelector('#lname');
  const phonenumber = document.querySelector('#phonenumber');
  if(fname.value != '' && lname.value != '' && phonenumber.value != ''){
      forms.classList.add('was-validated');
    } else {
      alert('Fill all required fields');
      return;
    }
    
    regButton.disabled = true;
  otpDiv.removeAttribute("hidden");
  regButton.textContent = 'Resend OTP'
  setTimeout(function() {
    regSubmit.disabled = false;
    regButton.disabled = false;
  }, 5000); 
  window.recaptchaVerifier = new RecaptchaVerifier('recaptcha-container', 
  {'size':'invisible', 
  'callback': (response) => {
  },
  'expired-callback': () => {
    alert('Expirted')
    window.recaptchaVerifier.render();
  }
  }, auth);
  window.recaptchaVerifier.render();
  const appVerifier = window.recaptchaVerifier;
  signInWithPhoneNumber(auth, phonenumber.value, appVerifier)
    .then((confirmationResult) => {
      window.confirmationResult = confirmationResult;
      confirmRes = confirmationResult;
    }).catch((error) => {
      grecaptcha.reset(window.recaptchaWidgetId);
    // Or, if you haven't stored the widget ID:
    window.recaptchaVerifier.render()
  });
});

}
if(logButton!= null){

  logButton.addEventListener('click', function() {
    const forms = document.querySelector('.validated-form');
    const phonenumber = document.querySelector('#phonenumber');
    if(phonenumber.value != ''){
      forms.classList.add('was-validated');
    } else {
      alert('Fill all required fields');
      return;
    }
    logButton.disabled = true;
    otpDiv.removeAttribute("hidden");
    logButton.textContent = 'Resend OTP';
    setTimeout(function() {
      logSubmit.disabled = false;
      logButton.disabled = false;
    }, 5000); 
    window.recaptchaVerifier = new RecaptchaVerifier('recaptcha-container', 
    {'size':'invisible', 
    'callback': (response) => {
    },
    'expired-callback': () => {
      alert('Expirted')
      window.recaptchaVerifier.render();
    }
  }, auth);
  window.recaptchaVerifier.render();
  const appVerifier = window.recaptchaVerifier;
  signInWithPhoneNumber(auth, phonenumber.value, appVerifier)
  .then((confirmationResult) => {
    window.confirmationResult = confirmationResult;
    confirmRes = confirmationResult;
  }).catch((error) => {
    grecaptcha.reset(window.recaptchaWidgetId);
    window.recaptchaVerifier.render()
  });
});
}
if(regSubmit != null){

  regSubmit.addEventListener('click', function(e){
    const otp = document.querySelector('#otp');
    e.preventDefault();
    confirmRes.confirm(otp.value).then((result) => {
      const user = result.user;
      regForm.submit();
    }).catch((error) => {
    });
  })
}
if(logSubmit != null){

  logSubmit.addEventListener('click', function(e){
    const otp = document.querySelector('#otp');
    e.preventDefault();
    confirmRes.confirm(otp.value).then((result) => {
      const user = result.user;
      logForm.submit();
    }).catch((error) => {
    });
  })
} 
function ValidityState() {

  'use strict'
  
  
  // Fetch all the forms we want to apply custom Bootstrap validation styles to
  const forms = document.querySelectorAll('.validated-form')
  
  // Loop over them and prevent submission
  Array.from(forms).forEach(form => {
    form.addEventListener('submit', (event) => {
      if (!form.checkValidity()) {
        event.preventDefault()
        event.stopPropagation()
      }
      
      form.classList.add('was-validated')
    }, false)
  })
}

