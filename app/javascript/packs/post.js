window.addEventListener('DOMContentLoaded', (event) => {
    const postId = $("#messages").data("post-id");
    console.log(`Post ID is: ${postId}`);

    App.post = App.cable.subscriptions.create(
      { channel: "PostChannel", post_id: $("#messages").data("post-id") },
      {
        received: function(data) {
        console.log(data);
        return $("#messages").append(data.message);
        },
    
        speak: function(message) {
          this.perform("speak", {
            message: message,
            post_id: postId
          });
        }
      }
    );
    
    $(document).on("keypress", "[data-behavior~=post_speaker]", function(event) {
      if (event.keyCode === 13) { // return/enter = send
        App.post.speak(event.target.value);
        event.target.value = "";
        event.preventDefault();
      }
    });
  });