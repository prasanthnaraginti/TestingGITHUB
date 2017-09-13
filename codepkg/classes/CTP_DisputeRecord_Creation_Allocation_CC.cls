/*****************************************************************
Name: CTP_DisputeRecord_Creation_Allocation_CC
Purpose: 1.To query all the related dispute records specific to an Parent Application record.
         2.To query the RecordType Id of Dispute RecordType
         
History
--------
VERSION  AUTHOR     DATE       DETAIL   Description
1.0     Capgemini  26-07-2017  Created  DCR-330,DCR-194,DCR-134
*****************************************************************/
public class CTP_DisputeRecord_Creation_Allocation_CC {
 
    public static List<CTP_CaseWrapperClass_CC> recordsForAllocation;    
	/*****************************************************************
    Purpose: To query all the related dispute records specific to an Parent Application record.
    Parameters: CaseId
    Returns: List<Case>
   
    History
    --------
    VERSION  AUTHOR     DATE       DETAIL   Description
    1.0     Capgemini  26-07-2017  Created  DCR-330,DCR-134,DCR-194
   *******************************************************************/
    
    @AuraEnabled
    public static List<CTP_CaseWrapperClass_CC> getDisputeCaseRecords(String caseId){
        
        system.debug('caseId:::::'+caseId);
        List<Case> caseRecordsList = [Select Id,CaseNumber,CTP_DisputeCategories__c,CTP_DisputeTypes__c,Owner.Name,Status,CTP_CaseSubStatus__c from Case where RecordType.Name = 'Dispute' AND ParentId = :caseId];
        List<CTP_CaseWrapperClass_CC> caseWrapperList = new List<CTP_CaseWrapperClass_CC>();
        
        if(!caseRecordsList.isEmpty()){
            for(Case rec : caseRecordsList){
                CTP_CaseWrapperClass_CC obj = new CTP_CaseWrapperClass_CC();
                obj.caseRecord = rec;
                if(rec.Status == System.Label.CTP_CaseStatus_ADR){
                	obj.isStatusADR = true;
                }  
                obj.isChecked = false;
                caseWrapperList.add(obj);
            }
        }    
        system.debug('case List:::::'+caseRecordsList);
        if(!caseWrapperList.isEmpty()){
            return caseWrapperList; 
        }else{
            return null;
        }
        
    }   
    
    /*****************************************************************
    Purpose: To query the Id of Dispute RecordType
    Parameters: NA
    Returns: String
   
    History
    --------
    VERSION  AUTHOR     DATE       DETAIL   Description
    1.0     Capgemini  26-07-2017  Created  DCR-330,DCR-194,DCR-134
   *******************************************************************/
    @AuraEnabled
    public static String getDisputeRecordTypeId(){
        
        system.debug('Method getDisputeRecordTypeId');
        String disputeRecordTypeId = [SELECT Id,Name FROM RecordType where Name='Dispute'].Id;
        system.debug('Dispute RecordType Id::::::'+disputeRecordTypeId);
        if(disputeRecordTypeId != '' && disputeRecordTypeId != null){
            return disputeRecordTypeId; 
        }else{
            return null;
        }
        
    }
	
	 /*****************************************************************
    Purpose: To get the picklist values of Case Field CTP_DisputeCategories__c
    Parameters: NA
    Returns: List<String>
   
    History
    --------
    VERSION  AUTHOR     DATE       DETAIL   Description
    1.0     Capgemini  26-07-2017  Created  DCR-330,DCR-194,DCR-134
   *******************************************************************/
    
    @AuraEnabled
    public static List<String> getDisputeCategories(){
        List<String> options = new List<String>();
        
       Schema.DescribeFieldResult fieldResult =
       Case.CTP_DisputeCategories__c.getDescribe();
        
       List<Schema.PicklistEntry> disputeCategoryValues = fieldResult.getPicklistValues();
       
        //options.add('------None------');
       for( Schema.PicklistEntry f : disputeCategoryValues)
       {
           options.add(f.getValue());
          
       }       
       return options;
    }
	
	/*****************************************************************
    Purpose: To create a map of Dispute Categories and Dispute Types by querying the custom setting CTP_DisputeCategoryDisputeTypeMapping__c
    Parameters: NA
    Returns: Map<String,List<String>>
   
    History
    --------
    VERSION  AUTHOR     DATE       DETAIL   Description
    1.0     Capgemini  26-07-2017  Created  DCR-330,DCR-194,DCR-134
   *******************************************************************/

	@AuraEnabled
    public static Map<String,List<String>> getDisputeMapping(){
        
        Map<String,List<String>> mappingRecords = new Map<String,List<String>>();
        List<CTP_DisputeCategoryDisputeTypeMapping__c> recordsList = [Select CTP_DisputeCategory__c,CTP_DisputeTypes__c from CTP_DisputeCategoryDisputeTypeMapping__c];
        
        for(CTP_DisputeCategoryDisputeTypeMapping__c rec : recordsList){
            if(mappingRecords.containsKey(rec.CTP_DisputeCategory__c)){
            	mappingRecords.get(rec.CTP_DisputeCategory__c).add(rec.CTP_DisputeTypes__c);
            }else{
               List<String> disputeTypeList = new List<String>();
               disputeTypeList.add(rec.CTP_DisputeTypes__c);
               mappingRecords.put(rec.CTP_DisputeCategory__c,disputeTypeList); 
            }    
            /*List<String> disputeTypeList = rec.CTP_DisputeTypes__c.split(',');
            mappingRecords.put(rec.CTP_DisputeCategory__c,disputeTypeList);*/
        }
        system.debug('mapping::'+mappingRecords);
        return mappingRecords;
        
    }  
    
