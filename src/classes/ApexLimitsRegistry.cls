/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global with sharing class ApexLimitsRegistry extends ApexBaseObject {
    
    private List<ApexLimits.ApexLimitType> apexLimitsOptions = new List<ApexLimits.ApexLimitType>();
    private List<ApexLimitsRangeConfiguration> apexLimitsRangeConfigList = new List<ApexLimitsRangeConfiguration>();
    
    private Boolean selectAll {get; private set;}
    private String className {get; private set;}
    private String methodName {get; private set;}
    private Boolean standardConfiguration {get; private set;}
    
    global ApexLimitsRegistry() { super(); this.initObject(); }
    
    private void initObject() { this.selectAll = false; this.standardConfiguration = false; }

    global ApexLimitsRegistry selectAllLimits(Boolean selectAll) { this.selectAll = selectAll == null ? false : selectAll; return this; }
    
    global ApexLimitsRegistry addApexLimits(List<ApexLimits.ApexLimitType> options) { if (options != null && !options.isEmpty()) { this.apexLimitsOptions.addAll(options); } return this; }
    
    global ApexLimitsRegistry selectApexLimit(ApexLimits.ApexLimitType apxLimitType) { if (apxLimitType != null) { this.apexLimitsOptions.add(apxLimitType); } return this; }
    
    //CustomLabel.CLASS_NAME_NOT_NULL_OR_EMPTY
    global ApexLimitsRegistry setClassName(final String apexClassNameWithNameSpace) { this.className = Preconditions.isEmptyString(apexClassNameWithNameSpace, ApexLimits.EMPTY_STRING); return this; }
    
    global ApexLimitsRegistry setMethodName(final String methodName) { this.methodName = Preconditions.isEmptyString(methodName, ApexLimits.EMPTY_STRING); return this; }
    
    global ApexLimitsRegistry setStandardConfiguration() { this.standardConfiguration = true; return this; }
    
    global ApexLimitsRegistry addApexLimitsRangeConfiguration(ApexLimitsRangeConfiguration apexLimitsRangeCong) {
        if (apexLimitsRangeCong != null) {
            this.apexLimitsRangeConfigList.add(apexLimitsRangeCong);
        }
        return this;
    }
    
    global override String className() { return ApexLimitsRegistry.class.getName(); }
    
    global void deployLimits() {
        if (selectAll && standardConfiguration) {           
            apexLimitsRangeConfigList.addAll(ApexLimitsGlobalConfig.getAll());
        }
        if (standardConfiguration) {
            for (ApexLimits.ApexLimitType limitType : this.apexLimitsOptions) {
                apexLimitsRangeConfigList.add(ApexLimitsGlobalConfig.getStandardLimitsConfigFor(limitType));
            }
        }
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        for (ApexLimitsRangeConfiguration config : this.apexLimitsRangeConfigList) {
            if (config != null) {
                mdContainer.addMetadata(createCustomMetaData(config, this.className, this.methodName));
            }
        }
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, new CustomMetadataCallback());
    }
    
    global static ApexLimitsRegistry getRegistry() { return new ApexLimitsRegistry(); }
    
    private class CustomMetadataCallback implements Metadata.DeployCallback {
        
        public void handleResult(Metadata.DeployResult result,
                                 Metadata.DeployCallbackContext context) {
            if (result.status == Metadata.DeployStatus.Succeeded) {
                System.debug('success: '+ result);
            } else {
                System.debug('fail: '+ String.valueOf(result.details));
            }
        }
    }
    
    private static Metadata.CustomMetadata createCustomMetaData(ApexLimitsRangeConfiguration config, String className, String methodName) {     
        String key = ApexLimitsGlobalConfig.generateLabel(config.apexLimitType, className, methodName);
        Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
        customMetadata.fullName = 'ApexLimitsConfiguration.' + key;
        customMetadata.label = key;
        customMetadata.description = ApexLimitsGlobalConfig.generateDescription(config.apexLimitType, className, methodName);
        
        Metadata.CustomMetadataValue allFromField = new Metadata.CustomMetadataValue();
        allFromField.field = 'All_From__c';
        allFromField.value = config.allFrom;
        customMetadata.values.add(allFromField);
        
        Metadata.CustomMetadataValue allToField = new Metadata.CustomMetadataValue();
        allToField.field = 'All_To__c';
        allToField.value = config.allTo;        
        customMetadata.values.add(allToField);
        
        Metadata.CustomMetadataValue criticalFromField = new Metadata.CustomMetadataValue();
        criticalFromField.field = 'Critical_From__c';
        criticalFromField.value = config.criticalFrom;  
        customMetadata.values.add(criticalFromField);
        
        Metadata.CustomMetadataValue criticalToField = new Metadata.CustomMetadataValue();
        criticalToField.field = 'Critical_To__c';
        criticalToField.value = config.criticalTo;
        customMetadata.values.add(criticalToField);
        
        Metadata.CustomMetadataValue partiallyFromField = new Metadata.CustomMetadataValue();
        partiallyFromField.field = 'Partially_From__c';
        partiallyFromField.value = config.partiallyFrom;        
        customMetadata.values.add(partiallyFromField);
        
        Metadata.CustomMetadataValue partiallyToField = new Metadata.CustomMetadataValue();
        partiallyToField.field = 'Partially_To__c';
        partiallyToField.value = config.partiallyTo;            
        customMetadata.values.add(partiallyToField);
        
        Metadata.CustomMetadataValue quarterlyFromField = new Metadata.CustomMetadataValue();
        quarterlyFromField.field = 'Quartely_From__c';
        quarterlyFromField.value = config.quarterlyFrom;        
        customMetadata.values.add(quarterlyFromField);
        
        Metadata.CustomMetadataValue quarterlyToField = new Metadata.CustomMetadataValue();
        quarterlyToField.field = 'Quartely_To__c';
        quarterlyToField.value = config.quarterlyTo;        
        customMetadata.values.add(quarterlyToField);
        
        Metadata.CustomMetadataValue initialFromField = new Metadata.CustomMetadataValue();
        initialFromField.field = 'Initial_From__c';
        initialFromField.value = config.initialFrom;        
        customMetadata.values.add(initialFromField);
        
        Metadata.CustomMetadataValue initialToField = new Metadata.CustomMetadataValue();
        initialToField.field = 'Initial_To__c';
        initialToField.value = config.initialTo;        
        customMetadata.values.add(initialToField);
        
        Metadata.CustomMetadataValue noneRangeFromField = new Metadata.CustomMetadataValue();
        noneRangeFromField.field = 'NONE_FROM__c';
        noneRangeFromField.value = config.noneRangeFrom;        
        customMetadata.values.add(noneRangeFromField);
        
        Metadata.CustomMetadataValue noneRangeToField = new Metadata.CustomMetadataValue();
        noneRangeToField.field = 'NONE_TO__c';
        noneRangeToField.value = config.noneRangeTo;
        customMetadata.values.add(noneRangeToField);
        
        Metadata.CustomMetadataValue limitTypeField = new Metadata.CustomMetadataValue();
        limitTypeField.field = 'Limit_Type__c';
        limitTypeField.value = String.valueOf(config.apexLimitType);        
        customMetadata.values.add(limitTypeField);
        
        Metadata.CustomMetadataValue classNameField = new Metadata.CustomMetadataValue();
        classNameField.field = 'Apex_Class__c';
        classNameField.value = className;
        customMetadata.values.add(classNameField);      
        
        Metadata.CustomMetadataValue methodNameField = new Metadata.CustomMetadataValue();
        methodNameField.field = 'Apex_Method_Name__c';
        methodNameField.value = methodName;
        customMetadata.values.add(methodNameField);
        
        return customMetadata;      
    }
}