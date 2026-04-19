package com.pms.util;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

public class FileUploadUtil {

    private FileUploadUtil() {}

    /**
     * Saves the uploaded image Part to the given absolute directory.
     *
     * @param part            the multipart Part for the file field
     * @param uploadDirAbsPath absolute filesystem path to /images folder
     * @return relative URL stored in DB, e.g. "images/patient_abc123.jpg"
     */
    public static String saveImage(Part part, String uploadDirAbsPath) throws IOException {
        if (part == null || part.getSize() == 0
                || part.getSubmittedFileName() == null
                || part.getSubmittedFileName().isBlank()) {
            return "images/default.png";
        }

        String original  = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String extension = original.contains(".")
                ? original.substring(original.lastIndexOf('.')).toLowerCase()
                : ".jpg";

        String uniqueName = "patient_" + UUID.randomUUID().toString().replace("-", "") + extension;

        File dir = new File(uploadDirAbsPath);
        if (!dir.exists()) dir.mkdirs();

        part.write(uploadDirAbsPath + File.separator + uniqueName);

        return "images/" + uniqueName;
    }
}
