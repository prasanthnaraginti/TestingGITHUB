trigger DRS_CaseItemTrigger on CaseItem__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    System.debug('@@@@@ Trigger.new Value :: '+JSON.SerializePretty(Trigger.new));
    if(CTP_ClaimantsCommunityService.BYPASSFLAG ==false)
    {
        DRS_CaseItemTriggerHandler.run(Trigger.New);
        CTP_ClaimantsCommunityService.BYPASSFLAG =true;
        System.debug('@@@@@  CTP_ClaimantsCommunityService.BYPASSFLAG :: '+CTP_ClaimantsCommunityService.BYPASSFLAG);
    }
    
}