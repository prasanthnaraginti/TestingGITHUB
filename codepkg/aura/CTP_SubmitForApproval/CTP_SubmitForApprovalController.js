({
    doInit : function(component, event, helper) {  
		var articleId = component.get("v.recordId");
		console.log('articleId>>>>'+articleId);
        var action = component.get("c.getArticle");
        action.setParams({
            "articleId":articleId
        }); 
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                var allValues = response.getReturnValue();
				component.set('v.submitForApproval',allValues); 
                console.log('response>>>'+response+'Field Value'+component.get('v.submitForApproval'));
            }    
        });
          $A.enqueueAction(action);
    },
    
    handleClick: function(component, event, helper) {
        
        // Create the action
        var articleId = component.get("v.recordId");
        var action = component.get("c.submitAndProcessApprovalRequest");
        action.setParams({
            "articleId":articleId
        });
        
        // Add callback behavior for when response is received
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                var allValues = response.getReturnValue();
                 $A.get('e.force:refreshView').fire();
                var cmpSubmit=component.find('submitId');
                $A.util.addClass(cmpSubmit, 'slds-hidden'); 
                console.log(response);
            }    
        });
        
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
})