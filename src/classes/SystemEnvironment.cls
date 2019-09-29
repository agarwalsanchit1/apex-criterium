/*************************************************************************************************
* This file is part of the apex-criterium project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-criterium for full license details. *
*************************************************************************************************/

global abstract with sharing class SystemEnvironment {
    
    private static final Organization org;
    
    private SystemEnvironment() { }
    
    global static Organization getOrg() {
        return org == null ? (Organization) [SELECT Name, OrganizationType, NamespacePrefix, InstanceName, isSandBox from Organization Limit 1] : org;
    }
    
    global static String getName() {
        return getOrg().Name;
    }
    
    global static String getOrganizationType() {
        return getOrg().OrganizationType;
    }
    
    global static String getNameSpacePrefix() {
        return getOrg().NamespacePrefix;
    }
    
    global static String getInstanceName() {
        return getOrg().InstanceName;
    }
    
    global static Boolean isSandBox() {
        return getOrg().isSandBox;
    }
    
    global static Boolean isProduction() {
        return !getOrg().isSandBox;
    }
    
    global Enum OrganizationType {
        Production, 
            SandBox, 
            Developer,
            DeveloperPro,
            PartialCopy,
            Partner_Developer,
            Full,  
            Unknown
            }
    
    global static OrganizationType findOrganizationType() {
        if (!getOrg().isSandBox) return OrganizationType.Production;
        else if (getOrg().isSandBox) return OrganizationType.SandBox;
        else if (isDevOrg()) return OrganizationType.Developer;
        return OrganizationType.Unknown;
    }
    
    global static Boolean isDevOrg() {
        return String.valueOf(SystemEnvironment.getOrganizationType()).equals('Developer Edition');
    }
    
    global static String className() {
        return SystemEnvironment.class.getName();
    }
}
