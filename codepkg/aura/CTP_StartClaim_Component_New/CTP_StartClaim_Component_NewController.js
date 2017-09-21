({
    openApplication : function(component, event, helper) {
        console.log('---function called---');
        console.log('---function called---');       
        var evt = $A.get("e.force:navigateToURL");
        if (evt) {
            evt.setParams({
                "url": '/startclaim'
                
            });
            console.log('evt url is'+evt.getParam("url"));
            evt.fire();
        } 
        console.log('---end of function call---');
        
    }
})