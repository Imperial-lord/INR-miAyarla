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

    let title = notif.idFrom;
    let content = (notif.type == 1) ? 'Sent a photo' : notif.content;

    const patient = db.collection('Patients').doc(notif.idTo);
    const doctor = db.collection('Doctors').doc(notif.idTo);
    patient.get().then((docSnapshot) => {
        if (docSnapshot.exists) {
            title = docSnapshot.data() ? ['Name'] : title;
        } else {
            doctor.get().then((docSnapshot) => {
                if (docSnapshot.exists) {
                    title = docSnapshot.data() ? ['Name'] : title;
                }
            });
        }
    });

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