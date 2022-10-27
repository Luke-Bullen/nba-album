import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quiz"
export default class extends Controller {
  static targets = ["button", "message"]

  static values = {
      correct: String,
  }


  connect() {
      console.log("connect");
  }

  checkResult(event) {
      event.preventDefault();
      const button = this.buttonTarget
      console.log(button);
      if (this.correctValue == "correct") {
          button.style.backgroundColor = "#3e753b"; //green
          // button.style.backgroundColor = "#007A33";
          const quizResultMessage = document.getElementById("quiz-result-message");
          quizResultMessage.innerText = "Congratulations! You won a new pack of 5 cards!";
          quizResultMessage.style.backgroundColor = "rgba(62, 117, 59, 0.7)"; //green
          // quizResultMessage.style.backgroundColor = "#AA76D8";
          // quizResultMessage.style.opacity = 0.7;
          quizResultMessage.style.display = "block";
          const quizOpenPack = document.getElementById("quiz-open-pack").style.display = "block";
      } else {
          button.style.backgroundColor = "#C8102E"; //$red
          // button.style.backgroundColor = "#C8102E";
          const quizResultMessage = document.getElementById("quiz-result-message");
          quizResultMessage.innerText = "Sooooo cloze!!! Best luck next time";
          quizResultMessage.style.backgroundColor = "rgba(200, 16, 46, 0.7)"; //$red
          // quizResultMessage.style.backgroundColor = "#AA76D8";
          // quizResultMessage.style.opacity = 0.7;
          quizResultMessage.style.display = "block";
          document.getElementById("quiz-try-another").style.display = "block";
      };
  };
};


// let element = document.getElementById("bodyy");

// // true makes sure it scrolls so top of element is at top of view - false would put the buttom on the buttom
// // element.scrollIntoView(true);

// function scroller() {
//   element.scrollIntoView(true);
// }
// window.onopen = scroller();
// console.log("hihiiiii")

// by using taget = "_top" on link_to ---- not sur which window. / .eventListner is triggering it tho





// Unhide the content and jump to the right place on the page at the same time
// function restoreAndSkipContent() {
//   var hidden = document.getElementsByClassName('skip-me')[0];
//   hidden.classList.add('unhide');
//   window.scroll(0, hidden.offsetHeight);
// };
// restoreAndSkipContent();



window.onscroll = function(){
  var hidden = document.getElementsByClassName('skip-me')[0];
  hidden.classList.add('unhide');
  // hidden.classList.remove('skip-me');
  // window.scroll(0, hidden.offsetHeight);
};


// window.onload = function(){
//   var hidden = document.getElementsByClassName('skip-me')[0];
//   hidden.classList.add('unhide');
//   window.scroll(0, hidden.offsetHeight);
// };

// window.onmousemove = function(){
//   var hidden = document.getElementsByClassName('skip-me')[0];
//   hidden.classList.add('unhide');
//   window.scroll(0, hidden.offsetHeight);
// };
