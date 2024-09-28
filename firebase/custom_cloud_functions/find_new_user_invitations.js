const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.findNewUserInvitations = functions.firestore
  .document("users/{userId}")
  .onCreate((snap, context) => {
    // Write your code below!
    const newUser = snap.data();

    // Find all invitations towards this user
    // Create reverse invitations

    // Write your code above!
  });
