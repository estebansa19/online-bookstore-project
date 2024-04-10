import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

export default class extends Controller {
  static values = {
    bookId: Number
  }

  addBook(event) {
    const token = document.querySelector("meta[name='csrf-token']").getAttribute("content");
    const data = { id: event.params.id };

    fetch("/orders/books", {
      method: "POST",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "Content-Type": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify(data)
    }).then((response) => response.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }
}
