package egovframework.let.com.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import egovframework.let.com.service.CommonService;
import egovframework.let.com.service.ExcelUtil;
import egovframework.let.com.service.StringUtil;

@Service("CommonService")
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService  {
	 
	@Resource(name = "CommonDAO")
	private CommonDAO commonDAO;
	   
	@Override
	public int InsertXcptInfo(HashMap<String, String> xcpt) {
		
		return commonDAO.InsertXcptInfo(xcpt);
	}
	
	/**
	 * 엑셀 업로드 처리
	 * @param multiRequest
	 * @return String
	 * @throws Exception
	 */
	/**
	@SuppressWarnings("unchecked")
	public void excelUpload(HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
		//파일 정보
		CommonsMultipartFile file = (CommonsMultipartFile)multiRequest.getFile("excelFile");
		//엑셀정보
		ExcelUtil eu = new ExcelUtil();
		int sheetNum = 0;		//1번째 시트 읽음 
		int strartRowNum = 1;	//2번째 줄부터 읽음
		int startCelNum = 2; 	//3번째 줄부터 읽음(지역ID)
		List<HashMap<Integer, String>> excelList = eu.excelReadSetValue(file, sheetNum, strartRowNum, startCelNum);
		//테이블 Key 정보
		DeviceBaseVO deviceBaseVO = null;
		//엑셀 Row 수 만큼 For문 조회 
		for(Object obj : excelList) {
			Map<Integer, String> mp = (Map<Integer, String>)obj;
			Set<Integer> keySet = mp.keySet();
			Iterator<Integer> iterator = keySet.iterator();
			deviceBaseVO = new DeviceBaseVO();
			while(iterator.hasNext()) {
				int key = iterator.next();
				String value = StringUtil.nullConvert(mp.get(key));
				switch(key) {
				case 2 :
					deviceBaseVO.setAreaId(value);
					break;
				case 4 :
					deviceBaseVO.setFacilityId(value);
					break;
				case 5 :
					deviceBaseVO.setDeviceNm(value);
					break;
				case 6 :
					deviceBaseVO.setDeviceId(value);
					break;
				case 7 :
					deviceBaseVO.setInstDt(value);
					break;
				case 8 :
					deviceBaseVO.setUseYn(value);
					break;
				}
			}
			if(!"".equals(deviceBaseVO.getAreaId()) && deviceBaseVO.getAreaId() != null) {
				cfgMapper.updateCfgInfo(deviceBaseVO);
			}
		}
	}*/
}

