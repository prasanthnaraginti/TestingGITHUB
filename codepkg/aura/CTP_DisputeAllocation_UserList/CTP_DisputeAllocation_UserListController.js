({
	allocateSelectedUser : function(component, event, helper) {
		var assessorRecord = component.get("v.assessor");
        if(assessorRecord.isSelected){
            console.log("sel:::"+assessorRecord);
            var createEvent = component.getEvent("getSuitableAssessor");
            createEvent.setParams({"suitableAssessor" : assessorRecord});
            createEvent.fire();
        }
        
	}
})