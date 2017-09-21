({
    init : function(component, event, helper) {
        component.set("v.progress", 1);
    },
    
    handleAppEvents : function(component, event, helper) {
        var stage = event.getParam("stage");
        
        component.set("v.progress", stage / 4 * 100);
    }
})