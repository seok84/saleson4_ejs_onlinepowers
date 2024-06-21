import SalesonSupporter from "./SalesonSupporter.js";
import Api from "../api/Api.js"

let SALESON;

const ev = {
    const: {
        EVENT_VIEW_UID : '_FRONTEND_EVENT_VIEW_UID',
        EVENT_VIEW_QUERY_STRING : '_FRONTEND_EVENT_VIEW_QUERY_STRING'
    },
    init: function($saleson) {

        SALESON = $saleson;

        let uid = ev.getUid();

        if (typeof uid === undefined || uid == '') {

            let paramUid = SalesonSupporter.getParameter('uid');

            if (typeof paramUid !== undefined && paramUid != '') {
                set(ev.const.EVENT_VIEW_UID, paramUid);

                let queryString = ev.getQueryString();

                if (typeof queryString == 'undefined' || queryString == '' ) {
                    let qs = location.search.replace('?','');
                    set(ev.const.EVENT_VIEW_QUERY_STRING, qs);
                }
            }
        }

        function set(cname, cvalue) {

            const expires = new Date();
            expires.setDate(expires.getDate() + 1);

            SalesonSupporter.setCookie(cname, cvalue, {'expires': expires});
        }
    },
    getUid: function() {
        return SalesonSupporter.getCookie(ev.const.EVENT_VIEW_UID);
    },
    getQueryString: function() {
        try {
            const value = SalesonSupporter.getCookie(ev.const.EVENT_VIEW_QUERY_STRING);
            return decodeURIComponent(value);
        } catch (e) {
            return ''
        }
    },
    error(message){
        console.log('[event log error]=>', message);
    },
    log : {
        getParamMap : function() {

            return make(ev.getQueryString());

            function make(qs) {
                let map = [];

                if (typeof qs != 'undefined' && qs != null) {
                    let params = qs.split('&');

                    for (let i=0; i<params.length; i++) {

                        let param = params[i],
                            array = param.split('=');

                        if (typeof array != 'undefined' && array != null) {
                            if (array.length == 2) {
                                map[array[0]]= array[1];
                            }else if (array.length == 1) {
                                map[array[0]]= '';
                            }
                        }
                    }
                }

                return map;
            }
        },
        getParamValue : function(map, key) {
            let value = map[key];
            return typeof value == 'undefined' || value == null ? '' : decodeURIComponent(value);
        },
        getLog : function(id, items) {
            let paramMap = ev.log.getParamMap();

            let log = {
                eventCode : ev.log.getParamValue(paramMap, 'ec'),
                uid : ev.getUid(),
                sourceUserId : ev.log.getParamValue(paramMap, 'source_user_id'),
                utmSource : ev.log.getParamValue(paramMap, 'utm_source'),
                utmMedium : ev.log.getParamValue(paramMap, 'utm_medium'),
                utmCampaign : ev.log.getParamValue(paramMap, 'utm_campaign'),
                utmItem : ev.log.getParamValue(paramMap, 'utm_item'),
                utmContent : ev.log.getParamValue(paramMap, 'utm_content')
            };

            if (typeof id != 'undefined' && id != null) {
                log['id'] = id;
            }

            if (typeof items != 'undefined' && items != null && Array.isArray(items)) {
                log['items'] = items;
            }

            return log;
        },
        async item(itemUserCode) {

            try {
                let params = ev.log.getLog(itemUserCode);
                const api = new Api(SALESON);

                await api.post('/api/event-log/item', params);

            } catch (e) {
                ev.error(e);
            }

        },
        async order(orderCode, itemUserCodes) {

            try {
                let params = ev.log.getLog(orderCode, itemUserCodes);
                const api = new Api(SALESON);

                await api.post('/api/event-log/order', params);

            } catch (e) {
                ev.error(e);
            }

        },
        async featured(itemUserCodes) {

            try {
                let params = ev.log.getLog('', itemUserCodes);
                const api = new Api(SALESON);

                await api.post('/api/event-log/featured', params);

            } catch (e) {
                ev.error(e);
            }
        },
        async joinUser(userId) {

            try {
                let params = ev.log.getLog(userId);
                const api = new Api(SALESON);

                await api.post('/api/event-log/join-user', params);

            } catch (e) {
                ev.error(e);
            }

        }
    }
}

export default ev;
