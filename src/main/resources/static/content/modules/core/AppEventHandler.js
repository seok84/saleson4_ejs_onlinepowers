import SalesonSupporter from "./SalesonSupporter.js";
import Api from "../api/Api.js"

let SALESON;
let DEVICE = '';

const pushMessage= {
    PUSH_ALERT: '세일즈온의 광고성 정보 메시지를 수신 하셨습니다. ',
    SAVE_LOG_ERROR: '광고성 정보 메시지 저장에 실패하였습니다. 알림설정에서 재설정해주세요.'
}

const isIos = () => {
    return 'IOS' == DEVICE;
}

const isAndroid = () => {
    return 'ANDROID' == DEVICE;
}

const getAndroidScheme = () => {
    return salesonApp;
}

const getIosScheme = () => {
    return 'salesonApp://';
}

export default {
    init($saleson, DEVICE) {
        SALESON = $saleson;
    },
    async updateVersion(storeVersion = '') {

            try {

                const api = new Api(SALESON);
                // 버전 업데이트 팝업
                const versionResponse = await api.get('/api/app-version');
                const version = versionResponse.data;

                if (version.version != null) {
                    const v1 = Number(storeVersion.replace(/\./g, ''));
                    const v2 = Number(version.version.replace(/\./g, ''));

                    if (v1 != v2) {
                        if (v1 < v2) {
                            SALESON.core.redirect('/app/update');
                        }
                    }
                }
            } catch (e) {
                console.error(e)
                console.error('app version event error');
            }
    },
    getAndroidScheme() {
        return this.getAndroidScheme();
    },

    getIosScheme() {
        return this.getIosScheme();
    },
    isIos() {
        return this.isIos();
    },

    isAndroid() {
        return this.isAndroid();
    },
    is() {
        return this.isIos() || this.isAndroid();
    },
    requestAlertStatus(target, receivePush = true, deviceInfo) { //시스템 설정의 알림 ON/OFF 상태를 리턴

        deviceInfo.target = target;
        deviceInfo.alarm = receivePush;
        //$store.commit('deviceInfo', deviceInfo);

        try {
            if (this.isIos()) {
                location.href = this.getIosScheme() + "requestAlertStatus";
            } else if (this.isAndroid()) {
                this.getAndroidScheme().requestAlertStatus();
            }
        } catch (e) {
            deviceInfo.status = 'off';
            //this.$store.commit('deviceInfo', deviceInfo);
        }
    },
    requestAlertSettings() { //시스템 설정으로 이동
        try {
            if (this.isIos()) {
                location.href = this.getIosScheme() + "requestAlertSettings";
            } else if (this.isAndroid()) {
                this.getAndroidScheme().requestAlertSettings();
            }
        } catch (e) {
        }

    },

    requestDeviceInfo(target, receivePush, deviceInfo) { //유효id, 앱 첫진입, 알림상태

        deviceInfo.target = target;
        deviceInfo.receive = receivePush;

        try {
            if (this.isIos()) {
                location.href = this.getIosScheme() + "requestDeviceInfo";
            } else if (this.isAndroid()) {
                this.getAndroidScheme().requestDeviceInfo();
            }
        } catch (e) {

            deviceInfo.key = '';
            deviceInfo.status = 'N';
            deviceInfo.first = true;
        }

        //$store.commit('deviceInfo', deviceInfo);
    },
    clearPushTokenStatus() {
        //$store.commit('setPushTokenStatus', '');
    },

    requestPushToken(status) {

        try {
            if (SALESON.auth.loggedIn()) {

                if (typeof status === undefined || status == null || status == '') {
                    if (this.isIos()) {
                        location.href = this.getIosScheme() + "requestPushToken";
                    } else if (this.isAndroid()) {
                        this.getAndroidScheme().requestPushToken();
                    } else {
                    }
                }
            } else {
                this.clearPushTokenStatus();
            }
        } catch (e) {
            console.error('requestPushToken error')
        }
    },

    requestAppPermission() {
        if (this.isIos()) {
            location.href = this.getIosScheme() + "requestAppPermission";
        } else if (this.isAndroid()) {
            this.getAndroidScheme().requestAppPermission();
        } else {
            console.error('not appliction')
            SALESON.core.redirect('/');
        }
    },

    requestNewOpen(url = '') {

        if (url != '') {
            try {
                const paramText = JSON.stringify({url:url});

                if (this.isIos()) {
                    location.href = this.getIosScheme() + encodeURIComponent(paramText);
                } else if (this.isAndroid()) {
                    this.getAndroidScheme().requestNewOpen(paramText);
                }
            } catch (e) {
                console.error(`requestNewOpen error [${url}]`)
            }
        }
    },
    async saveAppPushLog(key, receiveFlag, showToast) {
        try {

            const api = new Api(SALESON);
            const response = await api.post('/api/app-push/save-log',{key: key, receiveFlag:receiveFlag});

            if (showToast) {
                let toast = pushMessage.PUSH_ALERT + response.data;
                if (receiveFlag === 'Y') {
                    toast = toast.replace("pushType","동의");
                } else {
                    toast = toast.replace("pushType","거부");
                }

                SALESON.core.toast(toast);
            }

        } catch (e) {
            alert(pushMessage.SAVE_LOG_ERROR);
        }
    }
}