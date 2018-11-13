import {MongoClient} from 'mongodb'

let client = null;
let collections = {};

exports.init = function() {
  console.log("init")
  let mongoServer = process.env.MONGO_SERVER || '127.0.0.1'
  return MongoClient.connect(`mongodb://${mongoServer}:27017/CodeWhispers`)
  .then((database) => {
    client = database.db("whipser")
  })
};

exports.collection = function(collectionName) {
  if (!collections[collectionName]) {
    collections[collectionName] = client.collection(collectionName);
  }
  return collections[collectionName];
};
