import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const messages = document.getElementById('messages');
  if (messages === null) {
    return;
  }
  const postId = messages.dataset.postId;
  const appPost = consumer.subscriptions.create({channel: "PostChannel", post_id: postId}, {
    received(data) {
      messages.insertAdjacentHTML('beforeend', data['message']);
      setTimeout(function() {
        window.swiper.update(); // 更新
        const swiperContainer = document.querySelector('.swiper');
        if (swiperContainer !== null) {
          swiperContainer.scrollTop = swiperContainer.scrollHeight;
        } else {
          console.log('Error: No swiper container found.');
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