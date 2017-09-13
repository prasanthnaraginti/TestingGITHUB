<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
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
        <fullName>CTP_Reopen Case on Reply</fullName>
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
        <description>When a email is recieved on closed case it gets reopened. Created as part of DCR-328 Driver/Injured Person/Claimant Reply&apos;s to an email sent by a CAS Team Member</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
