package kr.co.acorn.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class CompareTime {
	public static String changeTime(String time) {
		String after = null;
		
		after = time.replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
		
		after = after.substring(0, after.length()-2);
		
		return after;
		
	}
	
	public static String getNowTime() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		return sdf.format(cal.getTime());
	}
	
	
	// isLater true => second is later
	public static boolean compareTime(String first, String second) {
		boolean isLater = false;
		
		if(Long.parseLong(first) < Long.parseLong(second)) {
			isLater = true;
		} 
		
		return isLater;
	}
	
	
}
