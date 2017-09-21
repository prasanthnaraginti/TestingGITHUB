({
    // function to initialize component attributes. To check URL and to check which page is this.
    doInit : function(component, helper, event){
        var attachmentWrapper = new Array();
        //component.set("v.AttachmentWrapper",attachmentWrapper);
        var uploadedUnCatFiles = new Array();
        component.set("v.uploadedUnCatFiles",uploadedUnCatFiles);
        console.log('Location PathName is ==>'+window.location.pathname + ' CaseId :: -> '+component.get("v.caseId"));
        if(window.location.pathname.includes("/public/s") && !(window.location.pathname.includes("/public/s/caseitem/")) && !(window.location.pathname.includes("public/s/replytodro"))){
            console.log('---inside if block---');
            /*var parentId = window.location.href.split("?")[1].substring(9,24);
            console.log("parentId is -->"+ parentId);
            if(parentId && (parentId.length == 15 || parentId.length == 18)){*/
                component.set("v.parentId", component.get("v.caseId"));
            /* }*/
            component.set("v.pageName","public homepage");
            component.set("v.replyPortal", false);
        }else if(window.location.pathname.includes("/insurer/s/caseitem/") || window.location.pathname.includes("/assessor/s/caseitem") || window.location.pathname.includes("/public/s/caseitem/")){
            // if(window.location.pathname.includes("/assessor/s/attachdocument")){
                // component.set("v.recordId",window.location.href.split('=')[1]);
            // }
            var parentId;
            var recordId = component.get("v.recordId");
            console.log(recordId);
            
            if(recordId && (recordId.length == 15 || recordId.length == 18)){
                component.set("v.isForceRecord", true);
                component.set("v.caseItemId", recordId);
            }
            var action = component.get("c.getParentCaseId");
            action.setParams({
                recordId : component.get("v.recordId"),
            })
            action.setCallback(this, function(response){
                var state = response.getState();
                console.log(state);
                parentId = response.getReturnValue();
                console.log('@@@@@@ParentId-->'+parentId);
                component.set("v.parentId", parentId);
                component.set("v.pageName","insurer portal");
                component.set("v.replyPortal", true);
            });
            $A.enqueueAction(action);
            console.log('inside else pathname found for insurer portal caseitem detail page');
            console.log(component.get("v.isForceRecord"));
            console.log("parentId is -->"+ parentId);
            
            component.set("v.pageName","insurer portal");
            component.set("v.replyPortal", true);
        }else if(window.location.pathname.includes("/insurer/s/") && !(window.location.pathname.includes("/insurer/s/caseitem/"))){
            
            /*var parentId = window.location.href.split("?")[1].substring(9,24);
            if(parentId && (parentId.length == 15 || parentId.length == 18)){*/
               component.set("v.parentId", component.get("v.caseId"));
            // }
            component.set("v.pageName","insurer portal");
            component.set("v.replyPortal", false);
        }else if(window.location.href.includes('/one/one.app')){
            console.log("it is internal page");
            var parentId;
            var recordId = component.get("v.recordId");
            console.log('record id-->'+recordId);
            console.log('starts with 500=====>'+!(recordId.startsWith('500')));
            if(recordId && (recordId.length == 15 || recordId.length == 18) && !(recordId.startsWith('500'))){
                component.set("v.isForceRecord", true);
                component.set("v.caseItemId", recordId);
            }
            var action = component.get("c.getParentCaseId");
            action.setParams({
                'recordId' : component.get("v.recordId"),
            })
            action.setCallback(this, function(response){
                var state = response.getState();
                console.log(state);
                parentId = response.getReturnValue();
                console.log('@@@@@@ParentId-->'+parentId);
                component.set("v.parentId", parentId);
                component.set("v.pageName","public homepage");
                component.set("v.replyPortal", false);
                component.set("v.internalPortal", true);
                console.log("internalPortal==>"+component.get("v.internalPortal"));
            });
            $A.enqueueAction(action);
        }else if(window.location.pathname.includes("public/s/replytodro") ){
            console.log('inside dro reply'+component.get("v.caseItemIdReply"));
            console.log('============'+component.get("v.caseItemIdReply"));
            component.set("v.parentId", component.get("v.caseId"));
            component.set("v.pageName","public homepage");
            component.set("v.replyPortal", false);
            component.set("v.caseItemId",component.get("v.caseItemIdReply"));
            component.set("v.recordId",component.get("v.caseItemIdReply"));
            
        }
        var categories = ['','Application Documents','SIRA documents','Medical information','Occupational rehabilitation services','Employment','Legal','Surveillance','Correspondence','Expenses'];
        component.set("v.categories",categories);
        
        var ApplicationDocumentsSubCategoryTypes = ["","Claim form/documents","Submissions","Obvious error application","Notification of insurer’s decision on internal review form","Internal review decision notice","Stay letter","Acknowledgement letter of application for internal review by insurer","Application for internal review by insurer"];
        component.set("v.ApplicationDocumentsSubCategoryTypes",ApplicationDocumentsSubCategoryTypes);
        var SIRADocumentsSubCategoryTypes = ["","Findings and recommendations on merit review by SIRA","Previous SIRA certificate or decision","Assessment Conference Report","Preliminary Conference Report"];
        component.set("v.SIRADocumentsSubCategoryTypes",SIRADocumentsSubCategoryTypes);
        var MedicalInformationSubCategoryTypes = ["","Treating doctor/specialist report","Treating doctor/specialist notes","Hospital records","Ambulance records","Physiotherapy records","Medical imaging reports","Certificate of capacity","Neuropsychologist report","Independent medical examination report","Injury management consultation/review report","Functional assessment/Occupational Therapist report","Joint medico-legal report","Vocational assessment report"];
        component.set("v.MedicalInformationSubCategoryTypes",MedicalInformationSubCategoryTypes);
        var OccupationalRehabilitationSubCategoryTypes = ["","Suitable duties plan","Return to work goals","Return to work plan","Vocational Assessment report","Labour market analysis report","Earning capacity assessment report","NTS approval/ sign-off suitable employment options","Progress report","Closure report","Job seeking report/plan","Job seeking logs","Injury management plan","Section 53 documents","Workplace assessment","Worktrial progress report","Worktrial closure report","Case conference report","Transferable skills analysis report","Rehab provider referral"];
        component.set("v.OccupationalRehabilitationSubCategoryTypes",OccupationalRehabilitationSubCategoryTypes);
        var EmploymentSubCategoryTypes = ["","Work capacity decision notice ","Fair notice","PIAWE form","Employment contract","Employment offer/letter of employment","Employment Fair Work Instrument","Payslips/Payroll advice","Position description","Offer/ withdrawal of suitable duties","Termination letter","PAYG summary","Tax return","Bank statements","Business activity statement","Business profit/loss statement","Log book/ work orders"];
        component.set("v.EmploymentSubCategoryTypes",EmploymentSubCategoryTypes);
        var LegalSubCategoryTypes = ["","Police report","Statutory declaration","Sworn statement/affidavit","Bio mechanical assessment report","Schedule of damages","Legal reports","Irrevocable authority","Subpoena","Court/Tribunal Orders","Birth Certificate or Passport","Australian citizenship or permanent residency","Death certificate","Guardianship order or similar","Lifetime Care & Support documentation","Worker’s Compensation documentation"];
        component.set("v.LegalSubCategoryTypes",LegalSubCategoryTypes);
        var SurveillanceSubCategoryTypes = ["","Surveillance footage","Surveillance report"];
        component.set("v.SurveillanceSubCategoryTypes",SurveillanceSubCategoryTypes);
        var CorrespondenceSubCategoryTypes = ["","Letters – General","Letter declining indemnity","Insurer liability notice","Request for particulars","Photos","File notes","Emails"];
        component.set("v.CorrespondenceSubCategoryTypes",CorrespondenceSubCategoryTypes);
        var ExpensesSubCategoryTypes = ["","Funeral expenses","Legal costs","Treatment costs"];
        component.set("v.ExpensesSubCategoryTypes",ExpensesSubCategoryTypes);
                                             
        /*initializing wrapper to upload file*/
        
        component.set('v.uploadForm', {
            'internalAuthor': '',
            'decisionSentDate': '',
            'internalReviewer': '',
            'author': '',
            'dateOfDocument': '',
            'fromDateCorrespondance': '',
            'toDateCorrespondance': '',
            'description': '',
            'externallyVisible': false,
            'category': '',
            'tier2': '',
            'tier3':''
        });
    },

    // function to open popup box where user can select files.
    fileButtonClicked : function(component, event, helper){
        var isForceRecord = component.get("v.isForceRecord");
        var pageName = component.get("v.pageName");
        if(isForceRecord && pageName && pageName === "insurer portal"){
            //var parentId = component.get("v.simpleRecord.Case__c");
            var parentId = component.get("v.parentId");// added by subhajit
            component.set("v.parentId", parentId);
        }
        component.set('v.uploadForm', {
            'internalAuthor': '',
            'decisionSentDate': '',
            'internalReviewer': '',
            'author': '',
            'dateOfDocument': '',
            'fromDateCorrespondance': '',
            'toDateCorrespondance': '',
            'description': '',
            'externallyVisible': false,
            'category': '',
            'tier2': '',
            'tier3':''
        });
        var fileElement = component.find("fileInput").getElement();
        fileElement.value = '';
        fileElement.click();
    },

    // function to add selected files to a temporary array.
    showfile: function(component, event, helper) {
        //var fileInput = component.find("fileInput").getElement();
        var files = jQuery('#fileInput').prop("files");
        console.log(files.length);
        for(var i= 0; i < files.length; i++){
        var file = files[i];
        helper.addToUnCatArray(component, file);
        
        }
    },
    
    //controller function to submit files for validation and then to server
    submitfiles : function(component, event, helper){
        //$('#'+event.currentTarget.id).attr("disabled",true);
        var uploadedUnCatFiles = component.get("v.uploadedUnCatFiles");
        console.log('<<<uploadedUnCatFiles>>',uploadedUnCatFiles);
        var isValid = true;
        var allValid = true;
        var files=[];
        for(var i =0; i< uploadedUnCatFiles.length; i++){
            files.push({ fileName: uploadedUnCatFiles[i].fileName, category: uploadedUnCatFiles[i].category});
            localStorage.setItem('Attachment', JSON.stringify(files));
            isValid = helper.validateFile(component, uploadedUnCatFiles[i]);
            console.log('<<<isValid>>',isValid);            
            if(!isValid){
                allValid = false;
            }
            
        }
        if(uploadedUnCatFiles.length == 0){
            console.log('<<<uploadedUnCatFiles.length>>',uploadedUnCatFiles.length);   
            helper.checkForAll(component);
        }
        console.log('<<<allValid>>',allValid);  
        if(allValid){
            component.set("v.uploadBtnDisabled", true);
            console.log('<<<Inside here0>>');  
            for(var i =0; i< uploadedUnCatFiles.length; i++){
                console.log('<<<Inside here1>>');  
                helper.saveToServer(component, uploadedUnCatFiles[i], helper);
            }
        }else{
            console.log('did not try to save files');
        }
    },
    //controller function to cancel the operation
    Cancel : function(component, event, helper){
        component.find("file").getElement().value='';
        component.set("v.isTrue",false);
    },

    //controller function to remove files from temporary array
    removeAttachment : function(component, event, helper){     
        var uploadedUnCatFiles = component.get("v.uploadedUnCatFiles");    
        var uploadedUnCatFilesTemp = new Array();
        var index = 0;
        var files=[];
        console.log('target id is -->'+ event.target.id);
        if(uploadedUnCatFiles.length == 1){
            component.set("v.uploadedUnCatFiles",uploadedUnCatFilesTemp);
            localStorage.removeItem('Attachment');
        }else{
      for(var i = 0; i < uploadedUnCatFiles.length; i++){;
            if(uploadedUnCatFiles[i].index != event.target.id){
                uploadedUnCatFiles[i].index = index++;
                uploadedUnCatFilesTemp.push(uploadedUnCatFiles[i]);
                files.push({ fileName: uploadedUnCatFiles[i].fileName, category: uploadedUnCatFiles[i].category});
                localStorage.setItem('Attachment', JSON.stringify(files));
            }
        }
        component.set("v.uploadedUnCatFiles",uploadedUnCatFilesTemp);
        console.log(uploadedUnCatFilesTemp);
        console.log(component.get("v.uploadedUnCatFiles"));  
        }
    },

    //controller function to validate if category is populated or not
    categoryChanged : function(component, event, helper){
        console.log(event.getSource().get("v.name"));
        var selectName = event.getSource().get("v.name");
        var selectedValue = event.getSource().get("v.value");
        var idBuilderArray = selectName.split("Select");
        var parentDivId = "#category"+idBuilderArray[1];
        var errorTextId = "#categoryErrorText"+idBuilderArray[1];
        if(selectedValue && selectedValue != ''){
            $(parentDivId).removeClass("slds-has-error");
            $(errorTextId).addClass("slds-hidden");
            
        }else{
            $(parentDivId).addClass("slds-has-error");
            $(errorTextId).removeClass("slds-hidden");
        }
    },

    //controller function to validate if sub-category is populated or not
    subCategoryChanged : function(component, event, helper){
        console.log(event.getSource().get("v.name"));
        var selectName = event.getSource().get("v.name");
        var selectedValue = event.getSource().get("v.value");
        var idBuilderArray = selectName.split("Select");
        var parentDivId = "#subCategory"+idBuilderArray[1];
        var errorTextId = "#subCategoryErrorText"+idBuilderArray[1];
        if(selectedValue && selectedValue != ''){
            $(parentDivId).removeClass("slds-has-error");
            $(errorTextId).addClass("slds-hidden");
            
        }else{
            $(parentDivId).addClass("slds-has-error");
            $(errorTextId).removeClass("slds-hidden");
        }
    },

    //controller function to show and hide help text
    displayHelp : function(component, event, helper){
        if(event.type === "mouseover"){
            $("#fileAttachmentHelp").css('display','inline-block');
        }else if(event.type === "mouseout"){
            $("#fileAttachmentHelp").css('display','none');
        }
    },
    disableMe : function(component, event, helper) {
        $('#'+event.currentTarget.id).attr("disabled",true);
    }
})