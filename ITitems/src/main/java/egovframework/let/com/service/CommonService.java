package egovframework.let.com.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface CommonService {
	
	public int InsertXcptInfo(HashMap<String, String> xcpt);

	public void excelAssetUpload(HttpServletRequest request) throws Exception;
	
	//public void excelUserUpload(HttpServletRequest request) throws Exception;
	 
	
}

