/******************************************************************************************************
// @Public Class:: Claimants Acitivity History Lightning Controller 
// Test Class   :: ClaimaintsActivityHistory_Test
// JIRA Task    :: DCR-292 
// SECENARIO    :: POR-4
// @Author      :: Subhajit Basak
// Org          :: DFSI-SIRA
*******************************************************************************************************/ 

public class CTP_ClaimaintsActivityHistory
{
    
    /***************************************************************************************************
    // getActivityHistory :: LOAD ACTIVITY HISTORY WHICH IS SUBMITTED BY DRS OFFICER
    ****************************************************************************************************/ 

    @AuraEnabled
    public static list<CaseItem__c> getActivityHistory(String id)
    {
        System.debug('@@@CaseID :: '+id);
      
        User usr = [select Id , ContactId from User where Id =: UserInfo.getUserId()];
        
        System.debug('-------'+usr);
        
        List<CaseItem__c> caseItemList =   [SELECT Id,CTP_ReplyDueByDate__c,Status__c,DueDate__c,ExpiryDate__c,CTP_Claim_Number__c,CommunityPageURL__c,Type__c,CreatedDate 
                                            FROM CaseItem__c 
                                            WHERE Case__r.CTP_InjuredPersonContact__r.id =:usr.ContactId
                                            AND Status__c ='Pending'
                                            AND RecordTypeId=:Schema.SObjectType.CaseItem__c.getRecordTypeInfosByName().get(CTP_ClaimantsCommunityService.CLAIMANT).getRecordTypeId()];
                                            
                                            
        System.debug('@@@@@CaseItem__c ::: '+JSON.serializePretty(caseItemList));
        return caseItemList;
    }
    
    /***************************************************************************************************
    // getCaseItemListInsurer:: LOAD Case Items in List View for Insurer in Insurer Community
    ****************************************************************************************************/
    @AuraEnabled
    public static list<CaseItem__c> getCaseItemListInsurer()
    {
     
        List<CaseItem__c> caseItemList =   [SELECT Id,CTP_Reply_due_Status__c,CTP_ReplyDueByDate__c,Status__c,DueDate__c,ExpiryDate__c,CTP_Claim_Number__c,CommunityPageURL__c,Type__c,CreatedDate 
                                            FROM CaseItem__c
                                            WHERE Status__c ='Pending'
                                            AND RecordTypeId=:Schema.SObjectType.CaseItem__c.getRecordTypeInfosByName().get(CTP_ClaimantsCommunityService.INSURER).getRecordTypeId()];
                                            
                                            
        System.debug('@@@@@CaseItem__c ::: '+JSON.serializePretty(caseItemList));
        return caseItemList;
    }
}