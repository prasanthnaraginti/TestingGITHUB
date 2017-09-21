({
    init : function(component, event, helper) {
        console.log('-----Reply Init-------');
        console.log(component.get("v.caseItemId"));
        console.log(component.get("v.caseId"));
        
        var action = component.get("c.getActivityHistory");
        action.setParams({
            "caseItemId":component.get("v.caseItemId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.caseItemReply",response.getReturnValue());
                var appEvent = component.getEvent("replyEvent");
                console.log('about to fire event');
                appEvent.setParams({
                    "casItem" : response.getReturnValue()
                });
                console.log('about to fire event 2');
                console.log(appEvent);
                appEvent.fire();
                
            } else {
                console.log('Problem getting Case Item from submit, response state: ' + state);
            }
        });
        $A.enqueueAction(action);
        
        
    },
	submitReplyCtrl : function(component, event, helper) {
        console.log(component.get("v.caseItemReply.CTP_Comments__c"));
        console.log('------------'+component.get("v.caseItemReply"));
        var action = component.get("c.submitReply");
        action.setParams({
            "caseItem":component.get("v.caseItemReply"),
            "replyTyp": 'submit'
                         });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.caseItemReply",response.getReturnValue());
                component.set("v.caseItemReply.CTP_Comments__c",'test');
                console.log('Success of submit' + state);
                component.gotoapp();
                
            } else {
                console.log('Problem getting Case Item from submit, response state: ' + state);
            }
        });
        $A.enqueueAction(action);
	},
    submitDraftCtrl : function(component, event, helper) {
        console.log('Inside draft');
        console.log('------------'+component.get("v.caseItemReply"));
        var action = component.get("c.submitReply");
        action.setParams({
            "caseItem":component.get("v.caseItemReply"),
            "replyTyp": 'draft'
        });
        console.log('------------2'+component.get("v.caseItemReply"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.caseItemReply",response.getReturnValue());
                console.log('Success Draft' + state);
                component.gotoapp();
                
            } else {
                console.log('Problem getting Case Item Draft, response state: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    
    goToMyApplications: function(component, event, helper) {
        var evt = $A.get("e.force:navigateToURL");
        console.log('<<<<evt>>>',evt);
        
        if (evt) {
            evt.setParams({
                "url": '/caseitem/',
                "isredirect": true
            });
            console.log('evt url is'+evt.getParam("url"));
            evt.fire();
        }  
    },
    
    
})