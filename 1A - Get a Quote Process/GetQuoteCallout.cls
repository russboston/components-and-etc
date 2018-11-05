public class GetQuoteCallout {
	
	@future(Callout=true)
    public static void getQuote(Id myContactID, String carModel){
        
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
        
        String quoteAmount = myStrings[0].substringAfter ('$');
        System.debug(quoteAmount);                
        

        Quote__c myQuote = new Quote__c();
        myQuote.Contact__c = myContactID;
        myQuote.Rate__c = Integer.valueOf(quoteAmount); 
        myQuote.RecordTypeId = '012f4000000Bh1RAAS'; // Disergard this line, hardcoding is not necessary - it's done for something we'll use later
        insert myQuote;        

        
    }
}
