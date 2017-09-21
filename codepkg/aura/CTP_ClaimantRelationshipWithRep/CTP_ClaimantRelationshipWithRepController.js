({
	select : function(component, event, helper) {
        var compEvent = component.getEvent("CTP_ClaimantRelationshipWithRepEvent"); 
        console.log('select Function called');
        var myValue = component.get("v.item");
        var checkedID = document.getElementById(myValue);
        var isClassPresent = $A.util.hasClass(checkedID,'slds-hidden');
        console.log('isClassPresent-->' +isClassPresent);
        if(isClassPresent)
        {
            console.log('myValue-->' +myValue);
            $A.util.removeClass(checkedID, 'slds-hidden');
            
            var elements = document.getElementsByClassName('rep-relation');
            for (var i = 0; i < elements.length; i++) {
               elements[i].classList.remove('selected');
            }
            $A.util.addClass(event.target, 'selected');
            
            if(localStorage.getItem("getIds")!=null)
            {
                console.log('getIds-->' +localStorage.getItem("getIds"));
                var storedIds = JSON.parse(localStorage.getItem("getIds"));
                var position = storedIds.indexOf(myValue);
                if ( ~position ) storedIds.splice(position, 1);
                console.log('storedIds-->' +JSON.stringify(storedIds));
                for(var index in storedIds)
                    {
                        console.log('index-->' +index);
                        console.log('Id value-->' +storedIds[index]);
                        var operatedId = storedIds[index]; 
                        var isClassAvail = $A.util.hasClass(operatedId,'slds-hidden');
                        console.log('isClassAvail-->' +isClassAvail);
                        if(isClassAvail==false)
                        {
                            console.log('operatedId-->' +operatedId);
                            var removeCheckedId = document.getElementById(operatedId);
                            $A.util.addClass(removeCheckedId, 'slds-hidden');
                        }    
                    }
            }
        }
        else
        {
            myValue = '';
            console.log('myValue-->' +myValue);
            $A.util.addClass(checkedID, 'slds-hidden');
            
        }
        compEvent.setParams({"getParam" : myValue }); 
        compEvent.fire(); 
   },
    
  
        

})