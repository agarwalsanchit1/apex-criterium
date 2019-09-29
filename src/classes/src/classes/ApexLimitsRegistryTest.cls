@IsTest
public class ApexLimitsRegistryTest {

    @isTest
    public static void testApexLimitsRegistryMethods() {       
		ApexLimitsRegistry.getRegistry().selectAllLimits(true).setClassName('ApexLimits').setMethodName('performanceTestMethod').setStandardConfiguration();
        ApexLimitsRegistry.getRegistry().setClassName('ApexLimits').setMethodName('performanceTestMethod').
            selectApexLimit(ApexLimits.ApexLimitType.SOSL_QUERY_LIMIT).setStandardConfiguration();
        ApexLimitsRegistry.getRegistry().setClassName('ApexLimits').setMethodName('performanceTestMethod').
            addApexLimits(new List<ApexLimits.ApexLimitType> {ApexLimits.ApexLimitType.SOSL_QUERY_LIMIT}).setStandardConfiguration().className();
			ApexLimitsRegistry.getRegistry().setClassName('ApexLimits').setMethodName('performanceTestMethod').
            addApexLimits(new List<ApexLimits.ApexLimitType> {ApexLimits.ApexLimitType.SOSL_QUERY_LIMIT}).setStandardConfiguration().deployLimits();
    }
	
	 // DeployCallbackContext subclass for testing that returns myJobId
    public class TestingDeployCallbackContext extends Metadata.DeployCallbackContext {
      private Id myJobId = Id.valueOf('1'); // define to a canned ID you can use for testing
        
      public override Id getCallbackJobId() {
        return myJobId;
      }
    }
}