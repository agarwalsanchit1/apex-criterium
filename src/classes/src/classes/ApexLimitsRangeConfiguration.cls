/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global class ApexLimitsRangeConfiguration extends ApexBaseObject {
    
    global ApexLimits.ApexLimitType apexLimitType {get; set;}
    global Decimal noneRangeFrom {get; set;}
    global Decimal noneRangeTo {get; set;}
    global Decimal initialFrom {get; set;}
    global Decimal initialTo {get; set;}
    global Decimal quarterlyFrom {get; set;}
    global Decimal quarterlyTo {get; set;}
    global Decimal partiallyFrom {get; set;}
    global Decimal partiallyTo {get; set;}
    global Decimal criticalFrom {get; set;}
    global Decimal criticalTo {get; set;}
    global Decimal allFrom {get; set;}
    global Decimal allTo {get; set;}
    
    global ApexLimitsRangeConfiguration() { super(); }
    
    global ApexLimitsRangeConfiguration(ApexLimits.ApexLimitType apexLimitType, Decimal noneRangeFrom, Decimal noneRangeTo, Decimal initialFrom, 
                                        Decimal initialTo, Decimal quarterlyFrom, Decimal quarterlyTo, 
                                        Decimal partiallyFrom, Decimal partiallyTo, Decimal criticalFrom, 
                                        Decimal criticalTo, Decimal allFrom, Decimal allTo) {
        this.apexLimitType = apexLimitType;
        this.noneRangeFrom = noneRangeFrom;
        this.noneRangeTo = noneRangeTo;
        this.initialFrom = initialFrom;
        this.initialTo = initialTo;
        this.quarterlyFrom = quarterlyFrom;
        this.quarterlyTo = quarterlyTo;
        this.partiallyFrom = partiallyFrom;
        this.partiallyTo = partiallyTo;
        this.criticalFrom = criticalFrom;
        this.criticalTo = criticalTo;
        this.allFrom = allFrom;
        this.allTo = allTo;
    }
    
    global override String className() {
        return ApexLimitsRangeConfiguration.class.getName();        
    }
}