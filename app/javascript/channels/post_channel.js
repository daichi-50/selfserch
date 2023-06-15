import consumer from "./consumer"

function scrollToBottom() {
  const messages = document.getElementById('messages');
  messages.scrollTop = messages.scrollHeight;
}

window.addEventListener('DOMContentLoaded', (event) => {
  const messages = document.getElementById('messages');
  const postId = messages.dataset.postId;
  const appPost = consumer.subscriptions.create({channel: "PostChannel", post_id: postId}, {
    connected() {},
    disconnected() {},
    received(data) {
      const messages = document.getElementById('messages');
      messages.insertAdjacentHTML('beforeend', data['message']);
    },
    speak: function(message, postId) {
      return this.perform('speak', {message: message, post_id: postId});
    }
  });

  const input = document.getElementById('post_input');
  const button = document.getElementById('submit_button');

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

  if(button) {
    button.addEventListener("click", function(e) {
      if(input.value !== '') {
        appPost.speak(input.value, postId);
        input.value = '';
      }
      e.preventDefault();
    });
  } else {
    console.error("Could not find element with id 'submit_button'");
  }
});