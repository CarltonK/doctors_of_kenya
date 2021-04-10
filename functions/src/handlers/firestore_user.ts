import { Logger } from '@firebase/logger';
import { firestore } from 'firebase-admin';

export default class FirestoreUserHandler {
  private logger: Logger = new Logger('FirestoreUserHandler');
  private db: firestore.Firestore = firestore();
  private uid: string | null = null;
  private batch: firestore.WriteBatch | null = null;

  constructor() {
    this.logger.setLogLevel('debug');
  }

  public async newUserDocumentHandler(snapshot: firestore.QueryDocumentSnapshot) {
    // Identifiers
    this.uid = snapshot.id;
    this.batch = this.db.batch();
    const mainDocRef = this.db.doc(`users/${this.uid}`);
    const publicProfileDocRef = this.db.doc(`users/${this.uid}/public_profile/${this.uid}`);
    const privateProfileDocRef = this.db.doc(`users/${this.uid}/private_profile/${this.uid}`);

    this.logger.info('The new user is identified by: ', this.uid);

    const { designation } = snapshot.data();

    if (!designation) throw this.logger.error('newUserDocumentHandler: ', 'No designation provided');

      try {
        if (designation === 'user') {
          this.writeToPublicDoc(publicProfileDocRef, snapshot.data());
        }

        if (designation === 'doctor') {
          this.writeToPublicDoc(publicProfileDocRef, snapshot.data());
          this.writeToPrivateDoc(privateProfileDocRef, snapshot.data());
        } 
        
        if (designation === 'liaison') {
          this.writeToPublicDoc(publicProfileDocRef, snapshot.data());
          this.writeToPrivateDoc(privateProfileDocRef, snapshot.data());
        }
      } catch (error) {
        this.logger.error('newUserDocumentHandler: ', error);
      } finally {
        this.obfuscateMainDoc(mainDocRef, snapshot.data());
        await this.batch.commit();
      }
    return;
  }

  private writeToPublicDoc(
    docRef: firestore.DocumentReference, data: firestore.DocumentData) {
    this.batch?.set(docRef, data);
  }

  private writeToPrivateDoc(docRef: firestore.DocumentReference, data: firestore.DocumentData) {
    this.batch?.set(docRef, data);
  }

  private obfuscateMainDoc(docRef: firestore.DocumentReference, data: firestore.DocumentData) {
    this.batch?.delete(docRef)
  }
}
