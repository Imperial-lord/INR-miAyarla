import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

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


export const sendNotifForChat = functions.firestore.document('Messages/{ChatID}/{MessagesCollection}/{MessageID}').onCreate(async snapshot => {
    const notif = snapshot.data();
    const querySnapshot = await db.collection('Users').doc(notif.idTo).collection('tokens').get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    var title = notif.idFrom as string;
    let content = (notif.type == 1) ? 'Sent a photo' : notif.content;

    const patient = await db.collection('Patients').doc(notif.idFrom).get();
    const doctor = await db.collection('Doctors').doc(notif.idFrom).get();
    if (patient.exists) title = patient.data()!.Name;
    else title = doctor.data()!.Name;


    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: title,
            body: content,
            icon: 'https://i.ibb.co/LN23p27/blood-drop.png',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    };

    return fcm.sendToDevice(tokens, payload);
});