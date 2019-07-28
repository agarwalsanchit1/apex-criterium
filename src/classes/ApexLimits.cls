/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global abstract class ApexLimits {
    
    global static final String LINE_SEPARATOR = '\n';
    global static final String DOT_REGEX = '\\.';
    global static final String EMPTY_STRING = '';
    global static final String COLON = ':';
    global static final String DATE_FORMAT = 'yyyy-MM-dd HH:mm:ss.SSSZ';
    
    @TestVisible
    private static final IApexLimitHolder HOLDER = ApexLimits.createIApexLimitHolder();
    
    @TestVisible
    private static IApexResourceConsumptionEventHandler APEX_LIMITS_EVENT_HANDLER = new ApexResourceConsumptionEventHandler();
    
    private static String getCurrentLimitsString() {
        return LINE_SEPARATOR + '##################################################################'
            + LINE_SEPARATOR + 'Limits:'
            + LINE_SEPARATOR + '##################################################################'
            + LINE_SEPARATOR + 'AggregateQueries: ' + Limits.getAggregateQueries() + ' of ' + Limits.getLimitAggregateQueries()
            + LINE_SEPARATOR + 'Callouts: ' + Limits.getCallouts() + ' of ' + Limits.getLimitCallouts()
            + LINE_SEPARATOR + 'DMLRows: ' + Limits.getDMLRows() + ' of ' + Limits.getLimitDMLRows()
            + LINE_SEPARATOR + 'DMLStatements: ' + Limits.getDMLStatements() + ' of ' + Limits.getLimitDMLStatements()
            + LINE_SEPARATOR + 'EmailInvocations: ' + Limits.getEmailInvocations() + ' of ' + Limits.getLimitEmailInvocations()
            + LINE_SEPARATOR + 'FindSimilarCalls: ' + Limits.getFindSimilarCalls() + ' of ' + Limits.getLimitFindSimilarCalls()
            + LINE_SEPARATOR + 'FutureCalls: ' + Limits.getFutureCalls() + ' of ' + Limits.getLimitFutureCalls()
            + LINE_SEPARATOR + 'HeapSize: ' + Limits.getHeapSize() + ' of ' + Limits.getLimitHeapSize()
            + LINE_SEPARATOR + 'Queries: ' + Limits.getQueries() + ' of ' + Limits.getLimitQueries()
            + LINE_SEPARATOR + 'QueryRows: ' + Limits.getQueryRows() + ' of ' + Limits.getLimitQueryRows()
            + LINE_SEPARATOR + 'RunAs: ' + Limits.getRunAs() + ' of ' + Limits.getLimitRunAs()
            + LINE_SEPARATOR + 'SavepointRollbacks: ' + Limits.getSavepointRollbacks() + ' of ' + Limits.getLimitSavepointRollbacks()
            + LINE_SEPARATOR + 'Savepoints: ' + Limits.getSavepoints() + ' of ' + Limits.getLimitSavepoints()
            + LINE_SEPARATOR + 'SoslQueries: ' + Limits.getSoslQueries() + ' of ' + Limits.getLimitSoslQueries();
    }
    
    global static void printLimits(System.LoggingLevel logLevel) {
        System.debug(logLevel == null ? System.LoggingLevel.DEBUG : logLevel, getCurrentLimitsString());
    }
    
    global static void printLimitsUsingError() { printLimits(System.LoggingLevel.ERROR); }
    
    global static void printLimitsUsingInfo() { printLimits(System.LoggingLevel.INFO); }
    
    global static void printLimitsUsingWarn() { printLimits(System.LoggingLevel.WARN); }
    
    global static void printLimitsUsingDebug() { printLimits(System.LoggingLevel.DEBUG); }
    
    global static void printLimitsUsingFine() { printLimits(System.LoggingLevel.FINE); }
    
    global static void printLimitsUsingFiner() { printLimits(System.LoggingLevel.FINER); }
    
    global static void printLimitsUsingFinest() { printLimits(System.LoggingLevel.FINEST); }
    
    // based on OrgLimits
    global static Map<String, ApexLimit> getMap() { return HOLDER.getMap(); }
    
    global static List<ApexLimit> getAll() { return HOLDER.getAll(); }    
    
    global static IApexLimitHolder getIApexLimitHolder() { return HOLDER; }
    
    @TestVisible
    private static IApexLimitHolder createIApexLimitHolder() { return new ApexLimitHolder(); }
    
    global static ApexLimit apexLimitForType(final String limitType) { return HOLDER.getApexLimit(limitType); }
    
    global static ApexLimit apexLimitForType(ApexLimitType limitType) { return HOLDER.getApexLimit(limitType); }
    
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
    
    global interface IApexLimitHolder {
        
        void initHolder();
        
        IApexLimitHolder add(ApexLimit paramLimit);
        
        Map<String, ApexLimit> getMap();
        
        ApexLimit getApexLimit(final ApexLimitType limitType);
        
        ApexLimit getApexLimit(final String limitType);
        
        List<ApexLimit> getAll();
        
        void clear();
        
        String toJSONArrayString();
        
        Map<ApexResourceConsumptionType, List<ApexLimit>> getApexResourceAllocationTypeMap();
        
        void printAllApexLimits(IApexLimitStylePrinter stylePrinter);
        
        void printAllApexLimits(IApexLimitStylePrinter stylePrinter, IApexLimitComparator apxComparator, Boolean sortAsc);          
        
        void printAllApexLimits(IApexLimitStylePrinter stylePrinter, ApexLimitsSortingType sortType, Boolean sortAsc);
        
        void monitorAllLimits();    
        
        void monitorLimits(ApexLimitType[] apexLimitTypes);
    }
    
    global class ApexLimitHolder extends ApexBaseObject implements IApexLimitHolder {
        
        private Map<String, ApexLimit> limitMap;
        
        global ApexLimitHolder() { this.limitMap = new Map<String, ApexLimit>(); this.initHolder(); }
        
        global void initHolder() {
            this.add(new ApexCpuTimeLimit()).add(new ApexAggregatedQueryLimit()).add(new ApexAsyncCalloutLimit()).
                add(new ApexCalloutLimit()).add(new ApexDmlRowLimit()).add(new ApexDmlStatementLimit()).add(new ApexEmailInvocationLimit()).
                add(new ApexFutureLimit()).add(new ApexHeapSizeLimit()).add(new ApexMobilePushApexLimit()).add(new ApexQueriesLimit()).
                add(new ApexQueryLocatorRowLimit()).add(new ApexQueryRowLimit()).add(new ApexSoslQueryLimit());
        }
        
        global IApexLimitHolder add(ApexLimit paramApexLimitObject) {
            this.limitMap.put(paramApexLimitObject.getName().toUpperCase(), paramApexLimitObject); return this; 
        }
        
        global List<ApexLimit> getAll() { return this.limitMap.values(); }        
        
        global Map<String, ApexLimit> getMap() { return this.limitMap; }
        
        global ApexLimit getApexLimit(final ApexLimitType paramType) { return this.getApexLimit(paramType.name()); }
        
        global ApexLimit getApexLimit(final String paramType) { return this.limitMap.get(paramType.toUpperCase()); }            
        
        global void clear() { this.limitMap.clear(); }
        
        global override String className() { return ApexLimitHolder.class.getName(); }
        
        global String toJSONArrayString() {
            List<Map<String, Object>> objectMapArray = new List<Map<String, Object>>();
            for (ApexLimit apxLimit : getAll()) {
                objectMapArray.add(apxLimit.objectMap());
            }
            return JSON.serialize(objectMapArray);
        }
        
        global Map<ApexResourceConsumptionType, List<ApexLimit>> getApexResourceAllocationTypeMap() {
            Map<ApexResourceConsumptionType, List<ApexLimit>> resourceAllocationMap = new Map<ApexResourceConsumptionType, List<ApexLimit>>();        
            for (ApexLimit limitObj : getAll()) {
                if (limitObj != null) {
                    ApexResourceConsumptionType resourceType = limitObj.evaluateLimit();
                    List<ApexLimit> apexObjLimit = resourceAllocationMap.get(resourceType);
                    apexObjLimit = (apexObjLimit == null) ? new List<ApexLimit>() : apexObjLimit;
                    apexObjLimit.add(limitObj);
                    resourceAllocationMap.put(resourceType, apexObjLimit);
                }
            }
            for (ApexResourceConsumptionType cosumptionType : ApexResourceConsumptionType.values()) {
                if (resourceAllocationMap.get(cosumptionType) == null) {
                    resourceAllocationMap.put(cosumptionType, new List<ApexLimit>());
                }
            }
            return resourceAllocationMap;
        }
        
        global void printAllApexLimits(IApexLimitStylePrinter stylePrinter) {
            validateStylePrinter(stylePrinter);
            for (ApexLimit limitObj : getAll()) { limitObj.printApexLimit(stylePrinter); }
        }
    
        global void printAllApexLimits(IApexLimitStylePrinter stylePrinter, IApexLimitComparator apxComparator, Boolean sortAsc) {
            validateStylePrinter(stylePrinter);
            List<ApexLimit> sortedLimits = ApexLimits.sortApexLimitsUsing(apxComparator, sortAsc);
            for (ApexLimit limitObj : sortedLimits) { limitObj.printApexLimit(stylePrinter); }
        }
        
        global void printAllApexLimits(IApexLimitStylePrinter stylePrinter, ApexLimitsSortingType sortType, Boolean sortAsc) {
            validateStylePrinter(stylePrinter);
            List<ApexLimit> sortedLimits = ApexLimits.sortApexLimitsUsing(sortType, sortAsc);
            for (ApexLimit limitObj : sortedLimits) { limitObj.printApexLimit(stylePrinter); }
        }
        
        @TestVisible
        private void validateStylePrinter(IApexLimitStylePrinter stylePrinter) {
            if (stylePrinter == null) { throw new IllegalArgumentException(LABEL.APEX_LIMITS_STYLER_NOT_NULL); }
        }
        
        global void monitorAllLimits() { monitorLimits(ApexLimitType.values()); }
    
        global void monitorLimits(ApexLimitType[] apexLimitTypes) {
            if (apexLimitTypes == null || apexLimitTypes.isEmpty()) { throw new IllegalArgumentException(LABEL.APEX_LIMIT_TYPE_REQUIRED); }
            List<ApexLimitsConfiguration__mdt> apexLimitConfigurationList = getApexLimitsConfigurationFor(apexLimitTypes);
            for (ApexLimitsConfiguration__mdt apexLimitConfgMdt : apexLimitConfigurationList) {
                ApexLimit apxLimit = getApexLimit(apexLimitConfgMdt.Limit_Type__c);
                if (apxLimit != null) {
                    apxLimit.performEvent((IApexResourceConsumptionEvent) new ContexBasedApexResourceConsumptionEvent(), createConfigurationApexLimitResourceEvaluator(apexLimitConfgMdt));
                }
            }
        }
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
    
    global interface IApexLimit {
        
        ApexLimitType getLimitType();
        
        Integer getValue();
        
        Integer getReserved();
        
        String getName();
        
        Integer getRemaining();
        
        String getFriendlyName();
    }
    
    global abstract class ApexLimit extends ApexBaseObject implements IApexLimit, IApexLimitEvaluator, Comparable {
        
        global ApexLimit() { super(); }
        
        global abstract ApexLimitType getLimitType();
        
        global abstract Integer getValue();
        
        global abstract Integer getReserved();
        
        global abstract String getFriendlyName();
        
        global virtual String getName() { return this.getLimitType().name(); }
        
        global virtual Integer getRemaining() { return this.getReserved() - this.getValue(); }
        
        global virtual void performEvent() {
            performEvent(new ContexBasedApexResourceConsumptionEvent());
        }
        
        global virtual void performEvent(IApexResourceConsumptionEventHandler eventHandler, IApexResourceConsumptionEvent event, IApexLimitResourceEvaluator limitEval) {
            if (ApexLimitOptions.enableEventLogging) {
                eventHandler.perform(limitEval.evaluateLimitResource(this.getValue(), this.getReserved()), event, this);
            }
        }
        
        global virtual void performEvent(IApexResourceConsumptionEvent event, IApexLimitResourceEvaluator limitEval) {
            performEvent(APEX_LIMITS_EVENT_HANDLER, event, limitEval);
        }
        
        global virtual void performEvent(IApexResourceConsumptionEvent event) {
            performEvent(event, createConfigurationApexLimitResourceEvaluator(this));
        }
        
        global virtual override String toString() {
            return 'Class: ' + this.className() + ', Name: ' + this.getName() + ', Value: ' + this.getValue() + ', Reserved: ' + this.getReserved() + ', Remaining : ' + this.getRemaining() + ', FriendlyName: ' + this.getFriendlyName();
        }
        
        global virtual ApexResourceConsumptionType evaluateLimit() {
            //return this.evaluateLimit(new DefaultApexLimitResourceEvaluator());
            return this.evaluateLimit(Test.isRunningTest() ? new DefaultApexLimitResourceEvaluator() : createConfigurationApexLimitResourceEvaluator(this));
        }
        
        global virtual ApexResourceConsumptionType evaluateLimit(IApexLimitResourceEvaluator limitEval) {
            return limitEval.evaluateLimitResource(this.getValue(), this.getReserved());
        }
        
        global virtual ApexLimit getCopy() {
            return new ApexLimitImMutableObject(this);
        }
        
        global virtual Boolean equalsTo(Object o) {
            if ((o == null) || !(o instanceof ApexLimit)) { return false; }
            if (o == this) { return true; }
            ApexLimit equalsToObj = (ApexLimit) o;
            if (System.equals(this.getLimitType(), equalsToObj.getLimitType())) { return true; }
            return this.toString().equals(equalsToObj.toString());
        }
        
        // -1, 0 , 1 for sorting on the basis of apex remaining limit
        global virtual Integer compareTo(Object o) {
            if ((o == null) || !(o instanceOf ApexLimit)) { throw new IllegalArgumentException(LABEL.INVALID_OBJECT_TYPE); }
            Integer currentObjRemaining = this.getRemaining();
            Integer oLimit = ((ApexLimit) o).getRemaining();
            if (currentObjRemaining == oLimit) { return 0; }
            if (currentObjRemaining > oLimit)  { return 1; }
            return -1;
        }
        
        global virtual Map<String, Object> objectMap() {
            return new Map<String, Object> { 'name' => this.getName(), 'value' => this.getValue(), 'reserved' => this.getReserved(), 'remaining' => this.getRemaining() ,'friendlyName' => this.getFriendlyName() };
                }
        
        global virtual void printApexLimit(IApexLimitStylePrinter apexStyler) {
            if (apexStyler == null) throw new IllegalArgumentException(LABEL.APEX_LIMITS_STYLER_NOT_NULL); 
            apexStyler.printStyle(this); 
        }
        
        private virtual String toJsonString(boolean pretty) { return pretty ? JSON.serializePretty(this.objectMap()) : JSON.serialize(this.objectMap()); }   
        
        global virtual String toJsonString() { return this.toJsonString(false); }
        
        global virtual String toPrettyJsonString() { return this.toJsonString(true); }
        
        global virtual void printPretty() { System.debug(LoggingLevel.INFO, this.toJsonString(true)); } 
    }
    
    global virtual class ApexLimitImMutableObject extends ApexLimit {
        
        private final ApexLimitType apexType;
        private final Integer value;
        private final Integer reserved; 
        private final String friendlyName;
        
        private ApexLimitImMutableObject(IApexLimit apxLimit) {
            this.apexType = apxLimit.getLimitType();
            this.value = apxLimit.getValue();
            this.reserved = apxLimit.getReserved();
            this.friendlyName = apxLimit.getFriendlyName();
        }
        
        private ApexLimitImMutableObject(final ApexLimitType apexLimitType, Integer value, Integer reserved, String friendlyName) {
            this.apexType = apexLimitType;
            this.value = value;
            this.reserved = reserved;
            this.friendlyName = friendlyName;
        }
        
        global override virtual ApexLimit getCopy() { return this; }
        global override ApexLimitType getLimitType() { return this.apexType; }        
        global override Integer getValue() { return this.value; }        
        global override Integer getReserved() { return this.reserved; }     
        global override String getFriendlyName() { return this.friendlyName; }
        global override String className() { return ApexLimitImMutableObject.class.getName(); }
        
        global override virtual Boolean equalsTo(Object o) {
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
        global override String getFriendlyName() { return 'CpuTime'; }
    }
    
    global class ApexAggregatedQueryLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.AGGREGATED_QUERY_LIMIT; }        
        global override Integer getValue() { return Limits.getAggregateQueries(); }        
        global override Integer getReserved() { return Limits.getLimitAggregateQueries(); }   
        global override String className() { return ApexAggregatedQueryLimit.class.getName(); }
        global override String getFriendlyName() { return 'AggregatedQueries'; }
    }
    
    global class ApexAsyncCalloutLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.ASYNC_CALL_LIMIT; }                
        global override Integer getValue() { return Limits.getAsyncCalls(); }                
        global override Integer getReserved() { return Limits.getLimitAsyncCalls(); }
        global override String className() { return ApexAsyncCalloutLimit.class.getName(); }        
        global override String getFriendlyName() { return 'AsyncCalls'; }
    }
    
    global class ApexCalloutLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.APEX_CALL_OUT_LIMIT; }        
        global override Integer getValue() { return Limits.getCallouts(); }        
        global override Integer getReserved() { return Limits.getLimitCallouts(); }
        global override String className() { return ApexCalloutLimit.class.getName(); }
        global override String getFriendlyName() { return 'Callouts'; }
    }
    
    global class ApexDmlRowLimit extends ApexLimit { 
        
        global override ApexLimitType getLimitType() { return ApexLimitType.DML_ROW_LIMIT; }        
        global override Integer getValue() { return Limits.getDmlRows(); }        
        global override Integer getReserved() { return Limits.getLimitDmlRows(); }
        global override String className() { return ApexDmlRowLimit.class.getName(); }
        global override String getFriendlyName() { return 'DMLRows'; }
    }
    
    global class ApexDmlStatementLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.DML_STATEMENT_LIMIT; }        
        global override Integer getValue() { return Limits.getDmlStatements(); }        
        global override Integer getReserved() { return Limits.getLimitDmlStatements(); }
        global override String className() { return ApexDmlStatementLimit.class.getName(); }
        global override String getFriendlyName() { return 'DMLStatements'; }
    }
    
    global class ApexEmailInvocationLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.EMAIL_INVOCATION_LIMIT; }                
        global override Integer getValue() { return Limits.getEmailInvocations(); }                
        global override Integer getReserved() { return Limits.getLimitEmailInvocations(); }
        global override String className() { return ApexEmailInvocationLimit.class.getName(); }
        global override String getFriendlyName() { return 'EmailInvocations'; }
    }
    
    global class ApexFutureLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.FUTURE_LIMIT; }        
        global override Integer getValue() { return Limits.getFutureCalls(); }        
        global override Integer getReserved() { return Limits.getLimitFutureCalls(); }
        global override String className() { return ApexFutureLimit.class.getName(); }
        global override String getFriendlyName() { return 'FutureCalls'; }
    }
    
    global class ApexHeapSizeLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.HEAP_SIZE_LIMIT; }        
        global override Integer getValue() { return Limits.getHeapSize(); }        
        global override Integer getReserved() { return Limits.getLimitHeapSize(); }     
        global override String className() { return ApexHeapSizeLimit.class.getName(); }
        global override String getFriendlyName() { return 'HeapSize'; }
    }
    
    global class ApexMobilePushApexLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.MOBILE_PUSH_LIMIT; }        
        global override Integer getValue() { return Limits.getMobilePushApexCalls(); }        
        global override Integer getReserved() { return Limits.getLimitMobilePushApexCalls(); }      
        global override String className() { return ApexMobilePushApexLimit.class.getName(); }
        global override String getFriendlyName() { return 'MobilePushApexCalls'; }
    }
    
    global class ApexQueriesLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.QUERIES_LIMIT; }        
        global override Integer getValue() { return Limits.getQueries(); }        
        global override Integer getReserved() { return Limits.getLimitQueries(); }      
        global override String className() { return ApexQueriesLimit.class.getName(); }
        global override String getFriendlyName() { return 'Queries'; }
    }
    
    global class ApexQueryLocatorRowLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.QUERY_LOCATOR_ROW_LIMIT; }         
        global override Integer getValue() { return Limits.getQueryLocatorRows(); }        
        global override Integer getReserved() { return Limits.getLimitQueryLocatorRows(); }
        global override String className() { return ApexQueryLocatorRowLimit.class.getName(); }
        global override String getFriendlyName() { return 'QueryLocatorRows'; }
    }
    
    global class ApexQueryRowLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.QUERY_ROW_LIMIT; }        
        global override Integer getValue() { return Limits.getQueryRows(); }        
        global override Integer getReserved() { return Limits.getLimitQueryRows(); }
        global override String className() { return ApexQueryRowLimit.class.getName(); }
        global override String getFriendlyName() { return 'QueryRows'; }
    }
    
    global class ApexSoslQueryLimit extends ApexLimit {
        
        global override ApexLimitType getLimitType() { return ApexLimitType.SOSL_QUERY_LIMIT; }        
        global override Integer getValue() { return Limits.getSoslQueries(); }        
        global override Integer getReserved() { return Limits.getLimitSoslQueries(); }
        global override String className() { return ApexSoslQueryLimit.class.getName(); }
        global override String getFriendlyName() { return 'SoslQueries'; }
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
    
    global class DefaultApexLimitResourceEvaluator extends ApexBaseObject implements IDefault, IApexLimitResourceEvaluator {
        
        global DefaultApexLimitResourceEvaluator () { super(); }
        global ApexResourceConsumptionType evaluateLimitResource(Integer value, Integer reserved) {
            Decimal val = (value / (Decimal) reserved) * 100;
            if (val == 0.00) { return ApexResourceConsumptionType.NONE;}
            if (val > 0.00 && val <= 25.00) { return ApexResourceConsumptionType.INITIAL; }
            if (val > 25.00 && val <= 50.00) { return ApexResourceConsumptionType.QUARTERLY; }
            if (val > 50.00 && val <= 75.00) { return ApexResourceConsumptionType.PARTIALLY; }            
            if (val > 75.00 && val <= 99.00) { return ApexResourceConsumptionType.CRITICAL; }
            return ApexResourceConsumptionType.ALL;
        }
        global override String className() { return DefaultApexLimitResourceEvaluator.class.getName(); }        
    }
    
    global interface IApexLimitStylePrinter {        
        void printStyle(ApexLimit paramLimit);
    }
    
    global interface IApexResourceConsumptionEvent {
        
        void noneResourceLevelEvent(IApexLimit apexLimit);             
        void initialResourceLevelEvent(IApexLimit apexLimit);             
        void quarterlyResourceLevelEvent(IApexLimit apexLimit);             
        void partiallyResourceLevelEvent(IApexLimit apexLimit);
        void criticallyResourceLevelEvent(IApexLimit apexLimit);
        void allResourceLevelEvent(IApexLimit apexLimit);
    }
    
    global interface IApexResourceConsumptionEventHandler {
        void perform(ApexResourceConsumptionType consumptionLevel, IApexResourceConsumptionEvent consumptionEvent, IApexLimit apexLimit);
    }
    
    global virtual class ApexResourceConsumptionEventHandler extends ApexBaseObject implements IDefault, IApexResourceConsumptionEventHandler {
        
        global ApexResourceConsumptionEventHandler() { super(); }       
        global virtual void perform(ApexResourceConsumptionType consumptionLevel, IApexResourceConsumptionEvent consumptionEvent, IApexLimit apexLimit) {
            if (consumptionLevel == ApexResourceConsumptionType.NONE) { consumptionEvent.noneResourceLevelEvent(apexLimit); }
            if (consumptionLevel == ApexResourceConsumptionType.INITIAL) { consumptionEvent.initialResourceLevelEvent(apexLimit); }
            if (consumptionLevel == ApexResourceConsumptionType.QUARTERLY) { consumptionEvent.quarterlyResourceLevelEvent(apexLimit); }
            if (consumptionLevel == ApexResourceConsumptionType.PARTIALLY) { consumptionEvent.partiallyResourceLevelEvent(apexLimit); }
            if (consumptionLevel == ApexResourceConsumptionType.CRITICAL) { consumptionEvent.criticallyResourceLevelEvent(apexLimit); }
            if (consumptionLevel == ApexResourceConsumptionType.ALL) { consumptionEvent.allResourceLevelEvent(apexLimit); }
        }        
        global virtual override String className() { return ApexResourceConsumptionEventHandler.class.getName(); }
    }
    
    global enum Order { NONE, ASCENDING, DESCENDING }   
    
    global static List<ApexLimit> orderApexListBy(Order paramOrderBy) {
        return orderListBy(getAll(), paramOrderBy);
    }
    
    private static List<ApexLimit> orderListBy(List<ApexLimit> paramList, Order paramOrder) {
        if (paramList == null || paramList.isEmpty()) { return paramList; }
        if (paramOrder == null || paramOrder == Order.NONE) { return paramList; }
        paramList.sort();
        if (paramOrder == Order.ASCENDING) { return paramList; }
        List<ApexLimit> descingList = new List<ApexLimit>();
        Integer len = paramList.size(), j = len;
        for (Integer i = len; i > 0; i--) {
            descingList.add(paramList.get(j--));
        }
        return descingList;
    }
    
    global interface IApexLimitComparator {
        
        Integer compare(ApexLimit l1, ApexLimit l2);      
    }
    
    global Enum ApexLimitsSortingType { BY_REMAINING, BY_CONSUMED_VALUE, BY_RESERVED_VALUE }
    
    global virtual class ApexLimitComparator extends ApexBaseObject implements IDefault, IApexLimitComparator {
        
        private ApexLimitsSortingType sortingType;
        
        global ApexLimitComparator(ApexLimitsSortingType pramSortingType) { this.sortingType = pramSortingType; }
        
        global virtual Integer compare(ApexLimit l1, ApexLimit l2) {
            Integer l1Value, l2Value;
            if (sortingType == ApexLimitsSortingType.BY_RESERVED_VALUE) {
                l1Value = l1.getReserved(); l2Value = l2.getReserved();
            }
            else if (sortingType == ApexLimitsSortingType.BY_CONSUMED_VALUE) {
                l1Value = l1.getValue(); l2Value = l2.getValue();
            }
            else if (sortingType == ApexLimitsSortingType.BY_REMAINING) {              
                l1Value = l1.getRemaining(); l2Value = l2.getRemaining();
            } else {            
                throw new IllegalArgumentException(LABEL.INVALID_SORTING_TYPE);
            }
            if (l1Value == l2Value) { return 0; }
            if (l1Value > l2Value)  { return 1; }
            return -1;
        }
        
        global virtual override String toString() { return ' to compare limits on the basis of criteria ' + sortingType; }      
        global virtual override String className() { return ApexLimitComparator.class.getName(); }
    }
    
    global static List<ApexLimit> sortApexLimitsUsing(ApexLimitsSortingType sortingType, Boolean sortAsc) {
        return sortApexLimitsUsing(new ApexLimitComparator(sortingType), sortAsc);
    }
    
    global static List<ApexLimit> sortApexLimitsUsing(IApexLimitComparator apxComparator, Boolean sortAsc) {
        return qsort(getAll(), apxComparator, sortAsc);
    }
    
    private static List<ApexLimit> qsort(List<ApexLimit> limitList, IApexLimitComparator apxComparator, Boolean sortAsc) {
        return qsort(limitList, 0, limitList == null ? 0 : limitList.size() - 1, apxComparator, sortAsc);
    }
    
    private static List<ApexLimit> qsort(List<ApexLimit> limitList, Integer low, Integer high, IApexLimitComparator apxComparator, Boolean sortAsc) {
        Integer l = low, h = high;
        if (limitList == null || limitList.isEmpty()) { return limitList; } 
        if (l >= h) { return limitList; }
        
        if (l == h - 1) {
            if ((apxComparator.compare(limitList[l], limitList[h]) > 0 && sortAsc) || (apxComparator.compare(limitList[l], limitList[h]) < 0 && !sortAsc)) {
                ApexLimit temp = limitList[l];
                limitList[l] = limitList[h];
                limitList[h] = temp;
            }
            return limitList;
        }
        ApexLimit pivot = limitList[(l + h) / 2];
        limitList[(l + h) / 2] = limitList[h];
        limitList[h] = pivot;
        
        while (l < h) {
            
            if (sortAsc) {
                while((apxComparator.compare(limitList[l], pivot) <= 0 && l < h)) { l++; }                
                while((apxComparator.compare(pivot, limitList[h]) <= 0 && l < h)) { h--; }
            } else {
                while((apxComparator.compare(limitList[l], pivot) >= 0 && l < h)) { l++; }                
                while((apxComparator.compare(pivot, limitList[h]) >= 0 && l < h)) { h--; }                
            }
            
            if (l < h) {
                ApexLimit apxLimit = limitList[l];
                limitList[l] = limitList[h];
                limitList[h] = apxLimit;
            }
        }
        
        limitList[high] = limitList[h];
        limitList[h] = pivot;
        qsort(limitList, low, l - 1, apxComparator, sortAsc);
        qsort(limitList, h + 1, high, apxComparator, sortAsc);
        return limitList;
    }
    
    @TestVisible
    private static String[] getMethodInitiationStackTrace() {
        String stackTraceElement = EMPTY_STRING;
        try { throw new DmlException(); }
        catch (Exception e) {
            String[] splitString = e.getStackTraceString().split(LINE_SEPARATOR);
            if (Test.isRunningTest()) {
                for (String str : splitString) {                     
                    if (str.containsIgnoreCase('performanceTestMethod')) { 
                        stackTraceElement = str;
                        break;
                    }
                }
            } else {
                for (String str : splitString) {             
                    if (!str.containsIgnoreCase(ApexLimits.class.getName())) {
                        stackTraceElement = str;
                        break;
                    }
                }
            }
        }
        if (String.isBlank(stackTraceElement)) { throw new IllegalArgumentException(Label.NO_STACK_TRACE_FOUND); }
        // Class.SampleBenchMarkerTemplate.benchMarkCode: line 21, column 1
        return stackTraceElement.substringBefore(COLON).replace('Class.', EMPTY_STRING).split(DOT_REGEX);
    }
    
    @TestVisible
    private static List<ApexLimitsConfiguration__mdt> getApexLimitsConfigurationFor(List<ApexLimitType> limitsTypeList) {
        List<ApexLimitsConfiguration__mdt> apexLimitsConfigurationList = new List<ApexLimitsConfiguration__mdt>();
        if (limitsTypeList == null || limitsTypeList.isEmpty()) { return apexLimitsConfigurationList; }
        String[] methodArgs = getMethodInitiationStackTrace();
        List<String> keysList = new List<String>();
        for (ApexLimitType apxLimitType : limitsTypeList) {
            if (apxLimitType != null) {
                keysList.add(ApexLimitsGlobalConfig.generateLabel(apxLimitType, methodArgs[0], methodArgs[1]));
            }
        }
        try {
        	apexLimitsConfigurationList = fetchApexConifigurationRecordsBy(keysList);
        } catch (System.QueryException e) {
            if (!Test.isRunningTest()) {
            	ApexLimitsRegistry.getRegistry().addApexLimits(limitsTypeList).
                    setClassName(methodArgs[0]).setMethodName(methodArgs[1]).
                    setStandardConfiguration().deployLimits();
        		apexLimitsConfigurationList = fetchApexConifigurationRecordsBy(keysList);
            }
        }
        return apexLimitsConfigurationList;
    }
    
    private static List<ApexLimitsConfiguration__mdt> fetchApexConifigurationRecordsBy(List<String> keysList) {
        return [SELECT All_From__c,All_To__c,Apex_Class__c,
                Apex_Method_Name__c,Critical_From__c,Critical_To__c,
                DeveloperName,Id,Initial_From__c, Initial_To__c,
                Label,Language,Limit_Type__c,MasterLabel,
                NamespacePrefix,NONE_FROM__c,NONE_TO__c,
                Partially_From__c,Partially_To__c,
                QualifiedApiName,Quartely_From__c,Quartely_To__c 
                FROM ApexLimitsConfiguration__mdt where MasterLabel IN :keysList];
    }
    
    @TestVisible
    private static ApexLimitsConfiguration__mdt getApexLimitsConfigurationFor(IApexLimit limtObj) {
        String[] methodArgs = getMethodInitiationStackTrace();
        String key = ApexLimitsGlobalConfig.generateLabel(limtObj.getLimitType(), methodArgs[0], methodArgs[1]);
        return [SELECT All_From__c,All_To__c,Apex_Class__c,
                Apex_Method_Name__c,Critical_From__c,Critical_To__c,
                DeveloperName,Id,Initial_From__c, Initial_To__c,
                Label,Language,Limit_Type__c,MasterLabel,
                NamespacePrefix,NONE_FROM__c,NONE_TO__c,
                Partially_From__c,Partially_To__c,
                QualifiedApiName,Quartely_From__c,Quartely_To__c 
                FROM ApexLimitsConfiguration__mdt where MasterLabel =: key and Limit_Type__c =: limtObj.getName()];
    }       
    
    @TestVisible
    private static IApexLimitResourceEvaluator createConfigurationApexLimitResourceEvaluator(ApexLimitsConfiguration__mdt apxLimitsConfg) {
        return new ConfigurableApexLimitResourceEvaluator(apxLimitsConfg); 
    }
    
    @TestVisible
    private static IApexLimitResourceEvaluator createConfigurationApexLimitResourceEvaluator(IApexLimit limitObj) {
        return new ConfigurableApexLimitResourceEvaluator(getApexLimitsConfigurationFor(limitObj)); 
    }
    
    global virtual class ConfigurableApexLimitResourceEvaluator extends ApexBaseObject implements IApexLimitResourceEvaluator {
        
        global ApexLimitsConfiguration__mdt apxLimitsConfg {get; set;}
        
        global ConfigurableApexLimitResourceEvaluator() { super(); }
        
        global ConfigurableApexLimitResourceEvaluator(ApexLimitsConfiguration__mdt apexLimitConfg) { super(); this.apxLimitsConfg = apexLimitConfg; }
        
        global virtual ApexResourceConsumptionType evaluateLimitResource(Integer value, Integer reserved) {
            ApexResourceConsumptionType consumptionType;
            Decimal val = (value / (Decimal) reserved) * 100;
            if (val > apxLimitsConfg.None_From__c && val <= apxLimitsConfg.None_To__c) { consumptionType = ApexResourceConsumptionType.NONE;}
            else if (val > apxLimitsConfg.Initial_From__c && val <= apxLimitsConfg.Initial_To__c) { consumptionType = ApexResourceConsumptionType.INITIAL; }
            else if (val > apxLimitsConfg.Quartely_From__c && val <= apxLimitsConfg.Quartely_To__c) { consumptionType = ApexResourceConsumptionType.QUARTERLY; }
            else if (val > apxLimitsConfg.Partially_From__c && val <= apxLimitsConfg.Partially_To__c) { consumptionType = ApexResourceConsumptionType.PARTIALLY; }            
            else if (val > apxLimitsConfg.Critical_From__c && val <= apxLimitsConfg.Critical_To__c) { consumptionType = ApexResourceConsumptionType.CRITICAL; }
            else if (val > apxLimitsConfg.All_From__c && val <= apxLimitsConfg.All_To__c) { consumptionType = ApexResourceConsumptionType.ALL; }
            return consumptionType;
        }
        global virtual override String className() { return ConfigurableApexLimitResourceEvaluator.class.getName(); }        
    }
    
    global virtual class ContexBasedApexResourceConsumptionEvent extends ApexBaseObject implements IDefault, IApexResourceConsumptionEvent {
        
        global ContexBasedApexResourceConsumptionEvent() { super(); }       
        global virtual void noneResourceLevelEvent(IApexLimit apexLimit) { this.formatString(Label.NONE_RESOURCE_MESSAGE, apexLimit); }
        global virtual void initialResourceLevelEvent(IApexLimit apexLimit) { this.formatString(Label.INITIAL_RESOURCE_LEVEL_EVENT, apexLimit); }
        global virtual void quarterlyResourceLevelEvent(IApexLimit apexLimit) { this.formatString(Label.QUARTELY_RESOURCE_LEVEL_EVENT_MESSAGE, apexLimit); }
        global virtual void partiallyResourceLevelEvent(IApexLimit apexLimit) { this.formatString(Label.PARTIALLY_RESOURCE_LEVEL_EVENT, apexLimit); }
        global virtual void criticallyResourceLevelEvent(IApexLimit apexLimit) { this.formatString(Label.CRITICAL_RESOURCE_LEVEL_EVENT, apexLimit); }
        global virtual void allResourceLevelEvent(IApexLimit apexLimit) { this.formatString(Label.ALL_RESOURCES_LEVEL_EVENT_MESSAGE, apexLimit); }       
        global virtual override String className() { return ContexBasedApexResourceConsumptionEvent.class.getName(); }
        
        private void formatString(String formattedString, IApexLimit apxLimit) {
            List<Object> argsList = this.messageInitialArgsList();            
            argsList.addAll(getMethodInitiationStackTrace());
            argsList.add(apxLimit.getName());
            argsList.add(apxLimit.getValue());
            argsList.add(apxLimit.getReserved());
            argsList.add(apxLimit.getRemaining());
            System.debug(String.format(formattedString, argsList));
        }
        
        private List<Object> messageInitialArgsList() {
            List<Object> finalArgs = new List<Object>();
            // adding time
            finalArgs.add(DateTime.now().format(DATE_FORMAT, 'UTC'));
            // user details
            finalArgs.add(UserInfo.getUserName());
            finalArgs.add(UserInfo.getTimeZone());
            finalArgs.add(UserInfo.getUserType());
            // OrganizationType
            finalArgs.add(SystemEnvironment.getOrganizationType());
            // context details
            finalArgs.add(RestContext.request != null);         
            finalArgs.add(System.isBatch());            
            finalArgs.add(Trigger.isExecuting);
            finalArgs.add(System.isFuture());
            finalArgs.add(UserInfo.getUiThemeDisplayed() == 'Theme4d');
            finalArgs.add(UserInfo.getUiThemeDisplayed() == 'Theme4u');
            finalArgs.add(System.isQueueable());
            finalArgs.add(UserInfo.getUiThemeDisplayed() == 'Theme4t');
            finalArgs.add(System.isScheduled());
            finalArgs.add(ApexPages.currentPage() != null);
            return finalArgs;
        }
    }
    
    @TestVisible
    public static void performanceTestMethod() { getIApexLimitHolder().monitorAllLimits(); ApexLimits.getCpuTimeLimit().evaluateLimit(); ApexLimits.getCpuTimeLimit().performEvent(); }
}