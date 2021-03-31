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
        if (snapshot.data().designation == 'user') {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set public profile
                this.db.doc(`users/${snapshot.data().uid}/public_profile/${snapshot.data().uid}`).set({
                    firstfirstName: snapshot.data().firstfirstName,
                    lastfirstName: snapshot.data().lastfirstName,
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

        } else if (snapshot.data().designation == 'doctor') {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set public profile
                this.db.doc(`users/${snapshot.data().uid}/public_profile/${snapshot.data().uid}`).set({
                    firstfirstName: snapshot.data().firstfirstName,
                    lastfirstName: snapshot.data().lastfirstName,
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
                this.db.doc(`users/${snapshot.data().uid}/private_profile/${snapshot.data().uid}`).set({
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
                this.db.doc(`users/${snapshot.data().uid}/premium_profile/${snapshot.data().uid}`).set({
                    userId: snapshot.data().uid,


                });
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }
        }
        else {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set public Liason profile
                this.db.doc(`users/${snapshot.data().uid}/public_profile/${snapshot.data().uid}`).set({
                    firstName: snapshot.data().firstName,
                    age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex ?? "",
                    userID: snapshot.data().uid,
                    areaOfWork: snapshot.data().areaOfWork,
                    professionalQualification: snapshot.data().professionalQualification


                });
                //private Liason profile
                this.db.doc(`users/${snapshot.data().uid}/private_profile/${snapshot.data().uid}`).set({
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