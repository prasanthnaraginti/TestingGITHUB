({
    //function to get today's date in dd/MM/yyyy format to set file upload date.
    todayDate: function(){
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();
        if(dd<10){
            dd='0'+dd;
        } 
        if(mm<10){
            mm='0'+mm;
        } 
        var today = dd+'/'+mm+'/'+yyyy;
        return today;
    },
    
    //function to get selected file to temporary array with blank categories and blank description
    addToUnCatArray : function(component, file){
        console.log(file.name);
        var pageName = component.get("v.pageName");
        var unCatFile;
        if(file && pageName == 'public homepage'){
            unCatFile = {
                'fileName' : file.name,
                'fileType' : file.type,
                'file': file,
                'description' : '',
                'category' : '',
                'subCategory' : '',
                'index' : component.get("v.uploadedUnCatFiles").length,
                'progressPercentage' : 0,
                'isUploaded' : false,
                'uploadingError' : false,
            };
        }else if(file && pageName == 'insurer portal'){
            unCatFile = {
                'fileName' : file.name,
                'file': file,
                'description' : '',
                'category' : '',
                'subCategory' : '',
                'index' : component.get("v.uploadedUnCatFiles").length,
                'progressPercentage' : 0,
                'isUploaded' : false,
                'uploadingError' : false,
            };
        }
        var uploadedUnCatFiles = component.get("v.uploadedUnCatFiles");
        uploadedUnCatFiles.push(unCatFile);
        component.set("v.uploadedUnCatFiles", uploadedUnCatFiles);
    },
    
    //function to call apex conmtroller to get AWS URL and then making ajax call to upload file.
    saveToServer : function(component, file, helper){
        var bar = jQuery('.bar');
        var percent = jQuery('.percent');
        var status = jQuery('#status');
        var objectName = component.get("v.objectName");
        console.log('inside helper---<>---file type is ===>'+file.file.type);
        var isValid = helper.validateFile(component, file);
        console.log(isValid);
        if(isValid){
            var params = component.get("v.uploadForm");
            params.name = file.file.name;
            params.caseId = component.get('v.parentId');
            if(component.get('v.parentId') == component.get('v.recordId'))
                params.caseItemId = '';
            else
                params.caseItemId = component.get('v.caseItemId') || '';
            console.log('Check for same case parent==>'+(component.get('v.parentId') != component.get('v.recordId')));
            params.dateLoaded = this.todayDate();
            params.description = file.description || '';
            params.category = file.category || '';
            params.tier2 = file.subCategory || '';
            console.log('file subcategory is -->'+file.subCategory);
            console.log('JSON PARAM -->'+JSON.stringify(params));// added by subhajit
            var action = component.get("c.addAttachmentAndGetSignedURL");
            action.setParams({
                attachmentJSON : JSON.stringify(params),
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === 'SUCCESS') {
                    console.log('Server call successful for'+file.file.name);
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
                        contentType: (!file.file.type || file.file.type ==='')? 'binary/octet-stream' : file.file.type,
                        headers: {'x-amz-server-side-encryption':'AES256'},
                        type: 'PUT',
                        data: file.file,
                        processData: false,
                        async: true,
                        
                        beforeSend: function() {
                            console.log('before send');
                            status.empty();
                            var percentVal = '0%';
                            bar.width(percentVal);
                            percent.html(percentVal);
                        },
                        xhr: function() {
                            var myXhr = $.ajaxSettings.xhr();
                            if(myXhr.upload){
                                myXhr.upload.addEventListener('progress',function(evt){
                                    if(evt.lengthComputable){
                                        //var progressBar = component.find(file.file.name+'progressBar').getElement();
                                        var max = evt.total;
                                        var current = evt.loaded;
                                        var Percentage = (current * 100)/max;
                                        console.log('upload status for '+file.file.name+' '+Math.ceil(Percentage)+'%');
                                        var id = '#attachSpan'+file.index;
                                        //console.log('generated id is --->'+id);
                                        //jQuery(id).attr('width',Math.ceil(Percentage)+'%');find('span:first')
                                        console.log(jQuery(id));
                                        var per = Math.ceil(Percentage)+'%';
                                        jQuery(id).css("width",per);
                                        
                                    }
                                });
                            }
                            return myXhr;
                        },
                        
                        success: function(result){
                            console.log('Ajax call successful for'+file.file.name);
                            console.log(result);
                            file.isUploaded = true;
                            file.uploadingError = false;
                            file.file = file.file;
                            console.log(file);
                            helper.setSubmitted(component, file);
                        },
                        error: function(err){ 
                            console.log('Ajax call failed for'+file.file.name);
                            file.isUploaded = false;
                            file.uploadingError = true;
                            file.file = file.file;
                            console.log(file);
                            helper.setSubmitted(component, file);
                            
                        }
                    });
                    console.info('after ajax');
                }else{
                    console.log('Server call failed for'+file.file.name);
                }
            });
            $A.enqueueAction(action);
        }else{
            
        }
    },

    //function to set status of file if it has been uploaded or not
    setSubmitted : function(component, file){
        var uploadedUnCatFiles = component.get("v.uploadedUnCatFiles");
        console.log('<<uploadedUnCatFiles_Inside setSubmitted>>>',uploadedUnCatFiles);
        console.log('<<uploadedUnCatFiles_Inside setSubmitted-file.index>>>',file.index);
        console.log('<<uploadedUnCatFiles_Inside file>>>',file);
        for(var i = 0; i < uploadedUnCatFiles.length; i++){
            if(uploadedUnCatFiles[i].index == file.index){
                uploadedUnCatFiles[i].file = file;
            }
        }
        
        if(uploadedUnCatFiles)
            console.log('<<Inside ##>>>');
            component.set("v.uploadedUnCatFiles", uploadedUnCatFiles);
        
        this.checkForAll(component);
    },
    
    //function to check whether all files have been uploaded or not and navigates to required page or refresh the current page.
    checkForAll : function(component){
        var uploadedUnCatFiles = component.get("v.uploadedUnCatFiles");
        var allUploaded = true;
        
        console.log('<<Inside ##checkForAll>>>');
        
        for(var i = 0; i< uploadedUnCatFiles.length; i++){
            if(!uploadedUnCatFiles[i].isUploaded){
                console.log('<<Inside ##uploadedUnCatFiles[i].isUploaded>>>',uploadedUnCatFiles[i].isUploaded);
                allUploaded = false;
            }
        }
        console.log('<<<uploadedUnCatFiles.length>>',uploadedUnCatFiles.length);
        console.log('<<<allUploaded>>',uploadedUnCatFiles.length);
        
        var replyPortal = component.get("v.replyPortal");
        var internalPortal = component.get("v.internalPortal");
        console.log("before navigating, internalPortal is ==>"+internalPortal);
        console.log("before navigating, replyPortal is ==>"+replyPortal);
		
		if(internalPortal && internalPortal == true){
            /*var evt1 = $A.get("e.force:refreshView");
            console.log('<<<evt1>>>',evt1);
            console.log('evt1 url is'+evt1.getParam("url"));
            evt1.fire(); */
            //$A.get('e.force:refreshView').fire();
            window.location.reload();
            component.set("v.uploadedUnCatFiles","[]");
        }
        else if(replyPortal && replyPortal == true){
            //$A.get("e.force:refreshView").fire();
            window.location.reload();
        }else if(allUploaded || uploadedUnCatFiles.length == 0){
            /*var evt = $A.get("e.force:navigateToURL");
            console.log('<<<<evt>>>',evt);
            if (evt) {
                evt.setParams({
                    "url": '/thankyou?parentId=' + component.get("v.parentId"),
                    "isredirect": true,
                });
                console.log('evt url is'+evt.getParam("url"));
                evt.fire();
            }*/
        }
    },

    //function to validate file and its related categories and sub-categories, if values are populated properly or not.
    validateFile : function(component, file){
        var pageName = component.get("v.pageName");
        var isValid = true;
        if(pageName == 'insurer portal'){
            if(!(file.category && file.category != '')){
                console.log('category not defines');
                isValid = false;
                var catId = '#category'+file.index;
                var catTextId = '#categoryErrorText'+file.index;
                $(catId).addClass("slds-has-error");
                $(catTextId).removeClass("displayNone");
                //var catElement = component.find(catId);
                //$A.util.addClass(catElement, 'sdls-has-error');
            }
            if(!(file.subCategory && file.subCategory != '')){
                console.log('subCategory not defines');
                isValid = false;
                var subCatId = '#subCategory'+file.index;
                var subCTextId = '#subCategoryErrorText'+file.index;
                $(subCatId).addClass("slds-has-error");
                $(subCTextId).removeClass("displayNone");
                //var catElement = component.find(catId);
                //$A.util.addClass(catElement, 'sdls-has-error');
            }
        }
        return isValid;
    }
})