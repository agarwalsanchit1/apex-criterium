/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-limits-framework for full license details. *
*************************************************************************************************/

global abstract class ApexBaseObject implements IClassName {
    
    global static final String EMPTY_STRING = '';
    
    global ApexBaseObject() {}
 
    global abstract String className();
    
    global virtual System.Type getType() { try { return Type.forName(this.className()); } catch(TypeException e) { throw e; } }
    
    global virtual String uniqueID() {
        return EMPTY_STRING + this.hashCode();
    }
    
    global virtual String identity() {
        return this.className() + '@' + System.hashCode(this);
    }
    
    global virtual Integer indentityHashCode() {
        return System.hashCode(this);
    }   
    
    global override virtual String toString() {
        return this.identity();
    }
    
    global virtual Integer hashCode() {
        return Crypto.getRandomInteger();
    }
}