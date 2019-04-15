/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-limits-framework for full license details. *
*************************************************************************************************/

global class SampleBenchMarkerTemplate extends AbstractApexBenchMarkTemplate {

     global SampleBenchMarkerTemplate() {
         super();
     }
     
     global override void benchMarkCode() {
         List<Foo__c> fooList = new List<Foo__c>();         
         for (Integer i = 0; i < 300; i++) {
             Foo__c fooObj = new Foo__c();
             fooObj.TestData__c = 'Foo_____' + i;
             fooList.add(fooObj);
         }
         Database.insert(fooList);
         Database.delete(fooList);
     }
     
     global override String className() {
         return SampleBenchMarkerTemplate.class.getName();
     }
}