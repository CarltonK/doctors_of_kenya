import { Logger } from "@firebase/logger";
import * as functions from 'firebase-functions';
import { firestore } from 'firebase-admin';

export default class FirestoreUserHandler {
    private logger: Logger = new Logger('FirestoreUserHandler');
    // private db: firestore.Firestore = firestore();

    constructor() {
        this.logger.setLogLevel('debug');
    }

    public async newUserDocumentHandler(snapshot: firestore.QueryDocumentSnapshot, context: functions.EventContext) {

        try {
            this.logger.info('The new user is identified by: ', snapshot.data().uid);
        } catch (error) {
            this.logger.error('newUserDocumentHandler: ', error);
        }
        return;
    }
}