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
        if (snapshot.data().role == 'nonpractitioner') {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set public profile
                this.db.doc(`users/${snapshot.data().uid}/public_profile/${snapshot.data().uid}`).set({
                    firstname: snapshot.data().firstname,
                    lastname: snapshot.data().lastname,
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

        } else if (snapshot.data().role == 'medicalpractitioner') {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set public profile
                this.db.doc(`users/${snapshot.data().uid}/public_profile/${snapshot.data().uid}`).set({
                    Name: snapshot.data().name,
                    Age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex ?? "",
                    userID: snapshot.data().uid,
                    mpdRegistrationNumber: snapshot.data().mpdRegistrationNumber ?? null,
                    mpdRegistrationDate: snapshot.data().mpdRegistrationDate ?? null,
                    address: snapshot.data().address ?? null,
                    countyOfPrimaryWork: snapshot.data().countyOfPrimaryWork ?? null,
                    officeContact: snapshot.data().officeContact ?? null,
                    email: snapshot.data().email ?? null,
                    professionalQualification: snapshot.data().professionalQualification ?? null,

                });
                //private profile
                this.db.doc(`users/${snapshot.data().uid}/private_profile/${snapshot.data().uid}`).set({
                    Name: snapshot.data().name,
                    Age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex,
                    userID: snapshot.data().uid,
                    personalContact: snapshot.data().personalContact ?? null,
                    ratings: snapshot.data().ratings,
                    peerreviews: snapshot.data().peerreviews

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
                    Name: snapshot.data().name,
                    Age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex ?? "",
                    userID: snapshot.data().uid,
                    areaOfWork: snapshot.data().areaOfWork,
                    professionalQualification: snapshot.data().professionalQualification


                });
                //private Liason profile
                this.db.doc(`users/${snapshot.data().uid}/private_profile/${snapshot.data().uid}`).set({
                    Name: snapshot.data().name,
                    Age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex,
                    userID: snapshot.data().uid,

                });
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }
        }
        return;
    }
}