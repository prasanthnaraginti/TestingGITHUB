({
    handleComponentEvent : function(component, event, helper) {
        
        console.log('Event Captured');
        component.set("v.caseItem", event.getParam("casItem"));
        console.log(event.getParam("casItem"));
        console.log(component.get("v.caseItem").CTP_Your_reply__c);
        
    },
    doInit : function(component, event, helper){
        var url = new URL(window.location);
        console.log('----------'+url);
        var cas = url.searchParams.get("CaseId");
        console.log('---------------'+cas);
        var casItm = url.searchParams.get("caseItem");
        console.log('---------------'+casItm);
		component.set("v.caseItemId",casItm);
        component.set("v.caseId",cas);
        
        $A.createComponent(
            "c:CTP_Insurer_ReplyRequest_InsurerReply",
            {
                "caseItemId": component.get("v.caseItemId"),
                "caseId": component.get("v.caseId")
            },
            function(newCmp){
                if (component.isValid()) {
                    console.log('--- Before setting component---');
                    component.set("v.body", newCmp);
                    console.log('--- After setting component---');
                }
            }
        );
    }
})