package com.TechBlog.Helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {
	public static boolean deleteFile(String path) {
		boolean stats=false;
		try {
			File file=new File(path);
			stats=file.delete();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return stats;
	}
	public static boolean saveFile(InputStream inputStream, String path) {
		boolean stats=false;
		try {
			byte[] b=new byte[inputStream.available()];
			inputStream.read(b);
			FileOutputStream fileOutputStream=new FileOutputStream(path);
			fileOutputStream.write(b);
			fileOutputStream.flush();
			fileOutputStream.close();
			stats=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stats;
	}
}
