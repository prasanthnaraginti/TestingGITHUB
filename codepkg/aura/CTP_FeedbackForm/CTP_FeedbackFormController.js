({
    doInit : function(component, event, helper) {  
        helper.fetchPickListVal(component, 'CTP_Feedback_Type__c','fType'); 
        
    },
    onfTypeChange: function(component, event, helper) {  
        // get the value of select option
        var masterValue = event.getSource().get("v.fTypeValue");
        
        helper.fetchDependentPickListVal(component, masterValue,'fsubType');             
    },
    
    handleClick: function(component, event, helper) {
        //console.log(component);
        //console.log(component.find("file").getElement().files[0]);
        var fTypeField = component.find("fType");
        var fTypeValue = fTypeField.get("v.value");  
        var fsubTypeField = component.find("fsubType");
        var fsubTypeValue = fsubTypeField.get("v.value");  
        var fdescField = component.find("desc");
        var fdescValue = fdescField.get("v.value");  
        var fresponseReqField = component.find("responseReq");
        var fresponseReqValue = fresponseReqField.get("v.value");  
   
        if (fTypeValue == "" || fTypeValue == null) {
            fTypeField.set("v.errors", [{message:"Error: Please select what you are submitting."}]);
        } else {
            fTypeField.set("v.errors", null);
        }
        if (fsubTypeValue == "" || fsubTypeValue == null) {
            fsubTypeField.set("v.errors", [{message:"Error: Please indicate what your submission is in regards to."}]);
        } else {
            fsubTypeField.set("v.errors", null);
        }
        
       if (fdescValue == null || fdescValue == "") {
            fdescField.set("v.errors", [{message:"Error: Please provide a description."}]);
        } else {
            fdescField.set("v.errors", null);
        } 
       
        if(fTypeField.get("v.errors") == null && fsubTypeField.get("v.errors")==null && fdescField.get("v.errors")== null){
        if(fTypeValue != "" && fsubTypeValue!= "" && fdescValue != ""){
    	//var file = component.find("file").getElement().files[0];
         helper.save(component,event,fTypeValue,fsubTypeValue,
             fdescValue,fresponseReqValue);    
        }
        }
        
        
    },
    
})