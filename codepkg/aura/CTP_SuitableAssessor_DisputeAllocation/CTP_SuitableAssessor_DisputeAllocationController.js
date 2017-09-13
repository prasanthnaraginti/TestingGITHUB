({
	cancel : function(component, event, helper) {
		
        var createEvent = component.getEvent("cancelAllocation");
        //createEvent.setParams({"suitableAssessor" : assessorRecord});
        createEvent.fire();
	}
})