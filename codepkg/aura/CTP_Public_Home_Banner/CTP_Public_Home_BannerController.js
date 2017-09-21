({

    init : function(component, event, helper) {
        console.log('--------test');
         var action = component.get("c.getCurrentUser");
        console.log('--------test');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                console.log('--------'+response.getReturnValue());
                var name = response.getReturnValue().FirstName;
                console.log(name);
                component.set("v.userName",name);
            }else{
                console.log('debug');
            }
        });
        $A.enqueueAction(action);
    }
    

})