/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

@isTest
public class ApexLimitsTest {

    private class TestApexLimitPrintStyle implements ApexLimits.IApexLimitStylePrinter {
    
        public void printStyle(ApexLimits.ApexLimit paramLimit) {
            System.debug(paramLimit.toString());
        }
    }
    
    private static ApexLimits.IApexLimitStylePrinter stylePrinter = new TestApexLimitPrintStyle();
    
    @isTest
    private static void testGetMap() {
        ApexLimits.getMap();
        ApexLimits.getAll();
        ApexLimits.className();
        ApexLimits.getType();
        try {ApexLimits.getMethodInitiationStackTrace(); } catch (Exception e ) {}
        ApexLimits.performanceTestMethod();
        System.assertEquals(false, ApexLimits.getQueryRowLimit().equalsTo(ApexLimits.getSoslQueriesLimit()));
        ApexLimits.apexLimitForType(ApexLimits.ApexLimitType.SOSL_QUERY_LIMIT).toString();
    }
    
    @isTest
    private static void testApexHolderMethod() {       
        ApexLimits.getIApexLimitHolder().toJSONArrayString();            
        ApexLimits.getIApexLimitHolder().getApexResourceAllocationTypeMap();         
        ApexLimits.getIApexLimitHolder().printAllApexLimits(stylePrinter);       
        ApexLimits.getIApexLimitHolder().printAllApexLimits(stylePrinter, ApexLimits.ApexLimitsSortingType.BY_CONSUMED_VALUE, false);        
        ApexLimits.getIApexLimitHolder().clear(); 
    }
    
    @isTest
    private static void testApexLimitsMethods() {
        ApexLimits.printLimitsUsingError();
        ApexLimits.printLimitsUsingInfo();        
        ApexLimits.printLimitsUsingWarn();
        ApexLimits.printLimitsUsingDebug();
        ApexLimits.printLimitsUsingFine();
        ApexLimits.printLimitsUsingFiner();
        ApexLimits.printLimitsUsingFinest();        
        String.valueOf(ApexLimits.apexLimitForType(ApexLimits.ApexLimitType.SOSL_QUERY_LIMIT.name()));
        String.valueOf(ApexLimits.getSoslQueriesLimit());
        String.valueOf(ApexLimits.getQueryRowLimit());
        String.valueOf(ApexLimits.getQueryLocatorRowLimit());
        String.valueOf(ApexLimits.getQueryLimit());
        String.valueOf(ApexLimits.getMobilePushLimit());
        String.valueOf(ApexLimits.getHeapSizeLimit());
        String.valueOf(ApexLimits.getFutureLimit());
        String.valueOf(ApexLimits.getDmlRowLimit());
        String.valueOf(ApexLimits.getApexCallOutLimit());
        String.valueOf(ApexLimits.getAsyncCallLimit());
        String.valueOf(ApexLimits.getAggregatedQueryLimit());
        String.valueOf(ApexLimits.getCpuTimeLimit());
        String.valueOf(ApexLimits.getDmlStatementLimit());
        String.valueOf(ApexLimits.getEmailInvocationLimit());
        String.valueOf(ApexLimits.getAsyncCallLimit());
        String.valueOf(ApexLimits.getEmailInvocationLimit().getCopy());
        String.valueOf(ApexLimits.getSoslQueriesLimit().className());
    }
    
    @isTest
    private static void testApexMethod() {
        ApexLimits.ApexLimit sfObj = ApexLimits.getSoslQueriesLimit();
        sfObj.getType();
        sfObj.uniqueID();
        sfObj.identity();
        sfObj.indentityHashCode();
        sfObj.toString();
        sfObj.hashCode();
        sfObj.objectMap();
        sfObj.toJsonString();
        sfObj.toPrettyJsonString();
        sfObj.printPretty();
        sfObj.printApexLimit(new TestApexLimitPrintStyle());
        sfObj.className();        
        sfObj.evaluateLimit();
    }
}