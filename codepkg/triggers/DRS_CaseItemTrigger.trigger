trigger DRS_CaseItemTrigger on CaseItem__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    System.debug('@@@@@ Trigger.new Value :: '+JSON.SerializePretty(Trigger.new));
    if(DRS_ClaimantsCommunityService.BYPASSFLAG ==false)
    {
        DRS_CaseItemTriggerHandler.run(Trigger.New);
        DRS_ClaimantsCommunityService.BYPASSFLAG =true;
        System.debug('@@@@@  DRS_ClaimantsCommunityService.BYPASSFLAG :: '+DRS_ClaimantsCommunityService.BYPASSFLAG);
    }
    
}