import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["bar", "text"];

  connect() {
    this.updateProgress(); // Fetch progress on page load
  }

  updateProgress() {
    fetch("/progress", { headers: { "Accept": "application/json" } })
      .then(response => response.json())
      .then(data => {
        this.barTarget.style.width = `${data.percentage}%`;
        this.textTarget.textContent = `${data.completed}/${data.total} Tasks Completed (${data.percentage}%)`;
      })
      .catch(error => console.error("Error fetching progress:", error));
  }
}
