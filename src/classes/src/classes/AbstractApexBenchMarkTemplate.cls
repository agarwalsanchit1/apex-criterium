/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global abstract class AbstractApexBenchMarkTemplate extends ApexBaseObject {
    
    global ApexLimits.IApexLimitStylePrinter beforeLimitPrinterStyle {
        get;
        set {
            this.beforeLimitPrinterStyle = (value == null) ? new SimpleFormatBasedApexLimitPrintStyle('Before Execution {0}') : (ApexLimits.IApexLimitStylePrinter) this.beforeLimitPrinterStyle;
        }
    }
    
    global ApexLimits.IApexLimitStylePrinter afterLimitPrinterStyle {
        get; 
        set {
            this.afterLimitPrinterStyle = (value == null) ? new SimpleFormatBasedApexLimitPrintStyle('After Execution {0}') : (ApexLimits.IApexLimitStylePrinter) this.afterLimitPrinterStyle;
        }
    }
    
    global AbstractApexBenchMarkTemplate() {
        this(null, null);
    }
    
    global AbstractApexBenchMarkTemplate(ApexLimits.IApexLimitStylePrinter beforeLimitPrinterStyle, ApexLimits.IApexLimitStylePrinter afterLimitPrinterStyle) {
        super();
        this.beforeLimitPrinterStyle = beforeLimitPrinterStyle; this.afterLimitPrinterStyle = afterLimitPrinterStyle;
    }
    
    global void printApexLimitFor(ApexLimits.ApexLimitType paramLimitType, ApexLimits.IApexLimitStylePrinter printStyle) {
        ApexLimits.apexLimitForType(paramLimitType).printApexLimit(printStyle);
    }
    
    global void printBeforeLimits() {
        ApexLimits.getIApexLimitHolder().printAllApexLimits(this.beforeLimitPrinterStyle);
    }
    
    global void printAfterLimits() {
        ApexLimits.getIApexLimitHolder().printAllApexLimits(this.afterLimitPrinterStyle, ApexLimits.ApexLimitsSortingType.BY_CONSUMED_VALUE, false);
    }
    
    global abstract void benchMarkCode();
    
    global void run(Integer times) {
        for (Integer i = 0; i < times; i++) {
            this.runBenchMarkCode();
        }
    }
    
    global void run() {
        this.run(1);
    }
    
    global void runBenchMarkCode() {
        this.printBeforeLimits();
        Long startAt = System.now().getTime();       
        System.debug('Executing started at ' + startAt + ' ms');
        this.benchMarkCode();        
        Long endedAt = System.now().getTime();
        System.debug('Executing ended at '+ endedAt  + ' ms. The total time taken to execute the code is : ' + (endedAt - startAt) + ' ms.');
        this.printAfterLimits();
    }
}