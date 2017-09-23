/*------------------------------------------------------------
Author:         Shyamala Sridevi
Company:        Capgemini
Description:    This Class is to handle the logic to return the meta data like RecordtypeID.
                        
Test Class:     OLCN_TestDataUtility
History
18/July/2017    Shyamala Sridevi Created
------------------------------------------------------------*/
public class OLCN_MetaUtility {
   
    static String onlineClaimRecordTypeId;
    static String onlineClaimFeedbackRecordTypeId;
    static String businessOLCNRecordTypeId;
    static String individualOLCNRecordTypeId;
    static String contactOLCNRecordTypeId;
    static String contactCTPRecordTypeId;
    
    //This method returns the Case records related to OLCN cases only.
    public static String getCaseOnlineClaimRecordType()
    {
        if(OLCN_MetaUtility.empty(onlineClaimRecordTypeId))
        {
            onlineClaimRecordTypeId = [Select Id from RecordType where DeveloperName='Online_Claims_Notification' and sObjectType = 'Case' limit 1].Id;
        }
        return onlineClaimRecordTypeId;
    }
    
     //This method returns the Case records related to OLCN cases and feedback type too.
    public static String getCaseClaimAndFeedbackRecordType()
    {
        if(OLCN_MetaUtility.empty(onlineClaimFeedbackRecordTypeId))
        {
            onlineClaimFeedbackRecordTypeId = [Select Id from RecordType where DeveloperName = 'Feedback' and sObjectType = 'Case' limit 1].Id;
        }
        return onlineClaimFeedbackRecordTypeId;
    }
        
    //This method returns the Account records related to OLCN Business accounts.
    public static String getAccountBusinessOLCNRecordType()
    {
        if(OLCN_MetaUtility.empty(businessOLCNRecordTypeId))
        {
            businessOLCNRecordTypeId = [Select Id from RecordType where DeveloperName='Business_OLCN' and sObjectType = 'Account' limit 1].Id;
        
        }
        return businessOLCNRecordTypeId;
    }
    
    //This method returns the Account records related to OLCN Individual accounts.
    public static String getAccountIndividualOLCNRecordType()
    {
        if(OLCN_MetaUtility.empty(individualOLCNRecordTypeId))
        {
        individualOLCNRecordTypeId = [Select Id from RecordType where DeveloperName='Individual_OLCN' and sObjectType = 'Account' limit 1].Id;
        }
        return individualOLCNRecordTypeId;
    }
    
    //This method returns the Contact records related to OLCN Contact records.
    public static String getContactOLCNRecordType()
    {
        if(OLCN_MetaUtility.empty(contactOLCNRecordTypeId))
        {
        contactOLCNRecordTypeId = [Select Id from RecordType where DeveloperName='Contact_OLCN' and sObjectType = 'Contact' limit 1].Id;
        }
        return contactOLCNRecordTypeId;
    }
    
    public static String getContactCTPRecordType()
    {
        if(OLCN_MetaUtility.empty(contactCTPRecordTypeId))
        {
        contactCTPRecordTypeId = [Select Id from RecordType where DeveloperName='CTP_Public' and sObjectType = 'Contact' limit 1].Id;
        }
        return contactCTPRecordTypeId;
    }
    
    public static Boolean empty(string o)
    {
        return o==null || o.trim()=='';
    }
    
    //This method returns the custom settings for General settings for OLCN Case view.
    public static String getGeneralSettingValue(string recordName)
    {
        try{
            OLCN_GeneralSetting__c secttingRecord=OLCN_GeneralSetting__c.getInstance(recordName);
            if(secttingRecord!=null){
                return secttingRecord.OLCN_value__C;
            }else{ return '';}
        }catch(exception ex){
            return '';
        }
    }

}