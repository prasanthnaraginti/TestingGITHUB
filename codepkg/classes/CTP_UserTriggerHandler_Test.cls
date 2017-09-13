@isTest
public class CTP_UserTriggerHandler_Test {
    public static List<User> lstUser = new List<User>();
    public static List<Contact> lstContact = new List<Contact>();
    public static User usr;
    public static Contact con;
    
    static testMethod void optOutOfEmail_Test() {
        createTestData();
        insert con;
        usr.CTP_Opt_Out_of_Case_Email_Updates__c = true;
        usr.ContactId = con.Id;
        
        lstUser.add(usr);
        insert lstUser;
        
        Test.StartTest();
        CTP_UserTriggerHandler.optOutOfEmail(lstUser);
        //CTP_UserTriggerHandler.optOutOfEmailUpdateContact(lstContact);
        test.stopTest();   
    }
    public static void createTestData(){
        Account a = new Account();
        a.Name= 'Test Account';
        a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CTP_Insurer').getRecordTypeId(); 
        insert a;
        
        con = new Contact();
        con.AccountId = a.Id;
        con.FirstName = 'Test First Name';
        con.LastName = 'Test Last Name';
        con.Email = 'test@test.com';
        con.InterpreterRequired__c = 'No';
        con.CTP_Opt_Out_of_Case_Email_Updates__c = true;
        

        Profile p = [SELECT Id FROM Profile WHERE Name='CTP Insurer Claim Manager']; 
      
        usr = new User(Alias = 'Testusr', Email='testuser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='Australia/Sydney', UserName='testuser@testorg.com.test', CTP_Opt_Out_of_Case_Email_Updates__c = true);

        // System.runAs(u) {
         // // The following code runs as user 'u' 
        // System.debug('Current User: ' + UserInfo.getUserName());
        // System.debug('Current Profile: ' + UserInfo.getProfileId()); 
    }
    static testMethod void optOutOfEmailUpdateContact_Test(){
        createTestData();

        Test.startTest();
            lstContact.add(con);
            insert lstContact;
            for(Contact co: lstContact){
                usr.ContactId = co.Id;
                usr.CTP_Opt_Out_of_Case_Email_Updates__c = true;
                lstUser.add(usr);
            }
            // if(!lstUser.isEmpty())
                // insert lstUser;
            CTP_UserTriggerHandler.optOutOfEmailUpdateContact(lstContact);
        Test.stopTest();
    }
}