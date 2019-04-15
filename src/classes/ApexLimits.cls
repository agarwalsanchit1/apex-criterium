/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-limits-framework for full license details. *
*************************************************************************************************/

global abstract class ApexLimits {
    
    @TestVisible
    private static final IApexLimitHolder HOLDER = ApexLimits.createIApexLimitHolder();
    
    global static Map<String, ApexLimit> getMap() {
        return HOLDER.getMap();
    }
    
    global static List<ApexLimit> getApexLimitList() {
        return HOLDER.getApexLimitList();
    }
    
    global static ApexLimit apexLimitForType(ApexLimitType limitType) {
        return HOLDER.getApexLimit(limitType);
    }
    
    global static void printApexLimit(IApexLimitStylePrinter stylePrinter) {
        if (stylePrinter == null) { throw new IllegalArgumentException('The stylePrinter is required.'); }
        for (ApexLimit limitObj : getApexLimitList()) { limitObj.printApexLimit(stylePrinter); }
    }
    
    global static ApexLimit getSoslQueriesLimit() { return apexLimitForType(ApexLimitType.SOSL_QUERY_LIMIT); }
    
    global static ApexLimit getQueryRowLimit() { return apexLimitForType(ApexLimitType.QUERY_ROW_LIMIT); }
    
    global static ApexLimit getQueryLocatorRowLimit() { return apexLimitForType(ApexLimitType.QUERY_LOCATOR_ROW_LIMIT); }
    
    global static ApexLimit getQueryLimit() { return apexLimitForType(ApexLimitType.QUERIES_LIMIT); }
    
    global static ApexLimit getMobilePushLimit() { return apexLimitForType(ApexLimitType.MOBILE_PUSH_LIMIT); }
    
    global static ApexLimit getHeapSizeLimit() { return apexLimitForType(ApexLimitType.HEAP_SIZE_LIMIT); }
    
    global static ApexLimit getFutureLimit() { return apexLimitForType(ApexLimitType.FUTURE_LIMIT); }
    
    global static ApexLimit getDmlRowLimit() { return apexLimitForType(ApexLimitType.DML_ROW_LIMIT); }
    
    global static ApexLimit getApexCallOutLimit() { return apexLimitForType(ApexLimitType.APEX_CALL_OUT_LIMIT); }
    
    global static ApexLimit getAsyncCallLimit() { return apexLimitForType(ApexLimitType.ASYNC_CALL_LIMIT); }
    
    global static ApexLimit getAggregatedQueryLimit() { return apexLimitForType(ApexLimitType.AGGREGATED_QUERY_LIMIT); }
    
    global static ApexLimit getCpuTimeLimit() { return apexLimitForType(ApexLimitType.CPU_TIME_LIMIT); }
    
    global static ApexLimit getDmlStatementLimit() { return apexLimitForType(ApexLimitType.DML_STATEMENT_LIMIT); }
    
    global static ApexLimit getEmailInvocationLimit() { return apexLimitForType(ApexLimitType.EMAIL_INVOCATION_LIMIT); }
        
    global static String className() { return ApexLimits.class.getName(); }
    
    global static System.Type getType() { try { return Type.forName(ApexLimits.className()); } catch(TypeException e) { throw e; } }
    
    @TestVisible
    private static IApexLimitHolder createIApexLimitHolder() {
        return new ApexLimitHolder();
    }
    
    global static ApexLimit createApexLimitImMutableObject(ApexLimitType limitType, Integer value, Integer reserved) {
        return new ApexLimitImMutableObject(limitType, value, reserved);
    }
    
    global static Map<ApexResourceConsumptionType, List<ApexLimit>> getApexResourceAllocationTypeMap() {
        Map<ApexResourceConsumptionType, List<ApexLimit>> resourceAllocationMap = new Map<ApexResourceConsumptionType, List<ApexLimit>>();
        List<ApexLimit> apexListObjectList = ApexLimits.getMap().values();
        for (ApexLimit limitObj : apexListObjectList) {
            if (limitObj != null) {
                ApexResourceConsumptionType resourceType = limitObj.evaluateLimit();
                List<ApexLimit> apexObjLimit = resourceAllocationMap.get(resourceType);
                apexObjLimit = (apexObjLimit == null) ? new List<ApexLimit>() : apexObjLimit;
                apexObjLimit.add(limitObj);
                resourceAllocationMap.put(resourceType, apexObjLimit);
            }
        }
        return resourceAllocationMap;
    }
    
    global class IllegalArgumentException extends Exception {}
    
    global interface IApexLimitHolder {
        
        void initHolder();
        
        IApexLimitHolder add(ApexLimit paramLimit);
        
        Map<String, ApexLimit> getMap();
        
        ApexLimit getApexLimit(final ApexLimitType limitType);
        
        List<ApexLimit> getApexLimitList();
        
        void clear();
    }
    
    global class ApexLimitHolder extends ApexBaseObject implements IApexLimitHolder {
    
        private Map<String, ApexLimit> limitMap;
        
        global ApexLimitHolder() { this.limitMap = new Map<String, ApexLimit>(); this.initHolder(); }
        
        global void initHolder() {
            this.add(new ApexCpuTimeLimit()).add(new ApexAggregatedQueryLimit()).add(new ApexAggregatedQueryLimit()).
            add(new ApexCalloutLimit()).add(new ApexDmlRowLimit()).add(new ApexDmlStatementLimit()).add(new ApexEmailInvocationLimit()).
            add(new ApexFutureLimit()).add(new ApexHeapSizeLimit()).add(new ApexMobilePushApexLimit()).add(new ApexQueriesLimit()).
            add(new ApexQueryLocatorRowLimit()).add(new ApexQueryRowLimit()).add(new ApexSoslQueryLimit());
        }
        
        global IApexLimitHolder add(ApexLimit paramApexLimitObject) {
            this.limitMap.put(paramApexLimitObject.getName(), paramApexLimitObject); return this; 
        }
        
        global List<ApexLimit> getApexLimitList() { return this.limitMap.values(); }        
        global Map<String, ApexLimit> getMap() { return this.limitMap; }
        global ApexLimit getApexLimit(final ApexLimitType paramType) { return this.limitMap.get(paramType.name()); }
        global void clear() { this.limitMap.clear(); }
        global override String className() { return ApexLimitHolder.class.getName(); }
    }
    
    global Enum ApexLimitType {
        
        SOSL_QUERY_LIMIT,
        QUERY_ROW_LIMIT,
        QUERY_LOCATOR_ROW_LIMIT,
        QUERIES_LIMIT,
        MOBILE_PUSH_LIMIT,
        HEAP_SIZE_LIMIT,
        FUTURE_LIMIT,
        EMAIL_INVOCATION_LIMIT,
        DML_STATEMENT_LIMIT,
        DML_ROW_LIMIT,
        APEX_CALL_OUT_LIMIT,
        ASYNC_CALL_LIMIT,
        AGGREGATED_QUERY_LIMIT,
        CPU_TIME_LIMIT      
    }
    
    global abstract class ApexLimit extends ApexBaseObject implements IApexLimitEvaluator, Comparable {
        
        global ApexLimit() {
            super();
        }
        
        global abstract ApexLimitType getLimitType();
        
        global abstract Integer getValue();
        
        global abstract Integer getReserved();
        
        global virtual String getName() {
            return this.getLimitType().name();
        }
        
        global virtual Integer getRemaining() {
            return this.getReserved() - this.getValue();
        }
        
        global virtual override String toString() {
            return 'Class: ' + this.className() + ', Name: ' + this.getName() + ', Value: ' + this.getValue() + ', Reserved: ' + this.getReserved() + ', Remaining : ' + this.getRemaining();
        }
        
        global virtual ApexResourceConsumptionType evaluateLimit() {
            return this.evaluateLimit(new DefaultApexLimitResourceEvaluator());
        }
        
        global virtual ApexResourceConsumptionType evaluateLimit(IApexLimitResourceEvaluator limitEval) {
            return limitEval.evaluateLimitResource(this.getValue(), this.getReserved());
        }
        
        global ApexLimit toApexLimitImMutableObject() {
            return new ApexLimitImMutableObject(this.getLimitType(), this.getValue(), this.getReserved());
        }
        
        global virtual Boolean isEqualsTo(Object o) {
            if ((o == null) || !(o instanceof ApexLimit)) { return false; }
            if (o == this) { return true; }
            ApexLimit equalsToObj = (ApexLimit) o;
            if (System.equals(this.getLimitType(), equalsToObj.getLimitType())) { return true; }
            return this.toString().equals(equalsToObj.toString());
        }
        
        // -1, 0 , 1 for sorting on the basis of apex remaining limit
        global virtual Integer compareTo(Object o) {
            if ((o == null) || !(o instanceOf ApexLimit)) { throw new IllegalArgumentException('Invalid Object type provided'); }
            Integer currentObjRemaining = this.getRemaining();
            Integer oLimit = ((ApexLimit) o).getRemaining();
            if (currentObjRemaining == oLimit) { return 0; }
            if (currentObjRemaining > oLimit)  { return 1; }
            return -1;
        }
        
        global Map<String, Object> objectMap() {
            return new Map<String, Object> { 'name' => this.getName(), 'value' => this.getValue(), 'reserved' => this.getReserved(), 'remaining' => this.getRemaining() };
        }
        
        private String toJsonString(boolean pretty) { return pretty ? JSON.serializePretty(this.objectMap()) : JSON.serialize(this.objectMap()); }   
        
        global String toJsonString() { return this.toJsonString(false); }
        
        global String toPrettyJsonString() { return this.toJsonString(true); }
        
        global void printPretty() { System.debug(LoggingLevel.INFO, this.toJsonString(true)); }
        
        global void printApexLimit(IApexLimitStylePrinter apexStyler) {
            if (apexStyler == null) throw new IllegalArgumentException('The apexStyler is required.'); 
            apexStyler.printStyle(this); 
        }
    }
    
    global virtual class ApexLimitImMutableObject extends ApexLimit {
    
        private final ApexLimitType apexType;
        private final Integer value;
        private final Integer reserved; 
        
        private ApexLimitImMutableObject(final ApexLimitType apexLimitType, Integer value, Integer reserved) {
            this.apexType = apexLimitType;
            this.value = value;
            this.reserved = reserved;
        }
        
        global override ApexLimitType getLimitType() { return this.apexType; }        
        global override Integer getValue() { return this.value; }        
        global override Integer getReserved() { return this.reserved; }        
        global override String className() { return ApexLimitImMutableObject.class.getName(); }
        
        global override virtual Boolean isEqualsTo(Object o) {
            if ((o == null) || !(o instanceof ApexLimitImMutableObject)) { return false; }
            if (o == this) { return true; }
            ApexLimitImMutableObject equalsToObj = (ApexLimitImMutableObject) o;
            if (System.equals(this.getLimitType(), equalsToObj.getLimitType())) { return true; }
            return this.toString().equals(equalsToObj.toString());
        }
    }
    
    global class ApexCpuTimeLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.CPU_TIME_LIMIT; }        
        global override Integer getValue() { return Limits.getCpuTime(); }        
        global override Integer getReserved() { return Limits.getLimitCpuTime(); }        
        global override String className() { return ApexCpuTimeLimit.class.getName(); }
    }
    
    global class ApexAggregatedQueryLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.AGGREGATED_QUERY_LIMIT; }        
        global override Integer getValue() { return Limits.getAggregateQueries(); }        
        global override Integer getReserved() { return Limits.getLimitAggregateQueries(); }   
        global override String className() { return ApexAggregatedQueryLimit.class.getName(); }
    }
    
    global class ApexAsyncCalloutLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.ASYNC_CALL_LIMIT; }                
        global override Integer getValue() { return Limits.getAsyncCalls(); }                
        global override Integer getReserved() { return Limits.getLimitAsyncCalls(); }
        global override String className() { return ApexAsyncCalloutLimit.class.getName(); }        
    }
    
    global class ApexCalloutLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.APEX_CALL_OUT_LIMIT; }        
        global override Integer getValue() { return Limits.getCallouts(); }        
        global override Integer getReserved() { return Limits.getLimitCallouts(); }
        global override String className() { return ApexCalloutLimit.class.getName(); }
    }
    
    global class ApexDmlRowLimit extends ApexLimit { 
    
        global override ApexLimitType getLimitType() { return ApexLimitType.DML_ROW_LIMIT; }        
        global override Integer getValue() { return Limits.getDmlRows(); }        
        global override Integer getReserved() { return Limits.getLimitDmlRows(); }
        global override String className() { return ApexDmlRowLimit.class.getName(); }
    }
        
    global class ApexDmlStatementLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.DML_STATEMENT_LIMIT; }        
        global override Integer getValue() { return Limits.getDmlStatements(); }        
        global override Integer getReserved() { return Limits.getLimitDmlStatements(); }
        global override String className() { return ApexDmlStatementLimit.class.getName(); }
    }
    
    global class ApexEmailInvocationLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.EMAIL_INVOCATION_LIMIT; }                
        global override Integer getValue() { return Limits.getEmailInvocations(); }                
        global override Integer getReserved() { return Limits.getLimitEmailInvocations(); }
        global override String className() { return ApexEmailInvocationLimit.class.getName(); }
    }
    
    global class ApexFutureLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.FUTURE_LIMIT; }        
        global override Integer getValue() { return Limits.getFutureCalls(); }        
        global override Integer getReserved() { return Limits.getLimitFutureCalls(); }
        global override String className() { return ApexFutureLimit.class.getName(); }
    }
    
    global class ApexHeapSizeLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.HEAP_SIZE_LIMIT; }        
        global override Integer getValue() { return Limits.getHeapSize(); }        
        global override Integer getReserved() { return Limits.getLimitHeapSize(); }     
        global override String className() { return ApexHeapSizeLimit.class.getName(); }
    }
    
    global class ApexMobilePushApexLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.MOBILE_PUSH_LIMIT; }        
        global override Integer getValue() { return Limits.getMobilePushApexCalls(); }        
        global override Integer getReserved() { return Limits.getLimitMobilePushApexCalls(); }      
        global override String className() { return ApexMobilePushApexLimit.class.getName(); }
    }
    
    global class ApexQueriesLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.QUERIES_LIMIT; }        
        global override Integer getValue() { return Limits.getQueries(); }        
        global override Integer getReserved() { return Limits.getLimitQueries(); }      
        global override String className() { return ApexQueriesLimit.class.getName(); }
    }
    
    global class ApexQueryLocatorRowLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.QUERY_LOCATOR_ROW_LIMIT; }         
        global override Integer getValue() { return Limits.getQueryLocatorRows(); }        
        global override Integer getReserved() { return Limits.getLimitQueryLocatorRows(); }
        global override String className() { return ApexQueryLocatorRowLimit.class.getName(); }
    }
    
    global class ApexQueryRowLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.QUERY_ROW_LIMIT; }        
        global override Integer getValue() { return Limits.getQueryRows(); }        
        global override Integer getReserved() { return Limits.getLimitQueryRows(); }
        global override String className() { return ApexQueryRowLimit.class.getName(); }
    }
    
    global class ApexSoslQueryLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.SOSL_QUERY_LIMIT; }        
        global override Integer getValue() { return Limits.getSoslQueries(); }        
        global override Integer getReserved() { return Limits.getLimitSoslQueries(); }
        global override String className() { return ApexSoslQueryLimit.class.getName(); }
    }
    
    global Enum ApexResourceConsumptionType {
        NONE, INITIAL, QUARTERLY, PARTIALLY, CRITICAL, ALL
    }
    
    global interface IApexLimitResourceEvaluator {        
        ApexResourceConsumptionType evaluateLimitResource(Integer value, Integer reserved);
    }
    
    global interface IApexLimitEvaluator {            
        ApexResourceConsumptionType evaluateLimit(IApexLimitResourceEvaluator limitEval);
    }
    
    global class DefaultApexLimitResourceEvaluator extends ApexBaseObject implements IApexLimitResourceEvaluator {
    
        global DefaultApexLimitResourceEvaluator () { super(); }
        global ApexResourceConsumptionType evaluateLimitResource(Integer value, Integer reserved) {
            Decimal val = (value /reserved) * 100;
            if (val == 0) { return ApexResourceConsumptionType.NONE;}
            else if (value > 0 && value <= 25) { return ApexResourceConsumptionType.INITIAL; }
            else if (value > 25 && value <= 50) { return ApexResourceConsumptionType.QUARTERLY; }
            else if (value > 50 && value <= 75) { return ApexResourceConsumptionType.PARTIALLY; }            
            else if (value > 75 && value <= 99) { return ApexResourceConsumptionType.CRITICAL; }
            else { return ApexResourceConsumptionType.ALL; }
        }
        global override String className() { return DefaultApexLimitResourceEvaluator.class.getName(); }        
    }
    
    global interface IApexLimitStylePrinter {        
        void printStyle(ApexLimit paramLimit);
    }
}