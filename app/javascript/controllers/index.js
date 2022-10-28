// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import QuizController from "./quiz_controller"
application.register("quiz", QuizController)




// Navbar reveal - placed here currently as want to apply to every page (not a specific controller) but will move later
window.onscroll = function navbarReveal() {
  var hidden = document.getElementsByClassName('hide-navbar')[0];
  hidden.classList.add('unhide-navbar');
};
// try to see if instead of display none - use -height to put it above screen
// or timed event, ie, being on page for 1s ect. --- Timed event with display none pushes page down
