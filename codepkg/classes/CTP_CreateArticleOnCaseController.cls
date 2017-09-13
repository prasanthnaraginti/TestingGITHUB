public class CTP_CreateArticleOnCaseController {
    public static Map<Id, String> recordtypemap {get;set;}
 @AuraEnabled
    public static List<String> getArticleRecordType(){
        List<Schema.RecordTypeInfo> recordtypes = Article__kav.SObjectType.getDescribe().getRecordTypeInfos();    
        recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes){
            if(rt.getName() != Label.CTP_MasterRecordType)
            recordtypemap.put(rt.getRecordTypeId(), rt.getName());
        }        
        return recordtypemap.values();
       
    }
    
    @AuraEnabled
    public static Id getRecTypeId(String recordTypeLabel){
        Id recid = Schema.SObjectType.Article__kav.getRecordTypeInfosByName().get(recordTypeLabel).getRecordTypeId();        
        return recid;
    }   
   
}