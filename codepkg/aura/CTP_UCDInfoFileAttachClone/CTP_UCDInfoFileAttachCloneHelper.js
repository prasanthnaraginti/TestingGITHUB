({
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
        return '27/09/1994';
        //return today;
    },
    startProgressBar: function(component, helper) {
        var timer = window.setTimeout(
            $A.getCallback(function() {
                var progressPercentage = component.get('v.progressPercentage');
                if (parseInt(progressPercentage) < 99) {
                    component.set('v.progressPercentage', progressPercentage + 1);
                    helper.startProgressBar(component, helper);
                }
                else {
                    jQuery('#backdrop').removeClass('slds-backdrop--open');
                    jQuery('#progressBarModal').removeClass('slds-fade-in-open');
                    jQuery('#myModalProgressBar').removeClass('slds-fade-in-open');
                    jQuery('#myModalProgressBar').addClass('slds-hidden');
                    component.set('v.progressPercentage', 0);
                    window.clearTimeout(timer);
                }
            }), 200
        );
    },
    addToUnCatArray : function(component, file){
        console.log(file.name);
        var pageName = component.get("v.pageName");
        var unCatFile;
        if(file && pageName == 'public homepage'){
            unCatFile = {
                'file': file,
                'description' : '',
                'index' : component.get("v.uploadedUnCatFiles").length,
            };
        }else if(file && pageName == 'insurer portal'){
            unCatFile = {
                'file': file,
                'category' : '',
                'subCategory' : '',
                'index' : component.get("v.uploadedUnCatFiles").length,
            };
        }
        var uploadedUnCatFiles = component.get("v.uploadedUnCatFiles");
        uploadedUnCatFiles.push(unCatFile);
        component.set("v.uploadedUnCatFiles", uploadedUnCatFiles);
    },
    
    saveToServer : function(component, file){
        var bar = jQuery('.bar');
        var percent = jQuery('.percent');
        var status = jQuery('#status');
        console.log('inside helper---<>---file type is ===>'+file.file.type);
        var params = component.get("v.uploadForm");
        params.name = file.file.name;
        params.caseId = component.get('v.parentId');
        params.caseItemId = component.get('v.caseItemId') || '';
        params.dateLoaded = this.todayDate();
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
                                    var Percentage = (current * 100)/max;
                                    console.log(Percentage);
                                    var bar = $('.bar');
                                    var percent = $('.percent');
                                    var status = $('#status');
                                    bar.width(Percentage);
                                    percent.html(Percentage);
                                }
                            });
                        }
                        return myXhr;
                    },
                    
                    success: function(result){
                        console.log('Ajax call successful for'+file.file.name);
                        console.log(result);
                    },
                    error: function(err){ 
                        console.log('Ajax call failed for'+file.file.name);
                    }
                });
                console.info('after ajax');
            }else{
                console.log('Server call failed for'+file.file.name);
            }
        });
        $A.enqueueAction(action);
    }
})