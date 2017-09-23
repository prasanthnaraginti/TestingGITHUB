/*------------------------------------------------------------
Author:         Shyamala Sridevi
Company:        Capgemini
Description:    This is the Case trigger Helper class 
                        
Test Class:     NA
History
05/June/2017    Shyamala Sridevi     Created

18/Sep/2017		Aishwarya Aithal 	 Modified
------------------------------------------------------------*/
public class OLCN_CaseTriggerHelper {
	
   public static Boolean islookUpOnInsurerProcessing = true;      
   public static Final String CASE_ORIGIN ='Web';
   public static Final String CASE_ORIGIN_2 ='Phone';       //added case origin='Phone'
    
    
    //This method is to get the OLCN cases
    public static list<Case> getAllCases(list<Case> allCases){
        list<Case> allNewCases = new List<Case>(); // to filter cases that are OLCN only
        Id getCaseRecordtype=OLCN_MetaUtility.getCaseOnlineClaimRecordType();
        for(Case c:allCases){
            if(c.RecordTypeId == getCaseRecordtype)
            allNewCases.add(c);
        }
        return allNewCases;
    }
    
    //This method is to get the OLCN cases
    public static list<Case> getAllCaseRecords(list<Case> allCases){
        list<Case> allNewCases = new List<Case>(); // to filter cases that are OLCN only
        Id getCaseOLCNRecordtype=OLCN_MetaUtility.getCaseOnlineClaimRecordType();
        Id getCaseFeedbackRecordtype=OLCN_MetaUtility.getCaseClaimAndFeedbackRecordType();
        for(Case c:allCases){
                if(c.RecordTypeId == getCaseOLCNRecordtype || c.RecordTypeId == getCaseFeedbackRecordtype)
            allNewCases.add(c);
        }
        return allNewCases;
    }
    
