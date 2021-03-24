import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { Logger } from '@firebase/logger';
import FirestoreUserHandler from './handlers/firestore_user';

admin.initializeApp();

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
FIRESTORE TRIGGERS
*/
export const onNewUserCreated = regionalFunctions.auth.user().onCreate(GlobalFirestoreUserHandler.newUserHandler.bind(GlobalFirestoreUserHandler));