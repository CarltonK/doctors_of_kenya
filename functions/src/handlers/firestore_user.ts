import { Logger } from '@firebase/logger';
import { firestore, auth } from 'firebase-admin';

export default class FirestoreUserHandler {
  private logger: Logger = new Logger('FirestoreUserHandler');
  private db: firestore.Firestore = firestore();
  private uid: string | null = null;
  private batch: firestore.WriteBatch | null = null;

  constructor() {
    this.logger.setLogLevel('debug');
  }

  async newUserDocumentHandler(snapshot: firestore.QueryDocumentSnapshot) {
    // Identifiers
    this.uid = snapshot.id;
    this.batch = this.db.batch();
    const mainDocRef = this.db.doc(`users/${this.uid}`);
    const publicProfileDocRef = this.db.doc(`users/${this.uid}/public_profile/${this.uid}`);
    const privateProfileDocRef = this.db.doc(`users/${this.uid}/private_profile/${this.uid}`);
    const premiumProfileDocRef = this.db.doc(`users/${this.uid}/premium_profile/${this.uid}`);

    this.logger.info('The new user is identified by: ', this.uid);

    const { designation } = snapshot.data();
    // General
    const { email, firstName, lastName, registeredOn } = snapshot.data();
    // Private - General
    const { chronicConditions, medications, primaryDoctor, otherDoctors, dob, gender } = snapshot.data();
    // Practitioner
    const { mpdbRegNumber, mpdbRegDate, userAddress, userContact, qualifications, practitionerType } = snapshot.data();

    if (!designation) throw this.logger.error('newUserDocumentHandler: ', 'No designation provided');

      try {
        // Writable UID
        const uid = this.uid;

        if (designation === 'General') {

          // Assign claims
          await auth().setCustomUserClaims(this.uid, { role: 'general' });
          
          this.writeToPublicDoc(publicProfileDocRef, { email, firstName, lastName, registeredOn, designation, uid });

          this.writeToPrivateDoc(privateProfileDocRef,{ email, firstName, lastName, registeredOn, chronicConditions, medications, primaryDoctor, otherDoctors, dob, gender, uid, designation });

        }

        if (designation === 'Practitioner') {

          // Assign claims
          await auth().setCustomUserClaims(this.uid, { role: 'premium' });

          this.writeToPublicDoc(publicProfileDocRef, { email, firstName, lastName, registeredOn, designation, uid, practitionerType });

          this.writeToPrivateDoc(premiumProfileDocRef,{ email, firstName, lastName, registeredOn, mpdbRegNumber, mpdbRegDate, userAddress, userContact, qualifications, dob, gender, uid, designation, practitionerType });
        } 
        
        if (designation === 'Liaison') {

          // Assign claims
          await auth().setCustomUserClaims(this.uid, { role: 'liaison' });

          this.writeToPublicDoc(publicProfileDocRef, { email, firstName, lastName, registeredOn, designation, uid });

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
