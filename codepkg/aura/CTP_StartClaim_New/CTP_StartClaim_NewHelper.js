({
    retrieveDraftCase : function(component, event,caseId) {
        console.log('---------->>'+caseId);
        var action = component.get("c.retrieveDraftCase");
        action.setParams({
            "caseId" : caseId
        });
        action.setCallback(this, function(response) {
            console.log('@@@@ Success -->'+response.getState());
            var state = response.getState();
            if (state === "SUCCESS") 
            {
                console.log('@@@@@@@ retrieveDraftCases Stringify ::: '+ JSON.stringify(response.getReturnValue()) );
                component.set("v.retrieveDraftCases", response.getReturnValue() );
                this.loadUCDInfohelper(component, event);
            }  
            
        });
        
        $A.enqueueAction(action); 
    },
    
    getfaultInsurer : function(component, event) {
        console.log('---helper----');
        var action = component.get("c.getfaultInsurer");
        var opts=[];
        opts.push({ label: "Select insurer", value: "Select insurer"});
        action.setCallback(this, function(response) {
            console.log('@@@@ Success -->'+response.getState());
            var state = response.getState();
            if (state === "SUCCESS") {
                for(var i=0;i< response.getReturnValue().length;i++){
                    opts.push({ label: response.getReturnValue()[i], value: response.getReturnValue()[i]});
                }
                console.log('@@@@ options -->'+JSON.stringify(opts));
                component.set("v.options", opts );
            }
        });
        $A.enqueueAction(action); 
    },
    
    ShowEnterClaimHelper : function(component, event)
    {
        component.set("v.isRepresentative", false);
        component.set("v.isLoggedinUserPublicRep", false);
        component.set("v.openStartClaim_Component", true);
        var cmpTargetdrop = component.find('claiminput');
        $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
        
        // Bhavani: adding event fire mechanism -start 
        var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
        appEvent.setParams({
            "stage" : "1",
            "claim_num" :""
        });
        appEvent.fire();
        // Bhavani: adding event fire mechanism -end
    },
    
    modalCancelHelper : function(component, event){
        component.set("v.isLoggedinUserPublicRep", true);
        component.set("v.isRepresentative", true);
        component.set("v.openStartClaim_Component", true);
        component.set("v.isTrue", true);
        var cmpTargetdrop = component.find('claiminput');
        $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
       // alert('setPlaceholder is called');
       //this.setPlaceholder(component)
        
        
    },
    
    setPlaceholder : function(component)
    {
        //component.set("v.isRepresentative", true);
        var dateFields = document.getElementsByClassName("cdateclass input")[0];
        alert('datefields'+dateFields);
        if(typeof dateFields != 'undefined')
            dateFields.setAttribute("placeholder", "mm/dd/yyyy"); 
       
    },
    
    loadUCDInfohelper : function(component, event)
    {
        console.log('-----------Inside Else----for nornal flow---');
        console.log('@@@@retrieveCase in StartClaim--->'+component.get("v.retrieveDraftCases"));
        var errorDivId = component.find("claimErrorMsgText");
        $A.util.addClass(errorDivId,"slds-hidden");
        component.set("v.isNoResult",false);
        localStorage.removeItem('Counter');
        var cmproceed=component.find('claiminput');
        $A.util.addClass(cmproceed, 'slds-hidden');
        var cmpucd=component.find('ucdcomp');
        $A.util.removeClass(cmpucd,'slds-hidden');
        component.set("v.openStartClaim_Component",false);
        component.set("v.isTrue",false);
        component.set("v.isRepresentative",false);
        console.log('-----------+'+component.get("v.targetPortal"));
        
        $A.createComponent(
            "c:CTP_UCDInfo_New",
            {
                
                "retrieveDraftCases" :component.get("v.retrieveDraftCases")
            },
            function(newCmp){
                if (component.isValid()) {
                    component.set("v.body", newCmp);
                }
            }
        );
    }
})