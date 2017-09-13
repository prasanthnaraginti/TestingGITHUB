({
	getActivityHistory: function(component)
    {
      
      var location = window.location.pathname.split('/');
      if (location && location[1])
      component.set('v.communitylink', '/' + location[1] + '/s');
        
       var caseRecID = component.get("v.recordId");
       console.log	( '@@Case ID@@' + caseRecID ); 
       var action1 = component.get( "c.getActivityHistory");
       action1.setParams(
            {
                "id" : caseRecID 
            }
        );
         
       action1.setCallback(this,function(response){
            var state = response.getState();
            console.log	( '@@STATE language Number@@' + state );
            if( component.isValid() && state === "SUCCESS" )
                {  
                    console.log('@@@@@@@ language ::: '+ JSON.stringify(response.getReturnValue()) );
                    component.set("v.caseItems",response.getReturnValue());
                }
            
       });
        
        $A.enqueueAction(action1) ; 
    }
})