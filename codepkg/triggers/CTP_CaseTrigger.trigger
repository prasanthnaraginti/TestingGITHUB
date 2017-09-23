trigger CTP_CaseTrigger on Case (before insert, before update,after update) {
    CTP_CaseTriggerHandler csHandler = new CTP_CaseTriggerHandler(trigger.new,trigger.newMap,trigger.old,trigger.oldMap);
    if(Trigger.isBefore && Trigger.isInsert){
        csHandler.handleBeforeInsert();
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        csHandler.handleBeforeUpdate();
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        csHandler.handleAfterUpdate();
    }
}