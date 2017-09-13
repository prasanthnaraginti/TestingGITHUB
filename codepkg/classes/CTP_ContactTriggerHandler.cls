public class CTP_ContactTriggerHandler {
    List<Contact> newContact;
    public CTP_ContactTriggerHandler (List<Contact> newContact) {
        this.newContact = newContact;
        
    }
    public void handleBeforeInsert(){  
        try{
            List<Account> accList = new List<Account>();
            Id recId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('CTP_Public').getRecordTypeId();
            Id accRecId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('CTP_Public').getRecordTypeId();
            Map<Contact,Account> contactAccountMap = new Map<Contact,Account>();
            For(Contact con:newContact){
                system.debug('testtest'+ con.RecordTypeId + 'testtest' + recId);
                if(con.RecordTypeId == recId){
                    Account acc = new Account();
                    acc.Name =con.FirstName+' '+con.LastName;
                    acc.RecordTypeId = accRecId;
                    accList.add(acc); 
                    contactAccountMap.put(con,acc);
                }
            }
            Database.insert(accList,false);
            For(Contact con:newContact){
                Account acc=contactAccountMap.get(con);
                con.AccountId= acc.id;    
            }
        }
        catch(Exception e){
            system.debug(e.getMessage());
        }
        
    }
    
}