import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slot-move"
export default class extends Controller {
  start(event) {
    this.moveUrl = event.currentTarget.dataset.moveUrl
    setTimeout(() => {
      this.element.classList.add("dragging")
    }, 0)
  }

  end() {
    this.element.classList.remove("dragging")
  }

  allow(event) {
    event.preventDefault()
  }

  drop(event) {
    event.preventDefault()
    const roomId = event.currentTarget.dataset.roomId
    const startAt = event.currentTarget.dataset.startAt
    const token = document.querySelector('meta[name="csrf-token"]').content
    const body = new FormData()
    body.append("slot[room_id]", roomId)
    body.append("slot[start_at]", startAt)
    fetch(this.moveUrl, {
      method: "PATCH",
      headers: { "X-CSRF-Token": token },
      body: body
    }).then(() => { window.location.reload() })
  }
}
