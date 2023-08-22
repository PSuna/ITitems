package egovframework.let.res.cop.bbs.mob;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.res.cop.bbs.service.Board;
import egovframework.let.res.cop.bbs.service.BoardMaster;
import egovframework.let.res.cop.bbs.service.BoardMasterVO;
import egovframework.let.res.cop.bbs.service.BoardVO;
import egovframework.let.res.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.let.res.cop.bbs.service.EgovBBSManageService;

@RestController
public class MobEgovBBSManageController {
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;
	
	@Resource(name = "EgovBBSManageService")
	private EgovBBSManageService bbsMngService;

	@Resource(name = "EgovBBSAttributeManageService")
	private EgovBBSAttributeManageService bbsAttrbService;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * XSS 방지 처리.
	 *
	 * @param data
	 * @return
	 */
	protected String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}

		String ret = data;

		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");

		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");

		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");

		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");

		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

		return ret;
	}

	/**
	 * 게시물에 대한 목록을 조회한다.
	 *
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/MobSelectBoardList.do")
	public Map<String, Object> selectBoardArticles(@RequestBody String uniqId, BoardVO boardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boardVO.setBbsId("BBSMSTR_AAAAAAAAAAAA");// 공지게시판만 가져옴

		BoardMasterVO vo = new BoardMasterVO();

		vo.setBbsId(boardVO.getBbsId());
		vo.setUniqId(uniqId);
		
		BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
		
		Map<String, Object> map = bbsMngService.mobSelectBoardArticles(boardVO, "BBSA01");

		resultMap.put("resultList", map.get("resultList"));
		resultMap.put("resultCnt", map.get("resultCnt"));
		resultMap.put("brdMstrVO", master);

		return resultMap;
	}

	/**
	 * 게시물에 대한 상세 정보를 조회한다.
	 *
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/MobSelectBoardArticle.do")
	public Map<String, Object> selectBoardArticle(@RequestBody BoardVO boardVO, String userId) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 조회수 증가 여부 지정
		boardVO.setPlusCount(true);

		if (!boardVO.getSubPageIndex().equals("")) {
			boardVO.setPlusCount(false);
		}
		//// -------------------------------

		boardVO.setLastUpdusrId(boardVO.getMobUniqId());
		BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

		resultMap.put("result", vo);

		resultMap.put("searchVO", boardVO);

		return resultMap;
	}
	
	/**
	 * 첨부파일에 대한 목록을 조회한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/mobelectFileInfs.do")
	public  Map<String, Object> selectFileInfs(FileVO fileVO, @RequestBody Map<String, Object> commandMap, ModelMap model) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String atchFileId = (String) commandMap.get("param_atchFileId");
		System.out.println(commandMap);
		System.out.println("dddddddddddddddddddddddddddddddddd");

		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);

		resultMap.put("fileList", result);
		resultMap.put("updateFlag", "N");
		resultMap.put("fileListCnt", result.size());
		resultMap.put("atchFileId", atchFileId);

		return resultMap;
	}

}
