({	
    doInit : function(component, event, helper) {  
        var caseId = component.get("v.recordId");
        var action = component.get("c.checkOwner");
        action.setParams({
            "caseId":caseId
        });
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                var showButton = response.getReturnValue(); 
                component.set("v.showButton",showButton);
                console.log(response);
            }    
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    handleClick: function(component, event, helper) {
        var caseId = component.get("v.recordId");
        // var caseId="5000k000002d5eK";
        var action = component.get("c.acceptCase");
        action.setParams({
            "caseId":caseId
        });
        
        // Add callback behavior for when response is received
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                $A.get('e.force:refreshView').fire();
                var result = response.getReturnValue(); 
                var cmpAccept=component.find('acceptId');
                $A.util.addClass(cmpAccept, 'slds-hidden');
                console.log(response);     
            }    
        });
        // Send action off to be executed
        $A.enqueueAction(action);    
    },
})