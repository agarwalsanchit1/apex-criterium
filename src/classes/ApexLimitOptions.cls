/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global class ApexLimitOptions {

    global static Boolean enableEventLogging {
       get {
            return enableEventLogging != null ? enableEventLogging : (enableEventLogging = true);
       }
       set { 
           enableEventLogging = value != null ? (Boolean) value : true;
       }
    }
    
    global static ApexLimits.Order defaultOrder {
       get {
            return defaultOrder != null ? defaultOrder : (defaultOrder = ApexLimits.Order.DESCENDING);
       }
       set { 
           defaultOrder = value != null ? (ApexLimits.Order) value : ApexLimits.Order.DESCENDING;
       }
    }
}