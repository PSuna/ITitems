package egovframework.let.com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import egovframework.let.ass.service.AssetManageVO;

public interface CommonService {
	
	public int InsertXcptInfo(HashMap<String, String> xcpt);

	public Map<String, Object> excelAssetUpload(HttpServletRequest request, AssetManageVO assetManageVO) throws Exception;
	
	public void excelUserUpload(HttpServletRequest request) throws Exception;

	public Map<String, Object> excelRentalUpload(HttpServletRequest request, AssetManageVO assetManageVO) throws Exception;
	 
	
}

