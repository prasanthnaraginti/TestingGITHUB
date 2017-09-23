/*------------------------------------------------------------
Author:         Lavanya Uddarraju
Company:        Capgemini
Description:    This is the test class for Case trigger Helper class 
                        
History
27/July/2017    <Lavanya Uddarraju>     Created
------------------------------------------------------------*/
@isTest
public class OLCN_CaseTriggerHelper_Test{

    //This method will test the look up of Contacts to Case created.

    
    //This method will test the look up of Insurer to Case.
    public static testmethod void testLookUpOnInsurer()
    {   
        List<Case> newCaseList = OLCN_TestDataUtility.creatCase();
        Account newAccount = OLCN_TestDataUtility.createAccount();
        newCaseList[0].OLCN_Insurer__c=newAccount.id;
        newCaseList[0].OLCN_InsurerStatus__c='New';
        newCaseList[0].OLCN_InsurerCode__c='26 - AAMI';
        newCaseList[0].OLCN_InsurerEmail__c='test@gmail.com';       
        update newCaseList[0];
        
        //This will assert the lookup of Insurer on Case.
        system.assertEquals(newCaseList[0].OLCN_Insurer__c,newAccount.Id);
    }
    
    //This method will test the duplicate Cases.
    public static testmethod void testDuplicateCheck()
    {            
		List<Case> newCaseList=OLCN_TestDataUtility.createCaseList();
        List<Case> dupCaseList=OLCN_TestDataUtility.createCaseList(); 
        Case caseRecord = [Select Status,OLCN_CloseReason__c from case where Id=:dupCaseList[0].Id];
        
        //This will assert whenever the system tries to insert theh duplicate ,updates the closed reason with "Duplicate""
        system.assertEquals(caseRecord.OLCN_CloseReason__c, 'Duplicate');              
    }  
    
    //This method will test whenever there is a change in lookup ,updating the contact fields on case or not
	public static testmethod void testLookUpOnContact()
	{
		ID ContactRecordtype=OLCN_MetaUtility.getContactOLCNRecordType();
        list<case> caseList=OLCN_TestDataUtility.createCaseList();
		Contact cntInj=new Contact();
        cntInj.RecordTypeID=ContactRecordtype;
        cntInj.LastName='replast1';
        cntInj.FirstName='rep1';
        cntInj.Email='rep1@test.com';
        cntInj.Phone='908871';
        insert cntInj;
		caseList[0].contactID=cntInj.id;
		update caseList[0];
        List<case> newcase=[select id,OLCN_FormFirstName__c,OLCN_FormLastName__c,OLCN_FormPhone__c,OLCN_FormEmail__c from case where id=:caseList[0].id];
        
        //This will assert the form first name,lastname,Phone and emails are updated with the fields from contact or not
        system.assertEquals(newcase[0].OLCN_FormFirstName__c,cntInj.FirstName);
		system.assertEquals(newcase[0].OLCN_FormLastName__c,cntInj.lastName);
		system.assertEquals(newcase[0].OLCN_FormPhone__c,cntInj.Phone);
		system.assertEquals(newcase[0].OLCN_FormEmail__c,cntInj.Email);
       
        list<case> caseList1=OLCN_TestDataUtility.createCaseList();
		Contact cntRep=new Contact();
        cntRep.RecordTypeID=ContactRecordtype;
        cntRep.LastName='reptest';
        cntRep.FirstName='rep1test';
        cntRep.Email='rep1@test500.com';
        cntRep.Phone='23413';
        insert cntRep;
		caseList1[0].OLCN_RepContact__c=cntRep.id;
		update caseList1[0];
        List<case> newcase1=[select id,OLCN_FormRepFirstName__c,OLCN_FormRepLastName__c,OLCN_FormRepPhone__c,OLCN_FormRepEmail__c from case where id=:caseList1[0].id];        
		
		//This will assert the form first name,lastname,Phone and emails are updated with the fields from contact or not
		system.assertEquals(newcase1[0].OLCN_FormRepFirstName__c,cntRep.FirstName);
		system.assertEquals(newcase1[0].OLCN_FormRepLastName__c,cntRep.lastName);
		system.assertEquals(newcase1[0].OLCN_FormRepPhone__c,cntRep.Phone);
		system.assertEquals(newcase1[0].OLCN_FormRepEmail__c,cntRep.Email);		
	}		 
}