    //Thihs method will create the Injured and Representative Contacts and gives the lookup to Contacts from Case
    public static void lookupContactOnCase(list<Case> getAllNewCases){
        try
        {            
            list<string> newCasesFirstNameList=new list<string>();						      //To get the firstname of the Cases submitted thru Web Form on Case Creation. 
            list<string> newCasesLastNameLst=new list<string>();							  //To get the lastname of the Cases submitted thru Web Form on Case Creation.								
            list<string> newCasesEmailLst=new list<string>();								  //To get the email of the Cases submitted thru Web Form on Case Creation.
            list<string> newCasesPhoneLst=new list<string>();								  //To get the phone of the Cases submitted thru Web Form on Case Creation.
			
            map<string,contact> contactLookUpMap=new map<string,contact>();                  //This is to give the lookup to the Injured and Representative contacts if they exist in the system.
            map<string,contact> createNewContactMap=new map<string,contact>();               //This is to create the Injured and Representative Contact 
            map<string,account> createNewAccountMap=new map<string,account>();              //This is to create the Injured and Representative Account 
			
            getAllNewCases = getAllCaseRecords(getAllNewCases);        				  		  //This list is to get only the OLCN and Feedback Cases.
            Id getContactRecordtype=OLCN_MetaUtility.getContactOLCNRecordType(); 		      //To get the OLCN Contact record type.
            Id getContactCTPRecordtype=OLCN_MetaUtility.getContactCTPRecordType();
            Id getAccountRecordtype=OLCN_MetaUtility.getAccountIndividualOLCNRecordType();    //To get the OLCN Account record type.
			
            //Getting the List of FirsName,LastName,Email & Phone for Injured/Rep from the Incomming cases.
            for (Case cas:getAllNewCases){
                if(cas.OLCN_FormFirstName__c!=null) newCasesFirstNameList.add(cas.OLCN_FormFirstName__c);
				if(cas.OLCN_FormLastName__c !=null) newCasesLastNameLst.add(cas.OLCN_FormLastName__c);
				if(cas.OLCN_FormEmail__c!=null) 	newCasesEmailLst.add(cas.OLCN_FormEmail__c);
				if(cas.OLCN_FormPhone__c!=null) 	newCasesPhoneLst.add(cas.OLCN_FormPhone__c);
                
                if(cas.OLCN_FormRepFirstName__c!=null) 	newCasesFirstNameList.add(cas.OLCN_FormRepFirstName__c);
				if(cas.OLCN_FormRepLastName__c!=null) 	newCasesLastNameLst.add(cas.OLCN_FormRepLastName__c);
				if(cas.OLCN_FormRepEmail__c!=null 	)	newCasesEmailLst.add(cas.OLCN_FormRepEmail__c);
				if(cas.OLCN_FormRepPhone__c!=null)		newCasesPhoneLst.add(cas.OLCN_FormRepPhone__c); 							
            }                                                                                     
                                                                                                  
			// Add comment                                                                        
			if(newCasesFirstNameList.size()>0 && newCasesLastNameLst.size()>0 && (newCasesEmailLst .size()>0 || newCasesPhoneLst.size()>0)){
				for(contact cnt:[select id,firstname,lastname,email,phone from contact where (recordtypeid =: getContactRecordtype or recordtypeid =: getContactCTPRecordtype) and firstname IN:newCasesFirstNameList and lastname IN:newCasesLastNameLst and (email IN:newCasesEmailLst or  phone IN:newCasesPhoneLst)]){
                    string contactKeyForExistingRec =cnt.firstname+cnt.lastname;                  
                    contactLookUpMap.put(contactKeyForExistingRec,cnt);                           
				}                                                                                  

                for(case caseRecord:getAllNewCases){	  
                    string caseKeyForInjured=caseRecord.OLCN_FormFirstName__c+caseRecord.OLCN_FormLastName__c;  // key for injured person
                    string caseKeyForRep=caseRecord.OLCN_FormRepFirstName__c+caseRecord.OLCN_FormRepLastName__c; // key for rep
                    
                    if(!contactLookUpMap.isEmpty() && contactLookUpMap.get(caseKeyForInjured)!=null){                        
                        caseRecord.Contactid=contactLookUpMap.get(caseKeyForInjured).id;                                                                            
                    }
                    else if((caseRecord.OLCN_FormPhone__c !=null && caseRecord.OLCN_FormPhone__c !='') || (caseRecord.OLCN_FormEmail__c !=null && caseRecord.OLCN_FormEmail__c !='')){
                        account accountRecord=new account(Name=caseRecord.OLCN_FormFirstName__c+' '+caseRecord.OLCN_FormLastName__c,phone=caseRecord.OLCN_FormPhone__c,RecordtypeID=getAccountRecordtype);
                        createNewAccountMap.put(caseKeyForInjured,accountRecord);                            
                        contact contactRecord=new contact(firstname=caseRecord.OLCN_FormFirstName__c,lastname=caseRecord.OLCN_FormLastName__c,email=caseRecord.OLCN_FormEmail__c,phone=caseRecord.OLCN_FormPhone__c,type__c=caseRecord.OLCN_RepType__c,RecordTypeId=getContactCTPRecordtype);
                        createNewContactMap.put(caseKeyForInjured,contactRecord);									
                    }
                    
                    if(!contactLookUpMap.isEmpty() && contactLookUpMap.get(caseKeyForRep)!=null){                        
                        caseRecord.OLCN_RepContact__c=contactLookUpMap.get(caseKeyForRep).id;
                    }else if((caseRecord.OLCN_FormRepPhone__c !=null && caseRecord.OLCN_FormRepPhone__c !='') || (caseRecord.OLCN_FormRepEmail__c !=null && caseRecord.OLCN_FormRepEmail__c !='')){
                        account accountRecord =new account(Name=caseRecord.OLCN_FormRepFirstName__c+' '+caseRecord.OLCN_FormRepLastName__c,phone=caseRecord.OLCN_FormRepPhone__c,RecordtypeID=getAccountRecordtype);
                        createNewAccountMap.put(caseKeyForRep,accountRecord);              
                        contact contactRecord =new contact(firstname=caseRecord.OLCN_FormRepFirstName__c,lastname=caseRecord.OLCN_FormRepLastName__c,email=caseRecord.OLCN_FormRepEmail__c,phone=caseRecord.OLCN_FormRepPhone__c,type__c=caseRecord.OLCN_RepType__c,RecordTypeId=getContactCTPRecordtype);
                        createNewContactMap.put(caseKeyForRep,contactRecord);
                    }																
                }
			
                //Creating Accounts for the new contacts if no existing Contacts found
                if(!createNewAccountMap.isempty()){
                    insert createNewAccountMap.values();
                }
                //Creating new Contacts once the new Case is submitted and no match is found for the contact details
                if(!createNewContactMap.isempty()){
                    insert createNewContactMap.values();
                }
                
                //Associating Case with the Contact details of the Injured & representative
                for(Case caseRec:getAllNewCases){
                    string caseKeyInjured =caseRec.OLCN_FormFirstName__c+caseRec.OLCN_FormLastName__c;
                    string caseKeyRep=caseRec.OLCN_FormRepFirstName__c+caseRec.OLCN_FormRepLastName__c;
                    if(createNewContactMap.get(caseKeyInjured)!=null) 
                        caseRec.Contactid=createNewContactMap.get(caseKeyInjured).id;
                    if(createNewContactMap.get(caseKeyRep)!=null) 
                        caseRec.OLCN_RepContact__c=createNewContactMap.get(caseKeyRep).id;
                }
            	
                //Associating Contacts with Accounts
                if(!createNewContactMap.isempty() && !createNewAccountMap.isEmpty()){
                    list<contact> contactlinkToaccountLst=new list<contact>();
                    for(string contactRec:createNewContactMap.keyset()){
                        id contactRecordId=createNewContactMap.get(contactRec).id;
                        id accountRecordId=createNewAccountMap.get(contactRec).id;
                        contact contactRecord =new contact (id=contactRecordId,accountId=accountRecordId);
                        contactlinkToaccountLst.add(contactRecord);
                    }
                    if(contactlinkToaccountLst.size()>0){
                         update contactlinkToaccountLst;
                    }
                 }  
    	}
      }catch(exception ex){                                                                       
          system.debug('Exception thrown' + ex.getmessage());                                     
      }                                                                                           
	}
  
