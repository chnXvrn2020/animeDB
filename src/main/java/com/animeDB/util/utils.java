package com.animeDB.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

public class utils {
    // insert hyphen(-) in phone number
    public static String phoneNumberWithHyphen(String s) {
        if (!s.matches("^[0-9]*$")) {
            return "";
        }
        if (s.startsWith("02")) {
            if (s.length() == 9) {
                s = s.substring(0, 2) + "-" + s.substring(2, 5) + "-" + s.substring(5);
            } else if (s.length() == 10) {
                s = s.substring(0, 2) + "-" + s.substring(2, 6) + "-" + s.substring(6);
            } else {
                return "";
            }
        } else {
            if (s.length() == 10) {
                s = s.substring(0, 3) + "-" + s.substring(3, 6) + "-" + s.substring(6);
            } else if (s.length() == 11) {
                s = s.substring(0, 3) + "-" + s.substring(3, 7) + "-" + s.substring(7);
            } else {
                return "";
            }
        }
        return s;
    }

    //insert hyphen(-) in post number
    public static String postNumberWithHyphen(String s) {
        if (!s.matches("^[0-9]*$")) {
            return "";
        }
        if (s.length() == 7) {
            s = s.substring(0, 3) + "-" + s.substring(3);
        } else {
            return "";
        }

        return s;
    }

    //Merge birth year, month and day to birthday
    public static String mergeBirthday(String year, String month, String day) {
        return year + "-" + month + "-" + day;
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

    // Uploading image files(jpg, png, gif, bmp)
    public static String imageFileUpload(MultipartFile file, HttpServletRequest request, String uploadDir) {

        if (uploadDir == null || uploadDir.isEmpty()) return "";

        String fileTemp = "";
        String fileName = file.getOriginalFilename();
        String fileType = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".") + 1) : "";
        if (!fileType.equalsIgnoreCase("jpg") && !fileType.equalsIgnoreCase("jpeg") && !fileType.equalsIgnoreCase("png") && !fileType.equalsIgnoreCase("gif") && !fileType.equalsIgnoreCase("bmp")) return "";
        try {
            if (file.getSize() > 0) {
                fileTemp = fileType.isEmpty() ? LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) : LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) + "." + fileType;
                String realUploadDir = "/upload/images/" + uploadDir;
                fileTemp = getUniqueFileName(realUploadDir, fileTemp);
                String filePath = realUploadDir + "/" + fileTemp;

                File dir = new File(realUploadDir);
                if (!dir.exists()) dir.mkdirs();

                java.io.File f = new java.io.File(filePath);
                file.transferTo(f);

            }

        } catch (IOException e) {
            return "";
        }

        return fileTemp;
    }

    // delete files
    public static void fileDelete(String uploadDir, String file) {
        File f = new File("/upload/" + uploadDir + "/" + file);
        if (f.exists()) f.delete();
    }

    //check duplicated files
    public static String getUniqueFileName(String uploadDir, String file) {
        int fileCnt = 0;
        String fileName = file.substring(0, file.lastIndexOf("."));
        String ext = file.contains(".") ? file.substring(file.lastIndexOf(".") + 1) : "";

        while (true) {
            fileCnt++;
            String filePath = ext.isEmpty() ? uploadDir + "/" + fileName : uploadDir + "/" + fileName + "." + ext;
            java.io.File f = new java.io.File(filePath);
            if (!f.exists()) {
                break;
            } else {
                fileName = file.substring(0, file.lastIndexOf(".")) + "_" + fileCnt;
            }
        }

        String result = fileName + "." + ext;

        return result;
    }
}
