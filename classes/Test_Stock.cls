@isTest
private class Test_Stock {
    private static testmethod void testStock()
    {
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
        
        Stock.byVariantWithoutCache(new String[]{ 'P001' }, 213);

    }
}