package egovframework.let.com.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetVO;

public interface CommonService {
	
	public int InsertXcptInfo(HashMap<String, String> xcpt);

	public void excelAssetUpload(HttpServletRequest request, AssetManageVO assetManageVO) throws Exception;
	
	public void excelUserUpload(HttpServletRequest request) throws Exception;
	 
	
}

