const button = document.querySelector("#verify");
const otpDiv = document.querySelector("#otpDiv");

button.addEventListener('click', function(){
  button.disabled = true;
  otpDiv.removeAttribute("hidden");
    const toSubmit = document.getElementById("submit")
    toSubmit.disabled = false;
    setTimeout(function() {
        button.disabled = false;
      }, 5000); 
    const http = new XMLHttpRequest();
    http.open("POST", "/auth", true)
    http.setRequestHeader('Content-Type', 'application/json');
    const data = {
        fname: document.getElementById("fname").value,
        lname: document.getElementById("lname").value,
        phoneNum: document.getElementById("phonenumber").value

    }
    const jsonData = JSON.stringify(data);
    http.onreadystatechange = function() {
        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
          const response = JSON.parse(this.responseText);
          console.log(response);
        } else {
            console.log('Something went wrong!');
        }
      };
      http.send(jsonData);
});
