/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global abstract class ApexLimitsGlobalConfig {

    private static Integer KEY_CHARACTER_LIMIT = 18;
    private static final String UNDERSCORE = '_';
    
    private static Map<ApexLimits.ApexLimitType, ApexLimitsRangeConfiguration> CACHE = new Map<ApexLimits.ApexLimitType, ApexLimitsRangeConfiguration>();

    static {
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.SOSL_QUERY_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.QUERY_ROW_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.QUERY_LOCATOR_ROW_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00,  99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.QUERIES_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.MOBILE_PUSH_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.HEAP_SIZE_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00,   99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.FUTURE_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00,  99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.EMAIL_INVOCATION_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.DML_STATEMENT_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.DML_ROW_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.APEX_CALL_OUT_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.ASYNC_CALL_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.AGGREGATED_QUERY_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
        addStandardLimitsConfigFor(new ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType.CPU_TIME_LIMIT, 0.00, 0.00, 0.00, 25.00, 25.00, 50.00, 50.00, 75.00, 75.00, 99.00, 99.00, 100.00));
    }
    
    global static void addStandardLimitsConfigFor(ApexLimitsRangeConfiguration apxLimitsRangeConfig) { CACHE.put(apxLimitsRangeConfig.apexLimitType, apxLimitsRangeConfig); }
    
    global static Map<ApexLimits.ApexLimitType, ApexLimitsRangeConfiguration> getMap() { return CACHE; }
   
    global static List<ApexLimitsRangeConfiguration> getAll() { return CACHE.values(); }
   
    global static ApexLimitsRangeConfiguration getStandardLimitsConfigFor(ApexLimits.ApexLimitType apexLimitType) { return CACHE.get(apexLimitType); }
    
    // generate a key of 40 characters
    global static String generateLabel(ApexLimits.ApexLimitType limitType, final String className, final String methodName) {
        String key = className.length() <= KEY_CHARACTER_LIMIT ? className : className.substring(0, KEY_CHARACTER_LIMIT);
        key += UNDERSCORE;
        key += methodName.length() <= KEY_CHARACTER_LIMIT ? methodName : methodName.substring(0, KEY_CHARACTER_LIMIT);        
        key += UNDERSCORE;
        return key + limitType.ordinal();
    }
    
    global static String generateDescription(ApexLimits.ApexLimitType limitType, final String className, final String methodName) {
        return className + UNDERSCORE + methodName + UNDERSCORE + ApexLimits.apexLimitForType(limitType).getFriendlyName();
    }
}