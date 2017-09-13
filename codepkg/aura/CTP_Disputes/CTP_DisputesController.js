({
    //function to query all the dispute child records related to specific parent case at the time of page load
    doInit : function(component, event, helper) {
    	var caseId = component.get("v.recordId");
       
        helper.getRecortTypeId(component);
        
        var action = component.get("c.getDisputeCaseRecords");
        action.setParams({ "caseId" : caseId });
        
        action.setCallback(this, function(a) {
           
            if(a.getState()=="SUCCESS"){
                component.set("v.disputeList", a.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
        
    },
    
    //function to display the create new record view
    createDisputeRecord : function(component, event, helper) {
        /*var caseId = component.get("v.recordId");
        var disputeRecordTypeId = component.get("v.recordTypeId");

		var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Case",
            "recordTypeId" : disputeRecordTypeId,
            "defaultFieldValues": {
                                   'ParentId' : caseId
                                  
                                  }
             
        });
        createRecordEvent.fire();*/
        console.log("add");
        
        
        /*var createEvent = $A.get("e.c:CTP_DisplayCreateDisputeBlock_Event");      
        createEvent.fire();*/
        
        var cmpTarget = component.find('create-dispute');
        console.log('dislay:::'+cmpTarget);
        $A.util.removeClass(cmpTarget, 'toggleHide');
        $A.util.addClass(cmpTarget, 'toggleShow');
        

    },
    
    addNewDisputeRecord : function(component, event, helper) {
    	var cmpTarget = component.find('create-dispute');
        $A.util.removeClass(cmpTarget, 'toggleShow');
        $A.util.addClass(cmpTarget, 'toggleHide');
        
        var newDisputeRecord = event.getParam("newDisputeRecord");
        console.log('record::'+newDisputeRecord.caseRecord);
        var disputeList = component.get("v.disputeList");
        if($A.util.isEmpty(disputeList)){
            console.log('empty');
            component.set("v.disputeList",newDisputeRecord); 
        }else{
            console.log('not empty');
            disputeList.push(newDisputeRecord);
            component.set("v.disputeList",disputeList); 
            console.log('record::'+disputeList);
         }   
        component.set("v.noRecords", false); 
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
     },
     
     
     searchSuitableAssessor : function(component, event, helper) {
         
         console.log('assessor');
         var selectedRecords = [];
         var disputerecords = component.get("v.disputeList"); 
         console.log('all records:'+disputerecords.length);
         for(var i=0;i<disputerecords.length;i++){
             console.log('check:'+disputerecords[i].isChecked);
             if(disputerecords[i].isChecked){
             	selectedRecords.push(disputerecords[i]);
             }    
         }
         console.log("selected:::"+selectedRecords);
         if(!$A.util.isEmpty(selectedRecords)){
             component.set("v.recordsForallocation",selectedRecords);

             var caseListWrapper = [];
             
             for(var i=0;i<selectedRecords.length;i++){
                 var caseList = {id: selectedRecords[i].caseRecord.Id,
                                CaseNumber:selectedRecords[i].caseRecord.CaseNumber,
                                CTP_DisputeCategories__c: selectedRecords[i].caseRecord.CTP_DisputeCategories__c,
                                CTP_DisputeTypes__c:selectedRecords[i].caseRecord.CTP_DisputeTypes__c,
                                Status:selectedRecords[i].caseRecord.Status,
                                OwnerId:selectedRecords[i].caseRecord.OwnerId
                               }; 
                 caseListWrapper.push({caseRecord : caseList,
                                isChecked : selectedRecords[i].isChecked,
                                isStatusADR : selectedRecords[i].isStatusADR
                                
                              });
                 
             }
             //localstorage.setItems('listOfDisputes',caseListWrapper);
             var action = component.get("c.getSuitableAssessor");
             action.setParams({"caseRecList" : JSON.stringify(caseListWrapper)});
             
             action.setCallback(this, function(a) {
               console.log(a.getState());
                if(a.getState()=="SUCCESS"){
     
                    var assessorList = a.getReturnValue();
                    
                    if($A.util.isEmpty(assessorList)){
                        console.log('empty');
                        component.set("v.noRecords",true);
                    }else{
                        component.set("v.suitableAssessorList",assessorList);
                        component.set("v.noRecords",false);
                    }
                    
                    var userListdiv = component.find('user-list');
                    $A.util.removeClass(userListdiv, 'toggleHide');
                    $A.util.addClass(userListdiv, 'toggleShow');
                    console.log('List::'+assessorList);
                    
                    var disputeListDiv = component.find('dipsute-listview');
                    $A.util.removeClass(disputeListDiv, 'toggleShow');
                    $A.util.addClass(disputeListDiv, 'toggleHide');
                    
                    
                }
            });
            
            $A.enqueueAction(action);
         }else{
             var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 "title": "Error!",
                 "message": "Please select at least one dispute record"
             });
             toastEvent.fire();
         }
         
 
     },
    
    getSelectedDispueRec : function(component, event, helper){
        var selectedDisputeRecord = event.getParam("selectedDisiputeRec");
        var recordList = component.get("v.recordsForallocation");
        
        if($A.util.isEmpty(recordList)){
            console.log('empty');
            component.set("v.recordsForallocation",selectedDisputeRecord); 
        }else{
            console.log('not empty');
            recordList.push(selectedDisputeRecord);
            component.set("v.recordsForallocation",recordList); 
            console.log('record::'+recordList);
         }   
        
    },
    
    allocateDisputeRecs : function(component,event,helper){
        console.log("allocate");
        var assessor = event.getParam("suitableAssessor");
        console.log("assessor:::"+assessor);
        //var selectedRecords = component.get("v.recordsForallocation");
        //var disputerecords = component.get("v.disputeList");
        //var disputeList = localstorage.getItems("listOfDisputes");
        var caseListWrapper = []; 
        var listWrapper = []; 
        //createWrapper(caseListWrapper,listWrapper);
        var selectedRecords = component.get("v.recordsForallocation");      
               
        for(var i=0;i<selectedRecords.length;i++){
             var caseList = {id: selectedRecords[i].caseRecord.Id,
                            CaseNumber:selectedRecords[i].caseRecord.CaseNumber,
                            CTP_DisputeCategories__c: selectedRecords[i].caseRecord.CTP_DisputeCategories__c,
                            CTP_DisputeTypes__c:selectedRecords[i].caseRecord.CTP_DisputeTypes__c,
                            Status:selectedRecords[i].caseRecord.Status,
                            OwnerId:selectedRecords[i].caseRecord.OwnerId
                           }; 
             caseListWrapper.push({caseRecord : caseList,
                            isChecked : selectedRecords[i].isChecked,
                            isStatusADR : selectedRecords[i].isStatusADR
                           	
                          });
             
         }
        
        var disputerecords = component.get("v.disputeList"); 
        console.log(disputerecords.length);
        for(var i=0;i<disputerecords.length;i++){
             var caseList = {id: disputerecords[i].caseRecord.Id,
                            CaseNumber:disputerecords[i].caseRecord.CaseNumber,
                            CTP_DisputeCategories__c: disputerecords[i].caseRecord.CTP_DisputeCategories__c,
                            CTP_DisputeTypes__c:disputerecords[i].caseRecord.CTP_DisputeTypes__c,
                            Status:disputerecords[i].caseRecord.Status,
                            OwnerId:disputerecords[i].caseRecord.OwnerId
                           }; 
             listWrapper.push({caseRecord : caseList,
                            isChecked : disputerecords[i].isChecked,
                            isStatusADR : disputerecords[i].isStatusADR
                           	
                          });
             
        }
        var action = component.get("c.allocateDisputeRecords");
        action.setParams({"assessorRec": JSON.stringify(assessor),"selecteddisputeList": JSON.stringify(caseListWrapper),"disputeList":JSON.stringify(listWrapper)});
        
        action.setCallback(this, function(a) {
            console.log("result:::"+a.getReturnValue());
            console.log("result:::"+a.getState());
            if(a.getState() == "SUCCESS"){
                component.set("v.disputeList",a.getReturnValue());
                var cmpTarget = component.find('user-list');
                $A.util.removeClass(cmpTarget, 'toggleShow');
                $A.util.addClass(cmpTarget, 'toggleHide');
                
                var disputeListDiv = component.find('dipsute-listview');
                $A.util.removeClass(disputeListDiv, 'toggleHide');
                $A.util.addClass(disputeListDiv, 'toggleShow');
            }
        });    
        
        $A.enqueueAction(action);
    },
    
    
    cancelAllocation : function(component,event,helper){
        
        var userListdiv = component.find('user-list');
        $A.util.removeClass(userListdiv, 'toggleShow');
        $A.util.addClass(userListdiv, 'toggleHide');
        
        var disputeListDiv = component.find('dipsute-listview');
        $A.util.removeClass(disputeListDiv, 'toggleHide');
        $A.util.addClass(disputeListDiv, 'toggleShow');
    }
    
    
    
})