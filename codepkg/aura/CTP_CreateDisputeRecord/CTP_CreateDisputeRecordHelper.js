({
	getDisputeCategories : function(component) {
		var action = component.get("c.getDisputeCategories");
         action.setCallback(this, function(a) {
            console.log('return value::'+a.getReturnValue());
            component.set("v.optionsDisputeCategory", a.getReturnValue());
            var dipsuteCategories = component.get("v.optionsDisputeCategory");
        	console.log("size:::"+dipsuteCategories);
         	var defaultCategory = dipsuteCategories[0];
            component.set("v.defaultCategory",defaultCategory);
        });
        $A.enqueueAction(action); 
	}
})