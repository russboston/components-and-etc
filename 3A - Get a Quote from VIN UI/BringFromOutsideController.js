({
	handleFromOutside : function(component, event, helper) {
        var action = component.get("c.bringFromOutside");
        action.setParams({
            "recordId": component.get("v.recordId"),
            "givenVIN" : component.get("v.VIN"),
            "smallRate" : component.get("v.smallRate"),
            "midRate" : component.get("v.midRate"),
            "largeRate" : component.get("v.largeRate"),
            "oldCarFactor" : component.get("v.oldCarFactor"),
            "classicCarFactor" : component.get("v.classicCarFactor"),
            "newCarFactor" : component.get("v.newCarFactor")
        });
        
        action.setCallback(this, function(data) {
            component.set("v.Output", data.getReturnValue());
        });
        
        component.set("v.showMe",true);                        
        $A.enqueueAction(action);
        
	}    
})
