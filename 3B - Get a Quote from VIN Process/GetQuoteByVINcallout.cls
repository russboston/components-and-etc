public class GetQuoteByVINcallout {
	
	@future(Callout=true)
    public static void bringFromOutside(Id recordId, String givenVIN, Integer smallRate, Integer midRate, Integer largeRate, Integer oldCarFactor, Integer classicCarFactor, Integer newCarFactor){                

        Quote__c myQuote = new Quote__c();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('WEB_SERVICE_URL_GOES_HERE/' + givenVIN);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
        List<String> myStrings = new List<String>();
        for (Object o : results){
            myStrings.add(String.valueOf(o));
        }                
        
        myQuote.Engine_Size__c = myStrings[0].substringAfterLast(' - ').substringBefore(' @').substringBefore('~');
        myQuote.Make__c = myStrings[0].substringAfterLast(' - ').substringBefore(' @').substringAfter('~').substringBefore('/');
        myQuote.Model__c = myStrings[0].substringAfterLast(' - ').substringBefore(' @').substringAfter('~').substringAfter('/');
        myQuote.VIN__c = givenVIN;
        myQuote.Year__c = Integer.valueOf(myStrings[0].substringAfter ('$'));        		
        
        myQuote.Rate__c = SyncMe.calculateRate(Integer.valueOf(myQuote.Year__c), myQuote.Engine_Size__c, smallRate, midRate, largeRate, oldCarFactor, classicCarFactor, newCarFactor);
        
        //This determines whether store to Contact, Lead, or Account from Lightning Component
		String objectInScope = recordId.getSObjectType().getDescribe().getName();
        
        if(objectInScope == 'Contact'){
            myQuote.Contact__c = recordId;
            myQuote.RecordTypeId = '012f4000000Bh1RAAS'; // Doesn't need to be hard-coded (was just used as a shortcut) - this is a RecordType for UI-elegance in Page Layouts 
        } else if(objectInScope == 'Lead'){
            myQuote.Lead__c = recordId;
            myQuote.RecordTypeId = '012f4000000Bh1bAAC'; // Same comment as 3 lines above
        } else if(objectInScope == 'Account'){
            myQuote.Account__c = recordId;
            myQuote.RecordTypeId = '012f4000000Bh1WAAS'; // Same comment as 3 lines above
        }
        
        
        insert myQuote;
        
    }

    public static Integer calculateRate(Integer givenYear, String givenEngineSize, Integer smallRate, Integer midRate, Integer largeRate, Integer oldCarFactor, Integer classicCarFactor, Integer newCarFactor){
        Integer myRate = 0;

        if(givenEngineSize == 'Small'){
            myRate = Integer.valueOf(smallRate);
        } else if (givenEngineSize == 'Medium'){
            myRate = Integer.valueOf(midRate);
        } else if (givenEngineSize == 'Large'){
            myRate = Integer.valueOf(largeRate);
        }                  
        
        if(givenYear <= 2010){
            myRate = Integer.valueOf(myRate * Integer.valueOf(oldCarFactor));
        } else if ((givenYear >= 2011) && (givenYear <= 2015)){
            myRate = Integer.valueOf(myRate * Integer.valueOf(classicCarFactor));
        } else if (givenYear >= 2016){
            myRate = Integer.valueOf(myRate * Integer.valueOf(newCarFactor));
        }        
        
        return myRate;
    }    
    
}
