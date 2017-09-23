/*------------------------------------------------------------
Author:         Shyamala Sridevi
Company:        Capgemini
Description:    This Class is the Handler class for the Case trigger,Holds all the Case Trigger logic.
                        
Test Class:     OLCN_TestDataUtility
History
04/June/2017    Shyamala Sridevi     Created
------------------------------------------------------------*/
public class OLCN_CaseTriggerHandler {
    
    public static void run() {
        
        //All isInsert Logic to be placed here
        if(Trigger.isInsert){            
            if(Trigger.isBefore){
            	//Logic to create the Accounts and Contacts once case is submitted thru webform for OLCN Cases.
                OLCN_CaseTriggerHandler.createContacts(); 
                
                //Logic to give the lookup to the Incusrer based on the Insurer Code.
                OLCN_CaseTriggerHandler.lookUpOnInsurer();         
                      
                //Logic to check duplicate cases
                OLCN_CaseTriggerHandler.checkDuplicateCases();
            }
            if(Trigger.isAfter){  
            	//For future development purpose.
              
            }            
        }
        
        //All isUpdate Logic to be placed here
        if(Trigger.isUpdate){            
            if(Trigger.isBefore){ 
            	//Logic to give the lookup to the Incusrer based on the Insurer Code.
                OLCN_CaseTriggerHandler.lookUpOnInsurer(); 
                
                //Logic to update the Contact fields on Case object when Contact lookup changes on Case.
                OLCN_CaseTriggerHandler.lookUpOnContact();
            }           
        }              
    }
    
    //Logic to create the Accounts and Contacts once case is submitted thru webform for OLCN Cases.
    public static void createContacts() {
    	///Thihs method will create the Injured and Representative Contacts and gives the lookup to Contacts from Case
        //OLCN_CaseTriggerHelper.lookupFLEPWiseOncase(trigger.new);
        OLCN_CaseTriggerHelper.lookupContactOnCase(trigger.new);
    } 
    
    //Logic to give the lookup to the Incusrer based on the Insurer Code.
    public static void lookUpOnInsurer() {
    	//This method will assign the Insurer to the Case based on the Insurer Code
        OLCN_CaseTriggerHelper.lookUpOnInsurer((list<case>)trigger.new); 
    }    
    
    //Logic to update the Contact fields on Case object when Contact lookup changes on Case.
 	public static void lookUpOnContact() {
 		//This method will update the form Injured and Representative fields on change of Contact from the Case.
        OLCN_CaseTriggerHelper.lookUpOnContact((list<case>)trigger.new); 
    }
    
    //Logic to check duplicate cases
    public static void checkDuplicateCases() {
    	//This method will check the duplicate cases and mark the close reason as possible duplicate.
        OLCN_CaseTriggerHelper.checkDuplicateCases(trigger.new); 
    } 

}