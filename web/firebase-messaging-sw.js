importScripts("https://www.gstatic.com/firebasejs/9.18.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.18.0/firebase-messaging-compat.js");

const firebaseConfig = {
  //apiKey: "AIzaSyC3aX3uqQ4D5XR29e9iiQoBPrbA3xEQHpU",
  //authDomain: "dtapps-f3442.firebaseapp.com",
  //projectId: "dtapps-f3442",
  //storageBucket: "dtapps-f3442.appspot.com",
  //messagingSenderId: "997133946428",
  //appId: "1:997133946428:web:2bcdc158a61750bd7b7d39"
  apiKey: "AIzaSyCn-f9guYCbxHiyQS7RvSJxLfsxyvaR3Mc",
  authDomain: "bharatmandiram-pocketfm.firebaseapp.com",
  projectId: "bharatmandiram-pocketfm",
  storageBucket: "bharatmandiram-pocketfm.firebasestorage.app",
  messagingSenderId: "743533913786",
  appId: "1:743533913786:web:31105cce9f07e206c3c483",
  measurementId: "G-7CP85Z9VLR"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/Icon-192.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
