public without sharing class CTP_UCDDetailsController {
    //public static CTP_UDCResponseWrapper ucdObj;
    @Auraenabled
    public static CTP_UDCResponseWrapper getUcddetails(String claimNumber)
    {
        System.debug('<<<claimNumber>>>'+claimNumber);
        //This will make sure we get a response everytime from Mule
        if(claimNumber !='987456' && claimNumber!='434343' && claimNumber!='765432' && claimNumber!='543210' ){
            claimNumber = '434343';
        }
        
        CTP_UDCResponseWrapper responseObj=new CTP_UDCResponseWrapper();
        
        //Start- REST API Call- Ankit.B-28/082017
        UCDResponse responseWrapperObj = new UCDResponse();
        responseWrapperObj = getClaimantDetailsFromUCD(claimNumber);
        system.debug('<<<responseWrapperObj>>'+responseWrapperObj);
        responseObj.Claimnumber= responseWrapperObj.claimNumber;
        responseObj.Claimantname= 'Sally Burns';//responseWrapperObj.firstName+' '+responseWrapperObj.lastName;     // Changed by Subhajit Steve Young User in not present in Salesfore
        //responseObj.Claimantname='Sally Robinsons';    // This Claimant is present in SFDC--> by subhajit
        //responseObj.Dateofaccident= responseWrapperObj.accidentDate;
        responseObj.Dateofaccident= '15/12/2017';
        responseObj.Locationofaccident= responseWrapperObj.accidentSuburb+' '+responseWrapperObj.accidentPostcode;
        responseObj.InsurerName = responseWrapperObj.insurerName;
        System.debug('@@@@'+responseObj);
        //End- REST API Call- Ankit.B-28/082017 
        
        return responseObj;
    }
    
    //********************************************************************
    // Purpose : This method makes the REST API call to UCD        
    //********************************************************************
    @AuraEnabled
    public static UCDResponse getClaimantDetailsFromUCD(String claimNumber)
    {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');
        //String url = 'https://mocksvc.mulesoft.com/mocks/e90c6915-f07e-4680-969b-f4457e4fb656/claimant?claimNumber=4343';
        String url = 'http://dfsi-ucd-claimant.au.cloudhub.io/api/claimant?claimNumber='+claimNumber;
        system.debug('<<<EndpointUrl>>>'+url);
        req.setEndpoint(url);
        
        //Create the response object
        HTTPResponse resp = http.send(req);
        system.debug('<<<Resp Status>>>'+resp);
        system.debug('<<<Resp Body Raw>>>'+resp.getBody());
        UCDResponse responseObj=new UCDResponse();
        List<UCDResponse> responseList =new List<UCDResponse>();
        responseList = parse(resp.getBody());
        system.debug('<<<Resp Body Parsed>>>'+ responseList);
        return responseList[0];
    }
    
    //********************************************************************
    // Purpose : This method is to parse the UCD Response        
    //********************************************************************
    public static List<UCDResponse> parse(String json) {
        return (List<UCDResponse>) System.JSON.deserialize(json, List<UCDResponse>.class);
    }
    
    //********************************************************************
    // Purpose : This class is the place holder for the fields returned from UCD        
    //********************************************************************
    @TestVisible
    private class UCDResponse {
        public String claimNumber {get;set;}
        public String firstName {get;set;}
        public String lastName {get;set;}
        public String insurerName {get;set;}
        public String accidentDate {get;set;}
        public String claimReceivedDate {get;set;}
        public String accidentSuburb {get;set;}
        public String accidentPostcode {get;set;}
        public String claimStatus {get;set;}
        public String liabilityStatus {get;set;}
        public String faultStatus {get;set;}
    }
    
    //********************************************************************
    // DCR-344 :Claimant lodges an application by entering claim details 
    //           manually as UCD database returns no results (Exception)
    // Purpose : Failure Response  (Subhajit)       
    //********************************************************************
    @AuraEnabled
    public static CTP_UDCResponseWrapper getUcdNoResultMockDataSetup()
    {
        
        System.debug('@@@@Called from Component');
        CTP_UDCResponseWrapper responseObj=new CTP_UDCResponseWrapper();
        responseObj.NoResult='Failure';
        return responseObj;
    }
    //********************************************************************
    // DCR-344 :Claimant lodges an application by entering claim details 
    //           manually as UCD database returns no results (Exception)
    // Purpose : Logged In User       
    //********************************************************************
    //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static String getUserName() 
    {
        return userinfo.getName();
    }
    
    //********************************************************************
    // DCR-344 :Claimant lodges an application by entering claim details 
    //           manually as UCD database returns no results (Exception)
    // Purpose : Fetching Insurer (Subhajit)        
    //********************************************************************
    @AuraEnabled
    public static List < String > fetchAccount() 
    {
        
        
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Case.OLCN_InsurerCode__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }
        
        return options;
    }
    
    
    @Auraenabled
    public static CTP_UDCResponseWrapper getUcddetailsparameter(String claim)
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
    
    //********************************************************************
    // Purpose : Create Case Record From Public Community        
    //********************************************************************
    @AuraEnabled
    public static String createCaseRecord(String reviewCompletion,String reviewRecept,String ClaimNumber, String disagreementReason ,String outcome,String ucdObj, String ucdDetailsIncorrect, Boolean isFailure, String circum)
    {
        
        System.Debug('@@@reviewCompletion ::--> '+ reviewCompletion); // Added By Subhajit
        System.Debug('@@@reviewRecept ::--> '+ reviewRecept); // Added By Subhajit 
        Boolean reviewCompletionflag = false;
        Boolean reviewReceptflag = false;
        Date reviewCompletionDate;
        Date reviewReceptDate;
        
      
        
        if(reviewCompletion!='null')
        {
            reviewCompletion = reviewCompletion.remove('"');
            List<String> reviewCompletionDateParts = reviewCompletion.split('-');
            reviewCompletionDate = Date.newInstance(Integer.valueOf(reviewCompletionDateParts[0]), Integer.valueOf(reviewCompletionDateParts[1]), Integer.valueOf(reviewCompletionDateParts[2]));
            reviewReceptflag =true;
        }
        
        
        if(reviewRecept!='null')
        {
            reviewRecept = reviewRecept.remove('"');
            List<String> reviewReceptDateParts = reviewRecept.split('-');
            reviewReceptDate = Date.newInstance(Integer.valueOf(reviewReceptDateParts[0]), Integer.valueOf(reviewReceptDateParts[1]), Integer.valueOf(reviewReceptDateParts[2]));
            reviewReceptflag=true;
        }
        
        
        CTP_UDCResponseWrapper ucdRecord = (CTP_UDCResponseWrapper)JSON.deserialize(ucdobj,CTP_UDCResponseWrapper.class);
        String dateOfAccident = ucdRecord.Dateofaccident;
        List<String> accidentDateParts = dateOfAccident.split('/');
        Date accidentDate = Date.newInstance(Integer.valueOf(accidentDateParts[2]), Integer.valueOf(accidentDateParts[1]), Integer.valueOf(accidentDateParts[0]));
        
        System.Debug('@@@=============='+reviewCompletion+reviewRecept+ClaimNumber+disagreementReason+ucdObj);
        System.Debug('@@@outcome ::--> '+ outcome); // Added By Subhajit for DCR-347
        System.Debug('@@@isFailure::--> '+ isFailure); // Added By Subhajit for DCR-344
        
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        
        //Creating the DMLOptions for "Assign using active assignment rules" checkbox
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        
        Case caseObj=new Case();
        
        if(isFailure) caseObj.UCD_no_result__c=true;// Added By Subhajit for DCR-344
        caseObj.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        caseObj.Status='Lodgement';
        caseObj.CTP_CaseSubStatus__c='Application Received';
        caseObj.CTP_CaseSubType__c='Application Received';
        caseObj.Origin='Web';
        //caseObj.Priority='Low';
        caseobj.Subject = 'Web form application';
        User usr = [select Id , ContactId from User where Id =: UserInfo.getUserId()];
        
        caseobj.CTP_InjuredPersonContact__c = usr.ContactId;
        caseObj.ClaimNumber__c=ClaimNumber;
        ///caseObj.CTP_Claim_Number__c=String.valueof(ClaimNumber);
        if(reviewCompletionflag) caseObj.CTP_ReviewCompletionDate__c= reviewCompletionDate;
        if(reviewReceptflag) caseObj.CTP_ReviewReceiptDate__c= reviewReceptDate;
        caseObj.CTP_Insurer_name__c = ucdRecord.InsurerName;
        caseObj.CTP_Date_of_accident__c=accidentDate;
        caseObj.CTP_outline_what_it_is_that_you_dont_agr__c = disagreementReason;
        caseObj.BriefSummaryOfOutcome__c=outcome; // Added By Subhajit for DCR-347
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
        caseObj.CTP_Details_of_incorrect_data__c = ucdDetailsIncorrect;
        if(ucdDetailsIncorrect != null || ucdDetailsIncorrect != ''){
            caseObj.CTP_Is_Claim_Detail_Incorrect__c = true;
        }
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
    
    @AuraEnabled
    public static CTP_DraftCaseWrapper portalIdentifier(String outcome,String reviewCompletion,String reviewRecept,String disagreementReason, String ClaimNumber,String CaseIdSave ,String ucdObj, List<Case> disputeCase,String stage, String disputecomment,Boolean ucdDetailsIncorrect,Boolean isFailure,String portalIdentifier, String circum , String CTPRepresentativeComments, String representativeRelation)
    {
    
    System.debug('outcome'+outcome+disagreementReason);
        
        if(portalIdentifier =='Claimant') return CTP_UCDDetailsController.createClaimaintCaseRecord(outcome,reviewCompletion,reviewRecept,disagreementReason,ClaimNumber,CaseIdSave ,ucdObj,disputeCase,stage,disputecomment,ucdDetailsIncorrect,isFailure,circum , CTPRepresentativeComments ,representativeRelation);
        else if(portalIdentifier =='Insurer') return CTP_UCDDetailsController.createInsurerCaseRecord(ClaimNumber,CaseIdSave,ucdObj,disputeCase,stage,disputecomment,ucdDetailsIncorrect,isFailure,outcome,disagreementReason,circum , CTPRepresentativeComments ,representativeRelation);
        
        return null;
    }
    
    @AuraEnabled
    public static CTP_DraftCaseWrapper createInsurerCaseRecord(String ClaimNumber,String CaseIdSave ,String ucdObj, List<Case> disputeCase,String stage, String disputecomment,Boolean ucdDetailsIncorrect,Boolean isFailure, String outcome,String disagreementReason, String circum, String CTPRepresentativeComments , String representativeRelation)
    {
        System.debug('==========='+CaseIdSave);
        List<Case>disputes = new List<Case>();
        CTP_DraftCaseWrapper caseWrap = new CTP_DraftCaseWrapper();
        List<Case> disputeToDelete = new List<Case>();
        List<Id> idList ;
        if(CaseIdSave != null && CaseIdSave != ''){
            
            System.debug('@@@@@@ DisputeCases--->'+disputeCase);
            CTP_UDCResponseWrapper ucdRecord = (CTP_UDCResponseWrapper)JSON.deserialize(ucdobj,CTP_UDCResponseWrapper.class);
            String dateOfAccident = ucdRecord.Dateofaccident;
            List<String> accidentDateParts = dateOfAccident.split('/');
            Date accidentDate;
            if(!accidentDateParts[0].equals('undefined'))
                accidentDate = Date.newInstance(Integer.valueOf(accidentDateParts[2]), Integer.valueOf(accidentDateParts[1]), Integer.valueOf(accidentDateParts[0]));
            
            Case caseObj= [Select id,CaseNumber,Contact.Email,RecordTypeId,Origin,Priority,Subject,CTP_Insurer_Application__c,UCD_no_result__c,
                           CTP_InjuredPersonContact__c,Claimant_Name__c,CTP_Insurer_name__c,CTP_Email__c,CTP_Date_of_accident__c,
                           CTP_ClaimNumber__c,Accident_Location__c,DateTimeCaseLodged__c from Case where id=:CaseIdSave limit 1];
            
            caseObj.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Application').getRecordTypeId();//Modified by Subhajit
            caseObj.Origin='Web';
            //caseObj.Priority='Low';
            caseobj.Subject = 'Web form application';
            caseobj.CTP_Insurer_Application__c = true;
            caseObj.CTP_Circumstances__c =circum;
            caseobj.CTP_Representative_Comments__c = CTPRepresentativeComments ;
            caseobj.How_are_you_representing_the_claimant__c = representativeRelation;
            
            if(ucdDetailsIncorrect)caseObj.CTP_Is_Claim_Detail_Incorrect__c = ucdDetailsIncorrect;
            if(isFailure)caseObj.UCD_no_result__c = isFailure;
            
            caseObj.CTP_Stage__c = stage;
            
            
            
            //-------Modified By Subhajit -----------------
            
            //For Claimant Name and Email
            User usr;
            if(ucdRecord.Claimantname != ''){
                usr = [SELECT Id , ContactId FROM User where name=:ucdRecord.Claimantname AND ContactId!=null LIMIT 1];
                caseobj.CTP_InjuredPersonContact__c = usr.ContactId; // DCR-292
            }
            caseObj.Claimant_Name__c=ucdRecord.Claimantname;
            
            //---Insurer Name and Email
            caseObj.CTP_Insurer_name__c = ucdRecord.InsurerName;
            caseObj.CTP_Email__c=[Select Email from User where id=:UserInfo.getUserId() AND ContactId!=null limit 1].Email;
            
            //-------Modified By Subhajit -----------------
            
            caseObj.CTP_Date_of_accident__c=accidentDate;
            caseObj.CTP_ClaimNumber__c=ClaimNumber;
            
            //caseObj.CTP_Location_of_accident__latitude__s=33.8688;
            //caseObj.CTP_Location_of_accident__longitude__s=151.2093;
            caseObj.Accident_Location__c = ucdRecord.Locationofaccident;
            caseObj.DateTimeCaseLodged__c = System.now();
            System.debug('==============stage'+Stage);
            if(!String.isEmpty(stage) &&  Stage == '3' ){
                caseObj.UCD_no_result__c = ucdDetailsIncorrect;
                if(disputeCase != null && disputeCase.size() > 0){
                    
                    caseWrap.disputeCaseList = new List<Case>();
                    idList = new List<Id>();
                    for(Case casdis : disputeCase){
                        
                        System.debug('===========disputeCase'+casdis);
                        
                        casdis.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Dispute').getRecordTypeId(); // modified by Subhajit
                        casdis.Status = 'Draft';
                        casdis.parentId = caseObj.id;
                        disputes.add((Case)casdis);
                    }
                    
                    
                    
                    upsert disputes;
                    for(Case dis : disputes){
                        idList.add(dis.Id);
                    }
                    
                    
                    if(idList != null && idList.size() > 0){
                        
                        disputeToDelete = [select id from Case where Id NOT IN : idList and ParentId = :caseObj.id ];
                        if(disputeToDelete.size()>0){
                            delete disputeToDelete;
                        }
                        
                    }
                    caseWrap.disputeCaseList = disputeCase;
                }
                
                caseObj.CTP_Tell_us_about_your_dispute__c = disputecomment;
                
                System.Debug('@@@'+caseObj);
            }
            
            
            System.Debug('@@@'+caseObj);
            
            update caseObj;
            system.debug('@@@@@caseObj -->'+JSON.serializePretty(caseObj));
            caseWrap.cas = caseObj;
            return caseWrap;
            
        }else
        {
            System.debug('@@@@@@ DisputeCases--->Else'+ucdObj);
            CTP_UDCResponseWrapper ucdRecord = (CTP_UDCResponseWrapper)JSON.deserialize(ucdobj,CTP_UDCResponseWrapper.class);
            String dateOfAccident = ucdRecord.Dateofaccident;
            List<String> accidentDateParts = dateOfAccident.split('/');
            System.debug('accidentDateParts'+accidentDateParts);
            Date accidentDate;
            if(!accidentDateParts[0].equals('undefined'))
                accidentDate= Date.newInstance(Integer.valueOf(accidentDateParts[2]), Integer.valueOf(accidentDateParts[1]), Integer.valueOf(accidentDateParts[0]));
            
            Case caseObj=new Case();
            
            caseObj.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Application').getRecordTypeId();//Modified by Subhajit
            caseObj.Status='Draft';
            
            caseObj.Origin='Web';
            //caseObj.Priority='Low';
            caseobj.Subject = 'Web form application';
            caseobj.CTP_Insurer_Application__c = true;
            System.debug('ucdDetailsIncorrect'+ucdDetailsIncorrect);
            
            if(ucdDetailsIncorrect)caseObj.CTP_Is_Claim_Detail_Incorrect__c = ucdDetailsIncorrect;
            if(isFailure)caseObj.UCD_no_result__c = isFailure;
            
            
            
            //-------Modified By Subhajit -----------------
            
            //For Claimant Name and Email
            User usr;
            if(ucdRecord.Claimantname != ''){
                usr= [SELECT Id , ContactId FROM User where name=:ucdRecord.Claimantname AND ContactId!=null LIMIT 1];
                caseobj.CTP_InjuredPersonContact__c = usr.ContactId; // DCR-292
            }
            caseObj.Claimant_Name__c=ucdRecord.Claimantname;
            
            //---Insurer Name and Email
            caseObj.CTP_Insurer_name__c = ucdRecord.InsurerName;
            caseObj.CTP_Email__c=[Select Email from User where id=:UserInfo.getUserId() AND ContactId!=null limit 1].Email;
            
            //-------Modified By Subhajit-----------------
            
            caseObj.CTP_Date_of_accident__c=accidentDate;
            caseObj.CTP_Time_When_Application_Lodged__c = Datetime.now().format('hh:mm:ss a');
            caseObj.CTP_ClaimNumber__c=ClaimNumber;
            caseObj.CTP_Insurer_Application__c = true;
            caseObj.CTP_Stage__c = stage;
            caseObj.CTP_Circumstances__c =circum;
            caseobj.CTP_Representative_Comments__c = CTPRepresentativeComments ;
            caseobj.How_are_you_representing_the_claimant__c = representativeRelation;
            
            //caseObj.CTP_Location_of_accident__latitude__s=33.8688;
            //caseObj.CTP_Location_of_accident__longitude__s=151.2093;
            caseObj.Accident_Location__c = ucdRecord.Locationofaccident;
            caseObj.DateTimeCaseLodged__c = System.now();
            System.Debug('@@@'+caseObj);
            
            insert caseObj;
            system.debug('@@@@@caseObj -->'+JSON.serializePretty(caseObj));
            caseWrap.cas = caseObj;
            String caseId=caseObj.id;
            caseWrap.disputeCaseList = new List<Case>();
            for(Case casdis : disputeCase){
                System.debug('=============disputeCase==========='+casdis);
                if(casdis.Id == null || String.ValueOf(casdis.Id) == ''){
                    casdis.Status = 'Draft';
                    casdis.RecordTypeId = [Select id from Recordtype where sobjecttype='Case' and DeveloperName='CTP_Dispute'].id; // modified by Subhajit
                    casdis.parentId = caseObj.id;
                    casdis.CTP_DisputeCategories__c = caseObj.CTP_DisputeCategories__c; 
                    casdis.CTP_DisputeTypes__c = caseObj.CTP_DisputeTypes__c; 
                    casdis.CTP_Dispute_For__c = caseObj.CTP_Dispute_For__c; 
                    casdis.CTP_ReviewCompletionDate__c = caseObj.CTP_ReviewCompletionDate__c; 
                    casdis.CTP_ReviewReceiptDate__c = caseObj.CTP_ReviewReceiptDate__c; 
                    casdis.CTP_outline_what_it_is_that_you_dont_agr__c = caseObj.CTP_outline_what_it_is_that_you_dont_agr__c; 
                    casdis.BriefSummaryOfOutcome__c = caseObj.BriefSummaryOfOutcome__c; 
                }
            }
            
            insert disputeCase;
            
            caseWrap.disputeCaseList = disputeCase;
            return caseWrap;
            
        }
        return null;
    }
    
    @AuraEnabled
    public static CTP_DraftCaseWrapper createClaimaintCaseRecord(String outcome,String reviewCompletion,String reviewRecept,String disagreementReason,String ClaimNumber,String CaseIdSave ,String ucdObj, List<Case> disputeCase,String stage, String disputecomment,Boolean ucdDetailsIncorrect,Boolean isFailure , String circum , String CTPRepresentativeComments , String representativeRelation)
    {
        System.debug('==========='+CaseIdSave);
        List<Case>disputes = new List<Case>();
        CTP_DraftCaseWrapper caseWrap = new CTP_DraftCaseWrapper();
        List<Case> disputeToDelete = new List<Case>();
        List<Id> idList ;
        System.Debug('@@@reviewCompletion ::--> '+ reviewCompletion); // Added By Subhajit
        System.Debug('@@@reviewRecept ::--> '+ reviewRecept); // Added By Subhajit 
        Boolean reviewCompletionflag = false;
        Boolean reviewReceptflag = false;
        Date reviewCompletionDate;
        Date reviewReceptDate;
        
        if(reviewCompletion!= null && reviewCompletion!='')
        {
            reviewCompletion = reviewCompletion.remove('"');
            List<String> reviewCompletionDateParts = reviewCompletion.split('-');
            reviewCompletionDate = Date.newInstance(Integer.valueOf(reviewCompletionDateParts[0]), Integer.valueOf(reviewCompletionDateParts[1]), Integer.valueOf(reviewCompletionDateParts[2]));
            reviewCompletionflag =true;
        }
        
        
        if(reviewRecept!=null && reviewRecept!='')
        {
            reviewRecept = reviewRecept.remove('"');
            List<String> reviewReceptDateParts = reviewRecept.split('-');
            reviewReceptDate = Date.newInstance(Integer.valueOf(reviewReceptDateParts[0]), Integer.valueOf(reviewReceptDateParts[1]), Integer.valueOf(reviewReceptDateParts[2]));
            reviewReceptflag=true;
        }
        
        
        if(CaseIdSave != null && CaseIdSave != ''){
            
            System.debug('@@@@@@ DisputeCases--->'+disputeCase);
            CTP_UDCResponseWrapper ucdRecord = (CTP_UDCResponseWrapper)JSON.deserialize(ucdobj,CTP_UDCResponseWrapper.class);
            String dateOfAccident = ucdRecord.Dateofaccident;
            List<String> accidentDateParts = dateOfAccident.split('/');
            Date accidentDate;
            if(!accidentDateParts[0].equals('undefined'))
                accidentDate = Date.newInstance(Integer.valueOf(accidentDateParts[2]), Integer.valueOf(accidentDateParts[1]), Integer.valueOf(accidentDateParts[0]));
            
            Case caseObj= [Select id,CaseNumber,Contact.Email,RecordTypeId,Origin,Priority,Subject,CTP_Insurer_Application__c,UCD_no_result__c,
                           CTP_InjuredPersonContact__c,Claimant_Name__c,CTP_Insurer_name__c,CTP_Email__c,CTP_Date_of_accident__c,
                           CTP_ClaimNumber__c,Accident_Location__c,DateTimeCaseLodged__c from Case where id=:CaseIdSave limit 1];
            
            caseObj.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Application').getRecordTypeId();//Modified by Subhajit
            caseObj.Origin='Web';
            //caseObj.Priority='Low';
            caseobj.Subject = 'Web form application';
            caseobj.CTP_Representative_Comments__c = CTPRepresentativeComments ;
            //caseobj.CTP_Insurer_Application__c = true;
            caseobj.How_are_you_representing_the_claimant__c = representativeRelation;
            
            if(ucdDetailsIncorrect)caseObj.CTP_Is_Claim_Detail_Incorrect__c = ucdDetailsIncorrect;
            if(isFailure)caseObj.UCD_no_result__c = isFailure;
            
            caseObj.CTP_Stage__c = stage;
            
            caseObj.BriefSummaryOfOutcome__c=outcome; 
            caseObj.CTP_Circumstances__c =circum; 
            if(reviewCompletionflag) caseObj.CTP_ReviewCompletionDate__c= reviewCompletionDate;
            if(reviewReceptflag) caseObj.CTP_ReviewReceiptDate__c= reviewReceptDate;
            caseObj.CTP_outline_what_it_is_that_you_dont_agr__c = disagreementReason;
            
            
            //-------Modified By Subhajit -----------------
            
            //For Claimant Name and Email
            User usr;
            if(ucdRecord.Claimantname != ''){
                usr = [SELECT Id , ContactId FROM User where name=:ucdRecord.Claimantname AND ContactId!=null LIMIT 1];
                caseobj.CTP_InjuredPersonContact__c = usr.ContactId; // DCR-292
            }
            caseObj.Claimant_Name__c=ucdRecord.Claimantname;
            
            //---Insurer Name and Email
            caseObj.CTP_Insurer_name__c = ucdRecord.InsurerName;
            caseObj.CTP_Email__c=[Select Email from User where id=:UserInfo.getUserId() AND ContactId!=null limit 1].Email;
            
            //-------Modified By Subhajit -----------------
            
            caseObj.CTP_Date_of_accident__c=accidentDate;
            caseObj.CTP_ClaimNumber__c=ClaimNumber;
            caseObj.CTP_outline_what_it_is_that_you_dont_agr__c = disagreementReason;
            caseObj.BriefSummaryOfOutcome__c=outcome; // Added By Subhajit for DCR-347
            
            //caseObj.CTP_Location_of_accident__latitude__s=33.8688;
            //caseObj.CTP_Location_of_accident__longitude__s=151.2093;
            caseObj.Accident_Location__c = ucdRecord.Locationofaccident;
            caseObj.DateTimeCaseLodged__c = System.now();
            System.debug('==============stage'+Stage);
            if(!String.isEmpty(stage) &&  Stage == '3' ){
                caseObj.UCD_no_result__c = ucdDetailsIncorrect;
                if(disputeCase != null && disputeCase.size() > 0){
                    
                    caseWrap.disputeCaseList = new List<Case>();
                    idList = new List<Id>();
                    for(Case casdis : disputeCase){
                        
                        System.debug('===========disputeCase'+casdis);
                        
                        casdis.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Dispute').getRecordTypeId(); // modified by Subhajit
                        casdis.Status = 'Draft';
                        casdis.parentId = caseObj.id;
                        disputes.add((Case)casdis);
                    }
                    
                    
                    
                    upsert disputes;
                    for(Case dis : disputes){
                        idList.add(dis.Id);
                    }
                    
                    
                    if(idList != null && idList.size() > 0){
                        
                        disputeToDelete = [select id from Case where Id NOT IN : idList and ParentId = :caseObj.id ];
                        if(disputeToDelete.size()>0){
                            delete disputeToDelete;
                        }
                        
                    }
                    caseWrap.disputeCaseList = disputeCase;
                }
                
                caseObj.CTP_Tell_us_about_your_dispute__c = disputecomment;
                
                System.Debug('@@@'+caseObj);
            }
            
            update caseObj;
            system.debug('@@@@@caseObj update-->'+JSON.serializePretty(caseObj));
            caseWrap.cas = caseObj;
            return caseWrap;
            
        }else
        {
            System.debug('@@@@@@ DisputeCases--->Else'+ucdObj+representativeRelation);
            CTP_UDCResponseWrapper ucdRecord = (CTP_UDCResponseWrapper)JSON.deserialize(ucdobj,CTP_UDCResponseWrapper.class);
            String dateOfAccident = ucdRecord.Dateofaccident;
            List<String> accidentDateParts = dateOfAccident.split('/');
            System.debug('accidentDateParts'+accidentDateParts);
            Date accidentDate;
            if(!accidentDateParts[0].equals('undefined'))
                accidentDate= Date.newInstance(Integer.valueOf(accidentDateParts[2]), Integer.valueOf(accidentDateParts[1]), Integer.valueOf(accidentDateParts[0]));
            
            Case caseObj=new Case();
            
            caseObj.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Application').getRecordTypeId();//Modified by Subhajit
            caseObj.Status='Draft';
            
            caseObj.Origin='Web';
            //caseObj.Priority='Low';
            caseobj.Subject = 'Web form application';
            //caseobj.CTP_Insurer_Application__c = true;
            caseObj.CTP_Circumstances__c =circum;
            caseobj.CTP_Representative_Comments__c = CTPRepresentativeComments ;
            System.debug('ucdDetailsIncorrect'+ucdDetailsIncorrect);
            caseobj.How_are_you_representing_the_claimant__c = representativeRelation;
            
            if(ucdDetailsIncorrect)caseObj.CTP_Is_Claim_Detail_Incorrect__c = ucdDetailsIncorrect;
            if(isFailure)caseObj.UCD_no_result__c = isFailure;
            
            caseObj.BriefSummaryOfOutcome__c=outcome; 
            if(reviewCompletionflag) caseObj.CTP_ReviewCompletionDate__c= reviewCompletionDate;
            if(reviewReceptflag) caseObj.CTP_ReviewReceiptDate__c= reviewReceptDate;
            caseObj.CTP_outline_what_it_is_that_you_dont_agr__c = disagreementReason;
            
            
            //-------Modified By Subhajit -----------------
            
            //For Claimant Name and Email
            User usr;
            if(ucdRecord.Claimantname != ''){
                usr= [SELECT Id , ContactId FROM User where name=:ucdRecord.Claimantname AND ContactId!=null LIMIT 1];
                caseobj.CTP_InjuredPersonContact__c = usr.ContactId; // DCR-292
            }
            caseObj.Claimant_Name__c=ucdRecord.Claimantname;
            
            //---Insurer Name and Email
            caseObj.CTP_Insurer_name__c = ucdRecord.InsurerName;
            caseObj.CTP_Email__c=[Select Email from User where id=:UserInfo.getUserId() AND ContactId!=null limit 1].Email;
            
            //-------Modified By Subhajit-----------------
            
            caseObj.CTP_Date_of_accident__c=accidentDate;
            caseObj.CTP_Time_When_Application_Lodged__c = Datetime.now().format('hh:mm:ss a');
            caseObj.CTP_ClaimNumber__c=ClaimNumber;
            //caseObj.CTP_Insurer_Application__c = true;
            caseObj.CTP_Stage__c = stage;
            caseObj.CTP_outline_what_it_is_that_you_dont_agr__c = disagreementReason;
            caseObj.BriefSummaryOfOutcome__c=outcome; // Added By Subhajit for DCR-347
            
            //caseObj.CTP_Location_of_accident__latitude__s=33.8688;
            //caseObj.CTP_Location_of_accident__longitude__s=151.2093;
            caseObj.Accident_Location__c = ucdRecord.Locationofaccident;
            caseObj.DateTimeCaseLodged__c = System.now();
            System.Debug('@@@'+caseObj);
            
            insert caseObj;
            Case currentcaseObj= [SELECT id,CaseNumber,Contact.Email,RecordTypeId,Origin,Priority,Subject,CTP_Insurer_Application__c,UCD_no_result__c,
                                  CTP_InjuredPersonContact__c,Claimant_Name__c,CTP_Insurer_name__c,CTP_Email__c,CTP_Date_of_accident__c,
                                  CTP_ClaimNumber__c,DateTimeCaseLodged__c,Accident_Location__c
                                  FROM Case 
                                  WHERE id=:caseObj.id 
                                  LIMIT 1];
            system.debug('@@@@@caseObj Insert-->'+JSON.serializePretty(currentcaseObj));
            
            caseWrap.cas = currentcaseObj;
            String caseId=caseObj.id;
            
            caseWrap.disputeCaseList = new List<Case>();
            for(Case casdis : disputeCase){
                System.debug('=============disputeCase==========='+casdis);
                if(casdis.Id == null || String.ValueOf(casdis.Id) == ''){
                    casdis.Status = 'Draft';
                    casdis.RecordTypeId = [Select id from Recordtype where sobjecttype='Case' and DeveloperName='CTP_Dispute'].id; // modified by Subhajit
                    casdis.parentId = caseObj.id; 
                    casdis.CTP_DisputeCategories__c = caseObj.CTP_DisputeCategories__c; 
                    casdis.CTP_DisputeTypes__c = caseObj.CTP_DisputeTypes__c; 
                    casdis.CTP_Dispute_For__c = caseObj.CTP_Dispute_For__c; 
                    casdis.CTP_ReviewCompletionDate__c = caseObj.CTP_ReviewCompletionDate__c; 
                    casdis.CTP_ReviewReceiptDate__c = caseObj.CTP_ReviewReceiptDate__c; 
                    casdis.CTP_outline_what_it_is_that_you_dont_agr__c = caseObj.CTP_outline_what_it_is_that_you_dont_agr__c; 
                    casdis.BriefSummaryOfOutcome__c = caseObj.BriefSummaryOfOutcome__c; 
                    
                    
                }
            }
            
            insert disputeCase;
            
            caseWrap.disputeCaseList = disputeCase;
            return caseWrap;
            
        }
        return null;
    }
    //********************************************************************
    // DCR-1332 : Claimant submits an application from the public portal 
    //            (UCD details correct)-SPRINT-3
    // Purpose : Common method for Fetching Insurer for public/Insurer
    //           (Subhajit)
    //********************************************************************
    @AuraEnabled
    public static List<String> getfaultInsurer(){
        /*List<String> options = new List<String>();
        
        List < Account > lstOfAccount = [SELECT id, Name FROM account WHERE recordtype.developerName='CTP_insurer' ];
        for(Account acc : lstOfAccount )
        {
        options.add(acc.Name);
        }
        return options;*/
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Case.OLCN_InsurerCode__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }
        
        return options;
    }
    
    //********************************************************************
    // DCR-1332 : Claimant submits an application from the public portal 
    //            (UCD details correct)-SPRINT-3
    // Purpose : Common Method for fetching User Profile Data 
    //           public/Insurer (Subhajit)
    //********************************************************************
    @AuraEnabled
    public static User getUserProfileData()
    {
        User userInfoData =[SELECT Email,Phone,Street,City,State,CTP_Interpreter__c,CTP_HaveDisability__c FROM User WHERE Id =:userInfo.getUserId()];
        return userInfoData;
    }
    
    
    //********************************************************************
    // DCR-1332 : Claimant submits an application from the public portal 
    //            (UCD details correct)-SPRINT-3
    // Purpose : Common Method for fetching User Profile Data 
    //           public/Insurer (Subhajit)
    //********************************************************************
    @AuraEnabled
    public static User updateUserProfileData(User usr , String language, String disability )
    {
        System.debug('Inside user update :'+usr+language+disability);
        usr.CTP_HaveDisability__c = disability;
        usr.CTP_Interpreter__c = language;
        update usr;
        return usr;  
    }
    
    
    //********************************************************************
    // DCR-1332 : Claimant submits an application from the public portal 
    //            (UCD details correct)-SPRINT-3
    // Purpose : Common Method for fetching User Interpreter Data 
    //           public/Insurer (Subhajit)
    //********************************************************************
    @AuraEnabled
    public static List<String> getUserInterpreterData()
    {
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = User.CTP_Interpreter__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }
        
        return options;
    }
    
    //********************************************************************
    // DCR-77 : 
    // Purpose : 
    //********************************************************************
    @AuraEnabled
    public static List<String> getRepRelationData()
    {
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Case.How_are_you_representing_the_claimant__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }
        
        return options;
    }
    
    //********************************************************************
    // DCR-873 : Claimant retrieves a draft application to complete the 
    //           application process
    // Purpose : To retrieve Draft Cases 
    //********************************************************************
     @AuraEnabled
    public static User claimantContactDetails(String userName)
    {
        User userInfoData =[SELECT Email,Phone,Street,City,State,CTP_Interpreter__c,CTP_HaveDisability__c 
                            FROM User 
                            WHERE name =:userName 
                            LIMIT 1];
        return userInfoData;
    }
    
    //********************************************************************
    // DCR-873 : Claimant retrieves a draft application to complete the 
    //           application process
    // Purpose : To retrieve Draft Cases 
    //********************************************************************
     @AuraEnabled
    public static case retrieveDraftCase(String caseId)
    {
        case theCase = [SELECT Accident_Location__c,AccountId,Attachments__c,BriefSummaryOfOutcome__c,CaseNumber,
                        Case_Number__c,Claimant_Name__c,ClosedDate,CTP_Accident_Number__c
                        ,CTP_Application_Case_Number__c,CTP_Application_Status__c,CTP_CaseCreator__c,CTP_CaseSubStatus__c,CTP_CaseSubType__c,
                        CTP_CaseType__c,CTP_Case_owner_is_DRO__c,CTP_Claimant_Language_Code__c,
                        CTP_ClaimNumber__c,CTP_Claim_details_verified__c,CTP_Claim_Detail_Verified_By_DRO__c,
                        CTP_Claim_Status__c,CTP_Date_of_accident__c,CTP_Date_of_birth__c
                        ,CTP_Date_Of_Decision__c,CTP_DaysSinceReceived__c,CTP_Details_of_incorrect_data__c,
                        CTP_DisputeCategories__c,CTP_DisputeTypes__c,CTP_Dispute_For__c,
                        CTP_Dispute_Sub_Category__c,CTP_InjuredPersonAccount__c,CTP_InjuredPersonContact__c, CTP_InjuredPersonRepresentative__c,CTP_InsurerInternalReviewDone__c,CTP_InsurerRepresentative__c,CTP_Insurer_Application__c,CTP_Insurer_name__c,CTP_Is_Claim_Detail_Incorrect__c,CTP_LegalRepresentativeInsurer__c,CTP_LegalRepresentative__c,CTP_Location_of_accident__c,CTP_Location_of_accident__Latitude__s,CTP_Location_of_accident__Longitude__s,CTP_LodgementDate__c,CTP_outline_what_it_is_that_you_dont_agr__c,CTP_OwnerEqualsLoggedinUser__c,CTP_RepresentativeAccount__c,CTP_RepresentativeContact__c,CTP_RepresentativeRelationship__c,CTP_RequestforReplySent__c,CTP_ReviewCompletionDate__c, CTP_ReviewReceiptDate__c,CTP_Tell_us_about_your_dispute__c,CTP_Time_When_Application_Lodged__c,DateTimeCaseLodged__c,How_are_you_representing_the_claimant__c,Id,Insurer__c,OLCN_InsurerCode__c,Origin,OwnerId,ParentId,Priority,Status
                        ,Type,UCD_no_result__c 
                        FROM  Case 
                        WHERE Id=:caseId LIMIT 1];
        return theCase;
    }
    
    @AuraEnabled
    public static void updateCaseDetails(String CaseIdSave){
        Case caseObj = retrieveDraftCase(CaseIdSave);
        List<Case> disputeCase ;
        caseObj.Status='Lodgement';
        caseObj.CTP_CaseSubStatus__c='Application Received';
        caseObj.CTP_CaseSubType__c='Application Received';
        caseObj.DateTimeCaseLodged__c = System.now();
        caseObj.CTP_Time_When_Application_Lodged__c = Datetime.now().format('hh:mm:ss a');
        if(false){
            AssignmentRule AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
            
            //Creating the DMLOptions for "Assign using active assignment rules" checkbox
            Database.DMLOptions dmlOpts = new Database.DMLOptions();
            dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
            caseObj.setOptions(dmlOpts);
        }
        /*
        if(caseObj.Cases != null && caseObj.Cases.Size() > 0){
            disputeCase = caseObj.Cases;
            for(Case casDisp : disputeCase){
                casDisp.Status='Lodgement';
                casDisp.CTP_CaseSubStatus__c='Application Received';
                casDisp.CTP_CaseSubType__c='Application Received';
            }
        }
        
        Update disputeCase;
*/

        Update caseObj;
        
    } 
    
}