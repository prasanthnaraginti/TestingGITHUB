({
    doInit: function(component, event, helper) {
        
        var action = component.get("c.getUcddetails");
        action.setCallback(this, function(response) {
            var state = response.getState();
            //console.log('=-------------'+state);
            //console.log('==========+'+response.getReturnValue().Claimnumber);
            component.set("v.UCDResponse", response.getReturnValue());
            var caseId = component.get("v.ClaimnumberNew");
            //console.log('caseId'+caseId);
            
        });
        
        $A.enqueueAction(action);
    },
    
    confimReview: function(component, event, helper) {
        
        var selected = event.getSource().get("v.text");
        var cmpTargetdrop = component.find('confirmReviewchoiceNew');
        if(selected === 'Yes'){
            $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
        }else if(selected === 'No'){
            $A.util.addClass(cmpTargetdrop, 'slds-hidden');
        }
        
    },
    showinputDate: function(component, event, helper) {
        var selected = event.getSource().get("v.text");
        var cmpTargetdrop = component.find('inputDateNew');
        if(selected === 'Yes'){
            $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
        }else if(selected === 'No'){
            $A.util.addClass(cmpTargetdrop, 'slds-hidden');
            var textareaDiv = component.find('disagreementReasonNew');
            $A.util.addClass(textareaDiv, 'slds-hidden');
        }
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
    focusIsthereD1 : function(component, event, helper){
        console.log('inside focus 1');
        var date2Div = component.find("date1");
        // $A.util.addClass("slds-hidden", date2Div);
    },
    focusIsthereD2 : function(component, event, helper){
        console.log('inside focus 2');
        var date2Div = component.find("date2");
        //$A.util.addClass("slds-hidden", date2Div);
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
    validateD1 : function(component, event, helper) {
        var d1 = component.get("v.ReviewCompletion");
        console.log('Date 1 is ---->'+d1);
        if(!d1){
            var date1Div = component.find("date1ErrorMsg");
            $A.util.removeClass(date1Div,"slds-hidden");
            var textareaDiv = component.find('disagreementReasonNew');
            $A.util.addClass(textareaDiv,"slds-hidden");
        }else{
            var date1Div = component.find("date1ErrorMsg");
            $A.util.addClass(date1Div,"slds-hidden");
        }
        var d2 = component.get("v.ReviewRecept");
        if(d2){
            component.validateDate2();
        }
        
    },
    validateD2 : function(component, event, helper) {
        var d2 = component.get("v.ReviewRecept");
        console.log('Date 2 is ---->'+d2);
        if(!d2){
            var date2Div = component.find("date2ErrorMsg1");
            $A.util.removeClass(date2Div,"slds-hidden");
            var date2DivGrt = component.find("date2ErrorMsg2");
            $A.util.addClass(date2DivGrt,"slds-hidden");
        }else{
            var date2Div = component.find("date2ErrorMsg1");
            $A.util.addClass(date2Div,"slds-hidden");
            var d1 = component.get("v.ReviewCompletion");
            if(d1>=d2){
                var date2DivGrt = component.find("date2ErrorMsg2");
                $A.util.removeClass(date2DivGrt,"slds-hidden");
                var textareaDiv = component.find('disagreementReasonNew');
                $A.util.addClass(textareaDiv,"slds-hidden");
            }else{
            	if(d1 && d2){
                var date2DivGrt = component.find("date2ErrorMsg2");
                $A.util.addClass(date2DivGrt,"slds-hidden");
                var textareaDiv = component.find('disagreementReasonNew');
                $A.util.removeClass(textareaDiv,"slds-hidden");
                }else{
                	var textareaDiv = component.find('disagreementReasonNew');
                	$A.util.addClass(textareaDiv,"slds-hidden");
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
        var disagreementReason = component.get("v.disagreementReason");
        console.log(disagreementReason);
        if(disagreementReason){
            var areaErrorMsg = component.find('textareaErrorMsg');
            $A.util.addClass(areaErrorMsg, 'slds-hidden');
            var cmpTargetdrop = component.find('myModal');
            $A.util.toggleClass(cmpTargetdrop, 'slds-hidden');
            component.set("v.isTrue", "true");
        }else{
            console.log('Errror msg');
            var areaErrorMsg = component.find('textareaErrorMsg');
            $A.util.removeClass(areaErrorMsg, 'slds-hidden');
        }
        /*var cmpproceedApp=component.find('proceedAppNew');
        	$A.util.addClass(cmpproceedApp,'slds-hidden');*/
    },
    
    Submit: function(component, event, helper) {
        var cmpProceed = component.find('proceedBtn');
        $A.util.toggleClass(cmpProceed, 'slds-hidden');
        
    },
    
    createCase: function(component, event, helper) {
        console.log('inside method createCase');
        var ReviewCompletion = JSON.stringify(component.get("v.ReviewCompletion"));
        var ReviewRecept = JSON.stringify(component.get("v.ReviewRecept"));
        var ClaimNumber = component.get("v.ClaimnumberNew");
        var disagreementReason = component.get("v.disagreementReason");
        var ucdObj = JSON.stringify(component.get("v.UCDResponse"));
        var action = component.get("c.createCaseRecord");
        console.log(ReviewCompletion+'<====>'+ReviewRecept);
        action.setParams({
            "reviewCompletion": ReviewCompletion,
            "reviewRecept": ReviewRecept,
            "ClaimNumber": ClaimNumber,
            "disagreementReason" : disagreementReason,
            "ucdObj" : ucdObj
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("State is-->"+state);
            if (state === "SUCCESS"){
                console.log(response.getReturnValue());
                component.set("v.caseId", response.getReturnValue());
                component.set("v.caseCreated", true);
                caseCreated
                /*var evt = $A.get("e.force:navigateToURL");
                if (evt) {
                    evt.setParams({
                        "url": '/thankyou?caseNumber=' + component.get("v.CaseNumber"),
                        "isredirect": true,
                    });
                    console.log('evt url is'+evt.getParam("url"));
                    evt.fire();
                }*/
            }
        });
        $A.enqueueAction(action);
    },
    
    modalCancel: function(component, event, helper) {
        var cmpTargetdrop = component.find('myModal');
        $A.util.addClass(cmpTargetdrop, 'slds-hidden');
        component.set("v.isTrue", "false");
    },
    displayDisagreementHelp: function(component, event, helper) {
        var toggleText = component.find("disagreementHelp");
        $A.util.toggleClass(toggleText, "slds-hidden");
    },
    internalReviewHelp : function(component, event, helper){
        var toggleText = component.find("internalReviewHelp");
        $A.util.toggleClass(toggleText, "slds-hidden");
    }
    
})