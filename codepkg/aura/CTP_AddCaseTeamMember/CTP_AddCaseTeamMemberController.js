({
    // Method to add user to team member
    addUserToTeam : function(component, event, helper) {
        //alert('Add new team member');
        var caseId = component.get("v.addMemCase");
        var userId = component.get("v.userId");
        var access = component.find("Access").get("v.value");
        //show modal
        
        var flag = true;
        if(document.getElementById("search").value == ''){
            flag = false;
            console.log('=========component.find("c:errorMessage")'+component.find("errorMessage").get("v.value"));
            component.find("errorMessage").set("v.value",$A.get("$Label.c.CTP_ErrorTeamAdd1"));
        }
        if(userId == '' || userId == null){
            flag = false;
            console.log('=========2'+component.find("errorMessage").get("v.value"));
            component.find("errorMessage").set("v.value",$A.get("$Label.c.CTP_ErrorTeamAdd1"));
         }
        if(flag){
            console.log('access'+access);
            console.log('userId'+userId);
            var action = component.get("c.addMemberToTheTeam");
            action.setParams({ "casId" : caseId , "access" : access,"userId" : userId});
            document.getElementById("search").value = '';
            console.log(action);
            action.setCallback(this, function(a) {
                var appEvent = component.getEvent("appEvent");
                console.log('event-->'+appEvent);
                appEvent.setParams({
                    "memberListNew" : a.getReturnValue()});
                console.log('=============new');
                appEvent.fire();
                console.log('after fire');
            });
            $A.enqueueAction(action);
        }
    },
    
    //Method to load team roles from Backend
    doInit : function(component, event, helper) {
        
        var action = component.get("c.getTeamRole");
        console.log(action);
        action.setCallback(this, function(a) {
            component.set("v.caseTeamR", a.getReturnValue());
            console.log('doInit CMP 2'+a.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    
    //Method to detect key change in the input text
    searchKeyChange: function(component, event, helper) {
        //alert('searching');
        var caseId = component.get("v.addMemCase");
        console.log('caseId======'+caseId);
        var val = console.log('event.target.value'+event.target.value);
        if(document.getElementById("search").value == '' && component.get("v.userId") != ''){
            component.find("errorMessage").set("v.value",'');
            
        }else{
            console.log('=========find'+component.find("errorMessage").get("v.value"));
            component.find("errorMessage").set("v.value",'');
            var action = component.get("c.getUserSearch");
            action.setParams({ "searchInput" :event.target.value , "casId" : caseId  });
            action.setCallback(this, function(a) {
                component.set("v.objNew", a.getReturnValue());
            });
            $A.enqueueAction(action);
        }
    },
    
    //method user to pass the selected user from the list of user coming in dropdown
    passUserId:function(component, event, helper){
        var selectedRecordId = event.currentTarget.getAttribute("id");
        console.log('selectedRecordId------'+selectedRecordId);
        component.set("v.userId",selectedRecordId);
        var searchInput = component.find("searchInput");
        var selectedAnsIdx = event.currentTarget.getAttribute('data-name');
        document.getElementById("search").value = selectedAnsIdx;
        component.set("v.objNew",'');
        component.find("errorMessage").set("v.value",'');
    },
    
    //Method for closing the modal window
    closeModal:function(component,event,helper){
        document.getElementById("search").value = '';
        var refEvent = component.getEvent("refreshEvent");
        component.set("v.objNew",'');
        refEvent.fire();
        
    }
})