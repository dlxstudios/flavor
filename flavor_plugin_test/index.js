const IORedis = require("ioredis");
const redis = new IORedis();

// you may find this read https://redis.io/topics/streams-intro
// very helpfull as a starter to understand the usescases and the parameters used

const f = async function () {
  const channel = "mystream";
  // specify the channel. you want to know how many messages
  // have been written in this channel
  let messageCount = await redis.xlen(channel);
  console.log(
    `current message count in channel ${channel} is ${messageCount} messages`
  );

  // specify channel to write a message into,
  // messages are key value
  // const myMessage = "hello world";
  // await redis.xadd(channel, "*", myMessage, "message");

  // messageCount = await redis.xlen(channel);
  // console.log(
  //   `current message count in channel ${channel} is ${messageCount} messages`
  // );
  // // now you can see we have one new message

  // use xread to read all messages in channel
  let messages = await redis.xread(["STREAMS", channel, 0]);
  // messages = messages[0][1];
  // console.log(
  //   `reading messages from channel ${channel}, found ${messages.length} messages`
  // );
  for (let i = 0; i < messages[0].length; i++) {
    let msg = messages[0][i];
    msg = msg.toString();
    console.log("reading message:", msg);
  }


  const processMessage = (message) => {
    console.log("Id: %s. Data: %O", message[0], message[1]);
    console.log(message);
    console.log(message[1][0]);
    var uid = message[1][0];
  };
  
  async function listenForMessage(lastId = "$") {
    // `results` is an array, each element of which corresponds to a key.
    // Because we only listen to one key (mystream) here, `results` only contains
    // a single element. See more: https://redis.io/commands/xread#return-value
    const results = await redis.xread("block", 0, "STREAMS", "mystream", lastId);
    const [key, messages] = results[0]; // `key` equals to "mystream"
  
    messages.forEach(processMessage);
  
    // Pass the last id of the results to the next round.
    await listenForMessage(messages[messages.length - 1][0]);
  }
  
  listenForMessage();
  
  // process.exit(0);
};
f();