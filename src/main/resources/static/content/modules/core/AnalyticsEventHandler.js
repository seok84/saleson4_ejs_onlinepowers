const validFirebase = () => {
    return typeof $firebase !== 'undefined' && typeof $firebase !== undefined && $firebase != null;
}

const getBaseProduct = () => {
    return {
        brand: '',
        id: '',
        name: '',
        price: -1,
        quantity: -1,
        variant: '',
        discount: 0
    }
}

const getSelectorItem = ($selector) => {

    const item = getBaseProduct();

    try {
        item.id = $selector.data('item-user-code');
        item.name = $selector.data('item-name');
        item.brand = $selector.data('brand');
        item.price = Number($selector.data('present-price'));
        item.discount = Number($selector.data('discount-amount'));
    } catch (e) {
    }

    return item;
}

const getImpressionsItem = (paramItem = {}, index = 0) => {

    let returnItem = null;
    const item = getBaseProduct();

    Object.assign(item, paramItem);

    if (isValid(item.id) || isValid(item.name)) {

        returnItem = {};

        if (isValid(item.id)) {
            returnItem['item_id'] = item.id;
        }

        if (isValid(item.name)) {
            returnItem['item_name'] = item.name;
        }

        if (isValid(item.brand)) {
            returnItem['item_brand'] = item.brand;
        }

        if (isValid(item.variant)) {
            returnItem['item_variant'] = item.variant;
        }

        const price = item.price;
        if (isValid(price.toString()) && price > -1) {
            returnItem['price'] = price;
        }

        const quantity = item.quantity;
        if (isValid(quantity.toString()) && quantity > -1) {
            returnItem['quantity'] = item.quantity;
        }

        const discount = item.discount;
        if (isValid(discount.toString()) && discount > -1) {
            returnItem['discount'] = item.discount;
        }

        returnItem['index'] = index;
    }

    return returnItem;

    function isValid(value) {
        return value != '';
    }
}

const impression = (items = [], listName = '', listId = '') => {
    try {

        if (validFirebase() && items.length > 0) {

            const params = {
                'item_list_id': listId,
                'item_list_name': listName,
                'items': items
            }

            $firebase.event('view_item_list', params);
        }
    } catch (e) {
    }
}

const select = (items = [], listName = '', listId = '') => {
    try {
        if (validFirebase() && items.length > 0) {

            const params = {
                'item_list_id': listId,
                'item_list_name': listName,
                'items': items
            }

            $firebase.event('select_item', params);
        }
    } catch (e) {
    }
}

const frontSelect = (item, listName, listId) => {
    try {

        const gaItem = getImpressionsItem(item, -1);

        if (gaItem != null) {
            select([gaItem], listName, listId);
        }
    } catch (e) {
    }
}

const frontImpression = (items = [], listName = '', listId = '') => {
    try {

        const gaItems = [];
        if (items.length > 0) {
            let index = 0;
            for (let i = 0; i < items.length; i++) {
                const item = items[i],
                    gaItem = getImpressionsItem(item, index);

                if (gaItem != null) {
                    gaItems.push(gaItem);
                    index++;
                }
            }

            impression(gaItems, listName, listId);
        }
    } catch (e) {
        console.error(e)
    }
}


const getItem = (list = [], key = '') => {

    try {
        if (list.length > 0 && key != '') {
            const elements = list.filter((l) => l['key'] == key.toString());

            if (elements.length > 0) {
                return JSON.parse(JSON.stringify(elements[0]));
            }
        }
    } catch (e) {
    }

    return null;
}

const getBaseEcommerceParam = (products = []) => {

    let value = 0;
    const items = [];

    if (products.length > 0) {
        let index = 0;
        products.forEach(p => {

            const item = getImpressionsItem(p, index);

            const calcQuantity = p.quantity <= 0 ? 1 : p.quantity;

            if (item != null && p.price > -1) {
                items.push(item);
                value += (p.price * calcQuantity);
                index++;
            }

        });
    }

    return {
        currency: 'KRW',
        value: value,
        items: items
    }
}

const getEcommerceOrderPram = (type = '', data = {transactionId: '', items: []}) => {

    let param = null;

    if (isValid(data.transactionId) || isValid(data.items)) {

        param = {};

        if (isValid(data.transactionId)) {
            param['transaction_id'] = data.transactionId;
        }

        param['currency'] = 'KRW';

        if (isValid(data.value.toString())) {
            param['value'] = data.value;
        }

        if ('purchase' == type) {
            if (isValid(data.tax.toString())) {
                param['tax'] = data.tax;
            }
            if (isValid(data.shipping.toString())) {
                param['shipping'] = data.shipping;
            }
        } else {

        }

        let items = [];

        const products = data.items;
        if (products != null && products.length > 0) {

            if ('purchase' == type) {
                let index = 0;
                products.forEach(p => {

                    const item = getImpressionsItem(p, index);
                    if (item != null && p.price > -1) {
                        items.push(item);
                        index++;
                    }

                });
            } else if ('refund' == type) {
                products.forEach(p => {
                   items.push({id: p.id, quantity: p.quantity})
                });
            } else {
                items = data.items;
            }
        }

        param['items'] = items;

    }

    return param;

    function isValid(value) {
        return value != '';
    }
}

const ecommerceEvent = (eventName = '', items = [], addParams = {}) => {
    try {
        if (validFirebase() && eventName != '' && items.length > 0) {

            const param = getBaseEcommerceParam(items);

            try {
                if (addParams != null) {
                    const addParamKeys = Object.keys(addParams);

                    if (addParamKeys.length > 0) {
                        Object.assign(param, addParams)
                    }
                }
            } catch (e) {
            }


            //console.log('ecommerceEvent', eventName, JSON.stringify(param));

            if (param.items.length > 0) {
                $firebase.event(eventName, param);
            }
        }
    } catch (e) {
    }
}

