import { Controller } from "@hotwired/stimulus"

const qBtnz = document.getElementsByClassName("quizz-btnzz");


export default class extends Controller {
  // static targets = ["button"]
  static targets = ["button", "message"];

  static values = {
      correct: String,
  }

  connect() {
    console.log("hello");
  }

  checkResult(event) {
    event.preventDefault();
    const button = this.buttonTarget;
    if (this.correctValue == "correct") {
        console.log("xzxz");
        const bnz = document.getElementsByClassName("quizz-btnzz");
        console.log(bnz);
        for(var i = 0; i < bnz.length; i++) {
          bnz[i].disabled = true;
        };


        button.style.backgroundColor = "#3e753b"; //green
        const quizResultMessage = document.getElementById("quiz-result-message");
        quizResultMessage.innerText = "Congratulations! You won a new pack of 5 cards!";
        quizResultMessage.style.backgroundColor = "rgba(62, 117, 59, 0.7)"; //green
        quizResultMessage.style.display = "block";
        const quizOpenPack = document.getElementById("quiz-open-pack").style.display = "block";

    } else {
        console.log("hjsjd");
        const bnz = document.getElementsByClassName("quizz-btnzz");
        console.log(bnz);
        for(var i = 0; i < bnz.length; i++) {
          bnz[i].disabled = true;
        };



        button.style.backgroundColor = "#C8102E"; //$red
        const quizResultMessage = document.getElementById("quiz-result-message");
        quizResultMessage.innerText = "Sooooo cloze!!! Best luck next time";
        quizResultMessage.style.backgroundColor = "rgba(200, 16, 46, 0.7)"; //$red
        quizResultMessage.style.display = "block";
        document.getElementById("quiz-try-another").style.display = "block";

    };
};
}
