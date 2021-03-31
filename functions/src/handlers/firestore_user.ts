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
        if (snapshot.data().role == 'nonpractitioner') {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set public profile
                firestore().doc('users/{${snapshot.data().uid}}/public_profile').set({
                    Name: snapshot.data().name,
                    Age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex,
                    userID: snapshot.data().uid,
                    chronicConditions: snapshot.data().chronicConditions ?? [],
                    medications: snapshot.data().medications ?? [],
                    primaryDoctor: snapshot.data().primaryDoctor ?? null,
                    additionalDoctors: snapshot.data().additionalDoctors ?? null,

                });
                //does not have a private profile
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }

        } else if (snapshot.data().role == 'medicalpractitioner') {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set public profile
                firestore().doc('users/{${snapshot.data().uid}}/public_profile').set({
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
                firestore().doc('users/{${snapshot.data().uid}}/private_profile').set({
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
        } else if (snapshot.data().role == 'institution') {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set institution public profile
                firestore().doc('users/{${snapshot.data().uid}}/public_profile').set({
                    Name: snapshot.data().name,
                    Location: snapshot.data().location,
                    contact: snapshot.data().contact,
                    affiliated: snapshot.data().affiliated,
                    services: snapshot.data().services,
                    paymentsMode: snapshot.data().paymentsMode,

                });
                //institution private profile
                firestore().doc('users/{${snapshot.data().uid}}/private_profile').set({
                    Name: snapshot.data().name,
                    location: snapshot.data().location,
                    liasonContacts: snapshot.data().liasonContacts,
                    discountfacilitis: snapshot.data().discountfacilitis,
                    serviceSpecifics: snapshot.data().serviceSpecifics,
                    practionerSpecifics: snapshot.data().practionerSpecifics,

                });
            } catch (error) {
                this.logger.error('newUserDocumentHandler: ', error);
            }
        }
        else {
            try {
                this.logger.info('The new user is identified by: ', snapshot.data().uid);
                //set public Liason profile
                firestore().doc('users/{${snapshot.data().uid}}/public_profile').set({
                    Name: snapshot.data().name,
                    Age: snapshot.data().age ?? "",
                    sex: snapshot.data().sex ?? "",
                    userID: snapshot.data().uid,
                    areaOfWork: snapshot.data().areaOfWork,
                    professionalQualification: snapshot.data().professionalQualification


                });
                //private Liason profile
                firestore().doc('users/{${snapshot.data().uid}}/private_profile').set({
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