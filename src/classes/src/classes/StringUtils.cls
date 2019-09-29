global class StringUtils {

    global static String joinArray(Object[] objectArray) {
        return joinArray(objectArray, null);
    }
    
    global static String joinArray(Object[] objectArray, String separator) {
        if (objectArray == null) {
            return null;
        }
        return joinArray(objectArray, separator, 0, objectArray.size());
    }

    global static String joinArray(Object[] objectArray, String separator, Integer startIndex, Integer endIndex) {
        if (objectArray == null) {
            return null;
        }
        if (separator == null) {
            separator = ApexBaseObject.EMPTY_STRING;
        }

        String buf = '';
        if(startIndex < 0){
            startIndex = 0;
        }
        Boolean isFirst = true;
        for (Integer i = startIndex; i < endIndex && i < objectArray.size(); i++) {
            if(objectArray[i] != null) {
	            if(isFirst){
	                isFirst = false;
	            } else {
	                buf += separator;
	            }
	            buf += objectArray[i];
            }
        }
        return buf;
    }
}