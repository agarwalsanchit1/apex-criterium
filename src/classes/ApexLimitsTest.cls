/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-limits-framework for full license details. *
*************************************************************************************************/

@isTest
public class ApexLimitsTest {

    private class TestApexLimitPrintStyle implements ApexLimits.IApexLimitStylePrinter {
    
        public void printStyle(ApexLimits.ApexLimit paramLimit) {
            System.debug(paramLimit.toString());
        }
    }
    
    @isTest
    private static void testGetMap() {
        ApexLimits.getMap();
        ApexLimits.getApexLimitList();
        ApexLimits.printApexLimit(new TestApexLimitPrintStyle());
        ApexLimits.getApexResourceAllocationTypeMap();
        ApexLimits.className();
        ApexLimits.getType();
        System.assertEquals(false, ApexLimits.getQueryRowLimit().isEqualsTo(ApexLimits.getSoslQueriesLimit()));
        ApexLimits.apexLimitForType(ApexLimits.ApexLimitType.SOSL_QUERY_LIMIT).toString();
        ApexLimits.createApexLimitImMutableObject(ApexLimits.ApexLimitType.SOSL_QUERY_LIMIT, Limits.getSoslQueries(), Limits.getLimitSoslQueries());
    }
    
    @isTest
    private static void testApexHolderMethod() {
        ApexLimits.HOLDER.clear();        
    }
    
    @isTest
    private static void testApexLimitsMethods() {
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
        String.valueOf(ApexLimits.getEmailInvocationLimit().toApexLimitImMutableObject());
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