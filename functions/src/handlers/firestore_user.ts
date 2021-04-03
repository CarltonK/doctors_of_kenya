import { Logger } from "@firebase/logger";
import * as functions from 'firebase-functions';
import { firestore } from 'firebase-admin';

export default class FirestoreUserHandler {
    private logger: Logger = new Logger('FirestoreUserHandler');
    private db: firestore.Firestore = firestore();

    constructor() {
        this.logger.setLogLevel('debug');
    }

    public async newUserDocumentHandler(snapshot: firestore.QueryDocumentSnapshot, context: functions.EventContext) {
        // Identifiers
        const uid: string = snapshot.id;
        // const baseUserDocRef = this.db.doc(`users/${uid}`);
        const publicProfileDocRef = this.db.doc(`users/${uid}/public_profile/${uid}`);
        const privateProfileDocRef = this.db.doc(`users/${uid}/private_profile/${uid}`);
        const premiumProfileDocRef = this.db.doc(`users/${uid}/public_profile/${uid}`);

        this.logger.info('The new user is identified by: ', uid);

        if (snapshot.data().designation === 'user') {
            try {
                //set public profile
                publicProfileDocRef.set({
                    firstName: snapshot.data().firstName,
                    lastName: snapshot.data().lastName,
                    age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex,
                    designation: snapshot.data().designation,
                    chronicConditions: snapshot.data().chronicConditions ?? [],
                    medications: snapshot.data().medications ?? [],
                    primaryDoctor: snapshot.data().primaryDoctor ?? null,
                    otherDoctors: snapshot.data().otherDoctors ?? null,
                });
                //does not have a private profile
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }

        } else if (snapshot.data().designation === 'doctor') {
            try {
                //set public profile
                publicProfileDocRef.set({
                    firstName: snapshot.data().firstName,
                    lastName: snapshot.data().lastName,
                    age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex ?? "",
                    mpdbRegNumber: snapshot.data().mpdbRegNumber ?? null,
                    mpdbRegDate: snapshot.data().mpdbRegDate ?? null,
                    userAddress: snapshot.data().userAddress ?? null,
                    countyOfPrimaryWork: snapshot.data().countyOfPrimaryWork ?? null,
                    userContact: snapshot.data().userContact ?? null,
                    email: snapshot.data().email ?? null,
                    professionalQualifications: snapshot.data().professionalQualification ?? null,

                });
                //private profile
                privateProfileDocRef.set({
                    firstName: snapshot.data().firstName,
                    lastName: snapshot.data().lastName,
                    Age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex,
                    userID: snapshot.data().uid,
                    personalContact: snapshot.data().personalContact ?? null,
                    ratings: snapshot.data().ratings,
                    peerreviews: snapshot.data().peerreviews

                });
                //premium profile
                premiumProfileDocRef.set({
                    userId: snapshot.data().uid,
                });
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }
        }
        else {
            try {
                //set public Liason profile
                publicProfileDocRef.set({
                    firstName: snapshot.data().firstName,
                    age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex ?? "",
                    userID: snapshot.data().uid,
                    areaOfWork: snapshot.data().areaOfWork,
                    professionalQualification: snapshot.data().professionalQualification


                });
                //private Liason profile
                privateProfileDocRef.set({
                    firstName: snapshot.data().firstName,
                    age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex

                });
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }
        }
        return;
    }
}