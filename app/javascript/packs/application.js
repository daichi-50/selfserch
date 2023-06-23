import { createConsumer } from "@rails/actioncable"

window.App = window.App || {}
App.cable = createConsumer()

import "../channels/cable"
import "../channels/post_channel"
import "./post.js" 