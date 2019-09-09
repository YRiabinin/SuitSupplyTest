/**
 * Created by Eugene on 08.09.2019.
 */

@IsTest
private class StockCheckControllerTest {
    @IsTest
    static void getProductsTest() {
        System.assert(StockCheckController.getProducts(null).isEmpty());

        Product2 p1 = new Product2(Name = 'P1',
                                   ProductCode = 'P001',
                                   Demandware_Id__c = 'P001',
                                   IsActive = true);
        Product2 p2 = new Product2(Name = 'P2',
                                   ProductCode = 'P002',
                                   Demandware_Id__c = 'P002',
                                   IsActive = true);
        insert new Product2[] { p1, p2 };
        System.assertEquals(2, StockCheckController.getProducts('p00').size());
        System.assertEquals(1, StockCheckController.getProducts('p002').size());
    }

    @IsTest
    static void getStoresTest() {
        Store__c store = new store__c(
                name = 'Copenhagen',
                Stock_location_id__c = '213',
                Location_Id__c = '213'
        );
        insert store;

        List<Store__c> result = StockCheckController.getStores();
        System.assertEquals('213', result[0].Stock_location_id__c);
    }

    @IsTest
    static void getStockTest() {
        Product2 p1 = new Product2(Name = 'Test'
                , ProductCode = 'P001'
                , Demandware_Id__c = 'P001'
                , IsActive = true);
        insert p1;

        Store__c store = new store__c(
                name = 'Copenhagen',
                Stock_location_id__c = '213',
                Location_Id__c = '213'
        );
        insert store;

        try {
            Map<String, Decimal> result = StockCheckController.getStock(null, null);
        } catch (AuraHandledException ahe) {
            System.assert(ahe != null);
        }

        Map<String, Decimal> result = StockCheckController.getStock(new String[] { 'P001' }, 213);
        System.assertEquals(1, result.size());
        for (String key : result.keySet()) {
            System.assertEquals('P001', key);
        }
    }
}