public class CTP_AcceptCaseController {
    
    @AuraEnabled
    public static Boolean checkOwner(String caseId){ 
        Case  caseObj = [Select id,OwnerId from Case where id=:caseId LIMIT 1];
        Group queueObj=[select Id from Group where Type = 'Queue' AND NAME =: Label.CTP_CASFeedbackQueueName Limit 1];
        if(caseObj.OwnerId != userInfo.getUserId() && caseObj.OwnerId == queueObj.id){
            return true;
        }
        else{
            return false;
        }    
    }
    
    @AuraEnabled
    public static Boolean acceptCase(String caseId){
        Case  caseObj = [Select id,OwnerId from Case where id=:caseId LIMIT 1];
        caseObj.OwnerId = userInfo.getUserId();
        update caseObj;
        return true;
    }
}