    /*****************************************************************
    Purpose: To create a new dipsute record specific to an application
    Parameters: Case disputeCaseRecord
	            String parentId
				String recordTypeId
    Returns: CTP_CaseWrapperClass_CC
   
    History
    --------
    VERSION  AUTHOR     DATE       DETAIL   Description
    1.0     Capgemini  26-07-2017  Created  DCR-330,DCR-194,DCR-134
   *******************************************************************/
   
    @AuraEnabled
    public static CTP_CaseWrapperClass_CC createChildDisputeRecord(Case disputeCaseRecord,String parentId,String recordTypeId){
        
        /*Case caserec = new Case();
        caserec.RecordTypeId = recordTypeId;
        caserec.ParentId = parentId;
        caserec.CTP_DisputeCategories__c = disputeCaseRecord.disputeCategory;
        caserec.CTP_DisputeTypes__c = disputeType;
        caserec.Status = 'Appropriate Dispute Resolution';*/

        disputeCaseRecord.RecordTypeId = recordTypeId;
        disputeCaseRecord.ParentId = parentId;
        
        try{ 
        	Insert disputeCaseRecord;
        }catch(Exception ex){
            system.debug('Exception:::'+ex);
        }    
        
        Case record = [Select Id,CaseNumber,Status,CTP_DisputeCategories__c,CTP_DisputeTypes__c,CTP_CaseSubStatus__c,OwnerId from Case where Id = :disputeCaseRecord.Id]; 
        system.debug('record:::'+record);
        CTP_CaseWrapperClass_CC newDisputeRecord = new CTP_CaseWrapperClass_CC();
        newDisputeRecord.caseRecord = record;
        if(record.Status == System.Label.CTP_CaseStatus_ADR){
            newDisputeRecord.isStatusADR = true;
        }  
        newDisputeRecord.isChecked = false;
        
        return newDisputeRecord;
    	
    } 
   
    /*****************************************************************
    Purpose: To get the list of suitable assessors based on the selected dipsute records
    Parameters: String caseRecList 
    Returns: List<CTP_DipsuteCase_UserWrapperClass_CC>
   
    History
    --------
    VERSION  AUTHOR     DATE       DETAIL   Description
    1.0     Capgemini  26-07-2017  Created  DCR-330,DCR-194,DCR-134
   *******************************************************************/

