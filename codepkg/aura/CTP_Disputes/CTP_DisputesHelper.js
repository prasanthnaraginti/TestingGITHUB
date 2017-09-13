({
    //function to set the dispute record type id
	getRecortTypeId : function(component) {
		
        var action = component.get("c.getDisputeRecordTypeId");

        action.setCallback(this, function(a) {
            console.log('return value id::'+a.getReturnValue());
            component.set("v.recordTypeId", a.getReturnValue());
        });
        $A.enqueueAction(action); 
	}
    
 
})