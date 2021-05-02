import { auth } from 'firebase-admin';
import { Logger } from '@firebase/logger';
import * as functions from 'firebase-functions';

export default class AuthenticationUserHandler {
    private logger: Logger = new Logger('AuthenticationUserHandler');

    constructor() {
        this.logger.setLogLevel('debug');
    }

    public async newUserHandler(user: auth.UserRecord, context: functions.EventContext) {

        try {
            // Check sign in method
            const providers: auth.UserInfo[] = user.providerData;

            if (providers.length === 0) {
                // Assign claims
                const uid: string = user.uid;
                await auth().setCustomUserClaims(uid, { role: 'public' });
            }
            
        } catch (error) {
            this.logger.error('newUserHandler: ', error);
        }
        return;
    }
}