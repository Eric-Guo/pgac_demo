function scrollToBottom() {
  const messages = document.getElementById('messages');
  const threshold = 100; // 距离底部多少像素视为"接近底部"

  if (messages.scrollHeight - messages.scrollTop - messages.clientHeight <= threshold) {
    requestAnimationFrame(() => {
      messages.scrollTop = messages.scrollHeight;
    });
  }
}

App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    var fingerprint = new Fingerprint().get();
    Cookies.set('fingerprint', fingerprint, { expires: 365 });
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    if (data['message']) {
      $('#messages').append(data['message']);

      if (data['id']) {
        $('#wrapper-').remove();
      }
    } else {
      $('#new_message').append(data['content']);
    }
    scrollToBottom();
  },

  speak: function(message) {
    var fingerprint = Cookies.get('fingerprint');
    this.perform('speak', { message: message, fingerprint: fingerprint });
  }
});

$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
  if (event.keyCode === 13) { // return = send
    App.room.speak(event.target.value);
    event.target.value = '';
    event.preventDefault();
  }
});
