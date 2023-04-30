const droppables = document.querySelectorAll('.droppable');
const draggables = document.querySelectorAll('.draggable');
const body = document.querySelector('.body');
const transitionTime = 500;
let dragging;
let cloned;
body.style.setProperty('--transitionTime', transitionTime + 'ms');

function cleanClass(className) {
  const elements = document.querySelectorAll(`.${className}`);
  for (const el of elements) {
    el.classList.remove(className);
  }
}

// drag start
document.addEventListener('dragstart', e => {
  if (e.target.classList.contains('draggable')) {
    dragging = e.target;
    dragging.classList.add('dragging');
    cloned = dragging.cloneNode(true);
  }
});

function handleDragEnd() {
  if (!dragging) return;
  dragging.classList.add('will-remove');
  setTimeout(() => {
    dragging.remove();
    cleanClass('dragging');
  }, [transitionTime]);
}

// drag end
document.addEventListener('dragend', e => {
  cleanClass('dragging');
  cleanClass('new-added');
});

// drag over
droppables.forEach(droppable => {
  droppable.addEventListener('dragover', e => {
    e.preventDefault();
    const frontSib = getClosestFrontSibling(droppable, e.clientY);
    const previousSib = dragging.previousElementSibling;
    if (frontSib) {
      if (
        frontSib.nextElementSibling === cloned ||
        frontSib === cloned ||
        frontSib === previousSib
      ) {
        return;
      }
      cloned.classList.add('new-added');
      frontSib.insertAdjacentElement('afterend', cloned);
      handleDragEnd(dragging);
    } else {
      if (
        droppable.firstChild === cloned ||
        droppable.firstChild === dragging
      ) {
        return;
      }
      if (dragging.parentNode === droppable && !previousSib) {
        return;
      }
      cloned.classList.add('new-added');
      droppable.prepend(cloned);
      handleDragEnd(dragging);
    }
  });
});

function getClosestFrontSibling(droppable, draggingY) {
  const siblings = droppable.querySelectorAll('.draggable:not(.dragging)');
  let result;

  for (const sibling of siblings) {
    const box = sibling.getBoundingClientRect();
    const boxCenterY = box.y + box.height / 2;
    if (draggingY >= boxCenterY) {
      result = sibling;
    } else {
      return result;
    }
  }

  return result;
}
const submitButton = document.querySelector("#submitbtn");
const allTeams = document.querySelector("#teams")
const groupA = document.querySelector("#A");
const groupB = document.querySelector("#B");
const groupC = document.querySelector("#C");
const groupD = document.querySelector("#D");
submitButton.onclick = function(){
    const teamsA = groupA.children;
    const teamsB = groupB.children;
    const teamsC = groupC.children;
    const teamsD = groupD.children;

    const arrayA = []
    for(let element of teamsA){
        arrayA.push(element.textContent.trim());
    }

    const arrayB = []
    for(let element of teamsB){
        arrayB.push(element.textContent.trim());
    }

    const arrayC = []
    for(let element of teamsC){
        arrayC.push(element.textContent.trim());
    }

    const arrayD = []
    for(let element of teamsD){
        arrayD.push(element.textContent.trim());
    }
    const url = document.URL.split('/');
    const id = url[url.length - 2];
    const xhr = new XMLHttpRequest();
    const body = JSON.stringify({
        arrayA, 
        arrayB,
        arrayC,
        arrayD
      });
      console.log(body);
      
      fetch(`/tournaments/${id}/groups`, {
        method: 'POST',
        body: body,
        headers: {
          'Content-Type': 'application/json'
        }
      })
      // .then(response => response.json())
      // .then(data => console.log(data))
      // .catch(error => console.error(error));
// xhr.onreadystatechange = function() {
//   if (xhr.readyState === XMLHttpRequest.DONE) {
//     if (xhr.status === 200) {
//       const responseData = JSON.parse(xhr.responseText);
//       // Handle the response data
//     } else {
//       console.log('Error:', xhr.status);
//     }
//   }
// };
// xhr.open("POST", `/tournaments/${id}/groups`);
// xhr.setRequestHeader("Content-Type", "application/json;") 
// xhr.send(JSON.stringify(body));
}