import { Logger } from "@firebase/logger";
import * as functions from 'firebase-functions';
import { firestore } from 'firebase-admin';

export default class FirestoreUserHandler {
    private logger: Logger = new Logger('FirestoreUserHandler');
    private db: firestore.Firestore = firestore();
    private uid: string | null = null;
    private publicProfileDocRef = this.db.doc(`users/${this.uid}/public_profile/${this.uid}`);
    private privateProfileDocRef = this.db.doc(`users/${this.uid}/private_profile/${this.uid}`);
    // private baseUserDocRef = this.db.doc(`users/${this.uid}`);

    constructor() {
        this.logger.setLogLevel('debug');
    }

    public async newUserDocumentHandler(snapshot: firestore.QueryDocumentSnapshot, context: functions.EventContext) {
        // Identifiers
        this.uid = snapshot.id;

        this.logger.info('The new user is identified by: ', this.uid);

        if (snapshot.data().designation === 'user') {
            try {
                // public profile
                await this.writeToPublicDoc(snapshot.data());
                // does not have a private profile
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }
        } else if (snapshot.data().designation === 'doctor') {
            try {
                // public profile
                await this.writeToPublicDoc(snapshot.data());
                // private profile
                await this.writeToPrivateDoc(snapshot.data());
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }
        }
        else {
            try {
                // public Liason profile
                await this.writeToPublicDoc(snapshot.data());
                // private Liason profile
                await this.writeToPrivateDoc(snapshot.data());
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }
        }
        return;
    }

    private async writeToPublicDoc(data: firestore.DocumentData): Promise<firestore.WriteResult> {
        return this.publicProfileDocRef.set({ ...data });
    }

    private async writeToPrivateDoc(data: firestore.DocumentData): Promise<firestore.WriteResult> {
        return this.privateProfileDocRef.set({ ...data });
    }
}