public with sharing class DRS_CaseItem_Reply{   
    @AuraEnabled
    public static CaseItem__c getCaseItemDetails(Id caseItemId){
        return [
        Select Id, Name, CaseItemData__c, CreatedDate, Case__c, DueDate__c, Status__c,
        RoleGroup__c, CommunityPageURL__c, SubmittedBy__c, SubmittedByName__c,CTP_Comments__c,
        ExpiryDate__c, CreatedBy.Id From CaseItem__c 
        WHERE Id =: caseItemId];
    }
    @AuraEnabled
    public static String saveCaseItems(Id caseItemId, String response){
        System.debug('----------'+caseItemId+'----------'+response);
        CaseItem__c casItem = [Select Id, Name, CaseItemData__c, CreatedDate, Case__c,Case__r.id, DueDate__c, Status__c,
                               RoleGroup__c, CommunityPageURL__c, SubmittedBy__c, SubmittedByName__c,CTP_Your_reply__c,CTP_Comments__c,
                               ExpiryDate__c, CreatedBy.Id From CaseItem__c 
                               WHERE Id =: caseItemId];
        
        
        casItem.Status__c = 'Submitted';
        casItem.CTP_Your_reply__c = response;
        update casItem;
        System.debug('------------'+casItem.Case__r.id);
        return casItem.Case__r.id;
    }
}