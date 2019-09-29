global class ApexMapUtils {

    global static List<String> joinMap(Map<String,String> theMap, String keyValueSeparator){
        return joinx(theMap, keyValueSeparator);
    }

    global static List<String> joinx(Map<String,String> theMap, String keyValueSeparator){
        List<String> returnValue = null;
        if(theMap != null){
            returnValue = new List<String>();
            if(theMap.size() > 0){
                final List<String> keys = new List<String>();
                keys.addAll(theMap.keySet());
                keys.sort();
                for(String key : keys){
                    returnValue.add(key + keyValueSeparator + theMap.get(key));
                }
            }
        }
        return returnValue;
    }

    global static String joinMap(Map<String,String> theMap, String keyValueSeparator, String recordSeparator){
        return joinx(theMap, keyValueSeparator, recordSeparator);
    }

    global static String joinx(Map<String,String> theMap, String keyValueSeparator, String recordSeparator){
        String returnValue = null;
        if(theMap != null){
            returnValue = '';
            if(theMap.size() > 0){
                returnValue = StringUtils.joinArray(joinMap(theMap,keyValueSeparator), recordSeparator);
            }
        }
        return returnValue;
    }

    global static String toString(Map<String,String> theMap){
        return '<Map#([' + joinMap(theMap,'=',';') + '])>';
    }
}