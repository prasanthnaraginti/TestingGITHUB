({
    doInit: function(component, event, helper) {
        var retrieveCase = component.get("v.retrieveDraftCases");
        console.log('@@@@retrieveCase--->'+retrieveCase);
        if(retrieveCase!=null)
        {
            
            for(var caseInfo in retrieveCase)
            {
                console.log('@@@caseInfo -------->'+caseInfo);
                
            }
            
            component.set("v.isHardStop",false);
            //component.set("v.isTrueDraft",false);
            helper.getUserProfileInfo(component, event);
            helper.getUserInterpreterPicklistInfo(component, event);
            helper.getUserName(component, event);
            component.set('v.next','ClaimDetails');
            console.log('isRepresentative-->'+component.get('v.isRepresentative'));
            if(component.get("v.targetPortal")=='Claimant')component.set('v.isClaimantCheck',true);
            if(component.get("v.targetPortal")=='Insurer')
            {
                component.set('v.closeWhenInsurer',false);
            }    
            if(component.get('v.isRepresentative'))
            {
                component.set("v.closewhenRepresentativeLogsIn",false);
                // component.set('v.closeWhenInsurer',false);
                helper.getRepRelationData(component, event);
                component.set('v.isRep',true);
                component.set('v.isClaimantCheck',false);
                if(component.get('v.isFailure')) {
                    component.set('v.closewhenRepresentativeLogsIn',true);
                    component.set('v.closeClaimantNameWhenRepresentativeLogsIn',false);
                }
            }
            component.set('v.isTrueDraft',true);
        }
        else
        {
            component.set("v.isHardStop",false);
            //component.set("v.isTrueDraft",false);
            helper.getUCDInfo(component, event);
            helper.getUserProfileInfo(component, event);
            helper.getUserInterpreterPicklistInfo(component, event);
            helper.getUserName(component, event);
            component.set('v.next','ClaimDetails');
            console.log('isRepresentative-->'+component.get('v.isRepresentative'));
            if(component.get("v.targetPortal")=='Claimant')component.set('v.isClaimantCheck',true);
            if(component.get("v.targetPortal")=='Insurer'){
                component.set('v.closeWhenInsurer',false);
                component.set('v.isOpenWhenInsurerLoad',true);
                
            }
            if(component.get('v.isRepresentative'))
            {
                component.set("v.closewhenRepresentativeLogsIn",false);
                // component.set('v.closeWhenInsurer',false);
                helper.getRepRelationData(component, event);
                component.set('v.isRep',true);
                component.set('v.isClaimantCheck',false);
                if(component.get('v.isFailure')) {
                    component.set('v.closewhenRepresentativeLogsIn',true);
                    component.set('v.closeClaimantNameWhenRepresentativeLogsIn',false);
                }
            }  
        }
        
        
    }
    ,
    showSpinner : function (component, event, helper) {
        component.set("v.showSpinnerImage", true);
    },
    hideSpinner : function (component, event, helper) {
        component.set("v.showSpinnerImage", false);    
    },
    
    /* All EDIT Utility */ 
    
    openClaimDetailsEdit : function(component, event, helper) {
        helper.openClaimDetailsEditHelper(component, event, helper);
        
    },  
    
    editInterpreter :function(component, event, helper) {
        console.log('------editInterpreter click----'); 
        
        component.set("v.isNotEdit", false);
        component.set("v.isEdit", true);
        
    },
    editDisability :function(component, event, helper) {
        console.log('------editDisability click----'); 
        var divId = component.find("disabilityId");
        $A.util.addClass(divId,"div-inputlook");
        var textElement   = divId.getElement();
        textElement.contentEditable = true;
        
    },
    editAddress :function(component, event, helper) {
        helper.editAddressHelper(component, event,helper);
    },
    editPhone :function(component, event, helper) {
        helper.editPhoneHelper(component, event,helper);
    },
    
    goToClaimDetailsEdit:function(component, event, helper) {
        console.log('------goToClaimDetailsEdit----'); 
        if(component.get("v.targetPortal")=='Insurer')
        {
            component.set("v.openConfirmation",false);
            component.set("v.openAttachment",false);
            component.set("v.isHardStop",false);
            component.set("v.closewhenDisputeOpen",true);
            component.set("v.closewhenRepresentativeLogsIn",true);
            component.find("checkbox-1").set("v.checked",true);
            var next = component.find("proceedBtn");
            $A.util.removeClass(next, "slds-hidden");
            var submit = component.find("submitBtn");
            $A.util.addClass(submit, "slds-hidden");
            component.set("v.isTrueNext",true);
            helper.openClaimDetailsEditHelper(component, event, helper);
            component.set("v.next","ClaimDetails");
            // Bhavani: adding event fire mechanism -start 
            var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
            appEvent.setParams({
                "stage" : "1",
                "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
            appEvent.fire();
            // Bhavani: adding event fire mechanism -end 
        }
        if(component.get("v.targetPortal")=='Claimant')
        {
            
            if(component.get('v.isRepresentative'))
            {
                /*component.set("v.openConfirmation",false);
                component.set("v.openAttachment",false);
                component.set("v.isHardStop",false);
                component.set("v.closewhenDisputeOpen",true);
                component.set("v.closewhenRepresentativeLogsIn",false);
                component.set("v.isRepresentative",true);
                component.set("v.closeWhenInsurer",true);
                component.find("checkbox-1").set("v.checked",true);
                var next = component.find("proceedBtn");
                $A.util.removeClass(next, "slds-hidden");
                var submit = component.find("submitBtn");
                $A.util.addClass(submit, "slds-hidden");
                component.set("v.isTrueNext",true);
                component.set("v.next","ClaimDetails");
                
                // Bhavani: adding event fire mechanism -start 
                var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                appEvent.setParams({
                    "stage" : "1",
                    "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                appEvent.fire();
                // Bhavani: adding event fire mechanism -end */
                
            }else
            {
                component.set("v.openConfirmation",false);
                component.set("v.openAttachment",false);
                component.set("v.isHardStop",false);
                component.set("v.closewhenDisputeOpen",true);
                component.set("v.closewhenRepresentativeLogsIn",true);
                component.set("v.closeWhenInsurer",true);
                component.find("checkbox-1").set("v.checked",true);
                var next = component.find("proceedBtn");
                $A.util.removeClass(next, "slds-hidden");
                var submit = component.find("submitBtn");
                $A.util.addClass(submit, "slds-hidden");
                component.set("v.isTrueNext",true);
                component.set("v.next","ClaimDetails");
                helper.openClaimDetailsEditHelper(component, event, helper);
                // Bhavani: adding event fire mechanism -start 
                var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                appEvent.setParams({
                    "stage" : "1",
                    "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                appEvent.fire();
                // Bhavani: adding event fire mechanism -end 
            }
            
            
        }
        
    },
    
    goToContactDetailsEdit:function(component, event, helper) {
        console.log('------goToClaimDetailsEdit----'); 
        if(component.get("v.targetPortal")=='Insurer')
        {
            component.set("v.openConfirmation",false);
            component.set("v.openAttachment",false);
            component.set("v.isHardStop",false);
            component.set("v.closewhenDisputeOpen",true);
            component.set("v.closewhenRepresentativeLogsIn",true);
            component.find("checkbox-1").set("v.checked",true);
            var next = component.find("proceedBtn");
            $A.util.removeClass(next, "slds-hidden");
            var submit = component.find("submitBtn");
            $A.util.addClass(submit, "slds-hidden");
            component.set("v.isTrueNext",true);
            //helper.editAddressHelper(component, event,helper);
            //helper.editPhoneHelper(component, event,helper);
            component.set("v.next","ClaimDetails");
            var divId = component.find("AddressId");
            $A.util.addClass(divId,"div-inputlook");
            
            var divId1 = component.find("phoneId");
            $A.util.addClass(divId1,"div-inputlook");
            
            component.set("v.userProfInfo.Phone","");
            component.set("v.userProfInfo.Street","");
            component.set("v.userProfInfo.City","");
            component.set("v.userProfInfo.State","");
            
            // Bhavani: adding event fire mechanism -start 
            var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
            appEvent.setParams({
                "stage" : "1",
                "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
            appEvent.fire();
            // Bhavani: adding event fire mechanism -end 
            
            var textElement   = divId.getElement();
            textElement.contentEditable = true;
            
            var textElement1   = divId1.getElement();
            textElement1.contentEditable = true; 
        }
        
        if(component.get("v.targetPortal")=='Claimant')
        {
            
            if(component.get('v.isRepresentative'))
            {
                component.set("v.openConfirmation",false);
                component.set("v.openAttachment",false);
                component.set("v.isHardStop",false);
                component.set("v.closewhenDisputeOpen",true);
                component.set("v.closewhenRepresentativeLogsIn",false);
                component.set("v.isRepresentative",true);
                component.set("v.closeWhenInsurer",true);
                component.find("checkbox-1").set("v.checked",true);
                var next = component.find("proceedBtn");
                $A.util.removeClass(next, "slds-hidden");
                var submit = component.find("submitBtn");
                $A.util.addClass(submit, "slds-hidden");
                component.set("v.isTrueNext",true);
                component.set("v.next","ClaimDetails");
                
                var divId = component.find("AddressId");
                $A.util.addClass(divId,"div-inputlook");
                
                var divId1 = component.find("phoneId");
                $A.util.addClass(divId1,"div-inputlook");
                
                
                // Bhavani: adding event fire mechanism -start 
                var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                appEvent.setParams({
                    "stage" : "1",
                    "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                appEvent.fire();
                // Bhavani: adding event fire mechanism -end 
                var textElement   = divId.getElement();
                textElement.contentEditable = true;
                
                var textElement1   = divId1.getElement();
                textElement1.contentEditable = true; 
                
            }else
            {
                component.set("v.openConfirmation",false);
                component.set("v.openAttachment",false);
                component.set("v.isHardStop",false);
                component.set("v.closewhenDisputeOpen",true);
                component.set("v.closewhenRepresentativeLogsIn",true);
                component.set("v.closeWhenInsurer",true);
                component.find("checkbox-1").set("v.checked",true);
                var next = component.find("proceedBtn");
                $A.util.removeClass(next, "slds-hidden");
                var submit = component.find("submitBtn");
                $A.util.addClass(submit, "slds-hidden");
                component.set("v.isTrueNext",true);
                component.set("v.next","ClaimDetails");
                var divId = component.find("AddressId");
                $A.util.addClass(divId,"div-inputlook");
                
                var divId1 = component.find("phoneId");
                $A.util.addClass(divId1,"div-inputlook");
                // Bhavani: adding event fire mechanism -start 
                var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                appEvent.setParams({
                    "stage" : "1",
                    "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                appEvent.fire();
                // Bhavani: adding event fire mechanism -end 
                var textElement   = divId.getElement();
                textElement.contentEditable = true;
                
                var textElement1   = divId1.getElement();
                textElement1.contentEditable = true; 
                
            }
            
            
        }
        
    },
    
    goToAttachmentEdit : function(component, event, helper) {
        component.set("v.openConfirmation",false);
        component.set("v.openAttachment",true);
        var next = component.find("proceedBtn");
        $A.util.removeClass(next, "slds-hidden");
        var submit = component.find("submitBtn");
        $A.util.addClass(submit, "slds-hidden");
        component.set("v.isTrueNext",true);
        component.set("v.next","Attachment");
        // Bhavani: adding event fire mechanism -start 
        var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
        appEvent.setParams({
            "stage" : "3",
            "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
        appEvent.fire();
        // Bhavani: adding event fire mechanism -end 
        
    },
    
    goToSpecialDetailsEdit : function(component, event, helper) {
        
        if(component.get("v.targetPortal")=='Claimant')
        {
            
            if(component.get('v.isRepresentative'))
            {
                component.set("v.openConfirmation",false);
                component.set("v.openAttachment",false);
                component.set("v.isHardStop",false);
                component.set("v.closewhenDisputeOpen",true);
                component.set("v.closewhenRepresentativeLogsIn",false);
                component.set("v.isRepresentative",true);
                component.set("v.closeWhenInsurer",true);
                component.find("checkbox-1").set("v.checked",true);
                var next = component.find("proceedBtn");
                $A.util.removeClass(next, "slds-hidden");
                var submit = component.find("submitBtn");
                $A.util.addClass(submit, "slds-hidden");
                component.set("v.isTrueNext",true);
                component.set("v.next","ClaimDetails");
                
                component.set("v.isNotEdit", false);
                component.set("v.isEdit", true);
                
                var divId = component.find("disabilityId");
                $A.util.addClass(divId,"div-inputlook");
                
                
                // Bhavani: adding event fire mechanism -start 
                var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                appEvent.setParams({
                    "stage" : "1",
                    "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                appEvent.fire();
                // Bhavani: adding event fire mechanism -end 
                var textElement   = divId.getElement();
                textElement.contentEditable = true;
            }else
            {
                component.set("v.openConfirmation",false);
                component.set("v.openAttachment",false);
                component.set("v.isHardStop",false);
                component.set("v.closewhenDisputeOpen",true);
                component.set("v.closewhenRepresentativeLogsIn",true);
                component.set("v.closeWhenInsurer",true);
                component.find("checkbox-1").set("v.checked",true);
                var next = component.find("proceedBtn");
                $A.util.removeClass(next, "slds-hidden");
                var submit = component.find("submitBtn");
                $A.util.addClass(submit, "slds-hidden");
                component.set("v.isTrueNext",true);
                component.set("v.next","ClaimDetails");
                component.set("v.isNotEdit", false);
                component.set("v.isEdit", true);
                var divId = component.find("disabilityId");
                $A.util.addClass(divId,"div-inputlook");
                // Bhavani: adding event fire mechanism -start 
                var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                appEvent.setParams({
                    "stage" : "1",
                    "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                appEvent.fire();
                // Bhavani: adding event fire mechanism -end 
                var textElement   = divId.getElement();
                textElement.contentEditable = true;
            }
            
            
        }
    },
    /* All EDIT Utility */  
    confimReview: function(component, event, helper) {
        var portal = component.get("v.targetPortal");
        console.log('------portal'+portal);
        var selected = event.getSource().get("v.text");
        var cmpDisputeSection = component.find('confirmReviewchoiceNew');
        
        if(selected === 'Yes'){
            console.log('Inside yes'+portal);
            
            var selected = event.getSource().get("v.text");
            component.set("v.isClaimCorrectChecked", false);
            
            
            if(portal =='Claimant'){
                
                component.set("v.isHardStop",true);
                component.set("v.isOpenWhenClaimantLoad",true); 
                console.log('------Yes Radio Button----');
                console.log('------Yes Radio Button--'+component.find('reviewYes').get("v.value"));
                console.log('------Yes Radio Button--'+component.find('reviewNo').get("v.value"));
                
                component.find('reviewYes').set("v.value", false);
                component.find('reviewNo').set("v.value", false);
                
                component.set("v.isClaimInCorrectChecked", false);
                
                var caselist = component.get("v.caseList");
                console.log('Case length-------->'+caselist.length);
                //if(caselist.length>1)caselist.splice(caselist.length -1, 1);
                
                console.log("Test===============>selected");
                console.log('Inside yes Claimant');
                component.set("v.isTrueDraft", true);
                component.set("v.detailsIncorrect", false);
                component.set("v.isNoResult",false);
                console.log('selected == '+selected);
                component.set("v.stage", "2");
                
                if(caselist.length==0)helper.createObjectData(component, event);
                
                component.set("v.isTrueDraft", true);
                component.set("v.isHaveYouReqAnInternal",false);
                component.set("v.showInternalReviewDateSection", false);
                component.set("v.showDateofInsurerInternalReview",false);
                
                component.set("v.showDateReqByClaimant",false);
                
                
            }else if(portal =='Insurer'){
                component.set("v.isHardStop",true);
                console.log("Test===============>selected");
                console.log('Inside yes Insurer');
                component.set("v.isTrueDraft", true);
                component.set("v.detailsIncorrect", false);
                component.set("v.isNoResult",false);
                console.log('selected == '+selected);
                component.set("v.stage", "2");
                
                helper.createObjectData(component, event);
                component.set("v.isOpenWhenInsurerLoad",false);
                component.set("v.isHardStop",true);
                component.set("v.isTrueDraft", true);
            }
            
        }else if(selected === 'No'){
            component.set("v.isTrueNext", false);
            component.set("v.stage", "2");
            component.set("v.isTrueDraft", false);
            component.set("v.detailsIncorrect", true);
            component.set("v.isNoResult",false);
            console.log('selected == '+selected);
            component.set("v.isClaimInCorrectChecked", true);
            
            if(portal =='Insurer'){
                
                component.set("v.isOpenWhenInsurerLoad",true);
                component.set("v.isHardStop",false);
                helper.createObjectNoData(component, event);
                component.set("v.isTrueDraft", true);
                
            }else if(portal =='Claimant'){
                
                component.set("v.isHardStop",true);
                component.set("v.isOpenWhenClaimantLoad",true); 
                
                console.log('------No Radio Button----');
                console.log('------No Radio Button--'+component.find('reviewYes').get("v.value"));
                console.log('------No Radio Button--'+component.find('reviewNo').get("v.value"));
                
                component.find('reviewYes').set("v.value", false);
                component.find('reviewNo').set("v.value", false);
                
                console.log('No Selected');
                component.set("v.isInCorrectDetailChecked", true); 
                
                var caselist = component.get("v.caseList");
                console.log('Case length-------->'+caselist.length);
                //if(caselist.length>1)caselist.splice(caselist.length -1, 1);
                
                component.set("v.stage", false);
                component.set("v.isNoResult",false);
                component.set("v.detailsIncorrect", true);
                component.set("v.isTrueDraft", true);
                component.set("v.stage", "2");
                
                if(caselist.length==0)helper.createObjectData(component, event);
                
                component.set("v.isHaveYouReqAnInternal",false);
                component.set("v.showInternalReviewDateSection", false);
                component.set("v.showDateofInsurerInternalReview",false);
                component.set("v.showDateReqByClaimant",false);
                
            }
        }
        
    },
    addNewRow: function(component, event, helper) {
        // call the comman "createObjectData" helper method for add new Object Row to List  
        var disputecommentinput = component.find('disputecommentinput');
        $A.util.addClass(disputecommentinput, 'slds-hidden');
        var AllRowsList = component.get("v.caseList");
        var vcase = component
        helper.createObjectData(component, event);
        console.log('@@@@ last line of addNewRow-->'+JSON.stringify(AllRowsList));
        
    },
    
    // function for delete the row 
    removeDeletedRow: function(component, event, helper) {
        // get the selected row Index for delete, from Lightning Event Attribute  
        var index = event.getParam("indexVar");
        // get the all List (contactList attribute) and remove the Object Element Using splice method    
        var AllRowsList = component.get("v.caseList");
        console.log('@@@@Before Removing-->'+JSON.stringify(AllRowsList));
        AllRowsList.splice(index, 1);
        console.log('@@@@After Removing-->'+JSON.stringify(AllRowsList));
        // set the contactList after remove selected row element
        component.set("v.caseList", AllRowsList);
        console.log('@@@@Setting Caselist..................');
        console.log('geting Case list again-->'+JSON.stringify(component.get("v.caseList")));
    },
    
    datenotblank: function(component, event, helper) {
        var reviewcompletion = component.get("v.ReviewCompletion");
        var reviewreceipt = component.get("v.ReviewRecept");
        var date1ErrorMsg = component.find('date1ErrorMsg');
        var date2ErrorMsg = component.find('date2ErrorMsg');
        var textareaDiv = component.find('disagreementReasonNew');
        if (reviewcompletion != null && reviewreceipt != null) {
            if(reviewcompletion < reviewreceipt){
                $A.util.addClass(date1ErrorMsg, 'slds-hidden');
                $A.util.addClass(date2ErrorMsg, 'slds-hidden');
                $A.util.removeClass(textareaDiv, 'slds-hidden');
            }else{
                component.set('v.typeOfError','Lesser');
                $A.util.removeClass(date2ErrorMsg, 'slds-hidden');
                $A.util.addClass(textareaDiv, 'slds-hidden');
            }
        }else if(reviewcompletion != null && reviewreceipt == null){
            $A.util.addClass(textareaDiv, 'slds-hidden');
            component.set('v.typeOfError','Blank');
            $A.util.removeClass(date2ErrorMsg, 'slds-hidden');
        } else if(reviewcompletion == null && reviewreceipt != null){
            $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
        }else if(reviewcompletion == null && reviewreceipt == null){
            var cmpTargetdrop = component.find('date1ErrorMsg');
            $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
            var cmpTargetdrop2 = component.find('date2ErrorMsg');
            $A.util.removeClass(cmpTargetdrop2, 'slds-hidden');
        }
        
    },
    
    disableKeydate1 : function(component, event, helper){
        var d1 = component.get("v.ReviewCompletion");
        for(var i =0; i< d1.length; i++){
            if(d1[i] === '/'){
                console.log('its a /');
            }else{
                if(!isNaN(parseFloat(d1[i])) && isFinite(d1[i])){
                }else{
                    component.set('v.ReviewCompletion', '');
                }
            }
        }
    },
    disableKeydate2 : function(component, event, helper){
        var d2 = component.get("v.ReviewRecept");
        for(var i =0; i< d1.length; i++){
            if(d2[i] === '/'){
                console.log('its a /');
            }else{
                if(!isNaN(parseFloat(d2[i])) && isFinite(d2[i])){
                }else{
                    component.set('v.ReviewRecept', '');
                }
            }
        }
    },
    
    
    datenotblankDummy : function(component, event, helper) {
        var reviewcompletion = component.get("v.ReviewCompletion");
        var reviewreceipt = component.get("v.ReviewRecept");
        var date1ErrorMsg = component.find('date1ErrorMsg');
        var date2ErrorMsg = component.find('date2ErrorMsg');
        var textareaDiv = component.find('disagreementReasonNew');
        if (reviewcompletion != null && reviewreceipt != null) {
            if(reviewcompletion < reviewreceipt){
                $A.util.addClass(date1ErrorMsg, 'slds-hidden');
                $A.util.addClass(date2ErrorMsg, 'slds-hidden');
                $A.util.removeClass(textareaDiv, 'slds-hidden');
            }else{
                component.set('v.typeOfError','Lesser');
                $A.util.removeClass(date2ErrorMsg, 'slds-hidden');
                $A.util.addClass(textareaDiv, 'slds-hidden');
            }
        }else if(reviewcompletion != null && reviewreceipt == null){
            $A.util.addClass(textareaDiv, 'slds-hidden');
            component.set('v.typeOfError','Blank');
            $A.util.removeClass(date2ErrorMsg, 'slds-hidden');
        } else if(reviewcompletion == null && reviewreceipt != null){
            $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
        }else if(reviewcompletion == null && reviewreceipt == null){
            var cmpTargetdrop = component.find('date1ErrorMsg');
            $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
            var cmpTargetdrop2 = component.find('date2ErrorMsg');
            $A.util.removeClass(cmpTargetdrop2, 'slds-hidden');
        }
        
    },
    
    reviewDateValidate : function(component, event, helper){
        var reviewcompletion = component.get("v.ReviewCompletion");
        var date1ErrorMsg = component.find('date1ErrorMsg');
        if(reviewcompletion == null){
            $A.util.removeClass(date1ErrorMsg, 'slds-hidden');
            
        }
    },
    
    datesKeyUp : function(component, event, helper){
        console.log('up');
        console.log(event.getSource().set("v.value",""));
        
    },
    
    datesKeyDown : function(component, event, helper){
        console.log('down');
        console.log(event.getSource().set("v.value",""));
    },
    
    ProceedApplication: function(component, event, helper) {
        
        console.log('....ProceedApplication...');
        console.log('----- dfdfdf ------'+component.get("v.next"));
        var nextVal = component.get("v.next");
        var error   = component.get("v.IsError");
        console.log('@@@@error -->'+error);
        //Validation : ------------------------------------------------------------------------------- 
        if(nextVal=='ClaimDetails')
        {
            //-------------Application Applicant contact details-------------------------------
            //---------------------------------------------------------------------------------
            console.log('@@@@before validation -->');
            helper.validatePhoneNumberHelper(component, event);
            console.log('@@@@after validation -->');
            error = component.get("v.IsError");
            console.log('@@@@error -->'+error);
            //---------------------------------------------------------------------------------- 
            
            //----------Claim Details ----------------------------------------------------------
            //-----------------Claimant Name-----------------------------------------------------------------
            if(component.get("v.isInsurer") && component.get("v.isFailure"))
            {
                console.log('@@@@before validation -->');
                helper.validateYourNameHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
            }    
            
            //----------------------------------------------------------------------------------- 
            //-----------------Date of accident-----------------------------------------------------------------
            if(component.get("v.isFailure"))
            {
                console.log('@@@@before validation -->');
                helper.validateDTAccHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
            }    
            
            //----------------------------------------------------------------------------------- 
            
            //-----------------Location of accident-----------------------------------------------------------------
            if(component.get("v.isFailure"))
            {
                console.log('@@@@before validation -->');
                helper.validateDTLocAccHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
                
            }
            //-----------------------------------------------------------------------------------
            
            //-----------------Insurer-----------------------------------------------------------------
            if(component.get("v.isFailure"))
            {
                console.log('@@@@before validation -->');
                helper.validateInsurerHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
                
            }
            //-----------------------------------------------------------------------------------
            //-----------------------------------------------------------------------------------
            if(component.get("v.isRepresentative"))
            {
                
                //---------------------Claimant Contact Details ---------------------------------------
                //-----------------Claimant contact number-------------------------------------------------------------
                
                console.log('@@@@before validation -->');
                helper.validateClaimantPhoneHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
                
                
                //-----------------------------------------------------------------------------------
                //-----------------Claimant email address-------------------------------------------------------------
                
                console.log('@@@@before validation -->');
                helper.validateEmailHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
                
                
                //----------------------------------------------------------------------------------- 
                //-----------------Claimant postal address-------------------------------------------------------------
                
                console.log('@@@@before validation -->');
                helper.validateRepClaimantAddressHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
                
                
                //-----------------------------------------------------------------------------------   
            }    
        }
        else if(nextVal=='DisputeSection')
        {
            //--------------------Disagreement-------------------------------------
            if(component.get("v.isHardStop"))
            {
                console.log('@@@@before validation -->');
                helper.validateDisagreementHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
            }    
            //--------------------------------------------------------- 
            
            //--------------------outcome-------------------------------------
            if(component.get("v.isHardStop"))
            {    
                console.log('@@@@before validation -->');
                helper.validateOutcomeHelper(component, event);
                console.log('@@@@after validation -->');
                error = component.get("v.IsError");
                console.log('@@@@error -->'+error);
            }    
            //---------------------------------------------------------
            
        }else if(nextVal=='Attachment')
        {
            
        } else if(nextVal=='ConfirmDetails')
        {
            
        }
        //Navigation : -------------------------------------------------------------------------------   
        if(error==false)
        {
            console.log('@@@@ Inside Navigation -->'+error);
            if(nextVal=='ClaimDetails')
            {
                component.set("v.closewhenDisputeOpen",false);
                component.doCreateCase();
                
                component.set("v.isHardStop",true);
                //helper.createObjectData(component, event);
                component.set("v.isOpenWhenClaimantLoad",true);
                component.set("v.isNoResult",false);
                component.set("v.next","DisputeSection");
                console.log('----- Next ------'+component.get("v.next"));
           
                console.log('----- dfdfdf ------'+component.get("v.Claimnumber"));
                console.log('----- dfdfdf ------'+component.get("v.ClaimnumberNew")); 
                // Bhavani: adding event fire mechanism -start 
                var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                appEvent.setParams({
                    "stage" : "2",
                    "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                appEvent.fire();
                // Bhavani: adding event fire mechanism -end 
            }
            else
                if(nextVal=='DisputeSection')
                {
                    
                    component.set("v.next","Attachment");
                    
                    // Bhavani: adding event fire mechanism -start 
                    var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                    appEvent.setParams({
                        "stage" : "3",
                        "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                    appEvent.fire();
                    // Bhavani: adding event fire mechanism -end 
                    
                    component.set("v.isHardStop", false);
                    component.set("v.openAttachment", true);
                    component.doSaveMethod();
                    console.log('---Before setting Component---'+component.get("v.caseId"));
                    $A.createComponent(
                        "c:CTP_FileAttachment",
                        {
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
                    console.log('---After setting Component---');  
                }
                else if(nextVal=='Attachment')
                {
                    component.set("v.openAttachment", false);
                    component.set("v.openConfirmation", true);
                    component.set("v.next","ConfirmDetails");
                    
                    var submitBtn = component.find("submitBtn");
                    $A.util.removeClass(submitBtn, "slds-hidden");
                    var proceedBtn = component.find("proceedBtn");
                    $A.util.addClass(proceedBtn, "slds-hidden");
                    console.log('@@@@ Attachment -->'+localStorage.getItem('Attachment'));
                    if(localStorage.getItem('Attachment')!=null)
                    {
                        var attachmentData = JSON.parse(localStorage.getItem('Attachment'));
                        component.set("v.attachmentData",attachmentData); 
                        localStorage.removeItem('Attachment');
                    }
                    else component.set("v.attachmentData",null); 
                    
                    // Bhavani: adding event fire mechanism -start 
                    var appEvent = $A.get("e.c:CTP_AE_StartClaim_Claimant");
                    appEvent.setParams({
                        "stage" : "4",
                        "claim_num" :component.get("v.Claimnumber")}); // Added by Subhajit as per Anil request
                    appEvent.fire();
                    // Bhavani: adding event fire mechanism -end 
                    
                    
                }
                    else if(nextVal=='ConfirmDetails')
                    {
                        component.set("v.isTrue", "true");
                        var cmpTargetdrop = component.find('myModal');
                        $A.util.toggleClass(cmpTargetdrop, 'slds-hidden');
                        //component.set("v.next","ClaimDetails");
                    }
            
            
        }
        
        
        
    },
    
    Submit: function(component, event, helper) {
        if(component.get("v.isChecked")==false)
        {
            component.set("v.isTrueNext",true);
            component.set("v.isChecked",true);
        }
        else{
            
            component.set("v.isTrueNext",false);
            component.set("v.isChecked",false);
        }
        
    },
    
    createCase: function(component, event, helper) {
        console.log('inside method createCase----------');
        
        if( component.get("v.isRepresentative"))
        {
            var personalrepCom = component.get("v.repClaimantContactNumber") 
            +','+ component.get("v.repClaimantContactAddress") 
            +','+ component.get("v.repClaimantContactEmail")
            +','+ component.get("v.language")
            +','+ component.get("v.disabilityNotIndicated");
            
            component.set("v.personalRepComments",personalrepCom);
        } else component.set("v.personalRepComments",'');
        
        
        
        var ClaimNumber = component.get("v.ClaimnumberNew");
        //var ucdDetailsIncorrect = component.get("v.detailsIncorrect");
        
        var ucdDetailsIncorrect =  component.get("v.isClaimInCorrectChecked");
        
        console.log('detailsIncorrect--------------'+ucdDetailsIncorrect);
        var disputeCase = component.get("v.caseList");
        //console.log('@@@@ disputeCase :: '+JSON.stringify(disputeCase));
        var disputecomment = component.get("v.disputecomment");
        
        var ucdObj = JSON.stringify(component.get("v.UCDResponse"));
        
        console.log('--------ClaimNumber'+ClaimNumber);
        console.log('--------disputeCase'+disputeCase);
        console.log('---------disputecomment'+disputecomment);
        
        console.log('-------------compone'+component.get("v.caseIdDraft"));
        
        var action = component.get("c.portalIdentifier");
        if(ClaimNumber=='987456')
        {
            
            console.log('--- Inside No Result(987456)----');
            console.log(component.get("v.Claim_name"));
            console.log(component.get("v.dtLocAcc"));
            console.log(component.get("v.Insurer_Name"));
            //var wrappers=component.get('v.UCDResponse');
            var dateSplit = component.get("v.dtAcc").split('-');
            var dateOfAccident =dateSplit[2]+'/'+ dateSplit[1]+'/'+dateSplit[0];
            console.log('@@@@dateOfAccident ::-->'+dateOfAccident);
            
            var wrappers=new Array();
            var wrapper = {'Claimantname' : component.get("v.Claim_name"),
                           'Dateofaccident' : dateOfAccident,
                           'Locationofaccident' : component.get("v.dtLocAcc"),
                           'InsurerName' : component.get("v.Insurer_Name")
                          };
            wrappers.push(wrapper);
            
            component.set('v.UCDResponse', wrappers);
            
            ucdObj = JSON.stringify(component.get("v.UCDResponse"));
            ucdObj = ucdObj.slice(1, -1);
            console.log('@@@@@ucdObj ::'+ ucdObj);
            action.setParams({
                "outcome" : component.get("v.outcome"),
                "reviewCompletion" : component.get("v.ReviewCompletion"),
                "reviewRecept" : component.get("v.ReviewRecept"),
                "disagreementReason" : component.get("v.disagreementReason"),
                "ClaimNumber": ClaimNumber,
                "ucdObj" : ucdObj,
                "disputeCase":null,
                "disputecomment":disputecomment,
                "ucdDetailsIncorrect":ucdDetailsIncorrect,
                "CaseIdSave":component.get("v.caseIdDraft"),
                "stage" : component.get("v.stage"),
                "isFailure" :component.get("v.isFailure"),
                "portalIdentifier" : component.get("v.targetPortal"),
                "circum": component.get("v.uniqueCircumstances"),
                "CTPRepresentativeComments" : component.get("v.personalRepComments"), 
                "representativeRelation" : component.get("v.relationData")
                
            });
        }
        else
        {
            console.log('-------------inside-------------');
            action.setParams({
                "outcome" : component.get("v.outcome"),
                "reviewCompletion" : component.get("v.ReviewCompletion"),
                "reviewRecept" : component.get("v.ReviewRecept"),
                "disagreementReason" : component.get("v.disagreementReason"),
                "ClaimNumber": ClaimNumber,
                "ucdObj" : ucdObj,
                "disputeCase":null,
                "disputecomment":disputecomment,
                "ucdDetailsIncorrect":ucdDetailsIncorrect,
                "CaseIdSave":component.get("v.caseIdDraft"),
                "stage" : component.get("v.stage"),
                "isFailure" :component.get("v.isFailure"),
                "portalIdentifier" : component.get("v.targetPortal"),
                "circum": component.get("v.uniqueCircumstances"),
                "CTPRepresentativeComments" : component.get("v.personalRepComments"),
                "representativeRelation" : component.get("v.relationData")
            });
            
            console.log('-------------outside-------------');
        } 
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("State is-->"+state);
            if (state === "SUCCESS"){
                console.log('final'+response.getReturnValue());
                var casewrap = response.getReturnValue();
                console.log('casewrap'+JSON.stringify(casewrap));
                console.log(response.getReturnValue());
                component.set("v.caseId", casewrap.cas.Id);
                component.set("v.CaseNumber", casewrap.cas.CaseNumber);
                component.set("v.caseList", casewrap.disputeCaseList);
                console.log('Isssssssssss'+component.get("v.caseList"));
                component.set("v.caseCreated", true);
                component.set("v.caseIdDraft", casewrap.cas.Id);
                var nextVal = component.get("v.next");
                console.log('================1'+JSON.stringify(component.get("v.userProfInfo")));
                
                
                var actionUserUpdate = component.get("c.updateUserProfileData");
                if(component.get("v.targetPortal")=='Insurer')
                {
                    console.log('@@@ user belongs to--->'+ component.get("v.targetPortal"));
                    
                    actionUserUpdate.setParams({
                        "language":'--None--',
                        "disability":'',
                        "usr":component.get("v.userProfInfo"),
                        
                    });
                }
                else if(component.get("v.targetPortal")=='Claimant')
                {
                    console.log('@@@ user belongs to--->'+ component.get("v.targetPortal"));
                    if(component.get("v.isRepresentative"))
                    {
                        actionUserUpdate.setParams({
                            "language":'--None--',
                            "disability":'',
                            "usr":component.get("v.userProfInfo"),
                            
                        });
                    }
                    else
                    {
                        actionUserUpdate.setParams({
                            "language":component.get("v.language"),
                            "disability":component.get("v.disabilityNotIndicated"),
                            "usr":component.get("v.userProfInfo")
                            
                        });
                    }
                    
                }
                
                console.log('================2');
                actionUserUpdate.setCallback(this, function(response) {
                    var state = response.getState();
                    console.log('================3');
                    if(state === "SUCCESS"){
                        console.log('User Updated Successfully');
                        component.set("v.userProfInfo",response.getReturnValue());
                    }
                    console.log('================4');
                });
                
                $A.enqueueAction(actionUserUpdate);
                
                console.log('================5');
                
                
                
                
                if(nextVal=='ConfirmDetails')
                {
                    component.set("v.isTrue", false);
                    component.set("v.isApplicationSubmitted", true);
                    var cmpTargetdrop = component.find('myModal1');
                    $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
                    
                    
                    
                    
                    var actionNew = component.get("c.updateCaseDetails");
                    actionNew.setParams({
                        "CaseIdSave":component.get("v.caseIdDraft")
                        
                    });
                    actionNew.setCallback(this, function(response) {
                        var state = response.getState();
                        console.log("State ---- Update------State"+state);
                    });
                    $A.enqueueAction(actionNew);
                    
                    
                    
                }
                
            }
        });
        $A.enqueueAction(action);
    },
    
    goToMyApplications: function(component, event, helper) {
        if(component.get("v.targetPortal")=='Claimant')
        {
            var evt = $A.get("e.force:navigateToURL");
            console.log('<<<<evt>>>',evt);
            if (evt) {
                evt.setParams({
                    "url": '/cases',
                    "isredirect": true,
                });
                console.log('evt url is'+evt.getParam("url"));
                evt.fire();
            }  
        }
        else if(component.get("v.targetPortal")=='Insurer')
        {
            var evt = $A.get("e.force:navigateToURL");
            console.log('<<<<evt>>>',evt);
            if (evt) {
                evt.setParams({
                    "url": '/case/Case/00B0k000000NAjUEAW',
                    "isredirect": true,
                });
                console.log('evt url is'+evt.getParam("url"));
                evt.fire();
            }  
        }
        
    },
    modalCancel: function(component, event, helper) {
        var cmpTargetdrop = component.find('myModal');
        $A.util.addClass(cmpTargetdrop, 'slds-hidden');
        component.set("v.isTrue", "false");
    },
    
    
    
    addDisputeType : function(component, event, helper){
        var type = component.find("levelsCat").get("v.DisType");
        var cat = component.find("levelsTyp").get("v.value");
        console.log('================'+type);
        
    },
    // function for create new object Row in Contact List 
    addNewRow: function(component, event, helper) {
        // call the comman "createObjectData" helper method for add new Object Row to List  
        var disputecommentinput = component.find('disputecommentinput');
        $A.util.addClass(disputecommentinput, 'slds-hidden');
        var AllRowsList = component.get("v.caseList");
        var vcase = component
        helper.createObjectData(component, event);
        console.log('@@@@ last line of addNewRow-->'+JSON.stringify(AllRowsList));
        
    },
    
    // function for delete the row 
    removeDeletedRow: function(component, event, helper) {
        // get the selected row Index for delete, from Lightning Event Attribute  
        var index = event.getParam("indexVar");
        // get the all List (contactList attribute) and remove the Object Element Using splice method    
        var AllRowsList = component.get("v.caseList");
        console.log('@@@@Before Removing-->'+JSON.stringify(AllRowsList));
        AllRowsList.splice(index, 1);
        console.log('@@@@After Removing-->'+JSON.stringify(AllRowsList));
        // set the contactList after remove selected row element
        component.set("v.caseList", AllRowsList);
        console.log('@@@@Setting Caselist..................');
        console.log('geting Case list again-->'+JSON.stringify(component.get("v.caseList")));
    },
    
    displaydeclaration : function(component, event, helper) {
        var portal = component.get("v.targetPortal");
        console.log('------portal'+portal);
        if(portal=="Insurer")
        {
            var comment = component.get("v.disputecomment");
            if(comment != '' || comment != 'undefined')
            {
                
                
            }
        }
    },
    
    gotoURL : function (component, event, helper) {
        localStorage.setItem('HardStop', 'Please correct the UCD details before lodging the application');
        console.log('---------gotoURL------'+localStorage.getItem('HardStop'));
        //window.location.reload();
        var evt = $A.get("e.force:navigateToURL");
        if (evt) {
            evt.setParams({
                "url": '/'
                
            });
            console.log('evt url is'+evt.getParam("url"));
            evt.fire();
        } 
        
    },
    
    navigateToEnterClaimNo : function (component, event, helper) {
        localStorage.setItem('EnterClaimNo', 'true');
        if(component.get('v.isRepresentative'))localStorage.setItem('Representative', 'true');
        console.log('---------gotoURL------EnterClaimNo-->'+localStorage.getItem('EnterClaimNo'));
        console.log('---------gotoURL------Representative-->'+localStorage.getItem('Representative'));
        window.location.reload();
        
    },
    
    
    hideAutoSave: function(component, event, helper){
        var showAutoSave = component.find('showAutoSave');
        $A.util.addClass(showAutoSave, 'slds-hidden');
    },
    doSave: function(component, event, helper){
        
        console.log('-------------------'+event.currentTarget);
        if( component.get("v.isRepresentative"))
        {
            var personalrepCom = component.get("v.repClaimantContactNumber") 
            +','+ component.get("v.repClaimantContactAddress") 
            +','+ component.get("v.repClaimantContactEmail")
            +','+ component.get("v.language")
            +','+ component.get("v.disabilityNotIndicated");
            
            component.set("v.personalRepComments",personalrepCom);
        } else component.set("v.personalRepComments",'');
        
        
        var btnSaveDraft ='';
        if(event.currentTarget == undefined){
            console.log('1');
            btnSaveDraft = '';
            console.log('2');
        }
        else{
            console.log('3');
            btnSaveDraft =  event.currentTarget.id;
            console.log('4');
        }
        component.set("v.isTrueDraft", true);
        console.log('doSave');
        var delay = 50000;
        if(btnSaveDraft == 'saveAsDraft')
            var delay=0;
        
        
        console.log('inside auto save');
        var ClaimNumber = component.get("v.ClaimnumberNew");
        //var ucdDetailsIncorrect = component.get("v.detailsIncorrect");
        
        var ucdDetailsIncorrect =  component.get("v.isClaimInCorrectChecked");
        console.log('detailsIncorrect--------------'+ucdDetailsIncorrect);
        var disputeCase = component.get("v.caseList");
        console.log('@@@@ disputeCase :: '+JSON.stringify(disputeCase));
        var disputecomment = component.get("v.disputecomment");
        var draftCase = component.get("v.caseIdDraft");
        var ucdObj = JSON.stringify(component.get("v.UCDResponse"));
        window.setTimeout(
            $A.getCallback(function() {
                if(component.isValid()){
                    console.log('Component is If');
                    
                    var action = component.get("c.portalIdentifier");
                    if(ClaimNumber=='987456')
                    {
                        
                        console.log('--- Inside No Result(987456)----');
                        console.log(component.get("v.Claim_name"));
                        console.log(component.get("v.dtLocAcc"));
                        console.log(component.get("v.Insurer_Name"));
                        //var wrappers=component.get('v.UCDResponse');
                        var dateSplit = component.get("v.dtAcc").split('-');
                        var dateOfAccident =dateSplit[2]+'/'+ dateSplit[1]+'/'+dateSplit[0];
                        console.log('@@@@dateOfAccident ::-->'+dateOfAccident);
                        
                        var wrappers=new Array();
                        var wrapper = {"Claimantname" : component.get("v.Claim_name"),
                                       "Claimnumber" : component.get("v.ClaimnumberNew"),
                                       "Dateofaccident" : dateOfAccident,
                                       "Locationofaccident" : component.get("v.dtLocAcc"),
                                       "InsurerName" : component.get("v.Insurer_Name")
                                      };
                        wrappers.push(wrapper);
                        
                        component.set('v.UCDResponse', wrappers);
                        
                        ucdObj = JSON.stringify(component.get("v.UCDResponse"));
                        ucdObj = ucdObj.slice(1, -1);
                        console.log('@@@@@ucdObj ::'+ ucdObj);
                        action.setParams({
                            "outcome" : component.get("v.outcome"),
                            "reviewCompletion" : component.get("v.ReviewCompletion"),
                            "reviewRecept" : component.get("v.ReviewRecept"),
                            "disagreementReason" : component.get("v.disagreementReason"),
                            "ClaimNumber": ClaimNumber,
                            "ucdObj" : ucdObj,
                            "CaseIdSave": draftCase,
                            "stage" : component.get("v.stage"),
                            "disputeCase": null,
                            "disputecomment":disputecomment,
                            "ucdDetailsIncorrect":ucdDetailsIncorrect,
                            "stage" : component.get("v.stage"),
                            "isFailure" :component.get("v.isFailure"),
                            "portalIdentifier" : component.get("v.targetPortal"),
                            "circum": component.get("v.uniqueCircumstances"),
                            "CTPRepresentativeComments" : component.get("v.personalRepComments"),
                            "representativeRelation" : component.get("v.relationData")
                        });
                    }
                    else
                    {
                        action.setParams({
                            "outcome" : component.get("v.outcome"),
                            "reviewCompletion" : component.get("v.ReviewCompletion"),
                            "reviewRecept" : component.get("v.ReviewRecept"),
                            "disagreementReason" : component.get("v.disagreementReason"),
                            "ClaimNumber": ClaimNumber,
                            "ucdObj" : ucdObj,
                            "CaseIdSave":draftCase,
                            "stage" : component.get("v.stage"),
                            "disputeCase": null,
                            "disputecomment":disputecomment,
                            "ucdDetailsIncorrect":ucdDetailsIncorrect,
                            "stage" : component.get("v.stage"),
                            "isFailure" :component.get("v.isFailure"),
                            "portalIdentifier" : component.get("v.targetPortal"),
                            "circum": component.get("v.uniqueCircumstances"),
                            "CTPRepresentativeComments" : component.get("v.personalRepComments"),
                            "representativeRelation" : component.get("v.relationData")
                        });
                    } 
                    console.log('--------ucdObj'+ucdObj);
                    action.setCallback(this, function(response) {
                        var state = response.getState();
                        console.log("State is-->"+state);
                        if (state === "SUCCESS"){
                            
                            console.log('final Draft status'+response.getReturnValue());
                            var casewrap = response.getReturnValue();
                            console.log('casewrap'+casewrap);
                            component.set("v.caseWrap",casewrap)
                            console.log(response.getReturnValue());
                            component.set("v.caseId", casewrap.cas.Id);
                            //component.set("v.caseIdDraft", casewrap.cas.Id);
                            
                            var RowItemList = component.get("v.caseList");
                            console.log(casewrap.disputeCaseList);
                            component.set("v.caseList", casewrap.disputeCaseList);
                            console.log(component.get("v.caseList"));
                            component.set("v.caseIdDraft", casewrap.cas.Id);
                            //Need To Chnage
                            
                            console.log('Draft status');
                            component.set("v.isTrueDraft", true);
                            
                            
                            //---
                            
                            var actionUserUpdate = component.get("c.updateUserProfileData");
                            if(component.get("v.targetPortal")=='Insurer')
                            {
                                console.log('@@@ user belongs to--->'+ component.get("v.targetPortal"));
                                
                                actionUserUpdate.setParams({
                                    "language":'--None--',
                                    "disability":'',
                                    "usr":component.get("v.userProfInfo"),
                                    
                                });
                            }
                            else if(component.get("v.targetPortal")=='Claimant')
                            {
                                console.log('@@@ user belongs to--->'+ component.get("v.targetPortal"));
                                if(component.get("v.isRepresentative"))
                                {
                                    actionUserUpdate.setParams({
                                        "language":'--None--',
                                        "disability":'',
                                        "usr":component.get("v.userProfInfo"),
                                        
                                    });
                                }
                                else
                                {
                                    actionUserUpdate.setParams({
                                        "language":component.get("v.language"),
                                        "disability":component.get("v.disabilityNotIndicated"),
                                        "usr":component.get("v.userProfInfo")
                                        
                                    });
                                }
                                
                            }
                            
                            console.log('================2');
                            actionUserUpdate.setCallback(this, function(response) {
                                var state = response.getState();
                                console.log('================3');
                                if(state === "SUCCESS"){
                                    console.log('User Updated Successfully');
                                    component.set("v.userProfInfo",response.getReturnValue());
                                }
                                console.log('================4');
                            });
                            
                            $A.enqueueAction(actionUserUpdate);
                            
                            console.log('================5');                         
                            //---
                            
                            
                            
                            var showAutoSave = component.find('showAutoSave');
                            $A.util.removeClass(showAutoSave, 'slds-hidden');
                        }
                    });
                    $A.enqueueAction(action);
                    
                    
                    
                    
                    if(btnSaveDraft != 'saveAsDraft')
                        component.doSaveMethod();
                }
            }), delay
        );
        
    },
    
    /* All Required Validation Check on Element Blur Event */
    
    validatePhoneNumber: function(component, event, helper) {
        helper.validatePhoneNumberHelper(component, event);
    }, 
    /* validateDispute : function(component, event, helper) {
        
        // Dispute Category and Dispute Type validation Check
        var isError = false;
        var caselist = component.get("v.caseList");
        for(var i =0; i< caselist.length; i++){
            console.log('inside for');
            console.log('case'+caselist[i].CTP_DisputeCategories__c);
            console.log('case'+caselist[i].CTP_DisputeTypes__c);
            if(caselist[i].CTP_DisputeCategories__c  == '--- None ---' && caselist[i].CTP_DisputeTypes__c == '--- None ---')
            {
                var errorMsg = component.find('disputeErrorMsgText');
                $A.util.removeClass(errorMsg, 'slds-hidden');
                isError=true;
            }
            else if(caselist[i].CTP_DisputeCategories__c  == '--- None ---' && caselist[i].CTP_DisputeTypes__c == '')
            {
                var errorMsg = component.find('disputeErrorMsgText');
                $A.util.removeClass(errorMsg, 'slds-hidden');
                isError=true;
            }
                else if(caselist[i].CTP_DisputeCategories__c  != '' && caselist[i].CTP_DisputeTypes__c == '--- None ---')
                {
                    var errorMsg = component.find('disputeErrorMsgText');
                    $A.util.removeClass(errorMsg, 'slds-hidden');
                    isError=true;
                }
                    else
                    {
                        var errorMsg = component.find('disputeErrorMsgText');
                        $A.util.addClass(errorMsg, 'slds-hidden');
                    }
            
        }
        
        if(isError){
            component.set("v.stage", "3");
            component.set("v.opendisputecomment", true);
            var disputecommentinput = component.find('disputecommentinput');
            $A.util.removeClass(disputecommentinput, 'slds-hidden');
            
        }
    },
    
    validateYourDispute : function(component, event, helper) {
        
        var disputeComment =component.find('disputecommentinput').get("v.value");
        
        
        console.log('disputeComment ---->'+disputeComment);
        var errorDivId = component.find("errorMsgText");
        if(disputeComment==''){
            $A.util.removeClass(errorDivId,"slds-hidden");
            
        }
        else
        { $A.util.addClass(errorDivId,"slds-hidden");
        }
        
    },*/
    
    validateYourLocation : function(component, event, helper) {
        helper.validateYourLocationHelper(component, event, helper);
        
    },
    validateYourDate : function(component, event, helper) {
        
        helper.validateYourDateHelper(component, event, helper);
        
    },
    
    validateYourName : function(component, event, helper) {
        
        helper.validateYourNameHelper(component, event, helper);
        
        
    },
    validateYourClaim : function(component, event, helper) {
        
        helper.validateYourClaimHelper(component, event, helper); 
    },
    
    validateIncorrectClaim : function(component, event, helper) {
        
        helper.validateIncorrectClaimHelper(component, event, helper); 
    },
    
    validateClaimNo : function(component, event, helper) {
        
        helper.validateClaimNoHelper(component, event, helper);  
        
    },
    
    validateDTAcc : function(component, event, helper) {
        
        helper.validateDTAccHelper(component, event, helper);   
    },
    validateDTLocAcc : function(component, event, helper) {
        
        helper.validateDTLocAccHelper(component, event, helper);   
        
    },
    
    validateInsurer : function(component, event, helper) {
        helper.validateInsurerHelper(component, event, helper);
    },
    
    validateOutcome : function(component, event, helper) {
        
        helper.validateOutcomeHelper(component, event); 
    },
    validateDisagreement : function(component, event, helper) {
        helper.validateDisagreementHelper(component, event); 
        
    },
    
    validateRepNumber: function(component, event, helper) {
        helper.validateClaimantPhoneHelper(component, event); 
        
    },
    validateRepClaimantAddress :function(component, event, helper) {
        helper.validateRepClaimantAddressHelper(component, event); 
        
    },
    validateEmail :function(component, event, helper) {
        helper.validateEmailHelper(component, event); 
        
    },
    /* All Required Validation Check on Element Blur Event */
    
    /* All Tool Tip Help Text Utility */
    
    displayYourDisputeHelp : function(component, event, helper){
        console.log('---------displayYourDisputeHelp------');
        var toggleText = component.find("displayDisputeHelp");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    displayYourDisputeHelpText : function(component, event, helper){
        console.log('---------displayYourDisputeHelp------');
        var toggleText = component.find("displayDisputeHelpIncorrect");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    
    displayDisputeCatgTypeHelp : function(component, event, helper){
        console.log('---------displayDisputeCatgTypeHelp------');
        var toggleText = component.find("ViewDisputeCatgTypeHelp");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    displayDisagreementHelp: function(component, event, helper) {
        var toggleText = component.find("disagreementHelp");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    internalReviewHelp : function(component, event, helper){
        console.log('----------------');
        var toggleText = component.find("internalReviewDateHelp");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    
    displayOutcomeHelp: function(component, event, helper) {
        var toggleText = component.find("OutcomeHelp");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    internlReviewDateHelp: function(component, event, helper) {
        console.log('icon should show');
        var toggleText = component.find("internalReviewDateHelp1");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    
    
    /* All Tool Tip Help Text Utility */
    
    /* All Event Handler Utility */    
    handleComponentEvent : function(component, event, helper) {
        var isurerAccount = event.getParam("getParam");
        console.log('@@@@@isurerAccount ::'+isurerAccount);
        component.set("v.Insurer_Name",isurerAccount);
        /*this.validateInsurer(component, event, helper);
        component.find("checkbox-1").set("v.checked",true);*/
        var errorDiv = component.find("InsurerNameMsg");
        $A.util.addClass(errorDiv, "slds-hidden");
        
    },
    
    setCheck: function(component, event, helper) {
        var relationship = event.getParam("getParam");
        console.log('@@@@@relationship ::'+relationship);
        component.set("v.relationData",relationship);
    }
    /* All Event Handler Utility */       
})