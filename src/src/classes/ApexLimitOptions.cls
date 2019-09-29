/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global abstract class ApexLimitOptions {
    
    static {
        ApexLimitOptions.enableProfiling = true; ApexLimitOptions.printBeforeSnapshotDetails = true;  ApexLimitOptions.printAfterSnapshotDetails = true;  ApexLimitOptions.enableEventLogging = true; 
        ApexLimitOptions.enableInMemoryConfiguration = true; ApexLimitOptions.includeNonConsumedLimitsInSnapshotDiff = true;
    }
        
    global static Boolean enableInMemoryConfiguration { get ; set {enableInMemoryConfiguration = value != null ? (Boolean) value : true; } }
    
    global static Boolean enableEventLogging { get; set { enableEventLogging = value != null ? (Boolean) value : true; } }
    
    // profile settings starts here 
    global static Boolean enableProfiling { get; set { enableProfiling = value != null ? (Boolean) value : true; } }
    
    global static Boolean printBeforeSnapshotDetails { get; set { printBeforeSnapshotDetails = value != null ? (Boolean) value : true; } }
    
    global static Boolean printAfterSnapshotDetails { get; set { printAfterSnapshotDetails = value != null ? (Boolean) value : true; } }

    global static Boolean includeNonConsumedLimitsInSnapshotDiff { get; set { includeNonConsumedLimitsInSnapshotDiff = value != null ? (Boolean) value : true; } }
    // profile settings ends here         
}