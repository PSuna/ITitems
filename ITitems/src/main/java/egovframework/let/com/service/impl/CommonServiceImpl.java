package egovframework.let.com.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetVO;
import egovframework.let.ass.service.impl.AssetDAO;
import egovframework.let.com.service.CommonService;
import egovframework.let.com.service.ExcelUtil;
import egovframework.let.com.service.StringUtil;
import egovframework.let.sec.rgm.service.AuthorGroup;
import egovframework.let.sec.rgm.service.impl.AuthorGroupDAO;
import egovframework.let.uss.umt.service.UserManageVO;
import egovframework.let.uss.umt.service.impl.UserManageDAO;
import egovframework.let.utl.sim.service.EgovFileScrty;

@Service("CommonService")
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService  {
	 
	@Resource(name = "CommonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name="authorGroup")
    private AuthorGroup authorGroup;
	
	@Resource(name = "AssetDAO")
	private AssetDAO assetDAO;
	
	@Resource(name = "AssetIdGnrService")
	private EgovIdGnrService assetIdGnrService;
	
	/** egovUsrCnfrmIdGnrService */
	@Resource(name="egovUsrCnfrmIdGnrService")
	private EgovIdGnrService idgenService;
	
	/** userManageDAO */
	@Resource(name="userManageDAO")
	private UserManageDAO userManageDAO;
	
	/** authorGroupDAO */
	@Resource(name="authorGroupDAO")
    private AuthorGroupDAO authorGroupDAO;
	
	@Override
	public int InsertXcptInfo(HashMap<String, String> xcpt) {
		
		return commonDAO.InsertXcptInfo(xcpt);
	}
	
	/**
	 * 엑셀 자산 업로드 처리
	 * @param multiRequest
	 * @return String
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> excelAssetUpload(HttpServletRequest request, AssetManageVO assetManageVO) throws Exception{
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
		Map<String, String> tmp = new HashMap<>();
		//파일 정보
		CommonsMultipartFile file = (CommonsMultipartFile)multiRequest.getFile("excelFile");
		//엑셀정보
		ExcelUtil eu = new ExcelUtil();
		int sheetNum = 0;		//1번째 시트 읽음 
		int strartRowNum = 2;	//3번째 줄부터 읽음
		int startCelNum = 0; 	//2번째 줄부터 읽음(지역ID)
		List<HashMap<Integer, String>> excelList = eu.excelReadSetValue(file, sheetNum, strartRowNum, startCelNum);
		//테이블 Key 정보
		AssetVO assetVO = null;
		int rowNum = 4;
		//엑셀 Row 수 만큼 For문 조회 
		for(Object obj : excelList) {
			Map<Integer, String> mp = (Map<Integer, String>)obj;
			Set<Integer> keySet = mp.keySet();
			Iterator<Integer> iterator = keySet.iterator();
			assetVO = new AssetVO();
			while(iterator.hasNext()) {
				int key = iterator.next();
				String value = StringUtil.nullConvert(mp.get(key));
				switch(key) {
				case 1 :
					assetVO.setRcptDate(value);
					break;
				case 2 :
					assetVO.setRcptNm(value);
					break;
				case 3 :
					assetVO.setMiddleCategory(value);
					break;
				case 4 :
					assetVO.setUseNm(value);
					break;
				case 5 :
					assetVO.setAssetSn(value);
					break;
				case 6 :
					assetVO.setAssetName(value);
					break;
				case 7 :
					assetVO.setMaker(value);
					break;
				case 8 :
					assetVO.setNote(value);
					break;	
				}
			}
			if(!"".equals(assetVO.getRcptNm()) && assetVO.getRcptNm() != null) {
				if(!"".equals(assetVO.getMiddleCategory()) && assetVO.getMiddleCategory() != null) {
					LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
					String id = assetIdGnrService.getNextStringId();
					assetVO.setAssetId(id);
					assetVO.setAssId("ASSMSTR_000000000001");
					assetVO.setAssetStauts("C2");
					assetVO.setUsageStauts("U1");
					assetVO.setLargeCategory(assetManageVO.getSearchLCat());
					assetVO.setOrgnztId(assetManageVO.getSearchOrgnzt());
					assetVO.setLowerOrgnztId(assetManageVO.getLowerOrgnzt());
					assetVO.setPrjId(assetManageVO.getSearchPrj());
					assetVO.setCreatId(user.getUniqId());
					int r = assetDAO.InsertExcelAsset(assetVO);
					System.out.println("result>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+r);
					if(r!=0) {
						tmp.put("errorMessage", rowNum+"번째 행의 시리얼넘버는 중복된 값입니다.");
						
					}else {
						tmp.put("errorMessage", "입력완료");
					}
				}else {
					tmp.put("errorMessage", rowNum+"번째 행의 분류가 입력되지 않았습니다.");
				}
			}else {
				tmp.put("errorMessage", rowNum+"번째 행의 수령자가 입력되지 않았습니다.");
			}
			rowNum++;
		}
		return tmp;
	}
	
	/**
	 * 엑셀 사용자 업로드 처리
	 * @param multiRequest
	 * @return String
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void excelUserUpload(HttpServletRequest request) throws Exception{
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
		UserManageVO userManageVO = null;
		//엑셀 Row 수 만큼 For문 조회 
		for(Object obj : excelList) {
			Map<Integer, String> mp = (Map<Integer, String>)obj;
			Set<Integer> keySet = mp.keySet();
			Iterator<Integer> iterator = keySet.iterator();
			userManageVO = new UserManageVO();
			while(iterator.hasNext()) {
				int key = iterator.next();
				String value = StringUtil.nullConvert(mp.get(key));
				switch(key) {
				case 2 :
					userManageVO.setEmplyrId(value);
					break;
				case 4 :
					userManageVO.setEmplyrNm(value);
					break;
				case 5 :
					userManageVO.setMoblphonNo(value);
					break;
				case 6 :
					userManageVO.setOrgnztId(value);
					break;
				case 7 :
					userManageVO.setGrade(value);
					break;
				case 8 :
					userManageVO.setEmpUniqNum(value);
					break;
				}
			}
			if(!"".equals(userManageVO.getEmplyrId()) && userManageVO.getEmplyrId() != null) {
				//고유아이디 셋팅
				String uniqId = idgenService.getNextStringId();
				userManageVO.setUniqId(uniqId);
				//패스워드 암호화
				String pass = EgovFileScrty.encryptPassword("iteyes00", userManageVO.getEmplyrId());
				userManageVO.setPassword(pass);
				authorGroup.setUniqId(uniqId);
				authorGroup.setAuthorCode(userManageVO.getAuthorCode());
				userManageDAO.insertUser(userManageVO);
				authorGroupDAO.insertAuthorGroup(authorGroup);
			}
		}
	}
}

