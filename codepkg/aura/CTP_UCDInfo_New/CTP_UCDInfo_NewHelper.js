({
    getRepRelationData : function(component, event){
        
        var action = component.get("c.getRepRelationData");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('getRepRelationData =-------------'+state);
            component.set("v.relationOptions", response.getReturnValue());
            localStorage.setItem("getIds", JSON.stringify(response.getReturnValue()));
        });
        
        $A.enqueueAction(action);
    },
    
    getUserName : function(component, event){
        
        var action = component.get("c.getUserName");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('Logged In User =-------------'+state);
            component.set("v.Claim_name", response.getReturnValue());
            
        });
        
        $A.enqueueAction(action);
    },
    getUserProfileInfo : function(component, event) {
        console.log("getUserProfileInfo is called-->");
        var action = component.get("c.getUserProfileData");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("State for getUserProfileData-->"+state);
            if(state === "SUCCESS")
            { 
                
                component.set("v.userProfInfo", response.getReturnValue()); 
                console.log('@@@@ userProfInfo -->'+JSON.stringify(response.getReturnValue()));
                var street='';
                var city ='';
                var state='';
                for(var data in response.getReturnValue())
                    {
                         console.log('@@@ fddf--> '+data);
                         console.log('@@@ fddf--> '+response.getReturnValue()[data]);
                         if(data=='Street')street = response.getReturnValue()[data];
                         if(data=='City')city = response.getReturnValue()[data];
                         if(data=='State')state = response.getReturnValue()[data];
                		
                    }
               
                var address =  street+ ' ' + city +' '+state; 
                component.set("v.applicatantAddress",address);
            }
            
            /* for(var usrInfo in response.getReturnValue())
            {
                var interpreter = usrInfo.CTP_Interpreter__c;
                var disablility = usrInfo.CTP_HaveDisability__c;
                
                console.log('@@@@@@@ after Stringify ::: '+ JSON.stringify(response.getReturnValue()) );
                console.log("usrInfo.CTP_Interpreter__c-->"+usrInfo.CTP_Interpreter__c);
                console.log("usrInfo.CTP_HaveDisability__c-->"+usrInfo.CTP_HaveDisability__c);
                if(usrInfo.CTP_Interpreter__c =='--None--' || typeof interpreter==="undefined")
                    component.set("v.language",'Not Indicated'); 
                
                if(usrInfo.CTP_HaveDisability__c ==null || typeof disablility==="undefined" || usrInfo.CTP_HaveDisability__c =='')
                    component.set("v.disabilityNotIndicated",'Not Indicated');
            }*/
            
            
        });
        $A.enqueueAction(action);
    }, 
    
    getUserInterpreterPicklistInfo : function(component, event) {
        var action = component.get("c.getUserInterpreterData");
        var opts=[];
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("State for getUserInterpreterPicklistInfo-->"+state);
            if(state === "SUCCESS")
            {
                for(var i=0;i< response.getReturnValue().length;i++){
                    opts.push({ label: response.getReturnValue()[i], value: response.getReturnValue()[i]});
                }
                console.log('@@@@ options -->'+JSON.stringify(opts));
                component.set("v.interpreterOptions",opts); 
            }
            
            
            
        });
        $A.enqueueAction(action);
    },    
    
    getUCDInfo : function(component, event) {
        
        console.log('--- in getUCDInfo --');
        var portal = component.get("v.targetPortal");
        console.log('------portal'+portal);
        
        if(portal =='Insurer')
        {
            var claimNo = component.find("claimId").get("v.value");
            console.log('claimNo---> '+claimNo);
            if(claimNo=='987456')// DCR-344 For No Result
            {
                component.set("v.isFailure",true);
                component.set("v.isInsurer",true);
                component.set("v.isHardStop",false);
                
                if(localStorage.getItem("Msg")!=null)
                {
                    component.set("v.isNoResult",true);
                    
                    component.set("v.isTrueDraft", true);
                    
                    component.set("v.noResult","No records found. To continue, please enter the claims details below");
                    localStorage.removeItem("Msg");
                    this.createObjectData(component, event);
                    console.log('Inside do save................');
                    component.doSaveMethod();
                }
                
                
            }
            else
            {
                var action = component.get("c.getUcddetails");
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    console.log('getUcddetails =-------------'+state);
                    component.set("v.UCDResponse", response.getReturnValue()); 
                    component.doSaveMethod();
                    
                    
                });
                
                $A.enqueueAction(action);
            }    
        }
        else if(portal =='Claimant')
        {
            var claimNo = component.find("claimId").get("v.value");
            console.log('claimNo---> '+claimNo);
            if(claimNo=='987456')// DCR-344 For No Result
            {
                component.set("v.isFailure",true);
                // component.set("v.isOpenWhenClaimantLoad",false);
                //component.set("v.showDateofInsurerInternalReview",false);
                component.set("v.isTrueDraft",true);
                component.set("v.isHardStop",false);
                component.set("v.isClaimant",true);
                this.createObjectData(component, event);
                
                if(localStorage.getItem("Msg")!=null)
                {
                    component.set("v.isNoResult",true);
                    component.set("v.noResult",localStorage.getItem("Msg"));
                    localStorage.removeItem("Msg");
                }
                var action = component.get("c.getUserName");
                
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    console.log('Logged In User =-------------'+state);
                    component.set("v.Claim_name", response.getReturnValue());
                    
                });
                
                $A.enqueueAction(action);
            }
            else
            {	
                var action = component.get("c.getUcddetails");
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    console.log('getUcddetails =-------------'+state);
                    component.set("v.UCDResponse", response.getReturnValue()); 
                    console.log('getUcddetails =------------->'+JSON.stringify(response.getReturnValue()));
                    
                    component.doSaveMethod();
                    
                    
                });
                
                $A.enqueueAction(action);
            }    
        }
        
    },
    createObjectData: function(component, event) {
        console.log('inside create');
        // get the contactList from component and add(push) New Object to List  
        var RowItemList = component.get("v.caseList");
        console.log('RowItemList-------------'+RowItemList);
        RowItemList.push({"sobjectType": "Case","Status":"Draft","ParentId":"","CTP_DisputeCategories__c":"","RecordTypeId":"","CTP_DisputeTypes__c":""});
        // set the updated list to attribute (contactList) again   
        console.log("size of caseList\t"+component.get("v.caseList").length);
        component.set("v.caseList", RowItemList);
        console.log('----------------component.get("v.caseList")'+component.get("v.caseList"));
    },
    createObjectNoData: function(component, event) {
        console.log('inside create');
        // get the contactList from component and add(push) New Object to List  
        var RowItemList = component.get("v.caseList");
        RowItemList = [];
        // set the updated list to attribute (contactList) again    
        component.set("v.caseList", RowItemList);
    },
    
    validateFuturedate : function(component, event) {
        console.log('====validateFuturedate is called ===');
        var dtAcc = component.get("v.dtAcc");
        console.log(dtAcc);
        if(dtAcc){
            
            var today = new Date().getTime();
            dtAcc = dtAcc.split("-");
            dtAcc = new Date(dtAcc[0], dtAcc[1] - 1, dtAcc[2]).getTime();
            console.log(today);
            console.log(dtAcc);
            console.log((today - dtAcc));
            if((today - dtAcc) < 0)
                
            {
                var errorDiv = component.find("DateofaccidentFutureMsg");
                $A.util.removeClass(errorDiv, "slds-hidden");
                isError = true;
            }
            else
            {
                var errorDiv = component.find("DateofaccidentFutureMsg");
                $A.util.addClass(errorDiv, "slds-hidden");
            }
        }
        
        
    },
    
    openClaimDetailsEditHelper :function(component, event,helper)
    {
        console.log('------editdetails click----');
        var portal = component.get("v.targetPortal");
        console.log('------portal'+portal);
        component.set("v.isFailure",true);   
        if(portal =='Claimant'){
            component.set("v.isClaimant",true);
            helper.getUserName(component, event);
            component.set("v.dtAcc",component.get("v.UCDResponse.Dateofaccident"));
            component.set("v.dtLocAcc",component.get("v.UCDResponse.Locationofaccident"));
            var isurerAccount = component.get("v.UCDResponse.InsurerName");
            component.set("v.Insurer_Name",isurerAccount);
            
        }
        if(portal =='Insurer'){
            component.set("v.isInsurer",true);
            component.find("claimantName").set("v.value","");
        }  
    },
    
    editAddressHelper :function(component, event,helper) {
        console.log('------editAddress click----'); 
        var divId = component.find("AddressId");
        $A.util.addClass(divId,"div-inputlook");
        var textElement   = divId.getElement();
        textElement.contentEditable = true;
    },
    
    editPhoneHelper :function(component, event,helper) {
        console.log('------editPhone click----'); 
        var divId = component.find("phoneId");
        $A.util.addClass(divId,"div-inputlook");
        var textElement   = divId.getElement();
        textElement.contentEditable = true; 
    },
    /* All Validation Helper */ 
    validatePhoneNumberHelper :function(component, event) 
    {
        var phone =component.get("v.userProfInfo.Phone");
        console.log('Phone ---->'+phone);
        var errorValidNumID = component.find("errorValidNumID");
        var errorReqFieldID = component.find("errorReqFieldID");
        if(typeof phone == 'undefined'|| phone==''){
            $A.util.removeClass(errorReqFieldID,"slds-hidden");
            $A.util.addClass(errorValidNumID,"slds-hidden");
            component.set("v.IsError",true);
        }
        else
        { 
            $A.util.addClass(errorReqFieldID,"slds-hidden");
            component.set("v.IsError",false);
            var phoneno = /^\(?([0-9]{3})\)?[ ]?([0-9]{3})[ ]?([0-9]{4})$/; 
            if(phone.match(phoneno)) 
            {
                $A.util.addClass(errorValidNumID,"slds-hidden");
                component.set("v.IsError",false);
            }
            else
            {
                $A.util.removeClass(errorValidNumID,"slds-hidden");
                component.set("v.IsError",true);
            }
        }
        
    },
    validateClaimantPhoneHelper :function(component, event) 
    {
        var phone =component.get("v.repClaimantContactNumber");
        console.log('Phone ---->'+phone);
        var errorValidNumID = component.find("repContactNumberValid");
        var errorReqFieldID = component.find("repContactNumberMand");
        if(typeof phone == 'undefined'|| phone==''){
            $A.util.removeClass(errorReqFieldID,"slds-hidden");
            $A.util.addClass(errorValidNumID,"slds-hidden");
            component.set("v.IsError",true);
        }
        else
        { 
            $A.util.addClass(errorReqFieldID,"slds-hidden");
            component.set("v.IsError",false);
            var phoneno = /^\(?([0-9]{3})\)?[ ]?([0-9]{3})[ ]?([0-9]{4})$/; 
            if(phone.match(phoneno)) 
            {
                $A.util.addClass(errorValidNumID,"slds-hidden");
                component.set("v.IsError",false);
            }
            else
            {
                $A.util.removeClass(errorValidNumID,"slds-hidden");
                component.set("v.IsError",true);
            }
        }
        
    },
    validateRepClaimantAddressHelper :function(component, event){
        var address = component.get("v.repClaimantContactAddress");
        console.log('address ---->'+address);
        var addressDiv = component.find("repContactAddressMand");
        if(address ==null || address==''){
            
            console.log('address ---->'+address);
            $A.util.removeClass(addressDiv,"slds-hidden");
            component.set("v.IsError",true);
        }
        else
        {
            console.log('address ---->'+address);
            $A.util.addClass(addressDiv,"slds-hidden");
            component.set("v.IsError",false);
            
        }
    },
    validateEmailHelper :function(component, event)   {
        
        var emailAddr = component.get("v.repClaimantContactEmail");
        console.log('emailAddr ---->'+emailAddr);
        var emailAddrDiv = component.find("repClaimantContactEmail");
        if(emailAddr=='')
        {
            $A.util.addClass(emailAddrDiv,"slds-hidden");
            component.set("v.IsError",false);
            
        }
        else
        {
            var atpos = emailAddr.indexOf("@");
            var dotpos = emailAddr.lastIndexOf(".");
            if (atpos<1 || dotpos<atpos+2 || dotpos+2>=emailAddr.length) {
                $A.util.removeClass(emailAddrDiv,"slds-hidden");
                component.set("v.IsError",true);
            }
            else{
                
                $A.util.addClass(emailAddrDiv,"slds-hidden");
                component.set("v.IsError",false);
            }
            
            /*var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if(re.test(emailAddr))
            {
                $A.util.removeClass(emailAddrDiv,"slds-hidden");
                component.set("v.IsError",true);
            }
            else{
                
                $A.util.addClass(emailAddrDiv,"slds-hidden");
                component.set("v.IsError",false);
            }*/
        }
        
    },
    validateOutcomeHelper :function(component, event)   {
        var outcome = component.get("v.outcome");
        console.log('Outcome ---->'+outcome);
        var outcomeDiv = component.find("outcomeErrorMsg");
        if(outcome ==null || outcome==''){
            
            console.log('Outcome ---->'+outcome);
            $A.util.removeClass(outcomeDiv,"slds-hidden");
            component.set("v.IsError",true);
        }
        else
        {
            console.log('Outcome ---->'+outcome);
            $A.util.addClass(outcomeDiv,"slds-hidden");
            component.set("v.IsError",false);
            
        }
    },
    validateDisagreementHelper : function(component, event) {
        var disagreementReason = component.get("v.disagreementReason");
        console.log(disagreementReason);
        if(disagreementReason){
            var areaErrorMsg = component.find('textareaErrorMsg');
            $A.util.addClass(areaErrorMsg, 'slds-hidden');
            component.set("v.IsError",false);
            
            var cmpTargetdrop = component.find('myModal');
            $A.util.toggleClass(cmpTargetdrop, 'slds-hidden');
            component.set("v.isTrue", "false");
            component.set("v.isValidRow",false);
        }else{
            component.set("v.isValidRow",true);
            console.log('Errror msg');
            var areaErrorMsg = component.find('textareaErrorMsg');
            $A.util.removeClass(areaErrorMsg, 'slds-hidden');
            component.set("v.IsError",true);
        } 
        
    },
    
    validateYourLocationHelper : function(component, event, helper) {
        
        var loc = component.find("loc").get("v.value");
        var errorDivIdloc = component.find("LocationofaccidentMsg");
        if(loc==''){
            $A.util.removeClass(errorDivIdloc,"slds-hidden");
            component.set("v.IsError",true);
        }
        else
        { 
            $A.util.addClass(errorDivIdloc,"slds-hidden");
            component.set("v.IsError",false);
        }
    },
    validateYourDateHelper : function(component, event, helper) {
        
        console.log('====validateYourDate is called ===');
        var date1 = component.find("date1").get("v.value");        
        var errorDivIddate1 = component.find("DateofaccidentMsg");
        if(date1==''){
            $A.util.removeClass(errorDivIddate1,"slds-hidden");
            component.set("v.IsError",true);
        }
        else
        { 
            console.log('---inside else---');
            $A.util.addClass(errorDivIddate1,"slds-hidden");
            component.set("v.IsError",false);
        }
        
        
        helper.validateFuturedate(component, event); 
        
    },
    
    validateYourNameHelper : function(component, event, helper) {
        
        
        var claimantName = component.find("claimantName").get("v.value");        
        var errorDivIdclaimantName = component.find("Claim_nameMsg");
        if(claimantName==''){
            $A.util.removeClass(errorDivIdclaimantName,"slds-hidden");
            component.set("v.IsError",true);
            
        }
        else
        { 
            $A.util.addClass(errorDivIdclaimantName,"slds-hidden");
            component.set("v.IsError",false);
        }
        
        
    },
    validateYourClaimHelper : function(component, event, helper) {
        var claimNo = component.find("claimInputId").get("v.value");
        var errorDivIdclaimNo = component.find("ClaimnumberMsg");
        if(claimNo==''){
            $A.util.removeClass(errorDivIdclaimNo,"slds-hidden");
            component.set("v.IsError",true);
        }
        else
        { 
            $A.util.addClass(errorDivIdclaimNo,"slds-hidden");
            component.set("v.IsError",false);
        }
        
    },
    
    validateIncorrectClaimHelper : function(component, event, helper) {
        
        console.log('validateIncorrectClaim Called---->');
        var claimDetailsIncorrect = component.get("v.claimDetailsIncorrect");
        var claimDetailsIncorrectDetailsDiv = component.find("ClaimIncorrectTextAreaErrorMsg");
        var confirmReviewchoiceNew = component.find('confirmReviewchoiceNew');
        if(claimDetailsIncorrect ==null || claimDetailsIncorrect==''){
            
            console.log('claimDetailsIncorrect ---->'+claimDetailsIncorrect);
            $A.util.removeClass(claimDetailsIncorrectDetailsDiv,"slds-hidden");
            component.set("v.IsError",true);
        }
        else
        {
            
            console.log('claimDetailsIncorrect ---->'+claimDetailsIncorrect);
            $A.util.addClass(claimDetailsIncorrectDetailsDiv,"slds-hidden");
            component.set("v.IsError",false);
            $A.util.removeClass(confirmReviewchoiceNew, 'slds-hidden');
        }
    },
    
    
    
    validateClaimNoHelper : function(component, event, helper) {
        
        var claimId = component.get("v.ClaimnumberNew");
        if(!claimId){
            var errorDiv = component.find("ClaimnumberMsg");
            $A.util.removeClass(errorDiv, "slds-hidden");
            component.set("v.IsError",true);
        }
        else{
            
            var errorDiv = component.find("ClaimnumberMsg");
            $A.util.addClass(errorDiv, "slds-hidden");
            component.set("v.IsError",false);
        }
        
    },
    
    validateDTAccHelper : function(component, event, helper) {
        var dtAcc = component.get("v.dtAcc");
        if(!dtAcc){
            var errorDiv = component.find("DateofaccidentMsg");
            $A.util.removeClass(errorDiv, "slds-hidden");
            component.set("v.IsError",true);
        }
        else{
            console.log('inside else part-'+dtAcc);
            var errorDiv = component.find("DateofaccidentMsg");
            $A.util.addClass(errorDiv, "slds-hidden");
            component.set("v.IsError",false);
            console.log('---Before Future call---');
            
            var today = new Date().getTime();
            dtAcc = dtAcc.split("-");
            dtAcc = new Date(dtAcc[0], dtAcc[1] - 1, dtAcc[2]).getTime();
            console.log(today);
            console.log(dtAcc);
            console.log((today - dtAcc));
            if((today - dtAcc) < 0)
            {
                var errorDiv = component.find("DateofaccidentFutureMsg");
                $A.util.removeClass(errorDiv, "slds-hidden");
                component.set("v.IsError",true);
            }
            else
            {
                var errorDiv = component.find("DateofaccidentFutureMsg");
                $A.util.addClass(errorDiv, "slds-hidden");
                component.set("v.IsError",false);
            }
            
        }
        
    },
    validateDTLocAccHelper : function(component, event, helper) {
        var dtLocAcc = component.get("v.dtLocAcc");
        
        if(!dtLocAcc){
            var errorDiv = component.find("LocationofaccidentMsg");
            $A.util.removeClass(errorDiv, "slds-hidden");
            component.set("v.IsError",true);
        }
        else
        {
            var errorDiv = component.find("LocationofaccidentMsg");
            $A.util.addClass(errorDiv, "slds-hidden");
            component.set("v.IsError",false);
        }
        
    },
    
    validateInsurerHelper : function(component, event, helper) {
        console.log('@@@@@ calling validateInsurer' );
        var insurerName = component.get("v.Insurer_Name");
        
        if(!insurerName){
            console.log('@@@@@ inside if in validateInsurer' );
            var errorDiv = component.find("InsurerNameMsg");
            $A.util.removeClass(errorDiv, "slds-hidden");
            component.set("v.IsError",true);
        } 
        else
        {
            console.log('@@@@@ inside else in validateInsurer' );
            var errorDiv = component.find("InsurerNameMsg");
            $A.util.addClass(errorDiv, "slds-hidden");
            component.set("v.IsError",false);
        }
    }
    /* All Validation Helper */   
})