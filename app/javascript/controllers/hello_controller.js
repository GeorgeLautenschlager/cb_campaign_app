import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Briefing room loaded");
  }

  resize() {
    console.log("Briefing room resized");
  }
}
