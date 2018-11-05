public class GetClaimByHeader {

    //Using a stub object but in practicallity, can use a "generic" object called "Object" (& JSON deserialize it)
    
    @AuraEnabled
    public static Claim_Detail__c getThisClaim(Id thisRecordId){
        
        String claimHeader = [SELECT Id, Claim_Header__c FROM Claim1__c WHERE Id = :thisRecordId LIMIT 1].get(0).Claim_Header__c;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('WEB_SERVICE_URL_GOES_HERE/' + claimHeader);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
        List<String> myStrings = new List<String>();
        for (Object o : results){
            myStrings.add(String.valueOf(o));
        }

		//After initial JSON.desrializate above, the rest is just string-parsed, for brevity/example sake
		        
        Claim_Detail__c myDetail = new Claim_Detail__c();
        myDetail.Amount__c = Integer.valueOf(myStrings[0].substringAfter ('$'));
        myDetail.Claim_ID__c = myStrings[0].substring(0,8);
        myDetail.Type__c = myStrings[0].substringAfterLast(' - ').substringBefore(' @').substringBefore('~');
        myDetail.Status__c = myStrings[0].substringAfterLast(' - ').substringBefore(' @').substringAfter('~').substringBefore('/');
        myDetail.Source__c = myStrings[0].substringAfterLast(' - ').substringBefore(' @').substringAfter('~').substringAfter('/');
        
        return myDetail;
    }
    
}
