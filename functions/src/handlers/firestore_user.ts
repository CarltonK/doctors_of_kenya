import { auth, firestore } from 'firebase-admin';
import { Logger } from '@firebase/logger';
import * as functions from 'firebase-functions';

export default class FirestoreUserHandler {
    private logger: Logger = new Logger('FirestoreUserHandler');
    private db: firestore.Firestore = firestore();

    constructor() {
        this.logger.setLogLevel('debug');
    }

    public async newUserHandler(user: auth.UserRecord, context: functions.EventContext) {
        // Main Doc Reference
        const userRef = this.db.doc(`users/${user.uid}`);

        try {
            await userRef.set({
                uid: user.uid,
                email: user.email ?? null,
            });
        } catch (error) {
            this.logger.error('newUserHandler: ', error);
        }
        return;
    }
}