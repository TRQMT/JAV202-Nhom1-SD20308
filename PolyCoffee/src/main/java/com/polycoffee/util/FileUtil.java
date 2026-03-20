package com.polycoffee.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class FileUtil {
	private static final String FOLDER = "/uploads";
	// Upload file vào /upload
	public static String upload(HttpServletRequest request, String name) throws IOException {
		try {
			Part part = request.getPart(name);
	        String fileName = part.getSubmittedFileName();
	        if (fileName == null || fileName.isBlank()) {
	        	return null;
	        }

	        String ext = "";
	        int dotIndex = fileName.lastIndexOf('.');
	        if (dotIndex >= 0) {
	        	ext = fileName.substring(dotIndex);
	        }

	        String uniqueName = System.currentTimeMillis() + ext;

	        String uploadRoot = request.getServletContext().getRealPath(FOLDER);
	        Path uploadDir;
	        if (uploadRoot != null) {
	        	uploadDir = Paths.get(uploadRoot);
	        } else {
	        	uploadDir = Paths.get(System.getProperty("java.io.tmpdir"), "polycoffee", "uploads");
	        }

	        Files.createDirectories(uploadDir);
	        Path target = uploadDir.resolve(uniqueName);
	        part.write(target.toString());
	        return uniqueName;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
	
	// Xóa file trong /upload
    public static boolean delete(HttpServletRequest request, String fileName) {
    	try {
	        if (fileName == null || fileName.isEmpty()) return false;
	        String realPath = request.getServletContext().getRealPath(FOLDER);
	        if (realPath == null) {
	        	return false;
	        }
	        File file = new File(realPath, fileName);
	        return file.exists() && file.isFile() && file.delete();
    	} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
    }

}
