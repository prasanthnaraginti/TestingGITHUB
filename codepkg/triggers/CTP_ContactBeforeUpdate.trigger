trigger CTP_ContactBeforeUpdate on Contact (before update,before insert) {
    List<Contact> contList = new List<Contact>();
    CTP_ContactTriggerHandler contactHandler= new CTP_ContactTriggerHandler(trigger.new);
    for(Contact con: Trigger.New){
        System.Debug('>> Contact Update >>>>');
        if(con.CTP_Opt_Out_of_Case_Email_Updates__c == true){
            System.Debug('>> update Contact called >>>>');
            contList.add(con);
        }
    }
    
    //Code Added for DCR-1215(Squad-2) To create account automatically for new contact record.
    if(Trigger.isBefore && Trigger.isInsert){
            contactHandler.handleBeforeInsert();
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        System.Debug('>> update Contact  >>>>');
        if(!contList.isEmpty()){
            CTP_UserTriggerHandler.optOutOfEmailUpdateContact(contList);
        }
    }
}