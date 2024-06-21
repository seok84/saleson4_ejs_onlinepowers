import SalesonSupporter from "./SalesonSupporter.js";
import SalesonConst from "./SalesonConst.js";

const closeAlert = () => {
    const $modal = $('#op-alert');
    if ($modal.length > 0) {

        $modal.removeClass('show');
        $('body').css('overflow', '');

        $modal.find('.alert-type').hide();
        $modal.find('.confirm-type').hide();

    }
}

const alertEvent = (message, callback, confirmFlag = false) => {

    const callbackAlert = SalesonSupporter.isFunction(callback) ? callback : closeAlert;

    const $modal = $('#op-alert');

    if ($modal.length > 0) {
        $modal.find('.modal-content').text(message);

        if (confirmFlag) {
            $modal.find('.alert-type').hide();
            $modal.find('.confirm-type').show();
        } else {
            $modal.find('.alert-type').show();
            $modal.find('.confirm-type').hide();
        }
        $modal.find('button.op-modal-ok').unbind('click');
        $modal.find('button.op-modal-ok').on('click', function (e) {
            e.preventDefault();
            callbackAlert();
            closeAlert();
        });

        $modal.addClass('show');
        $('body').css('overflow', 'hidden');


    } else {

        if (confirmFlag) {
            if (confirm(message)) {
                callbackAlert();
            }
        } else {
            alert(message);
        }


    }
}

const toastEvent = (message) => {
    const $modal = $('#op-toast');
    const fadeIn = 300;
    const fadeOut = 1000;

    if ($modal.length > 0) {
        $modal.show();
        $modal.find('.desc').text(message);

        $modal.delay(fadeIn).fadeIn();
        $modal.delay(fadeOut).fadeOut();
    }
}

const nl2br = (str) => {
    return str.replace(/(?:\r\n|\r|\n)/g, '<br/>');
}

const tooltipEvent = (selector) => {
    let tooltipSelector;
    if (typeof selector != 'undefined' && selector != null && selector.length > 0) {

        const className = '.invalid'
        const targets = [
            selector.parent().find(className),
            selector.parents('div[class*=area]:eq(-1)').find(className),
            selector.parents('div[class*=wrap]:eq(0)').next(className)
        ];

        if (selector.hasClass(className)) {
            tooltipSelector = selector;
        } else {
            for (const target of targets) {
                if (target.length > 0) {
                    tooltipSelector = target;
                    break;
                }
            }
        }

    }

    const valid = typeof tooltipSelector !== undefined
        && tooltipSelector != null
        && tooltipSelector.length == 1;

    const hide = () => {
        if (valid) {
            tooltipSelector.removeClass('on');
            tooltipSelector.hide();
        }
    }

    return {
        valid() {
            return valid;
        },
        show(message) {
            if (valid) {
                hide();

                if (typeof message !== undefined && message != '') {
                    tooltipSelector.html(nl2br(message));
                    selector.parent().addClass("is-invalid"); //input 밑줄 빨간색으로 바꿈
                }
                tooltipSelector.show();
            }
        },
        hide() {
            hide();
        }
    }
}

