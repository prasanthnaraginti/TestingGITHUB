public class CTP_UserTriggerHandler{
    public static boolean isOptout = false;
   
   @AuraEnabled
    public static void optOutOfEmail(List<User> userList){
        List<Contact> contList = new List<Contact>();
        List<Contact> contListtoUpdate = new List<Contact>();
        Set<Id> conId = new Set<Id>();
       
        if(!userList.isEmpty()){
            for(User u: userList){
                if(u.ContactId != null){
                    conId.add(u.ContactId);
                }
            }
        }
        
        List<User> usList = new List<User>();
        System.Debug('>>> userList >>> '+userList);
        System.Debug('>>> isOptout >>> '+isOptout);
        
        if(!conId.isEmpty()){
            contList = [SELECT Id, CTP_Opt_Out_of_Case_Email_Updates__c, HasOptedOutOfEmail FROM Contact WHERE Id IN:conId];
        }
        
        if(!contList.isEmpty() && isOptout==false){
            for(Contact con: contList){
                System.Debug('con.CTP_Opt_Out_of_Case_Email_Updates__c28  >>> '+con.CTP_Opt_Out_of_Case_Email_Updates__c);
                for(User us: userList){
                    if(con.CTP_Opt_Out_of_Case_Email_Updates__c == false && con.HasOptedOutOfEmail == false && us.CTP_Opt_Out_of_Case_Email_Updates__c == true){
                        con.CTP_Opt_Out_of_Case_Email_Updates__c = true ;
                        con.HasOptedOutOfEmail= true;
                        contListtoUpdate.add(con);
                        isOptout = true;
                    }else{
                        System.Debug('con.CTP_Opt_Out_of_Case_Email_Updates__c>>> '+con.CTP_Opt_Out_of_Case_Email_Updates__c);
                        con.CTP_Opt_Out_of_Case_Email_Updates__c = false ;
                        con.HasOptedOutOfEmail= false;
                        contListtoUpdate.add(con);
                    }
                }
            }
        } 
        if(!contListtoUpdate.isEmpty()){
            update contListtoUpdate;
           // isOptout = true;
            System.Debug('>>> contListtoUpdate >>> '+contListtoUpdate);
        }
    }
    
    @AuraEnabled
    public static void optOutOfEmailUpdateContact(List<Contact> contactList){
        List<User> userList = new List<User>();
        List<User> userListtoUpdate = new List<User>();
        Set<Id> conId = new Set<Id>();
       
        if(!contactList.isEmpty()){
            for(Contact c: contactList){
                if(c.Id != null){
                    conId.add(c.Id);
                }
            }
        }
        
        System.Debug('>>> isOptout >>> '+isOptout);
        if(isOptout == false){
            userList = [SELECT Id, CTP_Opt_Out_of_Case_Email_Updates__c,User.Contact.HasOptedOutOfEmail, User.Contact.CTP_Opt_Out_of_Case_Email_Updates__c, ContactId FROM User WHERE ContactId IN:conId];
            if(!userList.isEmpty() && !contactList.isEmpty()){
                for(Contact con: contactList){
                    for(User us: userList){
                        if(con.CTP_Opt_Out_of_Case_Email_Updates__c == true){
                            //us.Contact.CTP_Opt_Out_of_Case_Email_Updates__c = true ;
                            us.CTP_Opt_Out_of_Case_Email_Updates__c = true ;
                            con.HasOptedOutOfEmail= true;
                            isOptout = true;
                            userListtoUpdate.add(us);
                        }else{
                            us.CTP_Opt_Out_of_Case_Email_Updates__c = false ;
                            con.HasOptedOutOfEmail= false;
                            isOptout = true;
                            userListtoUpdate.add(us);
                        }
                    }
                }
            }
        } 
        if(!userListtoUpdate.isEmpty()){
            update userListtoUpdate;
            //isOptout = true;
            System.Debug('>>> userListtoUpdate >>> '+userListtoUpdate);
        }
    }
}