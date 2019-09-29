/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global abstract class ApexBaseObject implements IClassName {
    
    global static final String EMPTY_STRING = '';
    
    global ApexBaseObject() {}
    
    global abstract String className();
    
    global virtual System.Type getType() { try { return Type.forName(this.className()); } catch(TypeException e) { throw e; } }
    
    global virtual String uniqueID() { return EMPTY_STRING + this.hashCode(); }
    
    global virtual String identity() { return this.className() + '@' + System.hashCode(this); }
    
    global virtual Integer indentityHashCode() { return System.hashCode(this); }   
    
    global override virtual String toString() { return this.identity(); }
    
    global virtual Integer hashCode() { return Crypto.getRandomInteger(); }     
    
    global virtual String toJsonString(boolean pretty) { return pretty ? JSON.serializePretty(this) : JSON.serialize(this); }   
    
    global virtual String toJsonString() { return this.toJsonString(false); }
    
    global virtual String toPrettyJsonString() { return this.toJsonString(true); }
    
    global virtual void printPretty(System.LoggingLevel lvl) { System.debug(lvl == null ? LoggingLevel.INFO : lvl, this.toPrettyJsonString()); } 
	
    global virtual void printPretty() { this.printPretty(System.LoggingLevel.DEBUG); } 
	
    global virtual void print(System.LoggingLevel lvl) { System.debug(lvl == null ? LoggingLevel.INFO : lvl, this.toJsonString(false)); } 
    
    global virtual void print() { this.print(System.LoggingLevel.DEBUG); } 
    
    global virtual void initObject() { } // to allocate resources at the time of object initialization
    
    global virtual void reset() { } // apex-life cycle management
    
    global virtual ApexBaseObject self() { return this; }
}