  //This method will assign the Insurer to the Case based on the Insurer Code      
  public static void lookUpOnInsurer(list<Case> getAllNewCases)
  {   
         getAllNewCases = getAllCases(getAllNewCases);                 //This is to get the cases which belongs to OLCN
         if(islookUpOnInsurerProcessing){           
            ID accRecordType=OLCN_MetaUtility.getAccountBusinessOLCNRecordType(); //This is to get the OLCN Insurers.
        
            islookUpOnInsurerProcessing=false;
            list<string> insurerCodeList=new list<string>();                      //This is to get the insurer codes of the Insurers.
            map<string,account> mapForInsurerCodeName=new map<string,account>();  //This is to get the names of the insurers based on the insurer codes.
            for (case caseRecord:getAllNewCases){
                if(caseRecord.OLCN_InsurerCode__c!=null && caseRecord.OLCN_InsurerCode__c !=''){
                    insurerCodeList.add(caseRecord.OLCN_InsurerCode__c);
                }
            }
            If(insurerCodeList.size()>0){
                for(Account insurer:[select id,OLCN_InsurerCode__c from account where OLCN_InsurerCode__c IN :insurerCodeList and RecordTypeId=:accRecordType]){
                    mapForInsurerCodeName.put(insurer.OLCN_InsurerCode__c,insurer);         
                }
            }
            for (case caseRecord:getAllNewCases){
                if(!mapForInsurerCodeName.isempty() && caseRecord.OLCN_InsurerCode__c !=null && caseRecord.OLCN_InsurerCode__c!='' && mapForInsurerCodeName.get(caseRecord.OLCN_InsurerCode__c)!=null){
                    caseRecord.OLCN_Insurer__c=mapForInsurerCodeName.get(caseRecord.OLCN_InsurerCode__c).id;
                }else{
                    caseRecord.OLCN_Insurer__c=Null;
                }
            }
         }
   }    
   
  //This method updates the injured and representative details when the lookup of injured and representative contacts changes on case. 
  public static void lookUpOnContact(list<Case> getAllNewCases){
      
        try{
            getAllNewCases = getAllCases(getAllNewCases);
            ID contRecordtype=OLCN_MetaUtility.getContactOLCNRecordType();
            ID contCTPRecordtype=OLCN_MetaUtility.getContactCTPRecordType();
            set<Id> contactSet = new set<Id>(); 
 			for(Case cs:getAllNewCases){
   			  contactSet.add(cs.contactid);
			  contactSet.add(cs.OLCN_RepContact__c);
  			}
  			map<Id, Contact> allContactMap = new map<Id, Contact>(
                    [select Id,firstName,lastName,Phone,Email from Contact where Id IN:contactSet and (recordtypeid=:contRecordtype or recordtypeid=:contCTPRecordtype)]);
		    list<case> updateCaseList=new list<case>(); 
            for(case newcaseRecord:getAllNewCases){
              if(newcaseRecord.Contactid !=null && allContactMap.get(newcaseRecord.Contactid)!=null && newcaseRecord.Status != 'Closed' && newcaseRecord.Origin == 'Web'){
                   
                    newcaseRecord.OLCN_FormFirstName__c  =	allContactMap.get(newcaseRecord.Contactid).firstName;
					newcaseRecord.OLCN_FormLastName__c   =	allContactMap.get(newcaseRecord.Contactid).lastName;
					newcaseRecord.OLCN_FormPhone__c      =	allContactMap.get(newcaseRecord.Contactid).Phone;
					newcaseRecord.OLCN_FormEmail__c		 =	allContactMap.get(newcaseRecord.Contactid).Email;
					
                 }
				if(newcaseRecord.OLCN_RepContact__c !=null && allContactMap.get(newcaseRecord.OLCN_RepContact__c)!=null && newcaseRecord.Status != 'Closed' && newcaseRecord.Origin == 'Web'){
					newcaseRecord.OLCN_FormRepFirstName__c= allContactMap.get(newcaseRecord.OLCN_RepContact__c ).firstName;
                    newcaseRecord.OLCN_FormRepLastName__c = allContactMap.get(newcaseRecord.OLCN_RepContact__c ).lastName;
                    newcaseRecord.OLCN_FormRepPhone__c    = allContactMap.get(newcaseRecord.OLCN_RepContact__c ).Phone;
                    newcaseRecord.OLCN_FormRepEmail__c    = allContactMap.get(newcaseRecord.OLCN_RepContact__c ).Email;
				}             	
            }           					
        }catch(exception ex){
            system.debug('Exception thrown' + ex.getmessage()); 
		}
        
    }

