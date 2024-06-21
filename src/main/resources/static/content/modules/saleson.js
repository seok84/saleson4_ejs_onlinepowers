import SalesonConst from "./core/SalesonConst.js";
import SalesonCore from "./core/SalesonCore.js";
import SalesonEventLog from "./core/SalesonEventLog.js";
import SalesonEventHandler from "./core/SalesonEventHandler.js";
import SalesonAuth from "./core/SalesonAuth.js";
import Api from "./api/Api.js";
import AnalyticsEventHandler from "./core/AnalyticsEventHandler.js";


// axios 기본 설정
axios.defaults.baseURL = SalesonCore.api.host;

axios.defaults.headers.get['Content-Type'] = 'application/x-www-form-urlencoded';

axios.defaults.headers.put['Content-Type'] = 'application/json;charset=utf-8';

axios.defaults.headers.patch['Content-Type'] = 'application/json;charset=utf-8';
axios.defaults.headers.patch['Access-Control-Allow-Origin'] = '*';

axios.defaults.headers.delete['Content-Type'] = 'application/json;charset=utf-8';
axios.defaults.headers.delete['Access-Control-Allow-Origin'] = '*';

axios.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';
axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

axios.proxy = false;
axios.https = true;

window.$saleson = {
    const: SalesonConst,
    core: SalesonCore,
    axios: axios,
    auth : new SalesonAuth(axios, CryptoJS, SalesonCore.api.host),
    store: SalesonCore.store,
    ev: SalesonEventLog,
    handler: SalesonEventHandler,
    analytics: AnalyticsEventHandler
}
window.$saleson.api = new Api(window.$saleson);

$saleson.ev.init($saleson);
$saleson.auth.setSessionTimeout();
$saleson.handler.formEventHandler();

