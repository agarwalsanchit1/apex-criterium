/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global interface ISaveLimitsMetricsService  {

    ApexLimits.ApexLevelMetricsHolder getLimitsMetricsHolder();    
    void commitMetrics();    
    void commitMetricsAsync();
    void commitMetricsAutomatically();
    void setRangeToCommitMetricsAutomatically(Integer range);    
    Integer getRangeToCommitMetricsAutomatically();
}