import consumer from "./consumer"

window.addEventListener('DOMContentLoaded', (event) => {
  const messages = document.getElementById('messages');
  const postId = messages.dataset.postId;
  const appPost = consumer.subscriptions.create({channel: "PostChannel",post_id: postId}, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messages = document.getElementById('messages');
    messages.insertAdjacentHTML('beforeend', data['message']);
  },

  speak: function(message, postId) {
    return this.perform('speak', {message: message, post_id: postId});
  }
});

    const input = document.getElementById('post_input');
    if(input) {
      input.addEventListener("keypress", function(e) {
        if (e.keyCode === 13) {
          appPost.speak(e.target.value, postId);
          e.target.value = '';
          e.preventDefault();
        }
      });
    } else {
      console.error("Could not find element with id 'post_input'");
    }
});