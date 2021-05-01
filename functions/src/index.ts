import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { Logger } from '@firebase/logger';
// import AuthenticationUserHandler from './handlers/auth_user';
import FirestoreUserHandler from './handlers/firestore_user';

admin.initializeApp();

// const GlobalAuthenticationUserHandler = new AuthenticationUserHandler();
const GlobalFirestoreUserHandler = new FirestoreUserHandler();

// Define Logger
const logger = new Logger('Root');
logger.setLogLevel('debug');

// Define Static Functions
const runtimeOpts: functions.RuntimeOptions = {
    memory: '512MB',
    timeoutSeconds: 60,
    ingressSettings: 'ALLOW_ALL',
}
const regionalFunctions = functions.runWith(runtimeOpts).region('europe-west2');


/*
AUTHENTICATION TRIGGERS
*/
// export const onNewUserCreated = regionalFunctions.auth.user().onCreate(GlobalAuthenticationUserHandler.newUserHandler.bind(GlobalAuthenticationUserHandler));


/*
FIRESTORE TRIGGERS
*/
export const onNewUserDocumentCreated = regionalFunctions.firestore.document('/users/{user}').onCreate(GlobalFirestoreUserHandler.newUserDocumentHandler.bind(GlobalFirestoreUserHandler));