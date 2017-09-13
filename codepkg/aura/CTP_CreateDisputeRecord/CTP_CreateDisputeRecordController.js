({
	getDisputeTypes : function(component, event, helper) {
		
        console.log('selected value:::'+component.find("disputeCategory").get("v.value"));
        //var selectedCategory = component.get("v.case.CTP_DisputeCategories__c");
        var selectedCategory = component.find("disputeCategory").get("v.value");
        
        var mapValue = component.get("v.mapping");
        console.log(' Mapping value:::'+mapValue[selectedCategory]);
        component.set("v.disputeTypeDisable",false);
        component.set("v.optionsDisputeType",mapValue[selectedCategory]);
        component.find("disputeType").set("v.value",mapValue[selectedCategory][0]) ; 
        
	},
    
    doInit : function(component, event, helper) {
		 
         helper.getDisputeCategories(component);
         
        
         var action = component.get("c.getDisputeMapping");
         action.setCallback(this, function(a) {
            console.log('return value::'+a.getReturnValue());
            var mapValues = a.getReturnValue();
            //console.log('map::::'+mapValues.get("Medical assessment"));
            component.set("v.mapping", a.getReturnValue());
            var defaultCategory = component.get("v.defaultCategory");
            component.set("v.disputeTypeDisable",false);
            component.set("v.optionsDisputeType",mapValues[defaultCategory]);  
            component.find("disputeCategory").set("v.value",defaultCategory) ;
            var dipsuteType = component.get("v.optionsDisputeType");
             if(!$A.util.isEmpty(dipsuteType)){
                console.log("dipsuteType::::"+dipsuteType[0]); 
                component.set("v.defaultType",dipsuteType[0]);
                component.find("disputeType").set("v.value",dipsuteType[0]) ; 
             }    
        });
        $A.enqueueAction(action); 
       
	},
    
    saveDisputeRecord : function(component, event, helper) {
        
       /* var disputeCategory = component.get("v.selectedDisputeCategory");
        var disputeType = component.get("v.selectedDisputeType");
        console.log(disputeType);*/
        var parentId = component.get("v.parentId");
        var recordTypeId = component.get("v.recordTypeId");
        var selectedDisputeCategory = component.find("disputeCategory").get("v.value");
        var selectedDisputeType = component.find("disputeType").get("v.value");
        var disputeCaseRecord = component.get("v.case");
        disputeCaseRecord.CTP_DisputeCategories__c = selectedDisputeCategory;
        disputeCaseRecord.CTP_DisputeTypes__c = selectedDisputeType;
        console.log('rec:::'+disputeCaseRecord);
        console.log('rec:::'+disputeCaseRecord.CTP_DisputeCategories__c);
        console.log('rec:::'+disputeCaseRecord.CTP_DisputeTypes__c);
        if ($A.util.isEmpty(selectedDisputeCategory)){
        	component.find("disputeCategory").set("v.errors", [{message:"Cannot be blank"}]);

        }else if($A.util.isEmpty(selectedDisputeType)){
            component.find("disputeType").set("v.errors", [{message:"Cannot be blank"}]);
        }else{
        //if(disputeCaseRecord.CTP_DisputeCategories__c!='' && disputeCaseRecord.CTP_DisputeTypes__c!=''){
            console.log('enters');
            var action = component.get("c.createChildDisputeRecord");
            action.setParams({"disputeCaseRecord" : disputeCaseRecord,
                              "parentId" : parentId,
                              "recordTypeId" : recordTypeId 
                            });
            
            action.setCallback(this, function(response) {
                console.log(response.getState());
                if(response.getState()=="SUCCESS"){
                    console.log('success');
                    /*var cmpTarget = component.find('create-dispute');
                    $A.util.removeClass(cmpTarget, 'toggleShow');
                    $A.util.addClass(cmpTarget, 'toggleHide');*/
                    //component.set("v.case.CTP_DisputeCategories__c","");
                    var defaultCategory = component.get("v.defaultCategory");
                    
                    component.find("disputeCategory").set("v.value",defaultCategory);
                    component.set("v.disputeTypeDisable",false); 
                    //component.set("v.case.CTP_DisputeTypes__c","");
                    var mapValues = component.get("v.mapping");
                    component.set("v.optionsDisputeType",mapValues[defaultCategory]);
                    var defaultType = component.get("v.defaultType");
                    console.log("defaultType::"+defaultType);
                    component.find("disputeType").set("v.value",defaultType);
                    
                    var createEvent = component.getEvent("newDisputeRecord");
                    createEvent.setParams({"newDisputeRecord" : response.getReturnValue()});
                    createEvent.fire();
                    
                }   
            });
            $A.enqueueAction(action);
        }   
    },
    
    displayCreatedisputeBlock : function(component, event, helper) {
        console.log('display');
    	var cmpTarget = component.find('create-dispute');
        console.log('dislay:::'+cmpTarget);
        $A.util.removeClass(cmpTarget, 'toggleHide');
        $A.util.addClass(cmpTarget, 'toggleShow');
    }    
})