export default {
    parseUrl: (url) => {
        const self = {};

        let parser = document.createElement("a");
        parser.href = url;

        // IE 8 and 9 dont load the attributes "protocol" and "host" in case the source URL
        // is just a pathname, that is, "/example" and not "http://domain.com/example".
        parser.href = parser.href;

        // IE 7 and 6 wont load "protocol" and "host" even with the above workaround,
        // so we take the protocol/host from window.location and place them manually
        if (parser.host === "") {
            let newProtocolAndHost = window.location.protocol + "//" + window.location.host;
            if (url.charAt(1) === "/") {
                parser.href = newProtocolAndHost + url;
            } else {
                // the regex gets everything up to the last "/"
                // /path/takesEverythingUpToAndIncludingTheLastForwardSlash/thisIsIgnored
                // "/" is inserted before because IE takes it of from pathname
                let currentFolder = ("/" + parser.pathname).match(/.*\//)[0];
                parser.href = newProtocolAndHost + currentFolder + url;
            }
        }

        // copies all the properties to this object
        let properties = ['host', 'hostname', 'hash', 'href', 'port', 'protocol', 'search'];
        for (let i = 0, n = properties.length; i < n; i++) {
            self[properties[i]] = parser[properties[i]];
        }

        // pathname is special because IE takes the "/" of the starting of pathname
        self.pathname = (parser.pathname.charAt(0) !== "/" ? "/" : "") + parser.pathname;

        // requestUri
        self.requestUri = self.pathname;
        self.requestFullUri = self.pathname + self.search;

        return self;
    },

    getParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        let regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        let results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    },

    isFunction(func) {
        return func != null && typeof func === 'function' ? true : false;
    },

    makePagination(areaSelector = '#paginationArea', currentPage = 1, totalPages = 1, pageSize = 5, callback) {
        const getPagination = (currentPage = 1, totalPages = 1, pageSize = 5)=>{

            const pagination = {
                previous : {
                    page: -1,
                    show: false,
                },
                next : {
                    page: -1,
                    show: false,
                },
                pageNumbers : []
            }

            let n = 0;
            let startPage = 0;
            let endPage = 0;
            let halfSizeFloor = 0;
            let current = currentPage;
            let total = totalPages;

            current = current > total ? total : current;

            n = pageSize / 2;

            halfSizeFloor = Math.floor(n - (1 - (n % 1)) % 1);

            startPage = current < halfSizeFloor + 1 ? 1 : current - halfSizeFloor;
            startPage = current > total - halfSizeFloor ? total - pageSize + 1 : startPage;

            endPage = startPage + pageSize - 1;
            endPage = endPage > total ? total : endPage;

            startPage = total < pageSize ? 1 : startPage;
            endPage = total < pageSize ? total : endPage;

            const pageNumbers = [];

            for (let i = startPage; i <= endPage; i++) {
                pageNumbers.push(i);
            }

            if (!pageNumbers.length > 0) {
                pageNumbers.push(1);
            }


            let nextPage = current + 1;
            if (nextPage > total) {
                nextPage = total;
            }

            let previousPage = current - 1;
            if (previousPage < 1) {
                previousPage = 1;
            }

            pagination.next.page = nextPage;
            pagination.next.show = current < total;

            pagination.previous.page = previousPage;
            pagination.previous.show = current > 1;

            pagination.pageNumbers = pageNumbers;

            return pagination;
        }

        const getChildSelector = (page, label) =>{

            const callbackEvent = (event) => {
                event.preventDefault();
                callback(event.target.dataset.page);
                return false;
            }

            const $child = document.createElement('li');
            $child.innerText = label;
            $child.dataset.page = page;
            $child.addEventListener('click', callbackEvent);
            return $child;
        }

        const $area = document.querySelector(areaSelector);

        if ($area) {

            //$area.innerHTML = '';
            while ($area.firstChild) {
                $area.removeChild($area.lastChild);
            }

            const pagination = getPagination(currentPage, totalPages, pageSize);

            const $parent = document.createElement('ul');

            if (pagination.previous.show) {
                $parent.appendChild(getChildSelector(pagination.previous.page, '<'));
            }

            for (let i=0; i< pagination.pageNumbers.length; i++) {
                const page = pagination.pageNumbers[i];
                $parent.appendChild(getChildSelector(page, page));
            }

            if (pagination.next.show) {
                $parent.appendChild(getChildSelector(pagination.next.page, '>'));
            }

            $area.appendChild($parent);
        }
    },
    getCookie(name = '') {

        const cookies = document.cookie.split('; ').map((el) => el.split('='));

        if (typeof cookies !== undefined && cookies != null && cookies.length > 0) {

            const cookie = cookies.find((c)=>{
                return c[0] === name;
            })

            if (typeof cookie !== undefined && cookie != null) {
                return cookie[1];
            }
        }

        return '';
    },
    setCookie(name = '', value, options = {}) {
        options['path'] = '/';

        if (options['expires'] instanceof Date) {
            options['expires'] = options['expires'].toUTCString();
        }

        let updatedCookie = encodeURIComponent(name) + '=' + encodeURIComponent(value);

        for (let optionKey in options) {
            updatedCookie += '; ' + optionKey;
            let optionValue = options[optionKey];
            if (optionValue !== true) {
                updatedCookie += '=' + optionValue;
            }
        }

        document.cookie = updatedCookie;
    },
    getSessionStorage(name = '') {
        return window.sessionStorage.getItem(name);
    },
    setSessionStorage(name = '', value) {
        window.sessionStorage.setItem(name, value);
    },
    removeSessionStorage(name = '') {
        window.sessionStorage.removeItem(name);
    },
    getLocalStorage(name = '') {
        return window.localStorage.getItem(name);
    },
    setLocalStorage(name = '', value) {
        window.localStorage.setItem(name, value);
    },
    removeLocalStorage(name = '') {
        window.localStorage.removeItem(name);
    },
}