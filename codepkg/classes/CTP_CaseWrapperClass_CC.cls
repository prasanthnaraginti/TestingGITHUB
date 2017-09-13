public class CTP_CaseWrapperClass_CC {

    @AuraEnabled
    public Case caseRecord{get;set;}    
    
    /*public String disputeCategory{get;set;}
    public String disputeType{get;set;}
    public String recordTypeId{get;set;}
    public String parentId{get;set;}
    */
    
    
    @AuraEnabled
    public Boolean isStatusADR{get;set;}
    
    @AuraEnabled
    public Boolean isChecked{get;set;}
  
    
    
}