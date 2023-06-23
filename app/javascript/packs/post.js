window.addEventListener('DOMContentLoaded', (event) => {
  console.log('DOMContentLoaded event fired!');
  const messagesElement = document.getElementById("messages");
  const postId = messagesElement.dataset.postId;

  App.post = App.cable.subscriptions.create(
      { channel: "PostChannel", post_id: postId },
      {
          received: function(data) {
              console.log(data);
              messagesElement.insertAdjacentHTML('beforeend', data.message);
          },
          
          speak: function(message) {
              this.perform("speak", {
                  message: message,
                  post_id: postId
              });
          }
      }
  );
  
  document.querySelectorAll("[data-behavior~=post_speaker]").forEach(element => {
      element.addEventListener("keydown", event => {
          if (event.key === 'Enter') {
              App.post.speak(event.target.value);
              event.target.value = "";
              //if (DOM)
              event.preventDefault();
          }
      });
  });
});






