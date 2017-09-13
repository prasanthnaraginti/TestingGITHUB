@isTest
public class CTP_SubmitForApprovalController_Test {
    static testMethod void testSubmitForApprovalController() {
        Article__kav artKav = new Article__kav();
        //artKav.CTP_Submitted_For_Approval__c = false;
        artKav.title = 'TestRecord';
        artKav.UrlName = 'TestArticleRecord';
        artKav.ValidationStatus = 'Approved';
        artKav.CTP_Question__c = 'TestRecord';
        artKav.CTP_Answer__c = 'TestRecord';
        try{
            insert artKav;
        }
        catch(DMLException e){
            system.debug(e.getCause()+''+e.getMessage());
        }
        system.debug('artKav-->'+artKav.Id);
        String articleId = artKav.Id;
       
        Test.StartTest();
        
        CTP_SubmitForApprovalController.getArticle(articleId);
        CTP_SubmitForApprovalController.submitAndProcessApprovalRequest(articleId);
        System.assertEquals(artKav.CTP_Question__c, 'TestRecord');
        test.stopTest();
        
    }

}