    @AuraEnabled
    public static List<CTP_DipsuteCase_UserWrapperClass_CC> getSuitableAssessor(String caseRecList ){
        
        system.debug('case:::'+caseRecList);
        if(!string.isBlank(caseRecList)){
        	recordsForAllocation = (List<CTP_CaseWrapperClass_CC >)JSON.deserialize(caseRecList, List<CTP_CaseWrapperClass_CC>.class);
            system.debug('record:::'+recordsForAllocation);
        
            Map<String,List<String>> meritReviewMap = new Map<String,List<String>>(); //Map to store the search criteria mapping specific to Merit review
            List<String> meritReviewdisputeTypes = new List<String>(); //List to store the dispute types of selected merit review dispute records. 
            List<String> meritReviewProfiles = new List<String>(); //List to store the profile names specific to search criteira for merit review 
            Set<String> disputeCategoriesSet = new Set<String>();
            
            List<String> profileNames = System.Label.CTP_MeritReview_Allocation_UserProfile.split(',');
            List<Profile> profileIdsList = [Select Id,Name from Profile where Name IN :profileNames];
            for(Profile p : profileIdsList){
                meritReviewProfiles.add(p.Id);               
            }
            system.debug('profile:::'+meritReviewProfiles);
            
            for(CTP_CaseWrapperClass_CC rec : recordsForAllocation){
                system.debug('rec:::'+rec);
                if(rec.caseRecord.CTP_DisputeCategories__c == System.Label.CTP_MeritReview){
                    meritReviewdisputeTypes.add(rec.caseRecord.CTP_DisputeTypes__c);
                }
                disputeCategoriesSet.add(rec.caseRecord.CTP_DisputeCategories__c);
            }
            
            if(disputeCategoriesSet.contains(System.Label.CTP_MeritReview)){
               // meritReviewMap.put('DisputeCategory','Merit review');
                if(!meritReviewdisputeTypes.isEmpty()){
                    meritReviewMap.put('CTP_DisputeType__c',meritReviewdisputeTypes);
                }
                if(!meritReviewProfiles.isEmpty()){
                    meritReviewMap.put('ProfileId',meritReviewProfiles);
                }
            }  
            //String searchcondition = 'CTP_DisputeCategory__c = :meritReviewMap.get(DisputeCategory)'; 
            if(!meritReviewMap.isEmpty()){
                String queryString = 'Select Id,Name,City,Street,Country,PostalCode,State,CTP_Notes__c,CTP_DisputeCategory__c,CTP_DisputeType__c,ProfileId,Phone from User where ';
                
                if(disputeCategoriesSet.contains(System.Label.CTP_MeritReview)){
                    queryString+= 'CTP_DisputeCategory__c includes (\'Merit Review\') ';
                    if(!meritReviewMap.get('CTP_DisputeType__c').isEmpty()){
                        //queryString+= 'AND CTP_DisputeType__c IN :meritReviewMap.get(\'DisputeTypes\') ';
                        String dipsuteTypes;
                        for(String str : meritReviewdisputeTypes){
                            system.debug('val:::'+str);
                            if(dipsuteTypes!='' && dipsuteTypes!=null){
                            	dipsuteTypes+=';'+str;
                        	}else{
                                dipsuteTypes = '(\''+str;
                            
                        	}
                        }
                        dipsuteTypes=dipsuteTypes+'\')';
                        system.debug('type:::'+dipsuteTypes);
                        queryString+= 'AND CTP_DisputeType__c includes'+dipsuteTypes+' ';
                    }
                    if(!meritReviewMap.get('ProfileId').isEmpty()){
                        queryString+= 'AND ProfileId IN : meritReviewProfiles';
                    }
                    /*for(String search : meritReviewMap.keySet()){
                        List<String> searchfilteList = meritReviewMap.get(search);
                        queryString+= 'AND '+search+' IN '+searchfilteList+' '; 
                    }*/
                }
                system.debug('type:::'+meritReviewMap.get('DisputeTypes'));
                system.debug('query string:::'+queryString);
                List<User> matchedUserList = Database.query(queryString);
                system.debug('User List:::'+matchedUserList);
                
                List<CTP_DipsuteCase_UserWrapperClass_CC> userWrapperList = new List<CTP_DipsuteCase_UserWrapperClass_CC>();
                for(User rec : matchedUserList){
                    CTP_DipsuteCase_UserWrapperClass_CC obj = new CTP_DipsuteCase_UserWrapperClass_CC();
                    obj.userRecord = rec;
                    obj.isSelected = false;
                    userWrapperList.add(obj);
                }
                return userWrapperList;
            }else{
                return null;
            }    
            
           // return null ;
        }else{
            return null;
        }
        
    }
	
	/*****************************************************************
    Purpose: Allocate the selected dispute records to the selected assessor and update the status of those records to Decision
    Parameters: String assessorRec
	            String selecteddisputeList
				String disputeList
    Returns: List<CTP_CaseWrapperClass_CC>
   
    History
    --------
    VERSION  AUTHOR     DATE       DETAIL   Description
    1.0     Capgemini  26-07-2017  Created  DCR-330,DCR-194,DCR-134
   *******************************************************************/
    
    @AuraEnabled
    public static List<CTP_CaseWrapperClass_CC> allocateDisputeRecords(String assessorRec,String selecteddisputeList,String disputeList){
        system.debug('record1:::'+disputeList);
        system.debug('assessor:::'+assessorRec);
        
        CTP_DipsuteCase_UserWrapperClass_CC assessor = (CTP_DipsuteCase_UserWrapperClass_CC)JSON.deserialize(assessorRec, CTP_DipsuteCase_UserWrapperClass_CC.class);
        system.debug('val:::'+assessor);
        
        List<CTP_CaseWrapperClass_CC> disputeCaseList = (List<CTP_CaseWrapperClass_CC>)JSON.deserialize(disputeList, List<CTP_CaseWrapperClass_CC>.class);
        system.debug('List1:::'+disputeCaseList.size());
        
        List<CTP_CaseWrapperClass_CC> recordsForAllocation = (List<CTP_CaseWrapperClass_CC>)JSON.deserialize(selecteddisputeList, List<CTP_CaseWrapperClass_CC>.class);
        system.debug('List2:::'+recordsForAllocation.size());
        
        List<Case> updatedCaseList = new List<Case>();
        for(CTP_CaseWrapperClass_CC dispute : disputeCaseList){
            for(CTP_CaseWrapperClass_CC rec : recordsForAllocation){
                if(rec.caseRecord.CaseNumber == dispute.caseRecord.CaseNumber && rec.caseRecord.CTP_DisputeCategories__c == 'Merit review'){
                    dispute.caseRecord.OwnerId = assessor.userRecord.Id;
                    dispute.caseRecord.Status = 'Decision';
                    dispute.isStatusADR = false;
                    /*rec.caseRecord.OwnerId = assessor.userRecord.Id;
                    rec.caseRecord.Status = 'Decision';*/
                    updatedCaseList.add(dispute.caseRecord);
                }
                
            }
        }
        system.debug('updatedCaseList:::'+updatedCaseList);
        try{		
			update updatedCaseList;
	    }catch(Exception ex){
			system.debug('Exception:::'+ex);
		}		
        system.debug('disputeCaseList:::'+disputeCaseList);
        
        return disputeCaseList;
        
        
    }

}