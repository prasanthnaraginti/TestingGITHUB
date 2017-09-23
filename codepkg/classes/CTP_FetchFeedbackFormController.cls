//Apex Controller class for CTP_Feedback Form component
public class CTP_FetchFeedbackFormController { 
    
    //Method:To retrieve Feedback Type picklist values from metadata
    @AuraEnabled
    public static List < String > getselectOptions(string fld) {
        List < String > allOpts = new list < String > ();
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            Case.getSObjectType().getDescribe().fields.getMap().get(fld).getDescribe().getPickListValues(); 
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        return allOpts;
    }
    
    //Method to retireve feedback sub-type dependent picklist values from custom setting 
    @AuraEnabled
    public static List<String> getDependentOptions(string masterValue){
        List<String> options = new List<String>();
        Map<String,List<String>> feedbackTypesMap =  new  Map<String,List<String>> ();
        List<String> fsubtypeListForEnquiry = new List<String>();
        Set<String> fsubtypeSetForFeedbackOrComplaint = new Set<String>();
        List<String> fsubtypeListForFeedbackOrComplaint = new List<String>();
        List<String> fsubtypeListForCompliment = new List<String>();
        
        For(CTP_FeedbackTypeSubType__c obj: [Select CTP_Feedback_Type__c,CTP_Feedback_SubType__c from CTP_FeedbackTypeSubType__c]){ 
            if(obj.CTP_Feedback_Type__c == Label.CTP_Enquiry){
                fsubtypeListForEnquiry.add(obj.CTP_Feedback_SubType__c);
            }
            if(obj.CTP_Feedback_Type__c == Label.CTP_Feedback || obj.CTP_Feedback_Type__c == Label.CTP_Complaint){
                fsubtypeSetForFeedbackOrComplaint.add(obj.CTP_Feedback_SubType__c);
            }
            
            if(obj.CTP_Feedback_Type__c == Label.CTP_Compliment){
                fsubtypeListForCompliment.add(obj.CTP_Feedback_SubType__c);
            }         
        }
        if(fsubtypeListForEnquiry.size()>0){
            feedbackTypesMap.put(Label.CTP_Enquiry,fsubtypeListForEnquiry);
        }
        if(fsubtypeSetForFeedbackOrComplaint.size()>0){
            for(String s:fsubtypeSetForFeedbackOrComplaint){
                fsubtypeListForFeedbackOrComplaint.add(s);
            }
            feedbackTypesMap.put(Label.CTP_Feedback,fsubtypeListForFeedbackOrComplaint);
            feedbackTypesMap.put(Label.CTP_Complaint,fsubtypeListForFeedbackOrComplaint);
        }
        if(fsubtypeListForCompliment.size()>0){
            feedbackTypesMap.put(Label.CTP_Compliment,fsubtypeListForCompliment);
        }
        
        List<String> fsubTypeList = new List<String>();
        fsubTypeList = feedbackTypesMap.get(masterValue);
        for(String s:fsubTypeList){
            options.add(s);
        }
        return options;
    }
    
    //Method: To check 'CAS' or 'DRS' type of cases based on picklist values selected in dropdown values from custom setting
    @AuraEnabled
    public static string checkCaseType(String feedbackType , String feedbackSubType ,String descValue, Boolean respValue){
        Case caseDetail= new Case();
        try{
            CTP_FeedbackTypeSubType__c fTypeCaseType = [Select CTP_Feedback_Type__c,CTP_Feedback_SubType__c,CTP_Case_Type__c from CTP_FeedbackTypeSubType__c where CTP_Feedback_SubType__c=:feedbackSubType AND CTP_Feedback_Type__c=:feedbackType LIMIT 1];
            String csid =  createCase(fTypeCaseType.CTP_Case_Type__c,feedbackType,feedbackSubType,descValue,respValue);
            caseDetail=[Select CaseNumber from case where id=:csid];
        }
        catch(Exception e){
            system.debug('message>>>'+e);
        }
        
        return caseDetail.CaseNumber;
    }
    //Method: To create 'CAS' or 'DRS' type of cases based on picklist values selected in dropdown values.
    @AuraEnabled
    public static string createCase(String caseType ,String feedbackType,String feedbackSubType,String descValue ,Boolean respValue){
        Case csObj = new Case();
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.useDefaultRule= true;
        CTP_CaseTypeMapping__c newCaseInfo = [Select CTP_Status__c,CTP_Origin__c,CTP_Priority__c,CTP_RecordType__c,CTP_Case_Type__c from CTP_CaseTypeMapping__c where CTP_Case_Type__c=:caseType LIMIT 1];
        Id CSFRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(newCaseInfo.CTP_RecordType__c).getRecordTypeId(); 
        csObj.RecordTypeId= CSFRecordTypeId ;
        csObj.CTP_CaseType__c = newCaseInfo.CTP_Case_Type__c;
        csObj.Status = newCaseInfo.CTP_Status__c;
        csObj.Origin = newCaseInfo.CTP_Origin__c;
        csObj.Priority = newCaseInfo.CTP_Priority__c;
        csObj.setOptions(dmlOpts ); 
        csObj.CTP_Feedback_Type__c = feedbackType;
        csObj.CTP_Feedback_Sub_type__c = feedbackSubType;
        csObj.description = descValue;
        csObj.CTP_Response_Required__c = respValue;
        insert csObj; 
        return csObj.id;
    }  
}