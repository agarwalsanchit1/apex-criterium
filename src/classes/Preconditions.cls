/*************************************************************************************************
* This file is part of the apex-limit-framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/agarwalsanchit1/apex-events-trigger-framework for full license details. *
*************************************************************************************************/

global abstract class Preconditions {
    
    public static void checkArgument(boolean expression, String errorMessageTemplate, List<Object> errorMessageArgs) {
        if (!expression) {
            throw new IllegalArgumentException(format(errorMessageTemplate, errorMessageArgs));
        }
    }
    
    public static void checkArgument(boolean expression) {
        if (!expression) {
            throw new IllegalArgumentException();
        }
    }
    
    public static void checkState(boolean expression) {
        if (!expression) {
            throw new IllegalStateException();
        }
    }
    
    public static void checkState(boolean expression, Object errorMessage) {
        if (!expression) {
            throw new IllegalStateException(String.valueOf(errorMessage));
        }
    }
    
    public static void checkArgument(boolean expression, Object errorMessage) {
        if (!expression) {
            throw new IllegalArgumentException(String.valueOf(errorMessage));
        }
    }
    
    public static Object checkNotNull(Object reference) {
        if (reference == null) {
            throw new NullPointerException();
        }
        return reference;
    }

    public static Object checkNotNull(Object reference, Object errorMessage) {
        if (reference == null) {
            throw new NullPointerException(String.valueOf(errorMessage));
        }
        return reference;
    }
    
    public static String isEmptyString(final String reference, Object errorMessage) {
        if (String.isBlank(reference)) {
            throw new IllegalArgumentException(String.valueOf(errorMessage));
        }
        return reference;
    }
    
    public static String isEmptyString(final String reference) {
        if (String.isBlank(reference)) {
            throw new IllegalArgumentException('The string must be empty or null.');
        }
        return reference;
    }
    
    public static String isEmptyString(final String reference, String errorMessage) {
        if (String.isBlank(reference)) {
            throw new IllegalArgumentException(errorMessage);
        }
        return reference;
    }

    public static Object checkNotNull(Object reference, String errorMessageTemplate, List<Object> errorMessageArgs) {
        if (reference == null) {
            throw new NullPointerException(format(errorMessageTemplate, errorMessageArgs));
        }
        return reference;
    } 
    
    static String format(String errorMessageTemplate, List<Object> errorMessageArgs) {
        return String.format(errorMessageTemplate, errorMessageArgs);
    }
}