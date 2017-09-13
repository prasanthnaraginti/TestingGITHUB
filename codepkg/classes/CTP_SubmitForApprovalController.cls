public class CTP_SubmitForApprovalController{
     @AuraEnabled
    public static Boolean getArticle(String articleId){
          Article__kav  articleObj = [Select id,ValidationStatus,CreatedById from Article__kav where id=:articleId];
          if (articleObj.CreatedById == userInfo.getUserId() && (articleObj.ValidationStatus == Label.CTP_Draft || articleObj.ValidationStatus == Label.CTP_Rejected)){
          return true;
          }
          else{
          return false;
          }
    }
    
    @AuraEnabled
    public static Boolean submitAndProcessApprovalRequest(String articleId){
        
        try{
            // Create an approval request for the article
            Article__kav  articleObj = [Select id,ValidationStatus,CreatedById from Article__kav where id=:articleId];
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments(Label.CTP_ApprovalComment);
            req1.setObjectId(articleId);
            req1.setSubmitterId(UserInfo.getUserId());
            req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            req1.setProcessDefinitionNameOrId(Label.CTP_ApprovalProcessName);//'CTP_Lightning_Knowledge_Article_Approval' provide approval process name
            req1.setSkipEntryCriteria(true);
            // Submit the approval request for the article
            Approval.ProcessResult result1 = Approval.process(req1); 
              if (articleObj.CreatedById == userInfo.getUserId() && (articleObj.ValidationStatus == Label.CTP_Draft  || articleObj.ValidationStatus == Label.CTP_Rejected)){
                  return true;
               }
              else{
                  return false;
               }
        }
        catch(DMLException e){
            system.debug(e.getCause()+''+e.getMessage());
            return false;
        }
        
    }      
}