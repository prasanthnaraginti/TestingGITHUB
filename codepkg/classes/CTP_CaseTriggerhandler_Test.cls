/*********************
 * Test Class : CTP_CaseTriggerhandler_Test
 * Class : CTP_CaseTriggerhandler
 * Purpose : 
 * Author : Sudha Kumari
 * *******************************/
@isTest(seeAllData=false)
private class CTP_CaseTriggerhandler_Test {
    static testMethod void testCaseBeforeInsert(){
        List<RecordType> rcType = [select id,name from RecordType where sObjectType = 'case' and Name = 'Feedback'];
        Account acc = new account();
        acc.Name = 'Test Account';
        insert acc;
       
        Contact con = new Contact();
        con.lastName = 'Test Contact';
        Con.accountId = acc.Id;
        con.InterpreterRequired__c = 'Yes';
        con.Language__c = 'English';
        insert con;
        
        Entitlement ent = new Entitlement();
        ent.Name = 'CTP Feedback PS';
        ent.AccountId = acc.id;
        insert ent;
        
        CTP_CaseRecordTypeEntitlementMapping__c CaseEMap= new CTP_CaseRecordTypeEntitlementMapping__c();
        CaseEMap.Name = '1';
        CaseEMap.CTP_Case_Record_Type__c = 'Feedback';
        CaseEMap.CTP_Entitlement_Process_Name__c = 'CTP Feedback PS'; 
        insert CaseEMap; 
        
        Case cs = new case();
        cs.CTP_InjuredPersonContact__c = con.id;
        cs.recordTypeId = rcType[0].id;
        cs.status = 'Introduction Call';
        cs.CTP_Next_Action_Status__c = 'Must Call';
       // cs.CTP_ActionAndOutcome__c = 'Unable to Contact';
        insert cs;      
        
        Case csAfterTrigger = [select id , entitlementId from case limit 1];
        System.assertEquals(csAfterTrigger.EntitlementID,ent.id);
                
    }
    static testMethod void testCaseAfterUpdate(){
        List<RecordType> rcType = [select id,name from RecordType where sObjectType = 'case' and Name = 'CTP Assist - Claimant Support'];
        List<Group> queueObj= [select Id from Group where NAME = 'CTP Assist Feedback' Limit 1];
        List<User> userList = [select id from user where user.Profile.name ='CTP Claims Advisor' limit 1];
        Account acc = new account();
        acc.Name = 'Test Account';
        insert acc;
       
        Contact con = new Contact();
        con.lastName = 'Test Contact';
        Con.accountId = acc.Id;
        con.InterpreterRequired__c = 'Yes';
        con.Language__c = 'English';
        insert con;
        
        Entitlement ent = new Entitlement();
        ent.Name = 'CTP Feedback PS';
        ent.AccountId = acc.id;
        insert ent;
                
        CTP_CaseRecordTypeEntitlementMapping__c CaseEMap= new CTP_CaseRecordTypeEntitlementMapping__c();
        CaseEMap.Name = '2';
        CaseEMap.CTP_Case_Record_Type__c = 'CTP Assist - Claimant Support';
        CaseEMap.CTP_Entitlement_Process_Name__c = 'CTP Feedback PS'; 
        insert CaseEMap; 
        
        Case cs = new case();
        cs.CTP_InjuredPersonContact__c = con.id;
        cs.recordTypeId = rcType[0].id;
        cs.CTP_Date_of_accident__c = system.today() - 1;
        cs.CTP_LodgementDate__c = system.today();
        cs.status = 'Introduction Call';
        cs.CTP_Next_Action_Status__c = 'Must Call';
        cs.CTP_ActionAndOutcome__c = 'Unable to Contact';
        //cs.OwnerId = queueObj[0].id;
        cs.OwnerId = userList[0].id;
        cs.CTP_CaseType__c = 'CAS';
        insert cs;
        
        Case csAfterTrigger = [select id , entitlementId from case limit 1];
        System.assertEquals(csAfterTrigger.EntitlementID,ent.id);
        
        
       /* CaseMilestone cMStone = new CaseMilestone();
        cMStone.MilestoneType.Name = 'CTP Milestone 1 26-Week Entitlement';
      //  cMStone.caseId = cs.id;
        insert cMStone;   */
        
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate from CaseMilestone where (MilestoneType.Name='CTP Milestone 1 26-Week Entitlement' OR MilestoneType.Name='CTP Milestone 2 26-Week Entitlement' OR MilestoneType.Name='CTP Milestone 3 26-Week Entitlement') and completionDate = null];
            
        cs.status = '10 week call';
        cs.CTP_ActionAndOutcome__c = 'Claimant does not want to be contacted';
        Update cs;
      
        cs.status = '23 week call';
        Update cs;
        
        cs.status = 'Introduction Call';
       // cs.CTP_ActionAndOutcome__c = 'Unable to Contact';
        Update cs;
    }

}