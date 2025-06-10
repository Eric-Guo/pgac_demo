App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    var fingerprint = new Fingerprint().get();
    Cookies.set('fingerprint', fingerprint, { expires: 365 });
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    $('#messages').append(data['message']);
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
