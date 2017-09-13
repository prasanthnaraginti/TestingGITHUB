@isTest
public class CTP_FetchFeedbackFormController_Test { 
    static testMethod void testFetchFeedbackFormController() {
        CTP_FeedbackTypeSubType__c feedbacktypesubtype = new CTP_FeedbackTypeSubType__c();
        feedbacktypesubtype.Name = 'TestEnquiry';
        feedbacktypesubtype.CTP_Case_Type__c = 'DRS';
        feedbacktypesubtype.CTP_Feedback_Type__c = 'Enquiry';
        feedbacktypesubtype.CTP_Feedback_SubType__c = 'Claims Disputes';
        insert feedbacktypesubtype;
        
        CTP_FeedbackTypeSubType__c feedbacktype = new CTP_FeedbackTypeSubType__c();
        feedbacktype.Name = 'TestFeedback';
        feedbacktype.CTP_Case_Type__c = 'CAS';
        feedbacktype.CTP_Feedback_Type__c = 'Feedback';
        feedbacktype.CTP_Feedback_SubType__c = 'Green Slips';
        insert feedbacktype;
        
        CTP_FeedbackTypeSubType__c feedbacktypesubtypes = new CTP_FeedbackTypeSubType__c();
        feedbacktypesubtypes.Name = 'TestCompliment';
        feedbacktypesubtypes.CTP_Feedback_Type__c = 'Compliment';
        feedbacktypesubtypes.CTP_Feedback_SubType__c = 'Our Dispute Resolution Services';
        insert feedbacktypesubtypes;
        
        CTP_CaseTypeMapping__c caseTypeMap = new CTP_CaseTypeMapping__c();
        caseTypeMap.Name = 'testDRS';
        caseTypeMap.CTP_Case_Type__c = feedbacktypesubtype.CTP_Case_Type__c;
        caseTypeMap.CTP_Origin__c = 'Web';
        caseTypeMap.CTP_Priority__c = 'Low';
        caseTypeMap.CTP_RecordType__c = 'Feedback';
        caseTypeMap.CTP_Status__c = 'New';
        insert caseTypeMap;
        
        CTP_CaseTypeMapping__c caseTypeMaps = new CTP_CaseTypeMapping__c();
        caseTypeMaps.Name = 'testCAS';
        caseTypeMaps.CTP_Case_Type__c = feedbacktype.CTP_Case_Type__c;
        caseTypeMaps.CTP_Origin__c = 'Web';
        caseTypeMaps.CTP_Priority__c = 'Low';
        caseTypeMaps.CTP_RecordType__c = 'Feedback';
        caseTypeMaps.CTP_Status__c = 'New';
        insert caseTypeMaps;
        
        Id csRecordTypeId = [select id,Name from RecordType where sobjecttype = 'Case' and Name =:caseTypeMaps.CTP_RecordType__c].Id;
        
        Case caseObj = new Case();
		caseObj.RecordTypeId = csrecordTypeId;
		caseObj.CTP_CaseType__c = caseTypeMaps.CTP_Case_Type__c;
		caseObj.Origin = caseTypeMaps.CTP_Origin__c;
		caseObj.Status = caseTypeMaps.CTP_Status__c;
		caseObj.Priority = caseTypeMaps.CTP_Priority__c;
		caseObj.Description = 'Motor Accident Injury Claims';
		caseObj.CTP_Feedback_Type__c = feedbacktypesubtype.CTP_Feedback_Type__c;
		caseObj.CTP_Feedback_Sub_type__c = feedbacktypesubtype.CTP_Feedback_SubType__c;
		caseObj.CTP_Response_Required__c = true;
		insert caseObj; 
        
        Case caseObjs = new Case();
		caseObjs.RecordTypeId = csrecordTypeId;
		caseObjs.CTP_CaseType__c = caseTypeMap.CTP_Case_Type__c;
		caseObjs.Origin = caseTypeMap.CTP_Origin__c;
		caseObjs.Status = caseTypeMap.CTP_Status__c;
		caseObjs.Priority = caseTypeMap.CTP_Priority__c;
		caseObjs.Description = 'The CTP Scheme';
		caseObjs.CTP_Feedback_Type__c = feedbacktype.CTP_Feedback_Type__c;
		caseObjs.CTP_Feedback_Sub_type__c = feedbacktype.CTP_Feedback_SubType__c;
		caseObjs.CTP_Response_Required__c = true;
		insert caseObjs; 
        
        CTP_FetchFeedbackFormController.getselectOptions('CTP_Feedback_Type__c');
        CTP_FetchFeedbackFormController.getselectOptions('CTP_Feedback_Sub_type__c');    
        CTP_FetchFeedbackFormController.getDependentOptions('Enquiry');
        CTP_FetchFeedbackFormController.getDependentOptions('Feedback');
        CTP_FetchFeedbackFormController.getDependentOptions('Compliment');
        CTP_FetchFeedbackFormController.checkCaseType('Enquiry' , 'Motor Accident Injury Claims' ,'Motor Accident Injury Claims', true);
        CTP_FetchFeedbackFormController.checkCaseType('Enquiry' , 'Claims Disputes' ,'Motor Accident Injury Claims', true);
        CTP_FetchFeedbackFormController.checkCaseType('Feedback' , 'Green Slips' ,'The CTP Scheme', true);
        CTP_FetchFeedbackFormController.checkCaseType('Feedback' , 'Our Dispute Resolution Services' ,'The CTP Scheme', true);
        CTP_FetchFeedbackFormController.checkCaseType('Compliment' , 'The CTP Scheme' ,'The CTP Scheme', true);
        CTP_FetchFeedbackFormController.checkCaseType('Compliment' , 'Our Dispute Resolution Services' ,'The CTP Scheme', true);
        system.assertEquals(caseObjs.CTP_Response_Required__c,true);
    }    

}