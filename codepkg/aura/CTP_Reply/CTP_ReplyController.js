({
    init : function(component, event, helper) {
        
        var action = component.get("c.getCaseItemDetails");
        if (window.location.pathname && window.location.pathname.split('/')[1])
            component.set('v.communitylink', window.location.pathname.split('/')[1]);
        action.setParams({"caseItemId": component.get("v.recordId")});
        //var res = document.getElementById("response").value() ;
        console.log('------------'+component.get("v.recordId"));
        component.set('v.formLocked', true);
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.caseItem", response.getReturnValue());
            } else {
                console.log('Problem getting Case Item, response state: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    
    submit: function(component, event, helper) {
        // Prepare the action to create the new contact
        var saveCaseItemAction = component.get("c.saveCaseItems");
        saveCaseItemAction.setParams({
            "caseItemId": component.get("v.recordId"),
            "response" : document.getElementById("res").value
        });
        console.log('==========='+component.get("v.recordId"));
        console.log('==========='+document.getElementById("res").value);
        // Configure the response handler for the action
        saveCaseItemAction.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                /*
                
                // Prepare a toast UI message
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Case Item Saved",
                    "message": "Case Item Updated."
                });
                
                // Update the UI: close panel, show toast, refresh account page
                $A.get("e.force:closeQuickAction").fire();
                resultsToast.fire();
                $A.get("e.force:refreshView").fire();
            
            */
                
                console.log('-------------caseId'+response.getReturnValue());
                var evt = $A.get("e.force:navigateToURL");
                
                
                if (evt) {
                    evt.setParams({
                        "url": '/casedetail?recordId=' + response.getReturnValue(),
                        "isredirect": true,
                    });
                    console.log('evt url is'+evt.getParam("url"));
                    evt.fire();
                }
                
            }
            else if (state === "ERROR") {
                console.log('Problem saving contact, response state: ' + state);
            }
                else {
                    console.log('Unknown problem, response state: ' + state);
                }
        });
        
        // Send the request to create the new contact
        $A.enqueueAction(saveCaseItemAction);
    },
    
    handleCancel: function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})