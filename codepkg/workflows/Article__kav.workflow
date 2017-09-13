<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ApprovalRequiredLegal</fullName>
        <description>ApprovalRequiredLegal</description>
        <protected>false</protected>
        <recipients>
            <recipient>castestuser1@capgemini.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CTP_Claimant_Advisory_Services/CTP_Email_Template_for_Knowledge_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Email_Knowledge_Article_Rejection</fullName>
        <description>Email Knowledge Article Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CTP_Claimant_Advisory_Services/Email_Template_for_Knowledge_Article_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Email_Knowledge_Article_Rejection_Legal</fullName>
        <description>Email Knowledge Article Rejection_Legal</description>
        <protected>false</protected>
        <recipients>
            <recipient>castestuser1@capgemini.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CTP_Claimant_Advisory_Services/Email_Template_for_Knowledge_Article_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Email_Legal_team_Approval</fullName>
        <description>Email after Legal Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>castestuser1@capgemini.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CTP_Claimant_Advisory_Services/CTP_Email_Template_for_Knowledge_Published</template>
    </alerts>
    <alerts>
        <fullName>Email_To_Creator_Submitted_for_approval</fullName>
        <description>Email To Creator Submitted for approval</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CTP_Claimant_Advisory_Services/CTP_Email_Template_for_Knowledge_Submitted</template>
    </alerts>
    <fieldUpdates>
        <fullName>CTP_Set_Validation_Status_to_Pending</fullName>
        <description>Set validation status to Pending</description>
        <field>ValidationStatus</field>
        <literalValue>Pending</literalValue>
        <name>Set Validation Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ValidationRejected</fullName>
        <description>Validation Status Rejected</description>
        <field>ValidationStatus</field>
        <literalValue>Rejected</literalValue>
        <name>ValidationRejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ValidationStatusA</fullName>
        <description>Article Validation Status is Approved</description>
        <field>ValidationStatus</field>
        <literalValue>Approved</literalValue>
        <name>ValidationStatusA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ValidationStatusR</fullName>
        <description>Validation Status Rejected</description>
        <field>ValidationStatus</field>
        <literalValue>Rejected</literalValue>
        <name>ValidationStatusR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <knowledgePublishes>
        <fullName>Publish</fullName>
        <action>PublishAsNew</action>
        <description>Publish after all approval</description>
        <label>Publish</label>
        <language>en_US</language>
        <protected>false</protected>
    </knowledgePublishes>
</Workflow>
