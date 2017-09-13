({
	ShowEnterClaim : function(component, event, helper) {
       
		 var cmpTargetdrop = component.find('claiminput');
         $A.util.removeClass(cmpTargetdrop, 'slds-hidden');
         var cmpstartclamin=component.find('startclaim');
      $A.util.addClass(cmpstartclamin, 'slds-hidden');
       
	},
    confirmProceed: function(component,event,helper)
    {
       // alert('confirmproceed');
    
        var cmproceed=component.find('claiminput');
        $A.util.addClass(cmproceed, 'slds-hidden');
        var cmpucd=component.find('ucdcomp');
        $A.util.removeClass(cmpucd,'slds-hidden');
       
        
	}
})