/**
 * Created by Eugene on 07.09.2019.
 */
({
    init : function(cmp, e, h) {
        cmp.set('v.productColumns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Product Code', fieldName: 'ProductCode', type: 'text'}
        ]);

        cmp.set('v.stockColumns', [
            {label: 'Demandware ID', fieldName: 'demandwareId', type: 'text'},
            {label: 'Available For Ecommerce', fieldName: 'available', type: 'number'}
        ]);

        h.callAction(
            cmp.get('c.getStores'),
            {},
            function(response) {
                console.log('SEARCH RESULT', response.getReturnValue());
                cmp.set('v.stores', response.getReturnValue());
            }
        );
    },

    searchProducts : function(cmp, e, h) {
        var isEnterKey = e.keyCode === 13;
        if (isEnterKey) {
            h.callAction(
                cmp.get('c.getProducts'),
                { searchText : cmp.get('v.productSearch') },
                function(response) {
                    cmp.set('v.products', []);
                    console.log('SEARCH RESULT', response.getReturnValue());
                    cmp.set('v.products', response.getReturnValue());
                }
            );
        }
    },

    checkStock : function(cmp, e, h) {
        var prods = cmp.find('productsTable').getSelectedRows();
        if (prods.length > 0) {
            var params = {
                demandwareIds : [],
                locationId : null
            };
            var demandwareIds = [];
            for (var i = 0, len = prods.length; i < len; i++) {
                params.demandwareIds.push(prods[i].Demandware_Id__c);
            }
            params.locationId = cmp.find('storesSelect').get('v.value');
            h.callAction(
                cmp.get('c.getStock'),
                params,
                function(response) {
                    var result = response.getReturnValue();
                    var stock = [];
                    Object.keys(result).forEach(function(key) {
                        stock.push({ demandwareId : key, available : result[key] });
                    });
                    cmp.set('v.stock', stock);
                }
            );
        }
    },

    reset : function(cmp, e, h) {
        cmp.set('v.stock', []);
        cmp.set('v.products', []);
        cmp.find('searchProduct').set('v.value', '');
    }
})