	//This method will check the duplicate cases and once identified will set the status to "New" & mark the Close Reason as "Duplicate".
	public static void checkDuplicateCases(list<Case> getAllNewCases){
		try{
	         getAllNewCases = getAllCases(getAllNewCases);
	         Id OLCNCaseRecordtype=OLCN_MetaUtility.getCaseOnlineClaimRecordType();
	         
	         list<String> oldCasesFirstNameList = new list<String>(); 									//List to handle injured person's first name
	         list<String> oldCasesLastNameList = new list<String>(); 									//List to handle injured person's last name
	         list<Date>   oldCasesAccidentDateList = new list<Date>(); 									//List to handle injured person's accident date
	         list<String> oldCasesRegoNumberList = new list<String>(); 									//List to handle injured person's register number
	         map<String,list<case>> duplicateIdentityKeyToCaseRecordsMap = new map<String,list<case>>();		//Map to hold duplicate identification key To Case record mapping.
	         
	         if (!getAllNewCases.isEmpty()){
	         	
	         	for(Case newCaseRecord :getAllNewCases){
	         		
					if((newCaseRecord.Origin==CASE_ORIGIN  || newCaseRecord.Origin==CASE_ORIGIN_2)&& newCaseRecord.OLCN_FormFirstName__c!=null && newCaseRecord.OLCN_FormLastName__c!=null && newCaseRecord.OLCN_AccidentDate__c!=null && newCaseRecord.OLCN_AtFaultRegistrationNumber__c!=null) {
	                        String duplicateIdentityKeyNew ='';					//Key for duplicate identification for new case records.
	                        oldCasesFirstNameList.add(newCaseRecord.OLCN_FormFirstName__c);
	                        oldCasesLastNameList.add(newCaseRecord.OLCN_FormLastName__c);
	                        oldCasesAccidentDateList.add(newCaseRecord.OLCN_AccidentDate__c);
	                        oldCasesRegoNumberList.add(newCaseRecord.OLCN_AtFaultRegistrationNumber__c);
	                        
	                        duplicateIdentityKeyNew = newCaseRecord.OLCN_FormFirstName__c + newCaseRecord.OLCN_FormLastName__c + newCaseRecord.OLCN_AccidentDate__c + newCaseRecord.OLCN_AtFaultRegistrationNumber__c;
	                        
	                        if(duplicateIdentityKeyToCaseRecordsMap.containsKey(duplicateIdentityKeyNew)){ 
	                        	duplicateIdentityKeyToCaseRecordsMap.get(duplicateIdentityKeyNew).add(newCaseRecord);
	                        }else{
	                        	duplicateIdentityKeyToCaseRecordsMap.put(duplicateIdentityKeyNew,new list<case> {newCaseRecord});
	                        }
	                        
					}
	         	}
	         	
	         	for(Case oldCaseRecord:[Select id,OLCN_FormFirstName__c,OLCN_FormLastName__c,OLCN_AccidentDate__c,OLCN_AtFaultRegistrationNumber__c From Case Where recordtypeid =: OLCNCaseRecordtype 
	                    						And (Origin =:CASE_ORIGIN or Origin =:CASE_ORIGIN_2)
                                                And OLCN_FormFirstName__c IN:oldCasesFirstNameList And OLCN_FormLastName__c IN:oldCasesLastNameList 
	                    						And OLCN_AccidentDate__c IN:oldCasesAccidentDateList And OLCN_AtFaultRegistrationNumber__c IN:oldCasesRegoNumberList]){
					
					String duplicateIdentityKeyOld ='';		//Key for duplicate identification for old case records.
					duplicateIdentityKeyOld = oldCaseRecord.OLCN_FormFirstName__c + oldCaseRecord.OLCN_FormLastName__c + oldCaseRecord.OLCN_AccidentDate__c + oldCaseRecord.OLCN_AtFaultRegistrationNumber__c; 
					
					if(duplicateIdentityKeyToCaseRecordsMap.ContainsKey(duplicateIdentityKeyOld)){
						for(case newCaseRecord : duplicateIdentityKeyToCaseRecordsMap.get(duplicateIdentityKeyOld)){
							newCaseRecord.Status='New'; 
		                	newCaseRecord.OLCN_CloseReason__c='Duplicate';
						}
                    }
				}
          }
		}catch(exception ex){
            system.debug('Exception thrown' + ex.getmessage()); 
		}
	}

}