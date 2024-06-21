class Api {
    constructor($saleson = {}) {

        const axios = $saleson['axios'];
        const auth = $saleson['auth'];

        this._axios = axios;
        this._auth = auth;
    }

    get $axios() {
        return this._axios;
    }

    get $auth() {
        return this._auth;
    }

    get isLogin() {
        return this.$auth.loggedIn();
    }

    getRequestOptions(params) {
        let requestOptions = {
            headers:{
                SALESONID: this.$auth.salesonId()
            }
        };

        if (params !== 'undefined') {
            requestOptions.params = params;
        }

        if (this.isLogin) {
            requestOptions.headers['Authorization'] = 'Bearer ' + this.$auth.token();
        }

        return requestOptions;
    }

    get(url, params) {
        return this.$axios.get(url, this.getRequestOptions(params));
    }

    post(url, params) {
        return this.$axios.post(url, params, this.getRequestOptions());
    }

    downloadFile(url,params,type) {

        const option = this.getRequestOptions(url, this.getRequestOptions(params));

        if (typeof type !== undefined) {
            option['responseType'] = type;
        }

        return this.$axios.get(url, option);
    }
    getErrorMessage(error) {
        if (typeof error === 'string') return error;
        else {
            if (error.response !== undefined && error.response.data !== undefined) {
                return error.response.data.message
            } else if (error.message !== undefined) {
                return error.message
            } else {
                return 'Error';
            }
        }
    }
}

export default Api;