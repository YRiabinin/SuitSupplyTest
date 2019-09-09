/**
 * Created by Eugene on 07.09.2019.
 */

public with sharing class StockCheckController {
    @AuraEnabled
    public static List<Product2> getProducts(String searchText) {
        List<Product2> result = new List<Product2>();
        if (String.isNotBlank(searchText)) {
            searchText = '%' + searchText + '%';
            result = [SELECT Id, Name, ProductCode, Demandware_Id__c, Description FROM Product2 WHERE Name LIKE :searchText OR ProductCode LIKE :searchText LIMIT 1000];
        }
        return result;
    }

    @AuraEnabled
    public static List<Store__c> getStores() {
        return [SELECT Id, Name, Stock_location_id__c FROM Store__c LIMIT 100];
    }

    @AuraEnabled
    public static Map<String, Decimal> getStock(String[] demandwareIds, Integer locationId) {
        Map<String, Decimal> result = new Map<String, Decimal>();
        try {
            result = Stock.byVariantWithoutCache(demandwareIds, locationId);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
        return result;
    }

    public class StockCheck {
        public String demandwareIds { get; set; }
        public Decimal available { get; set; }

        public StockCheck(String demandwareIds, Decimal available) {
            this.demandwareIds = demandwareIds;
            this.available = available;
        }
    }
}