export default {

    isFunction(c) {
        return SalesonSupporter.isFunction(c);
    },

    alert(message, callback) {
        alertEvent(message, callback, false);
    },

    confirm(message, callback) {
        alertEvent(message, callback, true);
    },

    closeAlert() {
        closeAlert();
    },

    toast(message) {
        toastEvent(message);
    },

    tooltip(selector) {
        return tooltipEvent(selector);
    },

    redirect(url) {
        location.href = url;
    },

    reload() {
        location.reload();
    },

    dateFormat(t, type) {
        let result = "";
        if (t != null) {
            if (type == null || type == "time") {
                result = t.replace(/(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/, '$1-$2-$3 $4:$5:$6');
            } else if (type == "date") {
                result = t.substr(0, 8).replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
            }
        }
        return result;
    },

    maxlength(e, len) {
        let str = e.target.value;
        if (str.length > len) {
            str = str.slice(0, len);

            this.$saleson.alert(len + '자를 초과 할 수 없습니다.');
            e.target.value = str;
        }
    },

    formatNumber(number) {
        try {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        } catch (e) {
            return number;
        }
    },


    unescapeHtml(str) {

        if (typeof str !== undefined && str != '') {
            str = str.replace(/&amp;/g, '&')
                .replace(/&#40;/g, '(')
                .replace(/&#41;/g, ')')
                .replace(/&lt;/g, '<')
                .replace(/&gt;/g, '>')
                .replace(/&quot;/g, '\"')
                .replace(/&apos;/g, '\'')
                .replace(/&#x2F;/g, '\\')
                .replace(/<p>&nbsp;<\/p>/g, '<br/>')
                .replace(/&nbsp;/g, ' ');
        }

        return str;
    },

    nl2br(value) {
        return nl2br(value);
    },

    /*
    * input name 에 `., []` 들어간 데이터를 json parsing
    * ex) let formData = $saleson.core.formToJson('buy');
    * api.post(url, formData);
    * */
    formToJson(formId) {

        const formDataArray = $(`#${formId}`).serializeArray();
        let formData = {};

        formDataArray.forEach(function (field) {
            let keys;

            if (field.name.includes('[')) {
                keys = field.name.match(/[^\[\]]+/g);
            } else {
                keys = field.name.split('.');
            }

            let currentObject = formData;

            for (let i = 0; i < keys.length; i++) {
                let key = keys[i];
                key = key.replace(/^\./, '');

                if (i === keys.length - 1) {
                    currentObject[key] = field.value;
                } else {
                    currentObject[key] = currentObject[key] || {};
                    currentObject = currentObject[key];
                }
            }
        });

        return formData;
    },

    isMobile() {
        const mobileRegex = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i;
        return mobileRegex.test(navigator.userAgent);
    },

    isApp() {
        const appRegex = /SALESON_APPLICATION_ANDROID|SALESON_APPLICATION_IOS/i;
        return appRegex.test(navigator.userAgent);
    },

    requestContext: SalesonSupporter.parseUrl(location.href),

    findDomain(str) {
        let result = '';
        if (str != null && str != '') {
            result = str.match(/^https?:\/\/([a-z0-9_\-\.]+)/i)[0];
        } else {
            result = '직접입력';
        }

        return result;
    },
    /**
     * 브라우저 이름을 소문자로 반환하며 Internet Explorer는 ie로 반환한다.<br />
     * 지원 브라우저 : Internet Explorer, Chrome, Opera, FireFox, Safari
     * @returns {String}
     */
    getBrowser(agent) {
        if (agent == null) {
            return '기타';
        }

        agent = agent.toLowerCase();
        let os = this.getOs(agent);
        let browser = '';

        if (agent.substr(0, 7) == 'mozilla' && agent.indexOf("like gecko") > -1 && agent.indexOf("edge") > -1) {
            browser = 'MS Edge';
        } else if (agent.indexOf('rv:11.0') > -1 || agent.indexOf('trident/7.0') > -1) {
            browser = 'IE 11';
        } else if (agent.indexOf('trident/6.0') > -1) {
            browser = 'IE 10';
        } else if (agent.indexOf('trident/5.0') > -1) {
            browser = 'IE 9';
        } else if (agent.indexOf('trident/4.0') > -1) {
            browser = 'IE 8';
        } else if (agent.indexOf("msie 6.") > -1) {
            browser = "IE 6";
        } else if (agent.indexOf("msie 5.5") > -1)	{
            browser = "IE 5.5";
        } else if (agent.indexOf("msie 5.") > -1)	{
            browser = 'IE 5';
        } else if (agent.indexOf('msie 7.') > -1) {
            browser = 'IE 7';
        } else if (agent.indexOf('msie 8.') > -1) {
            browser = 'IE 8';
        } else if (agent.indexOf('msie 9.') > -1) {
            browser = 'IE 9';
        } else if (agent.indexOf('msie 10.') > -1) {
            browser = 'IE 10';
        } else if (agent.indexOf('msie 4.') > -1) {
            browser = 'IE 4.x';
        } else if (os == 'iOS') {
            browser = 'Safari Mobile';
        } else if (agent.indexOf('firefox') > -1 && agent.indexOf('seamonkey') == -1) {
            browser = 'Firefox';
        } else if (agent.indexOf('safari') > -1 && !(agent.indexOf('chrome') > -1 || agent.indexOf('chromium') > -1)) {
            browser = 'Safari';
        } else if (agent.indexOf('chrome') > -1 && agent.indexOf('chromium') == -1) {
            browser = 'Chrome';
        } else if (agent.indexOf('opera') > -1) {
            browser = 'Opera';
        } else if (agent.indexOf('x11') > -1) {
            browser = 'Netscape';
        } else if (agent.indexOf('gec') > -1) {
            browser = 'Gecko';
        } else if (agent.indexOf('bot|slurp') > -1) {
            browser = 'Robot';
        } else if (agent.indexOf('internet explorer') > -1) {
            browser = 'IE';
        } else if (agent.indexOf('mozilla') > -1) {
            browser = 'Mozilla';
        } else {
            browser = '기타';
        }
        return browser;
    },

    getOs(agent) {
        if (agent == null) {
            return '기타';
        }
        agent = agent.toLowerCase();
        let os = '';

        if (agent.indexOf('windows 98') > -1)                 { os = 'Windows 98'; }
        else if (agent.indexOf('windows 95') > -1)            { os = 'Windows 95'; }
        else if(agent.indexOf('windows nt 4') > -1)   		  { os = 'Windows NT'; }
        else if(agent.indexOf('windows nt 5.0') > -1)         { os = 'Windows 2000'; }
        else if(agent.indexOf('windows nt 5.1') > -1)         { os = 'Windows XP'; }
        else if(agent.indexOf('windows nt 5.2') > -1)         { os = 'Windows XP x64'; }
        else if(agent.indexOf('windows nt 6.0') > -1)         { os = 'Windows Vista'; }
        else if(agent.indexOf('windows nt 6.1') > -1)         { os = 'Windows 7'; }
        else if(agent.indexOf('windows nt 6.2') > -1)         { os = 'Windows 8'; }
        else if(agent.indexOf('windows nt 6.3') > -1)         { os = 'Windows 8.1'; }
        else if(agent.indexOf('windows nt 10') > -1)          { os = 'Windows 10'; }
        else if(agent.indexOf('windows 9x') > -1)             { os = 'Windows ME'; }
        else if(agent.indexOf('windows ce') > -1)             { os = 'Windows CE'; }
        else if(agent.indexOf('macintosh') > -1)              { os = 'Mac OS'; }
        else if(agent.indexOf('iphone') > -1)                 { os = 'iOS'; }
        else if(agent.indexOf('android') > -1)                { os = 'Android'; }
        else if(agent.indexOf('mac') > -1)                    { os = 'Mac OS'; }
        else if(agent.indexOf('linux') > -1)                  { os = 'Linux'; }
        else if(agent.indexOf('sunos') > -1)                  { os = 'sunOS'; }
        else if(agent.indexOf('irix') > -1)                   { os = 'IRIX'; }
        else if(agent.indexOf('phone') > -1)                  { os = 'Phone'; }
        else if(agent.indexOf('bot|slurp') > -1)              { os = 'Robot'; }
        else if(agent.indexOf('internet explorer') > -1)      { os = 'IE'; }
        else if(agent.indexOf('mozilla') > -1)                { os = 'Mozilla'; }
        else { os = '기타'; }

        return os;
    },

    getDomainName(domain) {
        if (domain == null) {
            return '';
        }

        let domainName = domain;
        if (domain.indexOf('naver.com') > -1) {
            domainName = '네이버';
        } else if (domain.indexOf('google.co.kr') <= -1 && domain.indexOf('google.com') <= -1) {
            if (domain.indexOf('yahoo.co.kr') <= -1 && domain.indexOf('yahoo.com') <= -1) {
                if (domain.indexOf('daum.net') > -1) {
                    domainName = '다음';
                } else if (domain.indexOf('paran.com') > -1) {
                    domainName = '파란';
                } else if (domain.indexOf('msn.com') > -1) {
                    domainName = 'MSN';
                } else if (domain.indexOf('nate.com') > -1) {
                    domainName = '네이트';
                } else if (domain.indexOf('onlinepowers.com') > -1) {
                    domainName = '온라인파워스';
                } else if (domain.indexOf('jungle.co.kr') > -1) {
                    domainName = '디자인정글';
                } else if (domain.indexOf('gongmo21.com') > -1) {
                    domainName = '공모닷컴';
                } else if (domain.indexOf('reportworld.co.kr') > -1) {
                    domainName = '레포트월드';
                } else if (domain.indexOf('campusmon.com') > -1) {
                    domainName = '캠퍼스몬';
                } else if (domain.indexOf('chulsa.kr') > -1) {
                    domainName = '출사닷컴';
                } else if (domain.indexOf('beautifulshinhan.com') > -1) {
                    domainName = '직접입력';
                } else if (domain == '직접입력') {
                    domainName = '직접입력';
                }
            } else {
                domainName = '야후';
            }
        } else {
            domainName = '구글';
        }

        return domainName;
    },
    api: {
        host: SalesonSupporter.getCookie(SalesonConst.cookie.API),
        handleApiExeption(error, failureHandler) {

            const requestContext = SalesonSupporter.parseUrl(location.href);

            if (SalesonSupporter.isFunction(failureHandler)) {
                failureHandler(error);
            } else {
                if (error.response) {

                    if (error.response.status === 401) {        // 토큰만료

                        if ("SLEEP_USER" === error.response.data.code) { // 휴면 회원

                            if (requestContext.requestUri === SalesonConst.pages.SLEEP_USER) {
                                return;
                            }

                            alertEvent("휴면 전환된 계정입니다.", () => {
                                location.href = SalesonConst.pages.SLEEP_USER;
                            });
                            return;
                        }

                        if ("PASSWORD_EXPIRED" === error.response.data.code) { // 패스워드 기간 만료

                            if (requestContext.requestUri === SalesonConst.pages.EXPIRED_PASSWORD) {
                                return;
                            }

                            alertEvent("패스워드 기간이 만료 되었습니다.", () => {
                                SalesonConst.redirect(SalesonConst.pages.EXPIRED_PASSWORD);
                            });
                            return;
                        }

                        if ("TEMP_PASSWORD" === error.response.data.code) { // 패스워드 기간 만료

                            if (requestContext.requestUri === SalesonConst.pages.TEMP_PASSWORD) {
                                return;
                            }
                            location.href = SalesonConst.pages.TEMP_PASSWORD;
                            return;
                        }

                        alertEvent("로그인 후 이용이 가능합니다.", () => {
                            const url = SalesonConst.pages.LOGIN + "?target=" + encodeURIComponent(requestContext.requestFullUri);
                            /*$s.logout(url);*/
                        });
                        return;
                    }
                    // $s.alert(error.response.data.description);
                    const erd = error.response.data;
                    alertEvent(erd.message == null || erd.message == "" ? erd.description : erd.message);
                } else {
                    alertEvent(error);
                }
            }
        }
    },

    store: {
        session: {
            get(name) {
                return SalesonSupporter.getSessionStorage(name);
            },
            set(name, value) {
                SalesonSupporter.setSessionStorage(name, value);
            },
            remove(name) {
                SalesonSupporter.removeSessionStorage(name);
            },
        },
        local: {
            get(name) {
                return SalesonSupporter.getLocalStorage(name);
            },
            set(name, value) {
                SalesonSupporter.setLocalStorage(name, value);
            },
            remove(name) {
                SalesonSupporter.removeLocalStorage(name);
            },
        },
        cookie: {
            get(name) {
                return SalesonSupporter.getCookie(name);
            },
            set(name, value, options) {
                return SalesonSupporter.setCookie(name, value, options);
            }
        }
    }
}