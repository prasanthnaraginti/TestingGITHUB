<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CTP_FU_New_Email_Received</fullName>
        <description>For CTP Assist - DCR-515</description>
        <field>CTP_New_Email_Received__c</field>
        <literalValue>1</literalValue>
        <name>CTP_FU_New_Email_Received</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetCaseCloseCommentsToNone</fullName>
        <description>CTP Case close comments</description>
        <field>CTP_Closed_Comment__c</field>
        <name>CTP_SetCaseCloseCommentsToNone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetCaseClosedReasonToNone</fullName>
        <description>Set Case Closed Reason to None</description>
        <field>Case_Closed_Reason__c</field>
        <name>SetCaseClosedReasonToNone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_to_Re_Open</fullName>
        <description>Set Case status to reopen once an email reply is received on closed case</description>
        <field>Status</field>
        <literalValue>Re-opened</literalValue>
        <name>Set Status to Re-Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>CTP_New_Email_Received_Icon_Open</fullName>
        <actions>
            <name>CTP_FU_New_Email_Received</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>For CTP Assist team - DCR-515 - New email icon flag set on existing open case in Salesforce.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP_Reopen Case on Reply</fullName>
        <actions>
            <name>CTP_FU_New_Email_Received</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_SetCaseCloseCommentsToNone</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SetCaseClosedReasonToNone</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Status_to_Re_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.FromAddress</field>
            <operation>notEqual</operation>
            <value>CAS@nsw.gov.au</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When a email is recieved on closed case it gets reopened. Created as part of DCR-328 Driver/Injured Person/Claimant Reply&apos;s to an email sent by a CAS Team Member.
for sprint 3: added Field Update to set New Email Received flag for DCR-515.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
