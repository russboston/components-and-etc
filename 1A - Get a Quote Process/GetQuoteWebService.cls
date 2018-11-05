global class GetQuoteWebService {
    
    global class MyVars {
        @InvocableVariable(label='Contact ID') // not making it required for sake of example
        public Id myContactID;
        @InvocableVariable(label='Car Model' required=true)
        public String carModel;
    }
    
    @InvocableMethod(label='Get a Quote')
    global static void invokeService(List<MyVars> vars){       
        for(MyVars var : vars){        
            GetQuoteCallout.getQuote(var.myContactID, var.carModel);
        }
    }
}
