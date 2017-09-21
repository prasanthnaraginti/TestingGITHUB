<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CTP_Assist_Update_Case_Status</fullName>
        <description>Update Case Status</description>
        <field>CTP_Stage__c</field>
        <formula>&apos;In Progress&apos;</formula>
        <name>Update Case Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Assist_Update_DueDate</fullName>
        <description>Update Due Date</description>
        <field>CTP_DueDate__c</field>
        <formula>CTP_Date_of_accident__c + 70</formula>
        <name>Update Due Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Case_Status_To_5Y_Review</fullName>
        <description>Case Status = 5 year damages review</description>
        <field>Status</field>
        <literalValue>5 year review</literalValue>
        <name>CTP Case Status To 5Y Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Changing_Case_Close_Reason_to_None</fullName>
        <description>When Case Status gets changed to anything other than &apos;Closed&apos; change Close Status to &apos;None&apos;.</description>
        <field>Case_Closed_Reason__c</field>
        <name>CTP_Changing Case Close Reason to None</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_FU_FBCase_Reassignment_DRS</fullName>
        <description>CTP project (r0.5) - field update to change ownership to DRS feedback queue if Case Type changed to DRS</description>
        <field>OwnerId</field>
        <lookupValue>CTP_DRS_Feedback</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>CTP_FU_FBCase Reassignment DRS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Flip_Damages_To_NonDamages</fullName>
        <description>Flip a Damages case to a NonDamages case</description>
        <field>RecordTypeId</field>
        <lookupValue>CTP_Assist_Non_damages</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Flip Record Type to Non-Damages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Flip_NonDamages_To_Damages</fullName>
        <field>RecordTypeId</field>
        <lookupValue>CTP_Assist_Damages</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Flip Record Type to Damages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
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
        <fullName>CTP_SetCaseSeverityToYellow</fullName>
        <description>Set severity to Yellow</description>
        <field>CTP_Severity__c</field>
        <literalValue>Yellow</literalValue>
        <name>CTP_SetCaseSeverityToYellow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>NextValue</operation>
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
        <fullName>CTP_Set_Action_Due_Date_For_5_year</fullName>
        <description>Due Date = Date of Accident + 257 weeks</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c + 1799</formula>
        <name>CTP Set Action Due Date For 5 year</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Set_Action_Due_Date_For_75_week</fullName>
        <description>Set action due date for 75 week review</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c + 525</formula>
        <name>CTP Set Action Due Date For 75 week</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Set_Action_Due_Date_for_20_month_cal</fullName>
        <description>Set Action Due Date to be Date of Accident + 609 (87 weeks * 7 days)</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c + 609</formula>
        <name>CTP Set Action Due Date for 20 month cal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Set_Action_Due_Date_for_2_year_call</fullName>
        <description>Set Action Due Date to be Date of Accident + 707 (101 weeks * 7 days)</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c + 707</formula>
        <name>CTP Set Action Due Date for 2 year call</name>
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
        <literalValue>CTP Assist</literalValue>
        <name>CTP Set Case Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Set_Status_to_3_Month_Review</fullName>
        <description>Set Status to 3 Month Review</description>
        <field>Status</field>
        <literalValue>3 month review</literalValue>
        <name>CTP Set Status to 3 Month Review</name>
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
        <fullName>CTP_Update_Case_Status_3Y</fullName>
        <description>CTP Update Case Status 3Y</description>
        <field>Status</field>
        <literalValue>3 year review</literalValue>
        <name>CTP Update Case Status 3Y</name>
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
        <fullName>CTP_Update_Case_Status_to_2_year_Review</fullName>
        <description>Case Status = 2 year review</description>
        <field>Status</field>
        <literalValue>2 year review</literalValue>
        <name>CTP Update Case Status to 2 year Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Case_Status_to_In_Progress</fullName>
        <description>Update Case Status to In Progress</description>
        <field>Status</field>
        <literalValue>In Progress</literalValue>
        <name>CTP Update Case Status to In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Due_Date_Accident_M2</fullName>
        <description>Updates due date of next action, based on date of accident.</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c  + 70</formula>
        <name>CTP Update Due Date Accident M2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Due_Date_Accident_M3</fullName>
        <description>Updates due date of next action</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c  + 161</formula>
        <name>CTP Update Due Date Accident M3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Due_Date_Lodgement</fullName>
        <description>Updates due date of next action, based on Lodgement date.</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_LodgementDate__c + 21</formula>
        <name>CTP Update Due Date Lodgement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Due_Date_Lodgement_13W</fullName>
        <description>Action Due Date to Date of Common Law Notification + 91</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_Common_Law_Notification__c + 91</formula>
        <name>CTP Update Due Date Lodgement 13W</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CTP_Update_Due_Date_Lodgement_3Y</fullName>
        <description>CTP Update Due Date Lodgement 3Y (153 week * 7 days)</description>
        <field>CTP_ActionDueDate__c</field>
        <formula>CTP_Date_of_accident__c + 1071</formula>
        <name>CTP Update Due Date Lodgement 3Y</name>
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
        <fullName>CTP Claims Assist Damages Entitlement Milestone 1</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Lodgement_13W</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>3 month review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the First milestone in the Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_Damages_3M_Call</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_Date_of_Common_Law_Notification__c</offsetFromField>
            <timeLength>88</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Damages Entitlement Milestone 1 Test</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Lodgement_13W</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_Damages_3M_Call</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>3 month review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the First milestone in the Damages CTP Assist Entitlement Process Test.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Damages Entitlement Milestone 2</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Lodgement_3Y</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>3 year review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the Second milestone in the Damages CTP Assist Entitlement Process Test.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_3_Year_Review</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_3_Year_Review_Formula__c</offsetFromField>
            <timeLength>-3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Damages Entitlement Milestone 2 Test</fullName>
        <actions>
            <name>CTP_Update_Due_Date_Lodgement_3Y</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_3_Year_Review</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>3 year review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the Second milestone in the Damages CTP Assist Entitlement Process Test.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Damages Entitlement Milestone 3</fullName>
        <actions>
            <name>CTP_Set_Action_Due_Date_For_5_year</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>5 year review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the Third milestone in the Damages CTP Assist Entitlement Process .</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_5_Year_Call</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_5_Year_Review_Formula__c</offsetFromField>
            <timeLength>-3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Damages Entitlement Milestone 3 Test</fullName>
        <actions>
            <name>CTP_Set_Action_Due_Date_For_5_year</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_5_Year_Call</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>5 year review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the Third milestone in the Damages CTP Assist Entitlement Process Test .</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
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
            <value>CTP Assist - Non-damages</value>
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
            <timeLength>18</timeLength>
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
            <value>CTP Assist - Non-damages</value>
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
            <timeLength>158</timeLength>
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
            <value>CTP Assist - Non-damages</value>
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
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Non-damages</value>
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
        <description>This workflow rule covers both immediate and time deferred workflow actions for the fourth milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_75_week_Call</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
            <timeLength>522</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 4 Test</fullName>
        <actions>
            <name>CTP_Set_Action_Due_Date_For_75_week</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_75_week_Call</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Non-damages</value>
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
        <description>This workflow rule covers both immediate and time deferred workflow actions for the fourth milestone in the Non-Damages CTP Assist Entitlement Process .&lt;Test Version in Minutes&gt;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 5</fullName>
        <actions>
            <name>CTP_Set_Action_Due_Date_for_20_month_cal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Non-damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>20 month call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the fifth milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_20_month_Call</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
            <timeLength>606</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 5 Test</fullName>
        <actions>
            <name>CTP_Set_Action_Due_Date_for_20_month_cal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_20_month_Call</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Non-damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>20 month call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the fifth milestone in the Non-Damages CTP Assist Entitlement Process&lt;Test Version&gt;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 6</fullName>
        <actions>
            <name>CTP_Set_Action_Due_Date_for_2_year_call</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Non-damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>2 year review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the sixth milestone in the Non-Damages CTP Assist Entitlement Process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CTP_Update_Next_Action_StatusMC</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>CTP_Assist_Task_Created_2_year_reviewcall</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
            <timeLength>704</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CTP Claims Assist Non-Damages Entitlement Milestone 6 Test</fullName>
        <actions>
            <name>CTP_Set_Action_Due_Date_for_2_year_call</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusMC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Assist_Task_Created_2_year_reviewcall</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Non-damages</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>2 year review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CTP_Next_Action_Status__c</field>
            <operation>equals</operation>
            <value>No Action</value>
        </criteriaItems>
        <description>This workflow rule covers both immediate and time deferred workflow actions for the sixth milestone in the Non-Damages CTP Assist Entitlement Process&lt;Test Version&gt;.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CTP FBCase Reassignment for DRS</fullName>
        <actions>
            <name>CTP_FU_FBCase_Reassignment_DRS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>CTP Project (r0.5) - Feedback case reassignment for DRS (Case Type = DRS)</description>
        <formula>AND(RecordType.DeveloperName = &quot;Feedback&quot;, ISCHANGED(CTP_CaseType__c),ISPICKVAL(CTP_CaseType__c , &quot;DRS&quot;) 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CTP Flip Damages case to Non-Damages</fullName>
        <actions>
            <name>CTP_Flip_Damages_To_NonDamages</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Case_Status_Intro_Call</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusNA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.CTP_Date_of_Common_Law_Notification__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Damages</value>
        </criteriaItems>
        <description>This workflow changes a Damages case to a Non-damages case</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CTP Flip NonDamages case to Damages</fullName>
        <actions>
            <name>CTP_Flip_NonDamages_To_Damages</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Set_Status_to_3_Month_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CTP_Update_Next_Action_StatusNA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.CTP_Date_of_Common_Law_Notification__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CTP Assist - Non-damages</value>
        </criteriaItems>
        <description>This workflow changes a non-damages case to a Damages case</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
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
            <value>CTP Assist Feedback</value>
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
        <fullName>CTP_Status Changed other than Closed</fullName>
        <actions>
            <name>CTP_Changing_Case_Close_Reason_to_None</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>When Case Status gets changed to anything other than &apos;Closed&apos; change Close Status to &apos;None&apos;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>CTP_Assist_Task_Created_10_week_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created 67 days after Case Accident Date with a due date of 70 calendar days after Case Accident Date.</description>
        <dueDateOffset>70</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 10 week Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_20_month_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created 606 days after Case Accident Date with a due date of 609 calendar days after Case Accident Date.</description>
        <dueDateOffset>609</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 20 month Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_23_week_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created 158 days after Case Accident Date with a due date of 161 calendar days after accident date.</description>
        <dueDateOffset>161</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 23 week Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_2_year_reviewcall</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created 704 days after Case Accident Date with a due date of 707 calendar days after Date of accident.</description>
        <dueDateOffset>707</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created:2 year call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_3_Year_Review</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1071</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_Common_Law_Notification__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 3 Year Review</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_5_Year_Call</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1799</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 5 Year Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_75_week_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created  522 days after Case Accident Date with a due date of 525 calendar days after Case Accident Date.</description>
        <dueDateOffset>525</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_accident__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: 75 week Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_Damages_3M_Call</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>91</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_Date_of_Common_Law_Notification__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: Damages 3M Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Assist_Task_Created_Introduction_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>This task will be created 18 days i.e (21 days-3) after Case Lodgement Date with a due date of 21 calendar days after lodgement.</description>
        <dueDateOffset>21</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_LodgementDate__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task Created: Introduction Call</subject>
    </tasks>
    <tasks>
        <fullName>CTP_Contact_the_Claimant</fullName>
        <assignedToType>owner</assignedToType>
        <description>milestone action to create the time dependent task to Contact the Claimant 3 weeks after the Date of Lodgement</description>
        <dueDateOffset>21</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CTP_LodgementDate__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>CTP Assist Task : Contact the Claimant 3 weeks</subject>
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
