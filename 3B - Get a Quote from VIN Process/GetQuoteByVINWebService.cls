global class GetQuoteByVINWebService {
    
    global class MyVars {
        @InvocableVariable(label='Record ID')
        public Id recordId;
        @InvocableVariable(label='VIN')
        public String givenVIN;
        @InvocableVariable(label='Rate for Small Engine')
        public Integer smallRate; 
        @InvocableVariable(label='Rate for Medium Engine')
        public Integer midRate;
        @InvocableVariable(label='Rate for Large Engine')
        public Integer largeRate; 
        @InvocableVariable(label='Factor for Old Car (2010-)')
        public Integer oldCarFactor;
        @InvocableVariable(label='Factor for Classic Car (2011-2015)')
        public Integer classicCarFactor;
        @InvocableVariable(label='Factor for New Car (2016+)')
        public Integer newCarFactor;   
    }
    
    @InvocableMethod(label='Get a Quote from VIN')
    global static void invokeService(List<MyVars> vars){       
        for(MyVars var : vars){        
            GetQuoteByVINcallout.bringFromOutside(var.recordId, var.givenVIN, var.smallRate, var.midRate, var.largeRate, var.oldCarFactor, var.classicCarFactor, var.newCarFactor);
        }
    }
}
