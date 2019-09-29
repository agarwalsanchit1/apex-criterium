@isTest
public class ApexLimitsGlobalConfigTest {

    @isTest()
    public static void executeApexLimitsGlobalConfigTest() {
        ApexLimitsGlobalConfig.getMap();        
        ApexLimitsGlobalConfig.getAll();
        ApexLimitsGlobalConfig.getStandardLimitsConfigFor(ApexLimits.ApexLimitType.QUERY_LOCATOR_ROW_LIMIT);
        ApexLimitsGlobalConfig.generateLabel(ApexLimits.ApexLimitType.QUERY_LOCATOR_ROW_LIMIT, 'ApexLimitsGlobalConfigTest', 'executeApexLimitsGlobalConfigTest');
        ApexLimitsGlobalConfig.generateDescription(ApexLimits.ApexLimitType.QUERY_LOCATOR_ROW_LIMIT, 'ApexLimitsGlobalConfigTest', 'executeApexLimitsGlobalConfigTest');
    }
}