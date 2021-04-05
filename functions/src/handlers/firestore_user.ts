import { Logger } from "@firebase/logger";
import * as functions from 'firebase-functions';
import { firestore } from 'firebase-admin';

export default class FirestoreUserHandler {
    private logger: Logger = new Logger('FirestoreUserHandler');
    private db: firestore.Firestore = firestore();
    private uid: string | null = null;

    constructor() {
        this.logger.setLogLevel('debug');
    }

    public async newUserDocumentHandler(snapshot: firestore.QueryDocumentSnapshot, context: functions.EventContext) {
        // Identifiers
        this.uid = snapshot.id;
        const publicProfileDocRef = this.db.doc(`users/${this.uid}/public_profile/${this.uid}`);
        const privateProfileDocRef = this.db.doc(`users/${this.uid}/private_profile/${this.uid}`);

        this.logger.info('The new user is identified by: ', this.uid);

        if (snapshot.data().designation) {
            if (snapshot.data().designation === 'user') {
                try {
                    // public profile
                    await this.writeToPublicDoc(publicProfileDocRef, snapshot.data());
                    // does not have a private profile
                } catch (error) {
                    this.logger.error('newUserDocumentHandler: ', error);
                }
            } else if (snapshot.data().designation === 'doctor') {
                try {
                    // public profile
                    await this.writeToPublicDoc(publicProfileDocRef, snapshot.data());
                    // private profile
                    await this.writeToPrivateDoc(privateProfileDocRef, snapshot.data());
                } catch (error) {
                    this.logger.error('newUserDocumentHandler: ', error);
                }
            }
            else {
                try {
                    // public Liason profile
                    await this.writeToPublicDoc(publicProfileDocRef, snapshot.data());
                    // private Liason profile
                    await this.writeToPrivateDoc(privateProfileDocRef, snapshot.data());
                } catch (error) {
                    this.logger.error('newUserDocumentHandler: ', error);
                }
            }
        }
        return;
    }

    private async writeToPublicDoc(docRef: firestore.DocumentReference, data: firestore.DocumentData): Promise<firestore.WriteResult> {
        return docRef.set({ ...data });
    }

    private async writeToPrivateDoc(docRef: firestore.DocumentReference, data: firestore.DocumentData): Promise<firestore.WriteResult> {
        return docRef.set({ ...data });
    }
}