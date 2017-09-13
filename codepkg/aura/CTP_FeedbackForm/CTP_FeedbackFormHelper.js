({
    fetchPickListVal: function(component, fieldName, elementId) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "fld": fieldName
        });	
        var opts = [];
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                var allValues = response.getReturnValue();
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(elementId).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchDependentPickListVal: function(component, fieldValue, elementId){
        var action = component.get("c.getDependentOptions");
        action.setParams({
            "masterValue": fieldValue
        });	
        var opts = [];    
        action.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                var allValues = response.getReturnValue();
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(elementId).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },  
    
       save : function(component,event, ftypeValue,fsubtypeValue,fdescValue,frespValue) {
        var action = component.get("c.checkCaseType"); 
        action.setParams({ 
            "feedbackType":ftypeValue,"feedbackSubType":fsubtypeValue ,
            "descValue" :fdescValue, "respValue":frespValue 
           
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
             var rec = response.getReturnValue();
             component.set("v.caseNumber",rec);
             console.log(rec);
            }
            console.log(component.get("v.caseNumber"));
             $A.createComponent(
             "ui:outputText",
            {
                "aura:id": "thankyoucmpId",
                "value": "Thank you. Your Case "+component.get("v.caseNumber")+" has been submitted successfully.",
                "class": "slds-output"
            }
            ,
            function(newcomponent){
                var content = component.find("body");
                console.log(component.get("v.caseNumber"));
                 content.set("v.body", newcomponent);
            }
        );     
        });
       $A.enqueueAction(action);    
    },
})