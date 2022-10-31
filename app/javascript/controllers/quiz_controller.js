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







          // let quizButtonz = document.getElementsByClassName("quiz-button-lg");
          // quizButtonz.disabled = true;

          const quizButtonz = document.getElementsByClassName("quiz-buttons-container");
          // quizButtonz.data-action = "";
          console.log(quizButtonz);
          quizButtonz.all.dataAction.disable ;
          console.log("xzxz")

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







          

          // let quizButtonz = document.getElementsByClassName("quiz-button-lg");
          // quizButtonz.disabled = true;

          const quizButtonz = document.getElementsByClassName("quiz-buttons-container");
          // quizButtonz.data-action = "";
          console.log(quizButtonz);
          quizButtonz.all.dataAction.disable;
          console.log("hjsjd");
      };
  };

};



// const qBtnz = document.getElementsByClassName("quizz-btnzz");

// function myScript(correctCheck) {
//   if (correctCheck == true) {
//     console.log("correct")
//   } else {
//     console.log("incorrect")
//   }
// }



// qBtnz.addEventListener("click", myScript);








// Navbar hiding function - now being placed in index.js

// window.onscroll = function navbarReveal() {
//   var hidden = document.getElementsByClassName('hide-navbar')[0];
//   hidden.classList.add('unhide-navbar');
// };

// // try to see if instead of display none - use -height to put it above screen
// // or timed event, ie, being on page for 1s ect.
