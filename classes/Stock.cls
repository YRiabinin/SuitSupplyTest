public class Stock {

public static Map<String, Decimal> byVariantWithoutCache(String[] demandwareIds, Integer locationId){
        
    String[] idsToCheck = new String[]{};
    Map<String, Decimal> resultMap = new Map<String, Decimal>();
    for (String dwId : demandwareIds){
        idsToCheck.add(dwId);
    }
    
    if (!idsToCheck.isEmpty())
    {
        HttpResponse res = new HttpResponse();
        String resString = '[{"requestedAs": "' + demandwareIds[0] + '","itemId": 439163,"locationId": 44,"availableForEcommerce": 1}]';
        res.setBody(resString);
        res.setStatusCode(200);
        if (res.getStatusCode() == 200){
            for (Stock.StockResponse sr : (Stock.StockResponse[]) JSON.deserialize(
                res.getBody(), Stock.StockResponse[].class)){
                    resultMap.put(sr.requestedAs, sr.availableForEcommerce);
                }
            for(string s :idsToCheck){
                if(resultMap.get(s) == null){resultMap.put(s, 0);}
            }   
            System.debug(res.getStatusCode());
            
        } 
    }
    return resultMap;
}


public Class StockResponse {
    public Integer itemId;
    public Integer locationId;
    public Double availableForEcommerce;
    public Double availableForTransfer;
    public String requestedAs;
}
public Class StockResponseData {
    public StockResponseAll[] data;
}
public Class StockResponseAll {
    public Integer itemId;
    public String variantCode;
    public Location[] locations;
}
public Class Location {
    public Integer locationId;
    public Double availableForEcommerce;
    public Double availableForTransfer;
    public String locationName;
}

}