/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

// for debugging - to check resource consumption for each and every method.
global abstract class ApexLimitsProfiling {
    
    private static String BEFORE_SNAPSHOT_PRINT_STYLE = 'Before Taking Snapshot : {0}';
    private static String AFTER_SNAPSHOT_PRINT_STYLE = 'After Taking Snapshot : {0}';    
    
    global static List<ApexLimits.ApexLimitType> globalApexMonitoringList {
        get;
        set {
            globalApexMonitoringList = (value == null ) ? ApexLimits.ApexLimitType.values() : (ApexLimits.ApexLimitType[]) value;
        }
    }    
    
    global static ApexLimits.IApexLimitStylePrinter beforeLimitPrinterStyle {
        get ;
        set {
            beforeLimitPrinterStyle = (value == null) ? new SimpleFormatBasedApexLimitPrintStyle(BEFORE_SNAPSHOT_PRINT_STYLE) : (ApexLimits.IApexLimitStylePrinter) value;
        }
    }
    
    global static ApexLimits.IApexLimitStylePrinter afterLimitPrinterStyle {
        get ;
        set {
            afterLimitPrinterStyle = (value == null) ? new SimpleFormatBasedApexLimitPrintStyle(AFTER_SNAPSHOT_PRINT_STYLE) : (ApexLimits.IApexLimitStylePrinter) value;
        }
    }    
    
    // to avoid null pointer exception
    static {
        ApexLimitsProfiling.globalApexMonitoringList = ApexLimits.ApexLimitType.values();
        ApexLimitsProfiling.beforeLimitPrinterStyle = new SimpleFormatBasedApexLimitPrintStyle(BEFORE_SNAPSHOT_PRINT_STYLE);
        ApexLimitsProfiling.afterLimitPrinterStyle = new SimpleFormatBasedApexLimitPrintStyle(AFTER_SNAPSHOT_PRINT_STYLE);        
    }   
    
    private ApexLimitsProfiling() {}    
    
    private static ApexLimits.ApexLevelMetricsHolder getMetricsHolder() { return ApexLimits.getIApexLimitHolder().getMetricsHolder(); }
    
    global static ApexLimits.MethodIntervalMetrics takeSnapshotForGlobalLimits() { 
        return takeSnapshot(ApexLimitsProfiling.globalApexMonitoringList, ApexLimitOptions.printBeforeSnapshotDetails, ApexLimitOptions.includeNonConsumedLimitsInSnapshotDiff); 
    } 
    
    global static ApexLimits.MethodIntervalMetrics takeSnapshotForGlobalLimits(boolean printSnapShot, boolean includeNonConsumed) { 
        return takeSnapshot(ApexLimitsProfiling.globalApexMonitoringList, printSnapShot, includeNonConsumed); 
    } 
    
    global static ApexLimits.MethodIntervalMetrics takeSnapshot(boolean printSnapShot, boolean includeNonConsumed) { 
        return takeSnapshot(ApexLimits.ApexLimitType.values(), printSnapShot, includeNonConsumed); 
    } 
    
    global static ApexLimits.MethodIntervalMetrics takeSnapshot(List<ApexLimits.ApexLimitType> limitTypes, boolean printSnapShot, boolean includeNonConsumed) {
        ApexLimits.MethodIntervalMetrics mthdIntLvlMetrics = getMetricsHolder().takeSnapshot(limitTypes);
        System.debug(String.format(' ####################### Taking Snapshot for Classname : {0} and method : {1} #######################', 
                                   new List<Object> { mthdIntLvlMetrics.getClassName(), mthdIntLvlMetrics.getMethodName()}));
        if (mthdIntLvlMetrics != null && printSnapShot) {
            mthdIntLvlMetrics.getStartMethodMetrics().printAllApexLimits(ApexLimitsProfiling.beforeLimitPrinterStyle, ApexLimits.ApexLimitsSortingType.BY_CONSUMED_VALUE, false);
            printStartLimitSnapshot(mthdIntLvlMetrics.getLimitSnapshot(includeNonConsumed));
        }
        return mthdIntLvlMetrics;
    }
    
    global static ApexLimits.MethodIntervalMetrics takeSnapshotForGlobalLimits(String classNameWithNameSpace, String methodName) { 
        return takeSnapshot(classNameWithNameSpace, methodName, ApexLimitsProfiling.globalApexMonitoringList, 
                            ApexLimitOptions.printBeforeSnapshotDetails, ApexLimitOptions.includeNonConsumedLimitsInSnapshotDiff); 
    }
    
    global static ApexLimits.MethodIntervalMetrics takeSnapshotForGlobalLimits(String classNameWithNameSpace, String methodName, boolean printSnapShot, boolean includeNonConsumed) { 
        return takeSnapshot(classNameWithNameSpace, methodName, ApexLimitsProfiling.globalApexMonitoringList, printSnapShot, includeNonConsumed); 
    }    
    
    global static ApexLimits.MethodIntervalMetrics takeSnapshot(String classNameWithNameSpace, String methodName, boolean printSnapShot, boolean includeNonConsumed) { 
        return takeSnapshot(classNameWithNameSpace, methodName, ApexLimits.ApexLimitType.values(), printSnapShot, includeNonConsumed); 
    } 
    
    global static ApexLimits.MethodIntervalMetrics takeSnapshot(String classNameWithNameSpace, String methodName, List<ApexLimits.ApexLimitType> limitTypes, 
                                                                boolean printSnapShot, boolean includeNonConsumed) {
        ApexLimits.MethodIntervalMetrics mthdIntLvlMetrics = getMetricsHolder().takeSnapshot(classNameWithNameSpace, methodName, limitTypes);
        System.debug(String.format(' ####################### Taking Snapshot for Classname : {0} and method : {1}  #######################', 
                                   new List<Object> { mthdIntLvlMetrics.getClassName(), mthdIntLvlMetrics.getMethodName()}));        
        if (mthdIntLvlMetrics != null && printSnapShot) {
            mthdIntLvlMetrics.getStartMethodMetrics().printAllApexLimits(ApexLimitsProfiling.beforeLimitPrinterStyle, ApexLimits.ApexLimitsSortingType.BY_CONSUMED_VALUE, false);
            printStartLimitSnapshot(mthdIntLvlMetrics.getLimitSnapshot(includeNonConsumed));
        }
        return mthdIntLvlMetrics;
    }
    
    global static void diffSnapshot(boolean printSnapShot, boolean includeNonConsumed) { diffSnapshot(ApexLimits.ApexLimitType.values(), printSnapShot, includeNonConsumed); } 
    
    global static ApexLimits.MethodIntervalMetrics diffSnapshotForGlobalLimits() { 
        return diffSnapshot(ApexLimitsProfiling.globalApexMonitoringList, ApexLimitOptions.printAfterSnapshotDetails, ApexLimitOptions.includeNonConsumedLimitsInSnapshotDiff); 
    }
    
    global static ApexLimits.MethodIntervalMetrics diffSnapshotForGlobalLimits(boolean printSnapShot,  boolean includeNonConsumed) { 
        return diffSnapshot(ApexLimitsProfiling.globalApexMonitoringList, printSnapShot, includeNonConsumed); 
    }
    
    global static ApexLimits.MethodIntervalMetrics diffSnapshot(List<ApexLimits.ApexLimitType> limitTypes, boolean printSnapShot, boolean includeNonConsumed) {
        ApexLimits.MethodIntervalMetrics mthdIntLvlMetrics = getMetricsHolder().diffSnapshot(limitTypes);   
        System.debug(String.format(' ####################### Taking End Snapshot for Classname : {0} and method : {1}  #######################', 
                                   new List<Object> { mthdIntLvlMetrics.getClassName(), mthdIntLvlMetrics.getMethodName()}));        
        if (mthdIntLvlMetrics != null && printSnapShot) {
            mthdIntLvlMetrics.getEndMethodMetrics().printAllApexLimits(ApexLimitsProfiling.afterLimitPrinterStyle, ApexLimits.ApexLimitsSortingType.BY_CONSUMED_VALUE, false);
            System.debug('111' + ApexLimitOptions.includeNonConsumedLimitsInSnapshotDiff);
            printDiffLimitSnapshot(mthdIntLvlMetrics.getLimitSnapshot(includeNonConsumed));
        } 
        return mthdIntLvlMetrics;
    }
    
    global static ApexLimits.MethodIntervalMetrics diffSnapshotForGlobalLimits(String classNameWithNameSpace, String methodName) { 
        return diffSnapshot(classNameWithNameSpace, methodName, ApexLimitsProfiling.globalApexMonitoringList, 
                            ApexLimitOptions.printAfterSnapshotDetails, ApexLimitOptions.includeNonConsumedLimitsInSnapshotDiff); 
    }  
    
    global static ApexLimits.MethodIntervalMetrics diffSnapshotForGlobalLimits(String classNameWithNameSpace, String methodName, boolean printSnapShot, boolean includeNonConsumed) { 
        return diffSnapshot(classNameWithNameSpace, methodName, ApexLimitsProfiling.globalApexMonitoringList, printSnapShot, includeNonConsumed); 
    }  
    
    global static ApexLimits.MethodIntervalMetrics diffSnapshot(String classNameWithNameSpace, String methodName, boolean printSnapShot, boolean includeNonConsumed) { 
        return diffSnapshot(classNameWithNameSpace, methodName, ApexLimits.ApexLimitType.values(), printSnapShot, includeNonConsumed); 
    } 
    
    global static ApexLimits.MethodIntervalMetrics diffSnapshot(String classNameWithNameSpace, String methodName, List<ApexLimits.ApexLimitType> limitTypes, 
                                                                boolean printSnapShot, boolean includeNonConsumed) {
        ApexLimits.MethodIntervalMetrics mthdIntLvlMetrics = getMetricsHolder().diffSnapshot(classNameWithNameSpace, methodName, limitTypes);
        System.debug(String.format(' ####################### Taking End Snapshot for Classname : {0} and method : {1}  #######################',
                                   new List<Object> { mthdIntLvlMetrics.getClassName(), mthdIntLvlMetrics.getMethodName()}));                
        if (mthdIntLvlMetrics != null && printSnapShot) {
            mthdIntLvlMetrics.getEndMethodMetrics().printAllApexLimits(ApexLimitsProfiling.afterLimitPrinterStyle, ApexLimits.ApexLimitsSortingType.BY_CONSUMED_VALUE, false);
            printDiffLimitSnapshot(mthdIntLvlMetrics.getLimitSnapshot(includeNonConsumed));
        }
        return mthdIntLvlMetrics;
    }    
    
    global static String className() { return ApexLimitsProfiling.class.getName(); }
    
    global static System.Type getType() { try { return Type.forName(ApexLimitsProfiling.className()); } catch(TypeException e) { throw e; } }    
    
    global static Boolean isProfilingEnabled() { return ApexLimitOptions.enableProfiling; }
    
    global static void setIsProfilingEnabled(Boolean isEnabled) { ApexLimitOptions.enableProfiling = isEnabled; }
    
    @TestVisible    
    private static void printStartLimitSnapshot(ApexLimits.LimitSnapshot snapshot) {
        System.debug(String.format('At start, Limits Snapshot : {0}', new List<Object> { snapshot }));
    }
    
    @TestVisible
    private static void printDiffLimitSnapshot(ApexLimits.LimitSnapshot snapshot) {
        System.debug(String.format('At the end, Limits Snapshot Diff : {0}', new List<Object> { snapshot }));
    }
    
    global static void clear() { getMetricsHolder().clear(); }
}