// import consumer from "channels/consumer"

// consumer.subscriptions.create("ChatChannel", {
//   connected() {
//     // Called when the subscription is ready for use on the server
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   received(data) {
//     // Called when there's incoming data on the websocket for this channel
//   }
// });
// app/assets/javascripts/channels/chat.js

// app/javascript/channels/chat_channel.js
import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // received(data) {
  //   // Called when there's incoming data on the websocket for this channel
  //   console.log(data)

    // if (data.user_id === current_user.id || data.receive_id === current_user.id) {
    //   document.getElementById('chat').innerHTML += data;
  //     scrollToBottom();
  //   }
  //   clearInputField();
  // }

  received(data) {
    try {
      const parsedData = JSON.parse(data);
      const chatContainer = document.getElementById('chat');
      const message = document.createElement('div');
      
      console.log('Received data:', parsedData);

      fetch('/current_user_id')
        .then(response => response.json())
        .then(userData => {
          const currentUserId = userData.current_user_id;
          const selected_user = userData.selected_id
          console(selected_user)

          const isCurrentUser = parsedData.user_id === currentUserId;
          const isReceiver = parsedData.receiver_id === currentUserId;
          const select_person = selected_user == parsedData.receiver_id
          console.log(selected_user)

          if (isCurrentUser || (isReceiver && select_person)) {
            const messageContent = document.createElement('div');
            messageContent.innerHTML = parsedData.message;

            if (isCurrentUser) {
              message.classList.add('current-user');
            } else {
              message.classList.add('other-user');
            }

            message.appendChild(messageContent);
            chatContainer.appendChild(message);
            scrollToBottom();
            console.log('Message added to the chat:', parsedData.message);
          } else {
            console.log('Message not added to the chat.');
          }

          clearInputField();
        })
        .catch(error => {
          console.error('Error fetching current user ID:', error);
        });
    } catch (error) {
      console.error('Error processing received data:', error);
    }
  }
});
function clearInputField() {
  document.getElementById('message-content').value = '';
}
function scrollToBottom() {
  const chatContainer = document.getElementById('chat');
  chatContainer.scrollTop = chatContainer.scrollHeight;
}

