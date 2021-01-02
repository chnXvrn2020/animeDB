package com.animeDB.util;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Set;

public class FileUtil {

    // Uploading image files(jpg, png, gif, bmp)
    public static String imageFileUpload(MultipartFile file, String serverDir, String uploadDir) {

        if (uploadDir == null || uploadDir.isEmpty()) return "";

        String fileTemp = "";
        String fileName = file.getOriginalFilename();
        String fileType = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".") + 1) : "";
        if (!fileType.equalsIgnoreCase("jpg") && !fileType.equalsIgnoreCase("jpeg") && !fileType.equalsIgnoreCase("png") && !fileType.equalsIgnoreCase("gif") && !fileType.equalsIgnoreCase("bmp")) return "";
        try {
            if (file.getSize() > 0) {
                fileTemp = fileType.isEmpty() ? LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) : LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) + "." + fileType;
                String realUploadDir = serverDir + "/upload/images/" + uploadDir;
                fileTemp = getUniqueFileName(uploadDir, fileTemp);
                String filePath = realUploadDir + "/" + fileTemp;

                File dir = new File(realUploadDir);
                if (!dir.exists()) dir.mkdirs();

                java.io.File f = new java.io.File(filePath);
                file.transferTo(f);

                Path img = Paths.get(filePath);
                Set<PosixFilePermission> pfp = PosixFilePermissions.fromString("rwxr-xr-x");
                Files.setPosixFilePermissions(img, pfp);
            }

        } catch (IOException e) {
            return "";
        }

        return fileTemp;
    }

    // remove files
    public static void fileDelete(String serverDir, String uploadDir, String file) {
        File f = new File(serverDir + "/upload/" + uploadDir + "/" + file);
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
