// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket";

var elmDiv = document.getElementById('elm-main'),
    initialState = {
      fixed: false,
      breadUpdates: false
    },
    elmApp = Elm.embed(Elm.BreadFixed, elmDiv, initialState);

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("bread:fixed", {});
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp); })
  .receive("error", resp => { console.log("Unable to join", resp); });

channel.on("set_bread", data => {
  console.log("got bread", data);
  elmApp.ports.fixed.send(data["fixed"]);
});

elmApp.ports.breadRequests.subscribe(bread => {
  console.log("requesting bread: ", bread);
  channel.push("request_bread", bread)
    .receive("error", payload => console.log(payload.message));
});

channel.on("bread_updated", bread => {
  console.log('updated bread: ', bread);
  elmApp.ports.breadUpdates.send(bread["fixed"]);
});
