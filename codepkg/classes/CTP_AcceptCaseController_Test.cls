@isTest
public class CTP_AcceptCaseController_Test {
    static testMethod void testAcceptCaseController() {
        Group testGroup = new Group(Name='CTP_CAS_Feedback', Type='Queue');
        insert testGroup;
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
            QueuesObject testQueue = new QueueSObject(QueueID = testGroup.id, SObjectType = 'Case');
            insert testQueue;
        }
        Case csObj = new Case();
        csObj.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Feedback').getRecordTypeId(); 
        csObj.OwnerId =testGroup.id;
        csObj.status = 'New';
        csObj.Origin = 'Post';
        csObj.CTP_Feedback_Type__c = 'Enquiry';
        csObj.CTP_Feedback_Sub_type__c = 'Motor Accident Injury Claims';
        csObj.Description = 'Test Case';
        insert csObj;     
        
        Test.StartTest();
        CTP_AcceptCaseController.checkOwner(csObj.id);
        system.assertEquals(true, CTP_AcceptCaseController.checkOwner(csObj.id));
        CTP_AcceptCaseController.acceptCase(csObj.id);
        system.assertEquals(true, CTP_AcceptCaseController.acceptCase(csObj.id));
        test.stopTest();   
    }
}