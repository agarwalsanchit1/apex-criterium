/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global virtual class SaveLimitMetricsService extends AbstractSaveLimitMetricsService {

    global SaveLimitMetricsService(ApexLimits.ApexLevelMetricsHolder apexLimitMetricsHolder) { super(apexLimitMetricsHolder); }
    
    global SaveLimitMetricsService(ApexLimits.ApexLevelMetricsHolder apexLimitMetricsHolder, Integer paramRangeToSaveMetricsAutmtcally) { super(apexLimitMetricsHolder, paramRangeToSaveMetricsAutmtcally); }

    global virtual override String className() { return SaveLimitMetricsService.class.getName(); }    
    
    global virtual override void commitMetrics() { 
    	
    }
}