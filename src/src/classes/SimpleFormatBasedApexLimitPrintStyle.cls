/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global class SimpleFormatBasedApexLimitPrintStyle extends ApexBaseObject implements ApexLimits.IApexLimitStylePrinter {
    
    private String formatStyle;
    
    global SimpleFormatBasedApexLimitPrintStyle(final String paramFormatStyle) { super(); this.formatStyle = Preconditions.isEmptyString(paramFormatStyle,
                                                                                                                                         'The paramFormatStyle must be empty or null.'); }
    
    global void printStyle(ApexLimits.ApexLimit paramLimit) {
        System.debug(String.format(this.formatStyle, new List<Object> { paramLimit.toString() }));
    }
    
    global String getFormatStyle() { return this.formatStyle; }
    
    global override String className() { return SimpleFormatBasedApexLimitPrintStyle.class.getName(); }
    
    global override String toString() { return String.format('to format apex limit with format style {0}', new List<String> { this.formatStyle}); }
}