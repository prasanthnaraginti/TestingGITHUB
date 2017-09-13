public with sharing class CTP_CaseTeamMember {
    
    
    @AuraEnabled
    public static List<CaseTeamRole> getTeamRole(){
        String[] ExcludeList = new String[]{'Worker','Worker Representative','Team Leader','Merit Review Officer','Insurer Triager','Case Manager','Case Management Officer' };
        List<CaseTeamRole> caseTeamList = [SELECT id,Name from CaseTeamRole where Name NOT IN : ExcludeList];
        return (caseTeamList);
    } 
    
    @AuraEnabled
    public static List<User> getUserSearch(String searchInput, String casId){
        
        Case cas = [select id, AccountId from case where Id =: casId limit 1];
        
        System.debug('=============case'+cas);
        
        System.debug('========searchInput'+searchInput);
        if(!String.isEmpty(searchInput)){
            List<User> userList = [SELECT id,Name,Email from User where Name LIKE :('%' + searchInput + '%') limit 5];
            System.debug('=========userList'+userList.size());
            if(userList != null && userList.size()> 0)
                return (userList);
            return null;
        }else{
            return null;
        }
    }     
    
    @AuraEnabled
    public static RequestWrapper getCaseTeamMember(String casId){
        System.debug('============'+casId);
        Map<ID, CaseTeamRole> caseTeamRoleMap = new Map<ID, CaseTeamRole>([SELECT Id, Name FROM CaseTeamRole]);
        System.debug('----------caseTeamRoleMap'+caseTeamRoleMap);
        //getCaseTeamMember
        //[SELECT RecordId, HasEditAccess,HasReadAccess,HasDeleteAccess FROM UserRecordAccess WHERE UserId ='0057F000000cx5l' AND RecordId ='0037F000005mrI5' ]
        Boolean flag = true;
        String userId = UserInfo.getUserId();
        List<UserRecordAccess> FlagList = [SELECT RecordId, HasEditAccess,HasReadAccess,HasDeleteAccess FROM UserRecordAccess WHERE UserId =: userId AND RecordId =:casId limit 1];
        
        if(FlagList != null && FlagList.size() > 0){
            flag = FlagList[0].HasEditAccess;
        }
        System.debug('----------');
        Map<ID, CaseTeamMember> caseShareMap = new Map<ID, CaseTeamMember>([SELECT TeamRoleId,MemberId,ParentId,id FROM CaseTeamMember where ParentId=:casId]);
        List<Id> UserIdList ; 
        List<User> userList;
        List<UserShareWrap> userShareList;
        Map<id,id> parentToRoleMap ;
        System.debug('----------caseShareMap'+caseShareMap);
        
        if(caseShareMap!= null && caseShareMap.size() > 0){
            
            
            UserIdList =  new List<Id>();
            parentToRoleMap = new Map<id,id>();
            for(Id cshare : caseShareMap.KeySet()){
                UserIdList.add(caseShareMap.get(cshare).MemberId);
                parentToRoleMap.put( caseShareMap.get(cshare).MemberId,caseShareMap.get(cshare).TeamRoleId);
            }
            
            System.debug('----------parentToRoleMap'+parentToRoleMap);
            System.debug('-----------UserIdList'+UserIdList);
            //User = where id in UserOrGroupId
            if(UserIdList != null && UserIdList.size() > 0){   
                userList = [SELECT id,Name,Email FROM User WHERE Id IN: UserIdList];
                
                userShareList = new List<UserShareWrap>();
                
                for(User u : userList){
                    userShareList.add(new UserShareWrap(caseTeamRoleMap.get(parentToRoleMap.get(u.Id)).Name,u.Id,u.Name,u.Email));
                }
            }
            
            System.debug('----------userShareList'+userShareList);
        }
        
        System.debug('-------'+userShareList);
        if(userShareList != null && userShareList.size() > 0)
            return (new RequestWrapper(userShareList,flag));
        //            return ((new RequestWrapper(userShareList)),false);
        else return (new RequestWrapper(null,flag));
        
        return null;
    }
    
    @AuraEnabled
    public static RequestWrapper removeCaseTeamMember(String userId, String casId){
        System.debug('============case'+casId);
        System.debug('============user'+userId);
        List<CaseTeamMember> CaseTeamMemberList = [SELECT Id FROM CaseTeamMember where ParentId=:casId and MemberId=:userId ];
        System.debug('===========1'+CaseTeamMemberList); 
        
        delete CaseTeamMemberList;
        return (getCaseTeamMember(casId));
        
    }
    
    @AuraEnabled
    public Static RequestWrapper addMemberToTheTeam(String casId, String access, String userId){
        
        System.debug('-------------'+casId);
        System.debug('-------------'+access);
        System.debug('-------------'+userId);
        
        List<CaseTeamMember> CaseTeamMemberList = [SELECT Id,MemberId,ParentId,TeamRoleId FROM CaseTeamMember where ParentId=:casId and MemberId=:userId ];
        
        if(CaseTeamMemberList != null && CaseTeamMemberList.size() > 0)
            
        {
            CaseTeamMember casTeam = new CaseTeamMember();
            CaseTeamMemberList[0].TeamRoleId = access;
            
            update CaseTeamMemberList;
            System.debug('-------------CaseTeamMemberList'+CaseTeamMemberList);
        }else{
            CaseTeamMember casTeam = new CaseTeamMember();
            casTeam.MemberId = userId;
            casTeam.ParentId = casId;
            casTeam.TeamRoleId = access;
            
            insert casTeam;
            System.debug('-------------casTeam'+casTeam);
        }
        
        return (getCaseTeamMember(casId));
    }
    
    public Class RequestWrapper{
        @AuraEnabled
        Public List<UserShareWrap> shareTeamMemberList{get;set;}
        @AuraEnabled
        Public Boolean show{get;set;}
        
        public RequestWrapper(List<UserShareWrap> wrapList, Boolean flag){
            shareTeamMemberList = new List<UserShareWrap>();
            shareTeamMemberList = wrapList;
            show = flag;
        }
    }
    
    public Class UserShareWrap{
        @AuraEnabled
        String access{get;set;}
        @AuraEnabled
        String uId{get;set;}
        @AuraEnabled
        String name{get;set;}
        @AuraEnabled
        String email{get;set;}
        
        UserShareWrap(String access, String uId, String name, String email){
            this.access = access;
            this.uId = uId;
            this.name= name;
            this.email= email;
        }
    }
    
}