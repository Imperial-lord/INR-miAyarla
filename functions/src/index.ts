import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sendToDevice = functions.firestore.document('orders/{orderID}').onCreate(async snapshot => {
    const order = snapshot.data();
    const querySnapshot = await db.collection('users').doc(order.seller).collection('tokens').get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: 'New Order!',
            body: 'you sold a ' + order.product + 'for ' + order.total,
            icon: 'https://i.ibb.co/LN23p27/blood-drop.png',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    };

    return fcm.sendToDevice(tokens, payload);
});

export const sendManualNotifToDevice = functions.firestore.document('Notifications/{NotificationsID}').onCreate(async snapshot => {
    const notif = snapshot.data();
    const querySnapshot = await db.collection('Users').doc(notif.PatientUID).collection('tokens').get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: notif.Title,
            body: notif.Body,
            icon: 'https://i.ibb.co/LN23p27/blood-drop.png',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    };

    return fcm.sendToDevice(tokens, payload);
});
