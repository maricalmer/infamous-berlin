// subscribe clients to chatroom channel - Action Cable
import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data);
        scrollBottom(messagesContainer);
      },
    });
  }
}
const scrollBottom = (messagesContainer) => {
  messagesContainer.scrollTop = messagesContainer.scrollHeight;
}
export { initChatroomCable };
