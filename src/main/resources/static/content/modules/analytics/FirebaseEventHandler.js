// Import the functions you need from the SDKs you need
import {initializeApp} from "https://www.gstatic.com/firebasejs/10.8.1/firebase-app.js";
import {getAnalytics, logEvent, setUserId} from "https://www.gstatic.com/firebasejs/10.8.1/firebase-analytics.js";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

export default class FirebaseEventHandler {

    _config = {
        apiKey: "",
        authDomain: "",
        projectId: "",
        storageBucket: "",
        messagingSenderId: "",
        appId: "",
        measurementId: ""
    }
    _analytics

    constructor(config = {
        apiKey: "",
        authDomain: "",
        projectId: "",
        storageBucket: "",
        messagingSenderId: "",
        appId: "",
        measurementId: ""
    }) {
        Object.assign(this._config, config);
    }

    init() {
        try {
            const app = initializeApp(this._config);
            this._analytics = getAnalytics(app);
        } catch (e) {
            console.log('Firebase init error', e);
        }
    }

    valid() {
        return typeof this._analytics !== undefined && this._analytics != null;
    }

    pageView(pageTitle = '', option = {}) {

        this.event('page_view', {
            page_title: pageTitle
        }, option)
    }

    event(eventName = '', eventParams = {}, option = {}) {

        if (!this.valid()) {
            return false;
        }

        try {
            logEvent(this._analytics, eventName, eventParams, option);
        } catch (e) {
        }
    }
    setUserId(id = '', option = {}) {

        if (!this.valid()) {
            return false;
        }

        try {
            if (id != '') {
                setUserId(this._analytics, id, option);
            }
        } catch (e) {
        }
    }
}