import { Controller } from "@hotwired/stimulus"

const qBtnz = document.getElementsByClassName("quizz-btnzz");

function myScript(correctCheck) {
  if (correctCheck == true) {
    console.log("correct")
  } else {
    console.log("incorrect")
  }
}





export default class extends Controller {
  // static targets = ["button"]
  static targets = ["button", "message"];

  static values = {
      correct: String,
  }




  connect() {
    // this.element.textContent = "Hello World!"


    console.log("helloooo");
  }

  checking() {
    if (this.correctValue == "correct") {
      console.log("correct");
    } else {
      console.log("incorrect");
    }
  }

  checkingTrue(){
    console.log("true");
  }

  checkingFalse(){
    console.log("false");
  }



  checkResult(event) {
    event.preventDefault();
    const button = this.buttonTarget;
    if (this.correctValue == "correct") {
        console.log("xzxz");

    } else {
        console.log("hjsjd");
    };
};
}
