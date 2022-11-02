import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quiz"
export default class extends Controller {
  static targets = ["button"];

  static values = {
      correct: String,
  }

  connect() {
    console.log("hello");
  }

  checkResult(event) {
    event.preventDefault();
    const button = this.buttonTarget;
    const quizAnswerButtons = document.getElementsByClassName("quiz-answer-button");
    const quizResultMessage = document.getElementById("quiz-result-message");
    if (this.correctValue == "correct") {
        button.style.backgroundColor = "rgb(62, 117, 59)"; //green
        // quizResultMessage.innerText = "Congratulations! You won a new pack of 5 cards!";
        // quizResultMessage.innerText = "Swishhhhh!!!";
        quizResultMessage.innerText = "Swish!!! Open your pack below!";
        // quizResultMessage.style.backgroundColor = "rgba(62, 117, 59, 0.7)"; //green
        quizResultMessage.style.backgroundColor = "rgb(62, 117, 59)"; //green
        document.getElementById("quiz-open-pack").style.display = "block";
    } else {
        button.style.backgroundColor = "rgb(200, 16, 46)"; //$red
        // quizResultMessage.innerText = "Sooooo cloze!!! Best luck next time";
        quizResultMessage.innerText = "So close!!! Better luck next time!";
        // quizResultMessage.style.backgroundColor = "rgba(200, 16, 46, 0.7)"; //$red
        quizResultMessage.style.backgroundColor = "rgb(200, 16, 46)"; //$red
        document.getElementById("quiz-try-another").style.display = "block";
    };

    for(var i = 0; i < quizAnswerButtons.length; i++) {
      quizAnswerButtons[i].disabled = true;
    };
    quizResultMessage.style.display = "block";

    // Debating between scrolling to top of the question or upto the bottom of the next action
    // document.getElementById("h2Question").scrollIntoView(true);
    document.getElementById("quizNextAction").scrollIntoView(false);

};
}
