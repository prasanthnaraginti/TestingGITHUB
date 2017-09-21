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
        
        autoSelectEntitlementProcess();
        
    }
     public void handleBeforeUpdate() {
       
        autoSelectEntitlementProcess();
    }
    public void handleAfterUpdate() {
        setMilestoneToComplete(); 
        setApplicationMilestoneToComplete(); 
    }
    
  public void autoSelectEntitlementProcess(){  
        Map<Id,Id> recTypeEntitlementMap = new Map<Id,Id>();
        List<Id> processIds = new List<Id>();
        List<CTP_CaseRecordTypeEntitlementMapping__c> mappingList = [Select Id,CTP_Case_Record_Type__c,CTP_Entitlement_Process_Name__c from CTP_CaseRecordTypeEntitlementMapping__c];
       /* for(CTP_CaseRecordTypeEntitlementMapping__c obj:mappingList){
            processIds.add(obj.id);
        }*/
       // List<Entitlement> eList= [Select name,id from Entitlement where id=:processIds]; 
       Boolean executeFlag =false;
      try{
      For(Case cas:newCase){
          if(cas.recordTypeId == Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_AssistClaimantSupportRecordTypeName).getRecordTypeId() || 
            cas.recordTypeId == Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_Feedback).getRecordTypeId() ||
            cas.recordTypeId == Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_AssistDamagesRecordTypeName).getRecordTypeId() ||
             cas.recordTypeId == Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_CompensationToRelatives).getRecordTypeId()){
              executeFlag = true;
          }
      }
      }
      catch(Exception e){
          e.getMessage();
      }
      if(executeFlag){
      for(CTP_CaseRecordTypeEntitlementMapping__c recTypeEntitlementObj:mappingList){
           // for(Entitlement entitlementIdObj:eList) {
                //if(recTypeEntitlementObj.CTP_Entitlement_Process_Name__c == entitlementIdObj.Id){ 
                    if(recTypeEntitlementObj != null) {
                        recTypeEntitlementMap.put(Schema.SObjectType.Case.getRecordTypeInfosByName().get(recTypeEntitlementObj.CTP_Case_Record_Type__c).getRecordTypeId(),recTypeEntitlementObj.CTP_Entitlement_Process_Name__c);
                    }
               // }
            //}
        }
        
        for (Case cas : newCase) {
            system.debug('>>>>> recTypeEntitlementMap.get(cas.RecordTypeId) returns: ' + recTypeEntitlementMap.get(cas.RecordTypeId));
            cas.EntitlementId = recTypeEntitlementMap.get(cas.RecordTypeId); 

        }
      }
    }
   
    public void setMilestoneToComplete(){
        List<Id> caseIds = new List<Id>();
        List<Id> caseIdsForMilestone2 = new List<Id>();
        List<Id> caseIdsForMilestone3 = new List<Id>();
        List<Id> caseIdsForMilestone4 = new List<Id>();
        List<Id> caseIdsForMilestone5 = new List<Id>();
        List<Id> caseIdsForMilestone6 = new List<Id>();
        List<Id> caseIdsForDamageMilestone1 = new List<Id>();
        List<Id> caseIdsForDamageMilestone2 = new List<Id>();
        List<Id> caseIdsForDamageMilestone3 = new List<Id>();
        List<Id> caseIdsForFeedbackMilestone = new List<Id>();
        List<Id> caseIdsForCompensationToRelatives = new List<Id>();
        Id recId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_AssistClaimantSupportRecordTypeName).getRecordTypeId();
        Id recIdForFeedback = Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_Feedback).getRecordTypeId();
        Id recIdForDamages = Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_AssistDamagesRecordTypeName).getRecordTypeId();
        Id recIdForCompensationToRelatives = Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.CTP_CompensationToRelatives).getRecordTypeId();
       
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
            if(cas.RecordTypeId== recId && cas.Status== Label.CTP_20_Month_Call_Case_Status &&
                cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call && 
                (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForMilestone5.add(cas.id);  
            }
            if(cas.RecordTypeId== recId && cas.Status== Label.CTP_2_Year_Review_Case_Status &&
                cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call && 
                (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForMilestone6.add(cas.id);
               
            }
             if(cas.RecordTypeId== recIdForDamages && cas.Status== Label.CTP_3_month_review_Case_Status &&
                cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call && 
                (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForDamageMilestone1.add(cas.id);
               
            }
            if(cas.RecordTypeId== recIdForDamages && cas.Status== Label.CTP_3_Year_Review_Case_Status &&
                cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call && 
                (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForDamageMilestone2.add(cas.id);
               
            }
            if(cas.RecordTypeId== recIdForDamages && cas.Status== Label.CTP_5_Year_Review_Case_Status &&
                cas.CTP_Next_Action_Status__c==Label.CTP_Must_Call && 
                (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForDamageMilestone3.add(cas.id);
               
            }
            //Boolean isQueuePrevOwner = String.valueOf(oldCaMap.get(cas.id).OwnerId).startsWith('00G');
             if(cas.RecordTypeId== recIdForFeedback && ((cas.OwnerId != queueObj.id  && cas.CTP_CaseType__c == Label.CTP_CAS_Case_Type)||
                                                        (cas.OwnerId != DRSQueueObj.id && cas.CTP_CaseType__c ==Label.CTP_DRS_Case_Type))) {
                system.debug('inside loop>>>'); 
                caseIdsForFeedbackMilestone.add(cas.id);      
            }
            
             if(cas.RecordTypeId== recIdForCompensationToRelatives && cas.CTP_Next_Action_Status__c== Label.CTP_Must_Call &&
                (cas.CTP_ActionAndOutcome__c == Label.CTP_Task_Completed_Case_Action_Outcome ||
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Unable_To_Contact_Case_Action_Outcome || 
                 cas.CTP_ActionAndOutcome__c == Label.CTP_Claimant_does_not_want_to_be_contacted_Case_Action_Outcome)){
                caseIdsForCompensationToRelatives.add(cas.id);   
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
        
         /****For Milestone 5****/ 
        if(caseIdsForMilestone5.size()>0){
            String milestoneName5 = Label.CTP_Milestone_name_5; //CTP Milestone 5 Non Damage Entitlement
           updateMilestoneToComplete(caseIdsForMilestone5,milestoneName5);   
        }
        
         /****For Milestone 6****/ 
        if(caseIdsForMilestone6.size()>0){
            String milestoneName6 = Label.CTP_Milestone_name_6; //CTP Milestone 6 Non Damage Entitlement
           updateMilestoneToComplete(caseIdsForMilestone6,milestoneName6);   
        }
		
        /***For Damage Milestone 1****/
        if(caseIdsForDamageMilestone1.size()>0){
            String damageMilestoneName1 = Label.CTP_Damage_Milestone_name_1; //CTP Milestone 6 Non Damage Entitlement
           updateMilestoneToComplete(caseIdsForDamageMilestone1,damageMilestoneName1);   
        }
        /***For Damage Milestone 2****/
        if(caseIdsForDamageMilestone2.size()>0){
            String damageMilestoneName2 = Label.CTP_Damage_Milestone_name_2; //CTP Milestone 6 Non Damage Entitlement
           updateMilestoneToComplete(caseIdsForDamageMilestone2,damageMilestoneName2);   
        }
        /***For Damage Milestone 3****/
        if(caseIdsForDamageMilestone3.size()>0){
            String damageMilestoneName3 = Label.CTP_Damage_Milestone_name_3; //CTP Milestone 6 Non Damage Entitlement
           updateMilestoneToComplete(caseIdsForDamageMilestone3,damageMilestoneName3);   
        }
        /****For feedback Milestone****/
        if(caseIdsForFeedbackMilestone.size()>0){
            String milestoneNameForFeedback = Label.CTP_Milestone_Name_For_Feedback; //Case Assignment
            updateMilestoneToComplete(caseIdsForFeedbackMilestone,milestoneNameForFeedback);   
        }
        
         /****For Compensation To Relatives Milestone****/
        if(caseIdsForCompensationToRelatives.size()>0){
            String milestoneNameForCompensationToRelatives = Label.CTP_Milestone_Name_For_Compensation_To_Relatives; //Compensation to Relatives
            updateMilestoneToComplete(caseIdsForCompensationToRelatives,milestoneNameForCompensationToRelatives);   
        }
        
      
    }

    
    public void updateMilestoneToComplete(List<Id> caseIdList ,String milestoneName ){
         List<CaseMilestone> cmsToUpdate = [Select Id,MilestoneType.Name,CompletionDate from CaseMilestone 
                                               where caseId in :caseIdList and MilestoneType.Name=:milestoneName and CompletionDate = null];
           system.debug('Case Milestone>>>'+cmsToUpdate);
            if (cmsToUpdate.isEmpty() == false){
                for (CaseMilestone cm : cmsToUpdate){
                    cm.CompletionDate = system.now();
                }
                system.debug('cmsToUpdate>>>'+cmsToUpdate);
                update cmsToUpdate;
            }  
    }
    
    //DCR-1194
    //Developer-Akshata
    
    public void updateApplicationMilestoneToComplete(Set<Id> caseIdList ,String milestoneName ){
         List<CaseMilestone> cmsToUpdate = [Select Id,MilestoneType.Name,CompletionDate from CaseMilestone 
                                               where caseId in :caseIdList and MilestoneType.Name=:milestoneName and CompletionDate = null];
           system.debug('Case Milestone>>>'+cmsToUpdate);
            if (cmsToUpdate.isEmpty() == false){
                for (CaseMilestone cm : cmsToUpdate){
                    cm.CompletionDate = system.now();
                }
                system.debug('cmsToUpdate>>>'+cmsToUpdate);
                update cmsToUpdate;
            }  
    }
    
    public void setApplicationMilestoneToComplete()
    {
        System.debug('@@@@@insidecompletemilestone@@@@');
        Set<Id> caseIdsForVerificationMilestone=new Set<Id>(); //DCR-1194 , Developer Akshata
        Set<Id> caseIdsForScreeningMilestone=new Set<Id>(); 
        Set<Id> caseIdsForReplyRequestedMilestone=new Set<Id>(); 
        List<Case> caseToUpdate=new List<Case>();
        Map<id,Case> casetoUpdateMap=new Map<id,Case>();
        System.debug('@@@Caselistsize@@@'+newCase.size());
        System.debug('@@@Caselist@@@'+newCase);
        Id applicationRecordtype=[Select id from RecordType where Sobjecttype='Case' and DeveloperName='CTP_Application' limit 1].id;  //DCR-1194 , Developer Akshata
         Map<id,id> caseownermap=new Map<id,id>();
          for (Case cas:newCase) {
           caseownermap.put(cas.id,cas.ownerid);
          }
           System.debug('@@@@@caseownermap@@@@'+caseownermap);
          Map<Id,Boolean> DROMap=new Map<id,Boolean>();
          for(User u:[Select Name, Profile.name ,UserRole.DeveloperName from User where id in : caseownerMap.values()])
          {
          System.Debug('@@@Name@@'+u.Name);
          if(u.Profile.Name=='CTP Dispute Resolution User' && u.userrole.DeveloperName=='DRS_Manager')
          {
              DROMap.put(u.id, true);
          }
          }
            System.debug('@@@@@DROMap@@@@'+DROMap);  
          for (Case cas:newCase) {  
            if(cas.RecordTypeid==ApplicationRecordtype && cas.CTP_Case_owner_is_DRO__c==true && cas.CTP_CaseSubStatus__c=='Awaiting Screening')
            {
                caseIdsForVerificationMilestone.add(cas.id);
                
            }
            System.debug('@@@@cas@@@'+cas);
            if(!DROMap.isEmpty() && cas!=null)
            {
            System.debug('@@@@inside if');
            System.debug('@@@@inside if@@@+'+cas.RecordTypeid);
               if(cas.RecordTypeid==ApplicationRecordtype && DROMap.get(caseOwnerMap.get(cas.id)) && (cas.CTP_CaseSubStatus__c=='Awaiting reply' || cas.Status=='Appropriate Dispute Resolution'))
                {
                    caseIdsForScreeningMilestone.add(cas.id);
                }
                
                if(cas.RecordTypeid==ApplicationRecordtype && DROMap.get(caseOwnerMap.get(cas.id)) && cas.Status=='Appropriate Dispute Resolution')
                {
                    caseIdsForReplyRequestedMilestone.add(cas.id);
                }
                
            }
            
           /* if(caseIdsForVerificationMilestone.contains(cas.id)){
                cas.CTP_Case_owner_is_DRO__c=false;
                caseToUpdate.add(cas);
            }
            if(caseIdsForReplyRequestedMilestone.contains(cas.id)){
              cas.CTP_RequestforReplySent__c =false;
              caseToUpdate.add(cas);
            }*/
            
            
          }
          
          System.debug('@caseIdsForVerificationMilestone@'+caseIdsForVerificationMilestone);
          System.debug('@@caseIdsForReplyRequestedMilestone@@'+caseIdsForReplyRequestedMilestone );
         for(Case c:[Select id,CTP_Case_owner_is_DRO__c,CTP_RequestforReplySent__c from case where id in: caseIdsForVerificationMilestone OR id in: caseIdsForReplyRequestedMilestone ])
          {
             if(caseIdsForVerificationMilestone.contains(c.id)){
             system.debug('272');
                 if(!casetoUpdateMap.containsKey(c.id))
                 {
                 system.debug('275');
                    c.CTP_Case_owner_is_DRO__c=false;
                    casetoUpdateMap.put(c.id,c);
                    //caseToUpdate.add(c);
                 }
                 else
                 {
                 system.debug('282');
                     Case caseobj=new Case();
                     caseobj=casetoUpdateMap.get(c.id);
                     caseobj.CTP_Case_owner_is_DRO__c=false;
                     casetoUpdateMap.put(c.id,c);
                     //caseToUpdate.add(c);
                 }
            }
          /*if(caseIdsForReplyRequestedMilestone.contains(c.id)){
              system.debug('291');
              if(!casetoUpdateMap.containsKey(c.id))
                 {
                   system.debug('294');
                   c.CTP_RequestforReplySent__c=false;
                    casetoUpdateMap.put(c.id,c);
                    //caseToUpdate.add(c);
                 }
                 else
                 {
                     system.debug('301');
                     Case caseobj=new Case();
                     caseobj=casetoUpdateMap.get(c.id);
                     caseobj.CTP_RequestforReplySent__c=false;
                     casetoUpdateMap.put(c.id,c);
                     //caseToUpdate.add(c);
                 }
            }*/
          }
          
          System.debug('@@@@casetoUpdateMap@@'+casetoUpdateMap);
          /*for(Case crec :[Select id,CTP_RequestforReplySent__c from case where id in: caseIdsForReplyRequestedMilestone])
          {
              crec.CTP_RequestforReplySent__c =false;
              caseToUpdate.add(crec);
          }*/
         if(casetoUpdateMap.values().size()>0)
          update casetoUpdateMap.values();
          /***** DCR-1194******/
          
            if(caseIdsForVerificationMilestone.size()>0)
            {
                    String milestoneNameForVerification = Label.CTP_Case_verification_milestone; 
                   updateApplicationMilestoneToComplete(caseIdsForVerificationMilestone,milestoneNameForVerification ); 
            }
             if(caseIdsForScreeningMilestone.size()>0)
            {
                    String milestoneNameForScreening = Label.CTP_Screening_Milestone; 
                   updateApplicationMilestoneToComplete(caseIdsForScreeningMilestone,milestoneNameForScreening ); 
            }
            if(caseIdsForReplyRequestedMilestone.size()>0)
            {
                    String milestoneNameForReplyRequested = Label.CTP_Reply_Received_Milestone; 
                   updateApplicationMilestoneToComplete(caseIdsForReplyRequestedMilestone,milestoneNameForReplyRequested); 
            }
    }  
    
}