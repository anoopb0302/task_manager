
// app/javascript/controllers/task_form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "title", "description", "errorTitle", "errorDescription"]

  toggle() {
    const form = this.formTarget;
    form.classList.toggle("invisible");
    form.classList.toggle("opacity-0")
  }

  validate(event) {
    event.preventDefault();
    let valid = true;

    if (this.titleTarget.value.trim() === "") {
      this.errorTitleTarget.textContent = "Title is required!";
      valid = false;
    } else {
      this.errorTitleTarget.textContent = "";
    }

    if (this.descriptionTarget.value.trim() === "") {
      this.errorDescriptionTarget.textContent = "Description is required!";
      valid = false;
    } else {
      this.errorDescriptionTarget.textContent = "";
    }

    if (valid) {
      this.formTarget.submit();
      
      // 🔥 Trigger the progress update after form submission
      setTimeout(() => {
        document.querySelector("[data-controller='progress']").controller.updateProgress();
      }, 1000);
    }
  }
}
