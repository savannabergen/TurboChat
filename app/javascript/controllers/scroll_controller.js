import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Connected");
    this.messages = document.getElementById("messages");
    this.observeMessages();
    this.resetScroll();
  }

  disconnect() {
    console.log("Disconnected");
  }

  observeMessages() {
    const observer = new MutationObserver(() => {
      this.resetScroll();
    });
    observer.observe(this.messages, {
      childList: true,
    });
  }

  resetScroll = () => {
    this.messages.scrollTop = this.messages.scrollHeight - this.messages.clientHeight;
  }
}
