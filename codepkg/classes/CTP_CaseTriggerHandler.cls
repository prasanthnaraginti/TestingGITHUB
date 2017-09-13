public class CTP_CaseTriggerHandler {
    
    List<Case> newCase;
    Map<ID, Account> AccountCaseMap;
    Map<Id,Case> newCaseMap;
    List<Case> oldCase;
    Map<Id,Case> oldCaseMap;
     
    public CTP_CaseTriggerHandler (List<Case> newCase, 
                                   Map<Id,Case> newCaseMap,List<Case> oldCase, Map<Id,Case> oldCaseMap) {
                                       this.newCase = newCase;
                                       this.newCaseMap = newCaseMap; 
                                       this.oldCase = oldCase;
                                       this.oldCaseMap = oldCaseMap;
                                   }
    
    public void handleBeforeInsert() {
        updateClaimantContactonCase();
        autoSelectEntitlementProcess();
        
    }
     public void handleBeforeUpdate() {
        updateClaimantContactonCase();   
        autoSelectEntitlementProcess();
    }
    public void handleAfterUpdate() {
        setMilestoneToComplete();    
    }
    
  public void autoSelectEntitlementProcess(){  
        Map<Id,Id> recTypeEntitlementMap = new Map<Id,Id>();
        List<String> processNames = new List<String>();
        List<CTP_CaseRecordTypeEntitlementMapping__c> mappingList = [Select Id,CTP_Case_Record_Type__c,CTP_Entitlement_Process_Name__c from CTP_CaseRecordTypeEntitlementMapping__c];
        for(CTP_CaseRecordTypeEntitlementMapping__c obj:mappingList){
            processNames.add(obj.CTP_Entitlement_Process_Name__c );
        }
        List<Entitlement> eList= [Select name,id from Entitlement where name=:processNames]; 
        for(CTP_CaseRecordTypeEntitlementMapping__c recTypeEntitlementObj:mappingList){
            for(Entitlement entitlementIdObj:eList){
                if(recTypeEntitlementObj.CTP_Entitlement_Process_Name__c == entitlementIdObj.name){ 
                    if(recTypeEntitlementObj != null){
                        recTypeEntitlementMap.put(Schema.SObjectType.Case.getRecordTypeInfosByName()
                                                  .get(recTypeEntitlementObj.CTP_Case_Record_Type__c)
                                                  .getRecordTypeId(),entitlementIdObj.id);
                    }
                }
            }
        }
        system.debug('Map>>>'+recTypeEntitlementMap);
        for (Case cas : newCase) {
            system.debug('>>>>> recTypeEntitlementMap.get(cas.RecordTypeId) returns: ' + recTypeEntitlementMap.get(cas.RecordTypeId));
            cas.EntitlementId = recTypeEntitlementMap.get(cas.RecordTypeId); 
            
            system.debug('TestSudha'+cas.EntitlementId );
            system.debug('TestSudha'+cas.Entitlement.name );
        }
    }
   
    public void setMilestoneToComplete(){
        List<Id> caseIds = new List<Id>();
        List<Id> caseIdsForMilestone2 = new List<Id>();
        List<Id> caseIdsForMilestone3 = new List<Id>();
        List<Id> caseIdsForMilestone4 = new List<Id>();
        List<Id> caseIdsForFeedbackMilestone = new List<Id>();
        Id recId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_AssistClaimantSupportRecordTypeName).getRecordTypeId();
        Id recIdForFeedback = Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_Feedback).getRecordTypeId();
        Group queueObj=[select Id from Group where Type = 'Queue' AND NAME =:Label.CTP_CASFeedbackQueueName Limit 1];
        Group DRSQueueObj=[select Id from Group where Type = 'Queue' AND NAME =: Label.CTP_DRS_Feedback_Queue_Name Limit 1];
        //Map<Id,Case> oldCaMap = new Map<Id,Case>([SELECT Id,CaseNumber,OwnerId FROM Case where id=:oldCase]);
        for (Case cas:newCase) {
            if(cas.RecordTypeId== recId && cas.Status==Label.CTP_Introduction_Call_Case_Status && 
               cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call &&
               (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIds.add(cas.id);
            }
            
            if(cas.RecordTypeId== recId && cas.Status== Label.CTP_10_week_call_Case_Status &&
               cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call && 
               (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome|| 
                cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome|| 
                cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForMilestone2.add(cas.id);
            }
            
             if(cas.RecordTypeId== recId && cas.Status== Label.CTP_23_Week_Call_Case_Status &&
                cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call && 
                (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForMilestone3.add(cas.id);
               
            }
            
             if(cas.RecordTypeId== recId && cas.Status== Label.CTP_75_week_review_Case_Status &&
                cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call && 
                (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForMilestone4.add(cas.id);
               
            }
       		//Boolean isQueuePrevOwner = String.valueOf(oldCaMap.get(cas.id).OwnerId).startsWith('00G');
             if(cas.RecordTypeId== recIdForFeedback && ((cas.OwnerId != queueObj.id  && cas.CTP_CaseType__c == Label.CTP_CAS_Case_Type)||
                                                        (cas.OwnerId != DRSQueueObj.id && cas.CTP_CaseType__c ==Label.CTP_DRS_Case_Type))) {
                system.debug('inside loop>>>'); 
                caseIdsForFeedbackMilestone.add(cas.id);      
            }
            
        }
        
        /****For milestone1*****/
        if(caseIds.size()>0){
            String milestoneName = Label.CTP_Milestone_Name_1; //CTP Milestone 1 Non Damage Entitlement
            updateMilestoneToComplete(caseIds,milestoneName);  
        }
        /****For milestone2****/
        if(caseIdsForMilestone2.size()>0){
            String milestoneName2 = Label.CTP_Milestone_Name_2; //CTP Milestone 2 Non Damage Entitlement
			updateMilestoneToComplete(caseIdsForMilestone2,milestoneName2);            
            
        }
        /****For Milestone 3****/ 
        if(caseIdsForMilestone3.size()>0){
            String milestoneName3 = Label.CTP_Milestone_name_3; //CTP Milestone 3 Non Damage Entitlement
            updateMilestoneToComplete(caseIdsForMilestone3,milestoneName3);   
        }
		
         /****For Milestone 4****/ 
        if(caseIdsForMilestone4.size()>0){
            String milestoneName4 = Label.CTP_Milestone_name_4; //CTP Milestone 4 Non Damage Entitlement
            updateMilestoneToComplete(caseIdsForMilestone4,milestoneName4);   
        }

        
        /****For feedback Milestone****/
        if(caseIdsForFeedbackMilestone.size()>0){
            String milestoneNameForFeedback = Label.CTP_Milestone_Name_For_Feedback; //Case Assignment
            updateMilestoneToComplete(caseIdsForFeedbackMilestone,milestoneNameForFeedback);   
        }
    }

    
    public void updateMilestoneToComplete(List<Id> caseIdList ,String milestoneName ){
          List<CaseMilestone> cmsToUpdate = [select Id, completionDate
                                               from CaseMilestone cm
                                               where caseId in :caseIdList and cm.MilestoneType.Name=:milestoneName and completionDate = null limit 1];
            system.debug('Case Milestone>>>'+cmsToUpdate);
            if (cmsToUpdate.isEmpty() == false){
                for (CaseMilestone cm : cmsToUpdate){
                    cm.completionDate = system.now();
                }
                system.debug('cmsToUpdate>>>'+cmsToUpdate);
                update cmsToUpdate;
            }   
    }
    
        
    public void updateClaimantContactonCase(){
        for (Case cas:newCase){
            cas.CTP_InjuredPersonContact__c = cas.ContactId;
        }  
    }
}