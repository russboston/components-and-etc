public class GetQuoteData {
    
    @AuraEnabled
    public static List<Quote__c> getExternalData(Id extId){
        
        String carModel = [SELECT Car_Model__c FROM Contact WHERE Id = :extId LIMIT 1].get(0).Car_Model__c;
        
        List<Quote__c> myQuoteList = new List<Quote__c>();
        

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('WEB_SERVICE_URL_GOES_HERE/' + carModel);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
        List<String> myStrings = new List<String>();
        for (Object o : results){
            myStrings.add(String.valueOf(o));
        }
		
        
        // Utilizing Quote object in memory for example sake - in reality, more optimal to use generic Object JSON deserialization
        for(Integer i = 0; i < myStrings.size(); i++){
            myQuoteList.add(new Quote__c(Ext_Id__c=myStrings[i].substring(0,8),
                                   Rate__c=Integer.valueOf(myStrings[i].substringAfter ('$'))));
        }
        
        //System.debug(myQuoteList.get(0).Ext_Id__c + ' --- ' + myQuoteList.get(0).Rate__c);
        
        return myQuoteList;
    
    }
}
