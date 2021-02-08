package com.animeDB.util;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class Utils {
    //insert hyphen(-) in phone number
    public static String phoneNumberWithHyphen(String s) {
        if (!s.matches("^[0-9]*$"))
            return "";
        if (s.length() == 10) {
            s = s.substring(0, 3) + "-" + s.substring(3, 6) + "-" + s.substring(6);
        } else if (s.length() == 11) {
            s = s.substring(0, 3) + "-" + s.substring(3, 7) + "-" + s.substring(7);
        } else {
            return "";
        }
        return s;
    }

    //Cast birthday string to date
    public static Date castBirthday(String birthday) {
        String[] strBirthday = birthday.split("-");
        for (int i = 1; i >= strBirthday.length; ++i) {
            if (!strBirthday[i].matches("^[0-9]*$"))
                return null;
        }
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            return dateFormat.parse(strBirthday[0] + strBirthday[1] + strBirthday[2]);
        } catch (Exception e) {
            return null;
        }
    }

    //Generate random user key to authenticate with Email
    public static String randomUserKey(boolean lowerCheck, int size) {
        Random ran = new Random();
        StringBuffer sb = new StringBuffer();
        int num = 0;

        do {
            num = ran.nextInt(75) + 48;
            if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
                sb.append((char) num);
            } else {
                continue;
            }
        }while (sb.length() < size);

        if (lowerCheck) {
            return sb.toString().toLowerCase();
        }

        return sb.toString();
    }



    //Load current domain
    public static String getBaseURL(HttpServletRequest request) {
        return request.getRequestURL().toString().replace(request.getRequestURI(), "");
    }

    //Check preview page
    public static boolean checkReferer(HttpServletRequest request) {
        String baseURL = getBaseURL(request);
        String referer = request.getHeader("REFERER") == null ? "" : request.getHeader("REFERER");
        boolean result = false;

        if (!referer.isEmpty()) {
            if (referer.startsWith(baseURL)) {
                result = true;
            }
        }
        return result;
    }

    //Processing search word string
    public static List<String> getSearchKeywordList(String searchKeyword) {
        // Remove blank characters at both ends
        String s = searchKeyword.trim();
        // Remove blanks twice in a row
        while (s.contains("  ")) { s = s.replace("  ", " "); }
        // Remove blank comma
        while (s.contains(" ,")) { s = s.replace(" ,", ","); }
        // Remove comma blanks
        while (s.contains(", ")) { s = s.replace(", ", ","); }
        // Remove comma twice in a row
        while (s.contains(",,")) { s = s.replace(",,", ","); }
        // Remove comma at both ends
        if (!s.isEmpty() && s.charAt(0) == ',') s = s.substring(1, s.length());
        if (!s.isEmpty() && s.charAt(s.length() - 1) == ',') s = s.substring(0, s.length() - 1);

        List<String> searchKeywordList = new ArrayList<String>();
        String keyword = "";
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == ',') {
                searchKeywordList.add(keyword);
                searchKeywordList.add(",");
                keyword = "";
            } else if (s.charAt(i) == ' ') {
                searchKeywordList.add(keyword);
                searchKeywordList.add(" ");
                keyword = "";
            } else {
                keyword += s.charAt(i);
            }
            if (i == s.length() - 1) {
                searchKeywordList.add(keyword);
            }
        }

        return searchKeywordList;
    }

    //Check IE
    public static boolean checkBrowserIE(HttpServletRequest request) {
        boolean isIE = request.getHeader("User-Agent").contains("MSIE") || request.getHeader("User-Agent").contains("Trident");
        return isIE;
    }

    //Check Mobile
    public static boolean checkMobile(HttpServletRequest request) {
        boolean isMobile = request.getHeader("User-Agent").contains("Mobile");
        return isMobile;
    }

    //Check PC
    public static boolean checkPc(HttpServletRequest request) {
        boolean isPc = request.getHeader("User-Agent").contains("Windows") ||
                request.getHeader("User-Agent").contains("CrOS") ||
                request.getHeader("User-Agent").contains("Macintosh") ||
                request.getHeader("User-Agent").contains("X11");
        return isPc;
    }


    //Check browser
    public static String checkBrowser(HttpServletRequest request) {
        String[] knownBrowser = {"Chrome", "Firefox", "Safari", "Opera", "Trident", "edge"};
        String userAgent = request.getHeader("User-Agent");

        for (String browser : knownBrowser) {
            if (userAgent.contains(browser)) {
                return browser;
            }
        }

        return "unknown";
    }
}
