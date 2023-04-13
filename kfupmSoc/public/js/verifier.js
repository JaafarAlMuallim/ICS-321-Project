const button = document.querySelector(".verifier");
button.onclick = function(){
    button.disabled = true;
    const toSubmit = document.getElementById("submit")
    toSubmit.disabled = false;
    setTimeout(function() {
        button.disabled = false;
      }, 5000); 
    const http = new XMLHttpRequest();
    http.open("POST", "/auth", true)
    xhr.setRequestHeader('Content-Type', 'application/json');
    const data = {
        phoneNum: document.getElementById("phonenumber").value
    }
    const jsonData = JSON.stringify(data);
    xhr.onreadystatechange = function() {
        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
          const response = JSON.parse(this.responseText);
          console.log(response);
        } else {
            console.log('Something went wrong!');
        }
      };
      xhr.send(jsonData);
    // const phoneNum = document.getElementById("phonenumber").value;
    // http.send(jsonData);
    // http.onload = function(){
    //     alert(http.responseText);
    // }
}