/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-limits-framework for full license details. *
*************************************************************************************************/

global abstract class AbstractApexBenchMarkTemplate extends ApexBaseObject {

    global ApexLimits.IApexLimitStylePrinter beforeLimitPrinterStyle {
        get;
        set {
            this.beforeLimitPrinterStyle = (value == null) ? new BeforeExecutionApexLimitPrintStyle() : (ApexLimits.IApexLimitStylePrinter) this.beforeLimitPrinterStyle;
        }
    }
    
    global ApexLimits.IApexLimitStylePrinter afterLimitPrinterStyle {
        get; 
        set {
            this.afterLimitPrinterStyle = (value == null) ? new AfterExecutionApexLimitPrintStyle() : (ApexLimits.IApexLimitStylePrinter) this.afterLimitPrinterStyle;
        }
    }
    
    global AbstractApexBenchMarkTemplate() {
        this(null, null);
    }
    
    global AbstractApexBenchMarkTemplate(ApexLimits.IApexLimitStylePrinter beforeLimitPrinterStyle, ApexLimits.IApexLimitStylePrinter afterLimitPrinterStyle) {
        super();
        this.beforeLimitPrinterStyle = beforeLimitPrinterStyle; this.afterLimitPrinterStyle = afterLimitPrinterStyle;
    }
    
    global void printApexLimit(ApexLimits.ApexLimitType paramLimitType, ApexLimits.IApexLimitStylePrinter printStyle) {
        ApexLimits.apexLimitForType(paramLimitType).printApexLimit(printStyle);
    }
    
    global void printBeforeLimits() {
        ApexLimits.printApexLimit(this.beforeLimitPrinterStyle);
    }
    
    global void printAfterLimits() {
        ApexLimits.printApexLimit(this.afterLimitPrinterStyle);
    }
    
    global abstract void benchMarkCode();
    
    global void runBenchMarkCode() {
        Long startAt = System.now().getTime();
        this.printBeforeLimits();        
        System.debug('Executing started at ' + startAt + ' ms');
        this.benchMarkCode();        
        Long endedAt = System.now().getTime();
        System.debug('Executing ended at '+ endedAt  + ' ms. The total time taken to execute the code is : ' + (endedAt - startAt) + ' ms.');
        this.printAfterLimits();
    }
    
    global class BeforeExecutionApexLimitPrintStyle implements ApexLimits.IApexLimitStylePrinter {
    
        global void printStyle(ApexLimits.ApexLimit paramLimit) {
            System.debug('Before Executing ' + paramLimit.toString());
        }
    } 
    
    global class AfterExecutionApexLimitPrintStyle implements ApexLimits.IApexLimitStylePrinter {
    
        global void printStyle(ApexLimits.ApexLimit paramLimit) {
            System.debug('After Executing ' + paramLimit.toString());
        }
    }
}