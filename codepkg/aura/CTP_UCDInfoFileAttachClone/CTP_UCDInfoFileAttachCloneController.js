({
    doInit : function(component, helper, event){
        var attachmentWrapper = new Array();
        component.set("v.AttachmentWrapper",attachmentWrapper);
        var uploadedUnCatFiles = new Array();
        component.set("v.uploadedUnCatFiles",uploadedUnCatFiles);
        console.log(window.location.pathname);
        if(window.location.pathname == '/c/CTP_UCDInfoFileAttchmentCloneApp.app'){
            component.set("v.pageName","insurer portal");
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
    },
    fileButtonClicked : function(component, event, helper){
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
    showfile: function(component, event, helper) {
        //var fileInput = component.find("fileInput").getElement();
        var files = jQuery('#fileInput').prop("files");
        var file = files[0];
        helper.addToUnCatArray(component, file);
        //console.log(component.get("v.uploadedUnCatFiles"));
        //var fileName = f.name;
       /* var params = component.get("v.uploadForm");
        params.name = file.name;
        params.caseId = component.get('v.parentId');
        params.caseItemId = component.get('v.caseItemId') || '';
        params.dateLoaded = helper.todayDate();*/
        /*var r = new FileReader();
        jQuery('#backdrop').addClass('slds-backdrop--open');
        jQuery('#progressBarModal').addClass('slds-fade-in-open');
        jQuery('#myModalProgressBar').addClass('slds-fade-in-open');
        jQuery('#myModalProgressBar').removeClass('slds-hidden');
        helper.startProgressBar(component, helper);*/
        //var action = component.get("c.addAttachmentAndGetSignedURL");
        /*var contents = e.target.result;
            console.log('======================');
            var wrapper = {
                //'link' : 'https://google.com?q='+fileName,
                'content' : contents,
                //'name' : fileName,
                'description' : component.get("v.description"),
                //'caseId' : component.get("v.caseId"),
                'author' : component.get("v.author"),
                'typeName' : file.type,
                'dateOfInsert' : component.get("v.insertDate"),
                'index' : component.get("v.AttachmentWrapper").length,
            };
            var wrapperArray = component.get("v.AttachmentWrapper");
            wrapperArray.push(wrapper);
            component.set("v.AttachmentWrapper",wrapperArray);*/
        /*action.setParams({
            attachmentJSON : JSON.stringify(params),
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state is-->'+state);
            if (state === 'SUCCESS') {
                component.set('v.uploadForm', {
                    'internalAuthor': '',
                    'decisionSentDate': '',
                    'internalReviewer': '',
                    'author': '',
                    'dateOfDocument': '',
                    'fromDateCorrespondance': '',
                    'toDateCorrespondance': '',
                    'description': '',
                    'externallyVisible': ''
                });
                console.log('URl is --->'+JSON.parse(response.getReturnValue()).saveURL);
                jQuery.ajax({
                    url: JSON.parse(response.getReturnValue()).saveURL,
                    contentType: (!file.type || file.type ==='')? 'binary/octet-stream' : file.type,
                    headers: {'x-amz-server-side-encryption':'AES256'},
                    type: 'PUT',
                    data: file,
                    processData: false,
                    async: true,
                    success: function(result){
                        console.log('Ajax call successful');
                        console.info(result);
                    },
                    error: function(err){ console.log(err); }
                });
                console.info('after ajax');
            }
        });
        $A.enqueueAction(action);*/
        
    },
    addAttachment : function(component, event, helper){
        var fileInput = component.find("file").getElement();
        var file = fileInput.files[0];
        var fileName = component.get("v.targetFile").name;
        var r = new FileReader();
        r.onload = function(e) {
            var contents = e.target.result;
            /*var base64Mark = 'base64,';
            var dataStart = contents.indexOf(base64Mark) + base64Mark.length;
            var fileContents = contents.substring(dataStart);
            console.log(contents.length);
            console.log(fileContents.length);*/
            component.set("v.fileName",fileName);
            component.set("v.content", contents);
            var wrapper = {
                'link' : 'https://google.com?q='+fileName,
                'content' : contents,
                'name' : fileName,
                'description' : component.get("v.description"),
                'caseId' : component.get("v.caseId"),
                'author' : component.get("v.author"),
                'typeName' : file.type,
                'dateOfInsert' : component.get("v.insertDate"),
                'index' : component.get("v.AttachmentWrapper").length,
            };
            var wrapperArray = component.get("v.AttachmentWrapper");
            wrapperArray.push(wrapper);
            console.log(wrapper);
            component.set("v.AttachmentWrapper",wrapperArray);
            component.set("v.isTrue",false);
        };
        r.onerror = function(e){
            console.log('error thrown');
        };
        r.readAsDataURL(file);
    },
    submitfiles : function(component, event, helper){
        var uploadedUnCatFiles = component.get("v.uploadedUnCatFiles");
        for(var i =0; i< uploadedUnCatFiles.length; i++){
            helper.saveToServer(component, uploadedUnCatFiles[i]);
        }
    },
    Cancel : function(component, event, helper){
        component.find("file").getElement().value='';
        component.set("v.isTrue",false);
    },
    removeAttachment : function(component, event, helper){     
        var uploadedUnCatFiles = component.get("v.uploadedUnCatFiles");    
        var uploadedUnCatFilesTemp = new Array();
        var index = 0;
        for(var i = 0; i < uploadedUnCatFiles.length; i++){
            if(uploadedUnCatFiles[i].index != event.target.id){
				uploadedUnCatFiles[i].index = index++;
                uploadedUnCatFilesTemp.push(uploadedUnCatFiles[i]);
        }
        
    }
        component.set("v.uploadedUnCatFiles",uploadedUnCatFilesTemp);
        console.log(uploadedUnCatFilesTemp);
        console.log(component.get("v.uploadedUnCatFiles"));        
    }
})