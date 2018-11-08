public class GetClaimDetailInfo {    
    
    @AuraEnabled
    public static Object getThisClaim(Id thisRecordId){
        
        String claimHeader = [SELECT Id, Claim_Header__c FROM Claim1__c WHERE Id = :thisRecordId LIMIT 1].get(0).Claim_Header__c;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://gist.githubusercontent.com/russboston/033834d417f29b70710823df49300735/raw/02c837c39169ed3901c1c2fe0e3086b195cefcd3/claims.json');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        Map<String, Object> ourAttributes;
        OurClaim myClaimDetail;
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());            
            
            //Pass claimHeader to get Claim attributes
            ourAttributes = (Map<String, Object>)results.get(claimHeader);
			
            // process Claim attributes
            myClaimDetail = new OurClaim(String.valueOf(ourAttributes.get('type')), 
                                         String.valueOf(ourAttributes.get('status')),
                                         Integer.valueOf(ourAttributes.get('amount')),
                                         String.valueOf(ourAttributes.get('claimID')),
                                         String.valueOf(ourAttributes.get('source')));

        }
        
        return JSON.serialize(myClaimDetail);
    }
    

    public class OurClaim {
        String aType;
        String aStatus;
        Integer anAmount;
        String aClaimID;
        String aSource;
                
        public OurClaim(String givenType, String givenStatus, Integer givenAmount, String givenClaimID, String givenSource){
            aType = givenType;
            aStatus = givenStatus;
            anAmount = givenAmount;
            aClaimID = givenClaimID;
            aSource = givenSource;
            
        }
        
    }    
    
}
