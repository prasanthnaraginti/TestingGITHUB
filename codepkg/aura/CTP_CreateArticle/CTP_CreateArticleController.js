({
    doInit : function(component, event, helper) {  
        
        var action = component.get("c.getArticleRecordType");
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                var allValues = response.getReturnValue();
                component.set('v.recordTypeList',allValues); 
                console.log('response>>>'+response+'Field Value'+component.get('v.recordTypeList'));
            }    
        });
        $A.enqueueAction(action);
    },
	
    /* In this "createRecord" function, apex class method "getRecTypeId" is called
    * and passed the selected RecordType values[label] and this "getRecTypeId"
    * apex method return the selected recordType ID.
    * When RecordType ID comes,"e.force:createRecord"
    * event is called and pass object API Name and 
    * set the record type ID in recordTypeId parameter and fire this event
    */
    
    createRecord : function(component, event, helper) { 
        
        component.set("v.isOpen", true);
        var action = component.get("c.getRecTypeId");
        //var recTypeName= component.get('v.recordTypeName');
        var recTypeName = component.find("selectid").get("v.value");
        console.log("recTypeName>>>"+recTypeName);
        action.setParams({
            "recordTypeLabel": recTypeName
        });	
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                var caseId = component.get("v.recordId");
                console.log("caseId>>>"+caseId);
                var createRecordEvent = $A.get("e.force:createRecord");
                var recTypeId = response.getReturnValue();
                console.log("createRecordEvent>>>"+createRecordEvent);
               createRecordEvent.setParams({
                    "entityApiName":'Article__kav',
                    "recordTypeId": recTypeId    
                });
                createRecordEvent.fire();
            }
            else if (state == "ERROR") {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
               "title": "Error!",
               "message": "Please contact your administrator"
            });
            toastEvent.fire();
         }
        });
        $A.enqueueAction(action);
       component.set("v.isOpen", false);
    },
    
    openModal: function(component, event, helper) {
      // set "isOpen" attribute to true to show model box
      component.set("v.isOpen", true);
   },
     closeModal: function(component, event, helper) {
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isOpen", false);
   },
})