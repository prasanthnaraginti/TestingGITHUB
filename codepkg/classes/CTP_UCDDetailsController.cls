public without sharing class CTP_UCDDetailsController {
    //public static CTP_UDCResponseWrapper ucdObj;
    @Auraenabled
    public static CTP_UDCResponseWrapper getUcddetails()
    {
        CTP_UDCResponseWrapper responseObj=new CTP_UDCResponseWrapper();
        responseObj.Claimnumber='123456';
        responseObj.Claimantname='Sally Robinson';
        responseObj.Dateofaccident='15/12/2017';
        responseObj.Locationofaccident='NSW 2000';
        responseObj.InsurerName = 'QBE';
        System.debug('@@@@'+responseObj);
        //ucdObj = responseObj;
        return responseObj;
    }
    
    @Auraenabled
    public static String createCaseRecord(String reviewCompletion,String reviewRecept,String ClaimNumber, String disagreementReason ,String ucdObj)
    {
        reviewCompletion = reviewCompletion.remove('"');
        List<String> reviewCompletionDateParts = reviewCompletion.split('-');
        Date reviewCompletionDate = Date.newInstance(Integer.valueOf(reviewCompletionDateParts[0]), Integer.valueOf(reviewCompletionDateParts[1]), Integer.valueOf(reviewCompletionDateParts[2]));
        
        reviewRecept = reviewRecept.remove('"');
        List<String> reviewReceptDateParts = reviewRecept.split('-');
        Date reviewReceptDate = Date.newInstance(Integer.valueOf(reviewReceptDateParts[0]), Integer.valueOf(reviewReceptDateParts[1]), Integer.valueOf(reviewReceptDateParts[2]));
        
        CTP_UDCResponseWrapper ucdRecord = (CTP_UDCResponseWrapper)JSON.deserialize(ucdobj,CTP_UDCResponseWrapper.class);
        String dateOfAccident = ucdRecord.Dateofaccident;
        List<String> accidentDateParts = dateOfAccident.split('/');
        Date accidentDate = Date.newInstance(Integer.valueOf(accidentDateParts[2]), Integer.valueOf(accidentDateParts[1]), Integer.valueOf(accidentDateParts[0]));
        System.Debug('@@@=============='+reviewCompletion+reviewRecept+ClaimNumber+disagreementReason+ucdObj);
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        
        //Creating the DMLOptions for "Assign using active assignment rules" checkbox
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        
        Case caseObj=new Case();
        
        caseObj.RecordTypeId=[Select id from Recordtype where sobjecttype='Case' and DeveloperName='CTP_Application'].id;
        caseObj.Status='Lodgement';
        caseObj.CTP_CaseSubStatus__c='Application received';
        caseObj.CTP_CaseSubType__c='Application received';
        caseObj.Origin='Web';
        caseObj.Priority='Low';
        caseobj.Subject = 'Web form application';
        User usr = [select Id , ContactId from User where Id =: UserInfo.getUserId()];

        caseobj.CTP_InjuredPersonContact__c = usr.ContactId;
        caseObj.ClaimNumber__c=ClaimNumber;
        ///caseObj.CTP_Claim_Number__c=String.valueof(ClaimNumber);
        caseObj.CTP_ReviewCompletionDate__c= reviewCompletionDate;
        caseObj.CTP_ReviewReceiptDate__c= reviewReceptDate;
        caseObj.CTP_Insurer_name__c = ucdRecord.InsurerName;
        caseObj.CTP_Date_of_accident__c=accidentDate;
        caseObj.CTP_outline_what_it_is_that_you_dont_agr__c = disagreementReason;
        caseObj.setOptions(dmlOpts);
        caseObj.CTP_Email__c=[Select Email from User where id=:UserInfo.getUserId() limit 1].Email;
        caseObj.CTP_InsurerInternalReviewDone__c=true;
        caseObj.CTP_Time_When_Application_Lodged__c = Datetime.now().format('hh:mm:ss a');
        caseObj.CTP_ClaimNumber__c=ClaimNumber;
        caseObj.Claimant_Name__c=ucdRecord.Claimantname;
        //caseObj.CTP_Location_of_accident__latitude__s=33.8688;
        //caseObj.CTP_Location_of_accident__longitude__s=151.2093;
        caseObj.Accident_Location__c = ucdRecord.Locationofaccident;
        caseObj.DateTimeCaseLodged__c = System.now();
        System.Debug('@@@'+caseObj);
        try
        {
            insert caseObj;
            String caseId=caseObj.id;
            Case cas = [Select id,CaseNumber,Contact.Email from Case where id=:caseId limit 1];
            return caseObj.id;
        }
        catch(Exception e)
        {
            return '12312312';
        } 
    }
    
    
}