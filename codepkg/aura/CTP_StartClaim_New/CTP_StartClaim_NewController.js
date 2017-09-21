({
    doInit: function(component, event, helper) {
        
        var portal = component.get("v.targetPortal");
        console.log('-----------'+portal); 
        if(portal=='Claimant')
        {
            var url = window.location;
            console.log('@@@@@@url --> '+url);
            if(url.toString().includes("caseId"))
            {
                
                var url = new URL(window.location);
                console.log('----------'+url);
                var cas = url.searchParams.get("caseId");
                if(cas!=null)
                {
                    console.log('---------->>'+cas);
                    helper.retrieveDraftCase(component, event,cas);
                    
                }
            }   
            else
            {
                
                component.set("v.isTrue", true);
                helper.getfaultInsurer(component, event);
                if(localStorage.getItem('EnterClaimNo')!=null)
                {
                    if(localStorage.getItem('Representative')!=null) 
                    {
                        
                        component.find('ClaimSubmissionNo').set('v.value',true); 
                        helper.modalCancelHelper(component, event);
                        localStorage.removeItem('EnterClaimNo');
                        localStorage.removeItem('Representative');
                    }
                    else
                    {
                        component.find('ClaimSubmissionYes').set('v.value',true); 
                        helper.ShowEnterClaimHelper(component, event);
                        localStorage.removeItem('EnterClaimNo');
                    }
                    
                }
            }
            
            
        }
        else if(portal=='Insurer')
        {
            console.log('--Inside--');
            //console.log('--Value-->'+component.get("v.openStartClaim_Component"));
            component.set("v.openStartClaim_Component", true);
            component.set("v.isRepresentative", true);
            var cmpTargetdrop = component.find('claiminput');
            $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
            
        }
    },
    
    ShowEnterClaim : function(component, event, helper) {
        console.log('---yes---');
        helper.ShowEnterClaimHelper(component, event);
    },
    confirmProceed: function(component,event,helper)
    {
        // Validation Starts
        var error =false;
        //------------------------------------------------- 
        if(component.get("v.openStartClaim_Component"))
        {
            var claim_Number =component.find('claimnum').get("v.value");
            var errorDivId = component.find("claimErrorMsgText");
            if(claim_Number==''){
                $A.util.removeClass(errorDivId,"slds-hidden");
                error=true;
            } 
        }
        //-------------------------------------------------
        if(component.get("v.isRepresentative"))
        {
            var firstName =component.get("v.firstname");
            var errorFirstnameDivId = component.find("firstnameId");
            if(firstName==''){
                $A.util.removeClass(errorFirstnameDivId,"slds-hidden");
                error=true;
            } 
            
            //------------------------------------------------- 
            var lastName =component.get("v.lastname");
            var errorLastnameDivId = component.find("lastnameId");
            if(lastName==''){
                $A.util.removeClass(errorLastnameDivId,"slds-hidden");
                error=true;
            } 
            //------------------------------------------------- 
            var dob =component.get("v.dob");
            var errorDobDivId = component.find("dob");
            if(dob==''){
                $A.util.removeClass(errorDobDivId,"slds-hidden");
                error=true;
            }
            else{
                
                console.log('---Before Future call---');
                
                var today = new Date().getTime();
                dob = dob.split("-");
                dob = new Date(dob[0], dob[1] - 1, dob[2]).getTime();
                console.log(today);
                console.log(dob);
                console.log((today - dob));
                if((today - dob) < 0)
                {
                    var errorDiv = component.find("DateofaccidentFutureMsg");
                    $A.util.removeClass(errorDiv, "slds-hidden");
                    error=true;
                }
                else
                {
                    var errorDiv = component.find("DateofaccidentFutureMsg");
                    $A.util.addClass(errorDiv, "slds-hidden");
                    error=false;
                }
                
            }
            
        }    
        //------------------------------------------------- 
        if(component.get("v.isTrue"))
        {
            var insurer =component.get("v.picklistValue");
            var errorInsurerDivId = component.find("insurer");
            if(insurer=='Select insurer'){
                $A.util.removeClass(errorInsurerDivId,"slds-hidden");
                error=true;
            }
        }
        // Validation Ends
        
        // Confirm Proceed Starts 
        if(!error && error==false)
        {
            var portal = component.get("V.targetPortal");
            console.log('-----------'+portal);
            var claim_Number =component.find('claimnum').get("v.value");
            console.log('claim_Number--->'+claim_Number);
            if(claim_Number=='')
            {
                
                console.log('-----------claim_Number==---');
                var errorDivId = component.find("claimErrorMsgText");
                $A.util.removeClass(errorDivId,"slds-hidden");
            }
            
            if(claim_Number=='987456')  // DCR-344 For No Result
            {
                
                //console.log('-----------claim_Number==987456---');
                var errorDivId = component.find("claimErrorMsgText");
                $A.util.addClass(errorDivId,"slds-hidden");
                var Count=0;
                
                if(localStorage.getItem('Counter')===null)
                {
                    console.log('Inside'); 
                    Count++;
                    
                }
                else
                {
                    Count = parseInt(localStorage.getItem('Counter'));
                }           
                
                if(Count<=1)
                {
                    //alert('Trying '+Count +' Time');
                    console.log('if block'); 
                    var action = component.get("c.getUcdNoResultMockDataSetup");
                    action.setCallback(this, function(response) {
                        var state = response.getState();
                        console.log('=-------------'+state);
                        console.log('==========+'+response.getReturnValue().NoResult);
                        component.set("v.isNoResult",true);
                        component.set("v.noResult","No records found. Please re-enter the claim number.");
                        Count++;
                        localStorage.setItem('Counter', Count);
                        
                        
                    });
                    
                    $A.enqueueAction(action);
                    
                }
                else
                {
                    //component.set("v.isNoResult",false);
                    localStorage.setItem("Msg","No records found. To continue, please enter the claims details below..");
                    localStorage.removeItem('Counter');
                    var cmproceed=component.find('claiminput');
                    $A.util.addClass(cmproceed, 'slds-hidden');
                    var cmpucd=component.find('ucdcomp');
                    $A.util.removeClass(cmpucd,'slds-hidden');
                    component.set("v.openStartClaim_Component",false);
                    component.set("v.isNoResult",false);
                    component.set("v.isTrue",false);
                    component.set("v.isRepresentative",false);
                    $A.createComponent(
                        "c:CTP_UCDInfo_New",
                        {
                            "ClaimnumberNew" : claim_Number,
                            "firstname" : component.get("v.firstname"),
                            "lastname" : component.get("v.lastname"),
                            "dob" : component.get("v.dob"),
                            "faultInsurer" :component.get("v.picklistValue"),
                            "targetPortal" : component.get("v.targetPortal"),
                            "isRepresentative" :component.get("v.isLoggedinUserPublicRep")
                        },
                        function(newCmp){
                            if (component.isValid()) {
                                component.set("v.body", newCmp);
                            }
                        }
                    );
                    // Bhavani: adding event fire mechanism -start 
                    /*var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                    appEvent.setParams({
                        "stage" : "2",
                        "claim_num" :claim_Number}); // Added by Subhajit as per Anil request
                    appEvent.fire();*/
                    // Bhavani: adding event fire mechanism -end                    
                }
                
            }
            else{
                
                //console.log('-----------Inside Else----for nornal flow---');
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
                        "ClaimnumberNew" : claim_Number,
                        "firstname" : component.get("v.firstname"),
                        "lastname" : component.get("v.lastname"),
                        "dob" : component.get("v.dob"),
                        "faultInsurer" :component.get("v.picklistValue"),
                        "targetPortal" : component.get("v.targetPortal"),
                        "isRepresentative" :component.get("v.isLoggedinUserPublicRep")
                    },
                    function(newCmp){
                        if (component.isValid()) {
                            component.set("v.body", newCmp);
                        }
                    }
                );
                // Bhavani: adding event fire mechanism -start 
                /*var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                appEvent.setParams({
                    "stage" : "2",
                    "claim_num" :claim_Number}); // Added by Subhajit as per Anil request
                appEvent.fire();*/
                // Bhavani: adding event fire mechanism -end
                
            }
            
        }
        
        // Confirm Proceed Ends
        
    },
    
    validateClaimNo : function(component, event, helper) {
        
        var claim_Number =component.find('claimnum').get("v.value");
        console.log('claim_Number ---->'+claim_Number);
        var errorDivId = component.find("claimErrorMsgText");
        if(claim_Number==''){
            $A.util.removeClass(errorDivId,"slds-hidden");
            
        }
        else
        { $A.util.addClass(errorDivId,"slds-hidden");
        }
        
    },
    
    validatefirstName : function(component, event, helper) {
        
        var firstName =component.get("v.firstname");
        console.log('firstName ---->'+firstName);
        var errorDivId = component.find("firstnameId");
        if(firstName==''){
            $A.util.removeClass(errorDivId,"slds-hidden");
        }
        else
        { 
            $A.util.addClass(errorDivId,"slds-hidden");
        }
    },
    
    validatelastName : function(component, event, helper) {
        var lastName =component.get("v.lastname");
        console.log('lastName ---->'+lastName);
        var errorDivId = component.find("lastnameId");
        if(lastName==''){
            $A.util.removeClass(errorDivId,"slds-hidden");
        }
        else
        { 
            $A.util.addClass(errorDivId,"slds-hidden");
        }
    },
    
    validatedob : function(component, event, helper) {
        var dob =component.get("v.dob");
        console.log('dob ---->'+dob);
        var errorDivId = component.find("dob");
        if(dob==''){
            $A.util.removeClass(errorDivId,"slds-hidden");
        }
        else
        { 
            $A.util.addClass(errorDivId,"slds-hidden");
            console.log('---Before Future call---');
            
            var today = new Date().getTime();
            dob = dob.split("-");
            dob = new Date(dob[0], dob[1] - 1, dob[2]).getTime();
            console.log(today);
            console.log(dob);
            console.log((today - dob));
            if((today - dob) < 0)
            {
                var errorDiv = component.find("DateofaccidentFutureMsg");
                $A.util.removeClass(errorDiv, "slds-hidden");
                
            }
            else
            {
                var errorDiv = component.find("DateofaccidentFutureMsg");
                $A.util.addClass(errorDiv, "slds-hidden");
               
            }
        }
    },
    
    validateInsurer : function(component, event, helper) {
        
        var insurer =component.get("v.picklistValue");
        console.log('insurer ---->'+insurer);
        var errorDivId = component.find("insurer");
        if(insurer=='Select insurer'){
            $A.util.removeClass(errorDivId,"slds-hidden");
        }
        else
        { 
            $A.util.addClass(errorDivId,"slds-hidden");
        }
        
    },
    
    displayClaimNumberHelp : function(component, event, helper){
        console.log('---------displayClaimNumberHelp------');
        var toggleText = component.find("claimNumberHelp");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    
    modalCancel: function(component, event, helper) {
        console.log('---no---');
        helper.modalCancelHelper(component, event);
        
    },
    showModal: function(component, event, helper) {
        /*var cmpTargetdrop = component.find('myModal');
        $A.util.addClass(cmpTargetdrop, 'slds-hidden');*/
        console.log('---no---');
        component.set("v.isTrue", true);
    }
    
})