import { auth, firestore } from 'firebase-admin';
import { Logger } from '@firebase/logger';
import * as functions from 'firebase-functions';

export default class AuthenticationUserHandler {
    private logger: Logger = new Logger('AuthenticationUserHandler');
    private db: firestore.Firestore = firestore();

    constructor() {
        this.logger.setLogLevel('debug');
    }

    async newUserHandler(user: auth.UserRecord, context: functions.EventContext) {

        try {
            const uid: string = user.uid;

            // Check sign in method
            const providers: auth.UserInfo[] = user.providerData;

            if (providers.length === 0) {
                // Assign claims
                await auth().setCustomUserClaims(uid, { role: 'public' });
            } else {
                // Assign admin claims
                if (user.email) {
                    const adminsRef = this.db.collection('admins');
                    const adminsSnapshot = await adminsRef.where('email','==',`${user.email}`).get();
                    if (adminsSnapshot.docs.length === 1) await auth().setCustomUserClaims(uid, { role: 'admin' });
                }
            }
            
        } catch (error) {
            this.logger.error('newUserHandler: ', error);
        }
        return;
    }
}