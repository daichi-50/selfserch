// app/javascript/channels/cable.js

import { createConsumer } from "@rails/actioncable"

let consumer;

if (process.env.NODE_ENV === "production") {
  consumer = createConsumer(); // Uses default URL if it's specified in your layout
} else {
  consumer = createConsumer('ws://localhost:3000/cable');
}

export default consumer;