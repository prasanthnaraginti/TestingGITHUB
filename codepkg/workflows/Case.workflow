<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CTP_SetActionOnCase</fullName>
        <description>Set Action field on case</description>
        <field>CTP_ActionAndOutcome__c</field>
        <literalValue>Task to be completed</literalValue>
        <name>CTP_SetActionOnCase</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetCaseEscalated</fullName>
        <description>Set Case to escalated</description>
        <field>IsEscalated</field>
        <literalValue>1</literalValue>
        <name>CTP_SetCaseEscalated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetCaseEscalatedToFalse</fullName>
        <description>Set Case Escalated to False</description>
        <field>IsEscalated</field>
        <literalValue>0</literalValue>
        <name>CTP_SetCaseEscalatedToFalse</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetCasePriorityToHigh</fullName>
        <description>Set Case Priority to High</description>
        <field>Priority</field>
        <literalValue>Expedited</literalValue>
        <name>CTP_SetCasePriorityToHigh</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetCaseSeverityToGreen</fullName>
        <description>Field Update to set severity colour formula field on case</description>
        <field>CTP_Severity__c</field>
        <literalValue>Green</literalValue>
        <name>CTP_SetCaseSeverityToGreen</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetCaseSeverityToRed</fullName>
        <description>Set Case Severity to Red</description>
        <field>CTP_Severity__c</field>
        <literalValue>Red</literalValue>
        <name>CTP_SetCaseSeverityToRed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetDueDateToNull</fullName>
        <description>Set Due Date to null</description>
        <field>CTP_ActionDueDate__c</field>
        <name>CTP_SetDueDateToNull</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetNumOfViolations</fullName>
        <description>Set Number Of Violations</description>
        <field>CTP_Number_Of_Violations__c</field>
        <formula>CTP_Number_Of_Violations__c+1</formula>
        <name>CTP_SetNumOfViolations</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetPriorityToStandard</fullName>
        <description>set case priority to standard</description>
        <field>Priority</field>
        <literalValue>Standard</literalValue>
        <name>CTP_SetPriorityToStandard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetSLAViolationToNo</fullName>
        <description>Field to update case violation field</description>
        <field>CTP_SLAViolation__c</field>
        <literalValue>No</literalValue>
        <name>CTP_SetSLAViolationToNo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetSLAViolationToYes</fullName>
        <description>Set SLA Violation to Yes</description>
        <field>CTP_SLAViolation__c</field>
        <literalValue>Yes</literalValue>
        <name>CTP_SetSLAViolationToYes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_SetSeverityToYellow</fullName>
        <description>Set severity to Yellow</description>
        <field>CTP_Severity__c</field>
        <literalValue>Yellow</literalValue>
        <name>CTP_SetSeverityToYellow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Set_Action_Due_Date_For_75_week</fullName>
        <description>Set action due date for 75 week review</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c + 375</formula>
        <name>CTP Set Action Due Date For 75 week</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Set_Case_Status_to_20_month_call</fullName>
        <description>Set Case Status to 20 month call</description>
        <field>Status</field>
        <literalValue>20 month call</literalValue>
        <name>CTP Set Case Status to 20 month call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Set_Case_Type</fullName>
        <description>Case Type field update for Cases created from email-to-case</description>
        <field>CTP_CaseType__c</field>
        <literalValue>CAS</literalValue>
        <name>CTP Set Case Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Set_Expedited_Priority</fullName>
        <description>Set the Priority field to &apos;Expedited&apos;.</description>
        <field>Priority</field>
        <literalValue>Expedited</literalValue>
        <name>CTP Set Expedited Priority</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Case_Status_10W</fullName>
        <description>Update Case Status to &apos;10 week call&apos;</description>
        <field>Status</field>
        <literalValue>10 week call</literalValue>
        <name>CTP Update Case Status 10W</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Case_Status_23W</fullName>
        <description>Update Case Status to &apos;23 week call&apos;</description>
        <field>Status</field>
        <literalValue>23 week call</literalValue>
        <name>CTP Update Case Status 23W</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Case_Status_75W</fullName>
        <field>Status</field>
        <literalValue>75 week review</literalValue>
        <name>CTP Update Case Status 75W</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Case_Status_Intro_Call</fullName>
        <description>Update Case Status to &apos;Introduction call&apos;</description>
        <field>Status</field>
        <literalValue>Introduction Call</literalValue>
        <name>CTP Update Case Status Intro Call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Due_Date_Accident_M2</fullName>
        <description>Updates due date of next action, based on date of accident.</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c  + 55</formula>
        <name>CTP Update Due Date Accident M2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Due_Date_Accident_M3</fullName>
        <description>Updates due date of next action</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c  + 115</formula>
        <name>CTP Update Due Date Accident M3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Due_Date_Lodgement</fullName>
        <description>Updates due date of next action, based on Lodgement date.</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_LodgementDate__c + 18</formula>
        <name>CTP Update Due Date Lodgement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Next_Action_StatusMC</fullName>
        <description>15 days after Lodgement Date, the Next Action Status will be set to &apos;Must Call&apos;.</description>
        <field>CTP_Next_Action_Status__c</field>
        <literalValue>Must Call</literalValue>
        <name>CTP Update Next Action StatusMC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Next_Action_StatusNA</fullName>
        <description>Update Next Action Status to ‘No Action’</description>
        <field>CTP_Next_Action_Status__c</field>
        <literalValue>No Action</literalValue>
        <name>CTP Update Next Action StatusNA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 1</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Lodgement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Claimant Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Introduction Call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the first milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_Introduction_Call</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_LodgementDate__c</offsetFromField>
            <timeLength>15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 1 Test</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Lodgement</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_Introduction_Call</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Claimant Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Introduction Call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the first milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 2</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Accident_M2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Claimant Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>10 week call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the first milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_10_week_Call</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_LodgementDate__c</offsetFromField>
            <timeLength>50</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 2 Test</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Accident_M2</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_10_week_Call</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Claimant Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>10 week call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the first milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 3</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Accident_M3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Claimant Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>23 week call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the third milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_23_week_Call</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
            <timeLength>110</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 3 Test</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Accident_M3</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_23_week_Call</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Claimant Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>23 week call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the third milestone in the 26 week CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 4</fullName>
        <actions>
            <name>CTP_Set_Action_Due_Date_For_75_week</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Claimant Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>75 week review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the first milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
            <timeLength>370</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP_Set Case Type for Email to Case</fullName>
        <actions>
            <name>CTP_Set_Case_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Email</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>CAS Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Standard</value>
        </criteriaItems>
        <description>Set case type when case is created from E2C</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>deleteme</fullName>
        <active>false</active>
        <description>deleteme</description>
        <formula>1 == 0</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Case.CTP_DueDate__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>CTP</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>375</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_LodgementDate__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 75 week Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_10_week_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created 50 days after Case Accident Date with a due date of 5 calendar days after lodgement.</description>
        <dueDateOffset>55</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 10 week Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_23_week_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created 110 days after Case Accident Date with a due date of 115 calendar days after lodgement.</description>
        <dueDateOffset>115</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_LodgementDate__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 23 week Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_Introduction_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created 15 days after Case Lodgement Date with a due date of 18 calendar days after lodgement.</description>
        <dueDateOffset>18</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_LodgementDate__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: Introduction Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_New_Task_has_been_assigned_to_you</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>-1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_ActionDueDate__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>New Task has been assigned to you</subject>
    </tasks>
</Workflow>
