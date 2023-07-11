package egovframework.com.cmm.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.LogVO;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

/**
 * @Class Name : EgovCmmUseServiceImpl.java
 * @Description : 공통코드등 전체 업무에서 공용해서 사용해야 하는 서비스를 정의하기위한 서비스 구현 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@Service("EgovCmmUseService")
public class EgovCmmUseServiceImpl extends EgovAbstractServiceImpl implements EgovCmmUseService {

	@Resource(name = "cmmUseDAO")
	private CmmUseDAO cmmUseDAO;

	/**
	 * 공통코드를 조회한다.
	 *
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<CmmnDetailCode> selectCmmCodeDetail(ComDefaultCodeVO vo) throws Exception {
		return cmmUseDAO.selectCmmCodeDetail(vo);
	}

	/**
	 * ComDefaultCodeVO의 리스트를 받아서 여러개의 코드 리스트를 맵에 담아서 리턴한다.
	 *
	 * @param voList
	 * @return
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public Map<String, List<CmmnDetailCode>> selectCmmCodeDetails(List voList) throws Exception {
		ComDefaultCodeVO vo;
		Map<String, List<CmmnDetailCode>> map = new HashMap<String, List<CmmnDetailCode>>();

		Iterator<?> iter = voList.iterator();
		while (iter.hasNext()) {
			vo = (ComDefaultCodeVO) iter.next();
			map.put(vo.getCodeId(), cmmUseDAO.selectCmmCodeDetail(vo));
		}

		return map;
	}

	/**
	 * 조직정보를 코드형태로 리턴한다.
	 *
	 * @param 조회조건정보 vo
	 * @return 조직정보 List
	 * @throws Exception
	 */
	@Override
	public List<CmmnDetailCode> selectOgrnztIdDetail(ComDefaultCodeVO vo) throws Exception {
		return cmmUseDAO.selectOgrnztIdDetail(vo);
	}

	/**
	 * 그룹정보를 코드형태로 리턴한다.
	 *
	 * @param 조회조건정보 vo
	 * @return 그룹정보 List
	 * @throws Exception
	 */
	@Override
	public List<CmmnDetailCode> selectGroupIdDetail(ComDefaultCodeVO vo) throws Exception {
		return cmmUseDAO.selectGroupIdDetail(vo);
	}

	
	/**
     * 공통코드를 단일 조회한다.
     */
	@Override
	public CmmnDetailCode selectCodeDetail(ComDefaultCodeVO vo) throws Exception {

		return cmmUseDAO.selectCodeDetail(vo);
	}

	@Override
	public List<CmmnDetailCode> selectOgrnztIdUpDetail(ComDefaultCodeVO vo) throws Exception {
		return cmmUseDAO.selectOgrnztIdUpDetail(vo);
	}

	@Override
	public List<CmmnDetailCode> selectAuthorCodeDetail(ComDefaultCodeVO vo) {
		return cmmUseDAO.selectAuthorCodeDetail(vo);
	}

	@Override
	public LogVO broswserInfo(HttpServletRequest request) {
		  
		  String agent = request.getHeader("USER-AGENT");
		  
		  String os = getClientOS(agent);
		  String broswser = getClientBrowser(agent);
		  String ip = (String)request.getHeader("X-Forwarded-For");
		  if(ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown")) ip = (String)request.getRemoteAddr();
		  LogVO logVO = new LogVO();
		  Map<String, Object> map = new HashMap<String, Object>();
		  logVO.setOs(os);
		  logVO.setBroswser(broswser);
		  logVO.setHeader(agent);
		  
		  return logVO;
	}
	
	 
	public static String getClientOS(String userAgent) {            
	  String os = "";            
	userAgent = userAgent.toLowerCase();
	if (userAgent.indexOf("windows nt 10.0") > -1) {
	    os = "Windows10";
	}else if (userAgent.indexOf("windows nt 6.1") > -1) {
	    os = "Windows7";
	}else if (userAgent.indexOf("windows nt 6.2") > -1 || userAgent.indexOf("windows nt 6.3") > -1 ) {
	    os = "Windows8";
	}else if (userAgent.indexOf("windows nt 6.0") > -1) {
	    os = "WindowsVista";
	}else if (userAgent.indexOf("windows nt 5.1") > -1) {
	    os = "WindowsXP";
	}else if (userAgent.indexOf("windows nt 5.0") > -1) {
	    os = "Windows2000";
	}else if (userAgent.indexOf("windows nt 4.0") > -1) {
	    os = "WindowsNT";
	}else if (userAgent.indexOf("windows 98") > -1) {
	    os = "Windows98";
	}else if (userAgent.indexOf("windows 95") > -1) {
	    os = "Windows95";
	}else if (userAgent.indexOf("iphone") > -1) {
	    os = "iPhone";
	}else if (userAgent.indexOf("ipad") > -1) {
	    os = "iPad";
	}else if (userAgent.indexOf("android") > -1) {
	    os = "android";
	}else if (userAgent.indexOf("mac") > -1) {
	    os = "mac";
	}else if (userAgent.indexOf("linux") > -1) {
	    os = "Linux";
	}else{
	    os = "Other";
	}            
	  return os;
	}
	 
	 
	 
	public static String getClientBrowser(String userAgent) {
	  String browser = "";
	  
	  if (userAgent.indexOf("Trident/7.0") > -1) {
	    browser = "ie11";
	}
	  else if (userAgent.indexOf("MSIE 10") > -1) {
	    browser = "ie10";
	}
	else if (userAgent.indexOf("MSIE 9") > -1) {
	    browser = "ie9";
	}
	else if (userAgent.indexOf("MSIE 8") > -1) {
	    browser = "ie8";
	}
	else if (userAgent.indexOf("Chrome/") > -1) {
	    browser = "Chrome";
	}
	else if (userAgent.indexOf("Chrome/") == -1 && userAgent.indexOf("Safari/") >= -1) {
	    browser = "Safari";
	}
	else if (userAgent.indexOf("Firefox/") >= -1) {
	    browser = "Firefox";
	}
	else {
	    browser ="Other";
	}
	  return browser;
	}

	@Override
	public int InsertActionLog(LogVO logVO) {
		
		return cmmUseDAO.InsertActionLog(logVO);
	}
}
