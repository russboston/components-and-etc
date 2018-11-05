({
	myAction : function(component, event, helper) {
        var action = component.get("c.getThisClaim");
        action.setParams({
            "thisRecordId": component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.myClaimDetail", data.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})
