public without sharing class DRS_CaseItemTriggerHandler {
  
   
   
  
    public static void run(List<CaseItem__c> caseItemList) {
        if(Trigger.isExecuting) {
            try{
                if (Trigger.isBefore && Trigger.isInsert) {
                    DRS_CaseItemTriggerHandler.beforeInsert(caseItemList);
                }
                else if(Trigger.isAfter && Trigger.isInsert) {
                   DRS_CaseItemTriggerHandler.afterInsert();
                }
                else if(Trigger.isBefore && Trigger.isUpdate) {
                   // DRS_CaseItemTriggerHandler.beforeUpdate(caseItemList);
                }
                else if(Trigger.isAfter && Trigger.isUpdate) {
                    DRS_CaseItemTriggerHandler.afterUpdate();
                }
            }
            catch(System.DmlException excep) {
                System.debug('---DRS_CaseItemTriggerHandler:DMLException:Message:' + excep.getMessage());
                System.debug('---DRS_CaseItemTriggerHandler:DMLException:StackTrace:' + excep.getStackTraceString());
                throw excep;
            }
            catch(System.Exception excep) {
                System.debug('---DRS_CaseItemTriggerHandler:Exception:Message:' + excep.getMessage());
                System.debug('---DRS_CaseItemTriggerHandler:Exception:StackTrace:' + excep.getStackTraceString());
                throw excep;
            }
        }
    }
    
    public static void beforeInsert(List<CaseItem__c> caseItemList) {
    
    
    CaseItem__c cItemObj;
    
    //if(DRS_ClaimantsCommunityService.BYPASSFLAG ==false)
    //  {
            for(CaseItem__c cItem : caseItemList)
            {
              
             if(cItem.RoleGroup__c != null) 
             {
                  if(String.valueOf(cItem.RoleGroup__c).contains(';'))
                  {
                    
                    List<String> tempRoleHolder = String.valueOf(cItem.RoleGroup__c).split(';');
                    system.debug('@@@@@ tempRoleHolder :: '+tempRoleHolder);
                    for(String role : tempRoleHolder)
                    {
                       // FOR INSURER :FUNCTIONALITY (DCR-551 :Subhajit Basak)
                      if(cItem.Status__c =='New' && role==DRS_ClaimantsCommunityService.INSURER)
                      {
                          system.debug('@@@@@ Role1 :: '+role);
                          cItem.RoleGroup__c=role;
                          cItem.RecordTypeId=Schema.SObjectType.CaseItem__c.getRecordTypeInfosByName().get(DRS_ClaimantsCommunityService.INSURER).getRecordTypeId();
                          cItem.Status__c ='Pending';
                          
                      }
                      // FOR CLAIMANT :FUNCTIONALITY (DCR-237 :Subhajit Basak)
                     else 
                         if(role==DRS_ClaimantsCommunityService.CLAIMANT)
                          {
                                  system.debug('@@@@@ Role2 :: '+role);
                                 
                                  cItemObj = new CaseItem__c();
                                  //cItemObj=cItem;
                                  cItemObj.CTP_Claim_Number__c=cItem.CTP_Claim_Number__c;
                                  //cItemObj.CTP_InsurerReplyStatus__c=cItem.CTP_InsurerReplyStatus__c;//Commented by Lavanya, as this field is no longer used in Caseitem object
                                  
                                  cItemObj.CTP_ReplyDueByDate__c=cItem.CTP_ReplyDueByDate__c;
                                  cItemObj.Case__c=cItem.Case__c;
                                  
                                  cItemObj.Comments__c=cItem.Comments__c;
                                  cItemObj.CTP_Comments__c=cItem.CTP_Comments__c;
                                  cItemObj.CTP_Subject__c=cItem.CTP_Subject__c;
                                  cItemObj.Subject__c=cItem.Subject__c;
                                  
                                  cItemObj.Status__c='Pending';
                                  cItemObj.RoleGroup__c=role; 
                                  cItemObj.RecordTypeId=Schema.SObjectType.CaseItem__c.getRecordTypeInfosByName().get(DRS_ClaimantsCommunityService.CLAIMANT).getRecordTypeId();
                                  //cItemObj.Status__c='Pending';
                                  //caseItemList.add(cItemObj);
                          } 
                      
                       
                    }
                    
                    System.debug('@@@@@ cItem :: '+JSON.SerializePretty(cItem));
                  
                  }
                  else
                  {
                      System.debug('@@@@@ cItem.RoleGroup__c :: '+cItem.RoleGroup__c);
                      // FOR INSURER :FUNCTIONALITY (DCR-551 :Subhajit Basak)
                      if(cItem.Status__c =='New' && cItem.RoleGroup__c==DRS_ClaimantsCommunityService.INSURER)
                      {
                          cItem.RecordTypeId=Schema.SObjectType.CaseItem__c.getRecordTypeInfosByName().get(DRS_ClaimantsCommunityService.INSURER).getRecordTypeId();
                          cItem.Status__c='Pending';
                      }
                      // FOR CLAIMANT :FUNCTIONALITY (DCR-237 :Subhajit Basak)
                      else 
                          if(cItem.Status__c =='New' && cItem.RoleGroup__c==DRS_ClaimantsCommunityService.CLAIMANT)
                          {
                              cItem.RecordTypeId=Schema.SObjectType.CaseItem__c.getRecordTypeInfosByName().get(DRS_ClaimantsCommunityService.CLAIMANT).getRecordTypeId();
                              cItem.Status__c='Pending';
                          }
                   }  
                   
               
               }//end of cItem.RoleGroup__cnull checking 
            
            }
            
         try{
            
            
             System.debug('@@@@@Before cItemObj :: '+JSON.SerializePretty(cItemObj));
             if(cItemObj!=null)insert cItemObj;
             System.debug('@@@@@After cItemObj :: '+JSON.SerializePretty(cItemObj));
         }
         catch(Exception excep)
         { 
          System.debug('Exception Occured While Executing DML Operation'+excep.getMessage());
         }
        
          System.debug('@@@@@  DRS_ClaimantsCommunityService.BYPASSFLAG :: '+DRS_ClaimantsCommunityService.BYPASSFLAG); 
          DRS_ClaimantsCommunityService.BYPASSFLAG =true; 
      //}
    }  
    
    //Developer-Akshata
    //User strory-DCR-586, DCR-605
    public static void beforeUpdate(List<CaseItem__c> triggerNew, Map<id,CaseItem__c> triggerOldMap) {
    
    Id DisputeTaskRecordId=[Select id from Recordtype where sobjecttype='CaseItem__c' and Name='CTP_DisputeTasks' limit 1].id;
    for(CaseItem__c caseItemObj:triggerNew)
    {
        if(caseItemObj.Status__c=='Accepted' && triggerOldMap.get(caseItemObj.id).Status__c=='New')
        {
            
        }
        else if(caseItemObj.Status__c=='Rejected' && triggerOldMap.get(caseItemObj.id).Status__c=='New')
       {
        }
    }
    
    }
     
    
    
    public static void afterUpdate() {
      //if(DRS_ClaimantsCommunityService.BYPASSFLAG ==false)
      //{ 
        List<SObject> listToUpdate = new List<SObject>();
        listToUpdate = DRS_CaseService.markCaseItemTasksAsCompleted(JSON.serialize((Map<Id,CaseItem__c>)Trigger.oldMap), JSON.serialize((Map<Id,CaseItem__c>)Trigger.newMap));
        DRS_GlobalUtility.performDML(null, listToUpdate, null);
        
        DRS_ClaimantsCommunityService.BYPASSFLAG =true;
      //}  
    }
    
    public static void afterInsert() {} 
     
    
}