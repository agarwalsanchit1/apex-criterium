global abstract with sharing class SystemEnvironment {

    private static final Organization org = [SELECT Name, OrganizationType, NamespacePrefix, InstanceName, isSandBox from Organization Limit 1];
 
    private SystemEnvironment() { }
    
    global static Organization getOrg() {
        return org;
    }
    
    global static String getName() {
        return org.Name;
    }
    
    global static String getOrganizationType() {
        return org.OrganizationType;
    }
    
    global static String getNameSpacePrefix() {
        return org.NamespacePrefix;
    }
    
    global static String getInstanceName() {
        return org.InstanceName;
    }
    
    global static Boolean isSandBox() {
        return org.isSandBox;
    }
    
    global static Boolean isProduction() {
        return !org.isSandBox;
    }
    
    global Enum OrganizationType {
        Production, 
        SandBox, 
        Developer,
        Unknown
    }
    
    global static OrganizationType findOrganizationType() {
        if (!org.isSandBox) return OrganizationType.Production;
        else if (Org.isSandBox) return OrganizationType.SandBox;
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