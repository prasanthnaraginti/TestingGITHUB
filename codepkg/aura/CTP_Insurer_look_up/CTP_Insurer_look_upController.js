({
    Search: function(component, event, helper) {
        helper.SearchHelper(component, event);
        component.set("v.isUserClicked",true);
    }, 
    
    setSearchKeyword: function(component, event, helper) {
     
      var accountName = event.getSource().get("v.value");
      console.log("@@@@@ accountName:::"+ accountName );
      component.set("v.searchKeyword", accountName);
      component.set("v.isUserClicked",false ); 
      helper.Navigate(component, event); 
    },
    
   
   
    
})