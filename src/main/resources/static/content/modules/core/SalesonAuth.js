import SalesonCore from "./SalesonCore.js";
import SalesonSupporter from "./SalesonSupporter.js";
import SalesonConst from "./SalesonConst.js";

export default class SalesonAuth {

    _cryptoJS;
    _key;
    _axios;

    constructor(axios, cryptoJS, key = '') {
        this._axios = axios;
        this._cryptoJS = cryptoJS;
        this._key = key;
    }

    getHashInBase64(hmacMessage = '') {

        const cryptoJS = this._cryptoJS;

        if (typeof cryptoJS !== undefined) {
            const hash = cryptoJS.HmacSHA256(hmacMessage, this._key);
            return cryptoJS.enc.Base64.stringify(hash);
        }

        return '';
    }

    login(request = {}, callback) {
        const self = this;
        const hmacMessage = JSON.stringify(request);
        const hmac = this.getHashInBase64(hmacMessage);

        if (!SalesonSupporter.isFunction(callback)) {
            SalesonCore.alert('empty callback');
            return false;
        }

        if (hmac == '') {
            SalesonCore.alert('로그인 시도시 오류가 발생했습니다.');
        }

        let url = '/api/auth/token';

        this._axios
            .post(url, request, {
                headers: {
                    Hmac: hmac
                }
            })
            .then((response) => {
                const token = response.data.token;
                callback(token);
            })
            .catch((error) => {
                SalesonCore.api.handleApiExeption(error);
            });
    }

    logout(url) {
        location.replace('/auth/logout?redirect='+url);
    }

    salesonId() {
        return SalesonSupporter.getCookie(SalesonConst.cookie.SALESON_ID);
    }

    token() {
        return SalesonSupporter.getCookie(SalesonConst.cookie.TOKEN);
    }
    loggedIn() {
        return SalesonSupporter.getCookie(SalesonConst.cookie.LOGGED_IN) === 'true';
    }

    async setSessionTimeout() {

        if (!this.loggedIn()) {
            return false;
        }

        try {
            const response = await this._axios.get('/api/auth/session-timeout');
            const data = response.data;
            const timeout = data.timeout;

            if (timeout > 0) {
                setTimeout(() => {
                    location.replace('/auth/logout');
                }, timeout * 1000 * 60);
            }

        } catch (e) {
            console.error('setSessionTimeout', e);
        }
    }


    guestLogin(request = {}, callback) {
        const self = this;
        const hmacMessage = JSON.stringify(request);
        const hmac = $saleson.auth.getHashInBase64(hmacMessage);

        if (hmac == '') {
            SalesonCore.alert('로그인 시도시 오류가 발생했습니다.');
        }

        let url = 'api/auth/guest-token';

        this._axios.post(url, request, {
            headers : {
                Hmac : hmac
            }
        })
        .then((response) => {
            const token = response.data.token;
            callback(token);
        })
        .catch((error) => {
            SalesonCore.api.handleApiExeption(error);
        });
    }

}