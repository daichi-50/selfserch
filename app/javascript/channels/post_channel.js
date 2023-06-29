import consumer from "./consumer"

function scrollToBottom() {
  const messages = document.getElementById('messages');
  messages.scrollTop = messages.scrollHeight;
}

document.addEventListener("turbo:load", () => {
  console.log('Turbolinks loaded');
  const messages = document.getElementById('messages');
  if (messages === null) {
    return;
  }
  const postId = messages.dataset.postId;
  console.log(`Post ID is: ${postId}`);
  const appPost = consumer.subscriptions.create({channel: "PostChannel", post_id: postId}, {
    connected() {
      console.log('Successfully connected to the channel.');
    },
    disconnected() {
      console.log('Disconnected from the channel.');
    },
    received(data) {
      console.log('Received data:', data);
      messages.insertAdjacentHTML('beforeend', data['message']);
      console.log('Message inserted');
      setTimeout(function() {
        window.swiper.update(); // 更新
        const swiperContainer = document.querySelector('.swiper');
        if (swiperContainer) {
          swiperContainer.scrollTop = swiperContainer.scrollHeight;
        }
      }, 100);
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

// Popstate event
window.addEventListener('popstate', function(event) {
  setTimeout(function() {
    window.swiper.update();
    const swiperContainer = document.querySelector('.swiper');
    if (swiperContainer) {
      swiperContainer.scrollTop = swiperContainer.scrollHeight;
    }
  }, 100);
});