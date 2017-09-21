({
	SearchHelper: function(component, event) {
        var action = component.get("c.fetchAccount");
        /*action.setParams({
            'searchKeyWord': component.get("v.searchKeyword")
        });*/
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('@@@@@@@ state'+state);
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log('@@@@@@@ log'+ storeResponse.length);
                // if storeResponse size is 0 ,display no record found message on screen.
                if (storeResponse.length == 0) {
                    component.set("v.Message", true);
                } else {
                    component.set("v.Message", false);
                }
                // set numberOfRecord attribute value with length of return value from server
                component.set("v.numberOfRecord", storeResponse.length);
                // set searchResult list with return value from server.
                component.set("v.searchResult", storeResponse);
            }
 
        });
        $A.enqueueAction(action);
 
    },
    
     Navigate :function(component, event) {
        //console.log('Navigate Function called');
        var compEvent = component.getEvent("CTP_Insurer_look_up_Event"); 
        console.log('Navigate Function called');
        var myValue = component.get("v.searchKeyword");
        compEvent.setParams({"getParam" : myValue }); 
        compEvent.fire(); 
    }
})