export default {
    view(title = '') {
        try {
            if (validFirebase()) {
                $firebase.pageView(title);
            }
        } catch (e) {
            console.error(e)
        }
    },
    frontSelect($selector, listName, listId) {
        try {
            if ($selector.length > 0) {
                frontSelect(getSelectorItem($selector), listName, listId);
            }
        } catch (e) {
            console.error(e);
        }

    },

    frontImpression($selector, listName, listId) {

        try {
            const items = [];
            if ($selector.length > 0) {
                const $datas = $selector.find('.item-analytics-data');

                if ($datas.length > 0) {
                    $datas.each(function (i) {
                        const $data = $datas.eq(i);
                        items.push(getSelectorItem($data));
                    });
                }
            }

            if (items.length > 0) {
                frontImpression(items, listName, listId);
            }
        } catch (e) {
            console.error(e);
        }
    },

    async itemView(itemUserCode = '') {

        if (itemUserCode != '') {
            try {

                if (validFirebase()) {
                    const response = await $saleson.api.post(`/api/analytics/item/${itemUserCode}`);

                    const data = response.data;

                    ecommerceEvent('view_item', [data]);

                }

            } catch (e) {
            }
        }
    },


    async addToWishlist(itemUserCode = '') {

        try {
            if (validFirebase()) {

                if (itemUserCode != '') {
                    const response = await $saleson.api.post(`/api/analytics/item/${itemUserCode}`);

                    const data = response.data;

                    ecommerceEvent('add_to_wishlist', [data]);
                }
            }
        } catch (e) {
        }

    },

    async addToCart(param = {arrayRequiredItems: []}) {

        try {
            if (validFirebase()) {
                if (param.arrayRequiredItems.length == 0) {
                    return false;
                }

                const response = await $saleson.api.post('/api/analytics/add-to-cart', param);

                ecommerceEvent('add_to_cart', response.data.list);

            }
        } catch (e) {
        }

    },

    removeFromCart(list = [], keys = []) {

        try {
            if (validFirebase() && list.length > 0 && keys.length > 0) {
                const items = [];
                for (const key of keys) {
                    const item = getItem(list, key);

                    if (item != null) {
                        items.push(item);
                    }
                }

                if (items.length > 0) {
                    ecommerceEvent('remove_from_cart', items);
                }
            }
        } catch (e) {
        }

    },

    async cartView(callback) {
        try {
            if (validFirebase()) {
                const response = await $saleson.api.post(`/api/analytics/cart`);
                const items = response.data.list;

                ecommerceEvent('view_cart', items);

                if ($saleson.core.isFunction(callback)) {
                    callback(items)
                }

            }
        } catch (e) {
        }
    },

    changeQuantity(list = [], key = '', changeQuantity = 0) {

        try {

            if (changeQuantity > 0) {
                const item = getItem(list, key);

                if (item != null) {

                    let calcQuantity = Math.abs(item.quantity - changeQuantity);

                    let eventName = '';
                    if (item.quantity > changeQuantity) {
                        eventName = 'remove_from_cart';
                    } else if (item.quantity < changeQuantity) {
                        eventName = 'add_to_cart';
                    }

                    if (calcQuantity > 0) {
                        item.quantity = calcQuantity;
                        ecommerceEvent(eventName, [item]);
                    }

                }

            }
        } catch (e) {
        }

    },

    async beginCheckout(callback) {
        try {
            if (validFirebase()) {

                const response = await $saleson.api.post(`/api/analytics/begin-checkout`);

                const items = response.data.list;

                ecommerceEvent('begin-checkout', items);

                if ($saleson.core.isFunction(callback)) {
                    callback(items)
                }
            }
        } catch (e) {
        }
    },

    addShippingInfo(list = [], shippingTier = '') {
        try {
            if (validFirebase() && list.length) {
                ecommerceEvent('add_shipping_info', list, {'shipping_tier': shippingTier});
            }
        } catch (e) {
        }
    },

    addPaymentInfo(list = [], paymentType = '') {
        try {
            if (validFirebase() && list.length) {
                ecommerceEvent('add_payment_info', list, {'payment_type': paymentType});
            }
        } catch (e) {
        }
    },

    async purchase(orderCode = '', orderSequence = '') {

        try {
            if (validFirebase() && orderCode != '' && orderSequence != '') {
                const response = await $saleson.api.post(`/api/analytics/order/${orderCode}/${orderSequence}`);
                const param = getEcommerceOrderPram('purchase', response.data);

                if (param != null && param.transaction_id != '') {
                    $firebase.event('purchase', param);
                }
            }
        } catch (e) {
        }
    },

    refund(data = {}) {

        try {
            if (validFirebase()) {
                const param = getEcommerceOrderPram('refund', data);

                if (param != null && param.transaction_id != '') {
                    $firebase.event('refund', param);
                }
            }
        } catch (e) {}
    },

    async allRefund(orderCode = '', orderSequence = '') {
        try {
            if (validFirebase() && orderCode != '' && orderSequence != '') {
                const response = await $saleson.api.post(`/api/analytics/order/${orderCode}/${orderSequence}`);
                const param = getEcommerceOrderPram('refund', response.data);

                if (param != null && param.transaction_id != '') {
                    $firebase.event('refund', param);
                }
            }
        } catch (e) {
        }
    },

    setUserId (data = {userId:0}) {
        try {

            if (validFirebase() && data.userId > 0) {

                const options = {}
                $firebase.setUserId(data.userId.toString(), options);
            }
        } catch (e) {

        }
    }
}