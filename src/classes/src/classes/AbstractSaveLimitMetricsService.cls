/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global abstract class AbstractSaveLimitMetricsService extends ApexBaseObject implements ISaveLimitsMetricsService {

    private ApexLimits.ApexLevelMetricsHolder apexLimitMetricsHolder;
    private Integer rangeToSaveMetricsAutmtcally;
    
    global AbstractSaveLimitMetricsService(ApexLimits.ApexLevelMetricsHolder apexLimitMetricsHolder) { this(apexLimitMetricsHolder, ApexLimitsAppConstants.AUTO_COMMIT_METRICS_ENTRY_MIN_RANGE); }
    
    global AbstractSaveLimitMetricsService(ApexLimits.ApexLevelMetricsHolder apexLimitMetricsHolder, Integer paramRangeToSaveMetricsAutmtcally) { 
        super(); 
        this.apexLimitMetricsHolder = (ApexLimits.ApexLevelMetricsHolder) Preconditions.checkNotNull(apexLimitMetricsHolder, 'The apexLimitMetricsHolder must not be null.'); 
        this.setRangeToCommitMetricsAutomatically((Integer) Preconditions.checkNotNull(paramRangeToSaveMetricsAutmtcally, 'The paramRangeToSaveMetricsAutmtcally must not be null.'));
        this.initObject();
    }
    
    global virtual override void initObject() { 
        super.initObject();
        if (rangeToSaveMetricsAutmtcally == null) this.setRangeToCommitMetricsAutomatically(ApexLimitsAppConstants.AUTO_COMMIT_METRICS_ENTRY_MIN_RANGE);
    }
        
    global ApexLimits.ApexLevelMetricsHolder getLimitsMetricsHolder() { return this.apexLimitMetricsHolder; }
    global virtual void commitMetricsAutomatically() {
        if (this.apexLimitMetricsHolder.getMetricsSize() >= this.getRangeToCommitMetricsAutomatically()) { this.commitMetrics(); this.clear(); }
    }
    
    global virtual void setRangeToCommitMetricsAutomatically(Integer range) {
        if (range <= 0 && range < ApexLimitsAppConstants.AUTO_COMMIT_METRICS_ENTRY_MIN_RANGE) {
            this.rangeToSaveMetricsAutmtcally = ApexLimitsAppConstants.AUTO_COMMIT_METRICS_ENTRY_MIN_RANGE;
        } else if ((range >= ApexLimitsAppConstants.AUTO_COMMIT_METRICS_ENTRY_MIN_RANGE) && (range <= ApexLimitsAppConstants.AUTO_COMMIT_METRICS_ENTRY_MAX_RANGE)) {            
            this.rangeToSaveMetricsAutmtcally = range;
        } else if (range >= ApexLimitsAppConstants.AUTO_COMMIT_METRICS_ENTRY_MIN_RANGE) {
            this.rangeToSaveMetricsAutmtcally = ApexLimitsAppConstants.AUTO_COMMIT_METRICS_ENTRY_MIN_RANGE;
        }
    }
    
    global Integer getRangeToCommitMetricsAutomatically() { return this.rangeToSaveMetricsAutmtcally; }
    
    global abstract void commitMetrics();
    
    global virtual void clear() { this.apexLimitMetricsHolder.clear(); }
    
    global virtual void commitMetricsAsync() { this.commitMetricsAsync(new SaveMetricsQueueable(this)); }
    
    global virtual void commitMetricsAsync(AbstractSaveLimitsMetricsQueueable asynSaveMetrics) { 
        System.debug('Going to save metrics via async approach'); 
        System.enqueueJob((AbstractSaveLimitsMetricsQueueable) Preconditions.checkNotNull(asynSaveMetrics, 'The asynSaveMetrics must not be null.')); 
    }
    
    global virtual with sharing class SaveMetricsQueueable extends AbstractSaveLimitsMetricsQueueable {     
       
        global SaveMetricsQueueable(ISaveLimitsMetricsService saveMetricsService) { super(saveMetricsService); }        
        global virtual override boolean commitLogs(QueueableContext context, ISaveLimitsMetricsService saveMetricsService) { 
            try { this.getISaveLimitsMetricsService ().commitMetrics(); return true;} 
            catch(Exception e) { return false; } 
        }        
        global override String toString() { return 'to save logs via SaveMetricsQueueable approach.'; }
        global virtual override String className() { return SaveMetricsQueueable.class.getName(); }        
    }
}