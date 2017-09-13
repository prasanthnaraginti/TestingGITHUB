@isTest
public class CTP_CreateArticleOnCaseController_Test {
    static testMethod void testCreateArticleOnCaseController() {
      
        Test.StartTest();
        Boolean flag;
        Id checkId;
        List<String> rtList= CTP_CreateArticleOnCaseController.getArticleRecordType();
        if(rtList.size() >0){
            flag = true;
        }
        system.assertEquals(true ,flag );
        Id recordId = CTP_CreateArticleOnCaseController.getRecTypeId(rtList[0]);
        if(recordId != null){
            if(rtList[0] == 'FAQ')
            checkId= Schema.SObjectType.Article__kav.getRecordTypeInfosByName().get('FAQ').getRecordTypeId();
            else if(rtList[0] == 'How-To')
               checkId= Schema.SObjectType.Article__kav.getRecordTypeInfosByName().get('How-To').getRecordTypeId();
             else if(rtList[0] == 'Discussion Guide')
               checkId= Schema.SObjectType.Article__kav.getRecordTypeInfosByName().get('Discussion Guide').getRecordTypeId();
        }
        system.assertEquals(checkId , recordId );
        test.stopTest();
        
    }

}