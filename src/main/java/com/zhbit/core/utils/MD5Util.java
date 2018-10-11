package com.zhbit.core.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public final class MD5Util {
	public static String getMD5(String str) {
        String reStr = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(str.getBytes());
            byte ss[] = md.digest();
            reStr = bytesString(ss);
        } catch (NoSuchAlgorithmException e) {
        	e.printStackTrace();
        }
        return reStr;
    }
    
    private static String bytesString(byte[] aa) {
        String hash = "";
        for (int i = 0; i < aa.length; i++) {
            int temp;
            if (aa[i] < 0)		
                temp = 256 + aa[i];
            else
                temp = aa[i];
            if (temp < 16)
                hash += "0";
            hash += Integer.toString(temp, 16);
        }
        hash = hash.toUpperCase();
        return hash;
    }
}
