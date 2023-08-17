package egovframework.let.res.sec.rgm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.res.sec.ram.service.AuthorManageVO;
import egovframework.let.res.sec.ram.service.EgovAuthorManageService;
import egovframework.let.res.sec.rgm.service.AuthorGroup;
import egovframework.let.res.sec.rgm.service.AuthorGroupVO;
import egovframework.let.res.sec.rgm.service.EgovAuthorGroupService;

/**
 * 권한그룹에 관한 controller 클래스를 정의한다.
 * @author 영남사업부 천세훈 선임
 * @since 2023.04.14
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일         수정자           수정내용
 *  -------     --------    ---------------------------
 *  2023.04.14    천세훈          최초 생성
 *
 * </pre>
 */

@Controller
public class EgovAuthorGroupController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "egovAuthorGroupService")
    private EgovAuthorGroupService egovAuthorGroupService;
    
	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    @Resource(name = "egovAuthorManageService")
    private EgovAuthorManageService egovAuthorManageService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /**
	 * 권한 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/sec/rgm/EgovAuthorGroupListView.do")
    public String selectAuthorGroupListView(@ModelAttribute("authorGroupVO") AuthorGroupVO authorGroupVO,
								            @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
								            HttpServletRequest request,
								            ModelMap model) throws Exception {
    	
    	// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
    	request.getSession().setAttribute("baseMenuNo", "6000000");
    	LoginVO loginId = (LoginVO)request.getSession().getAttribute("LoginVO");
		
    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorGroupVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorGroupVO.getPageUnit());
		paginationInfo.setPageSize(authorGroupVO.getPageSize());
		
		authorGroupVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorGroupVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorGroupVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		authorGroupVO.setUniqId(loginId.getUniqId());
		authorGroupVO.setAuthorGroupList(egovAuthorGroupService.selectAuthorGroupList(authorGroupVO));
		
        model.addAttribute("authorGroupList", authorGroupVO.getAuthorGroupList());
        
        int totCnt = egovAuthorGroupService.selectAuthorGroupListTotCnt(authorGroupVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

    	authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        
        //사용자상태코드를 코드정보로부터 조회
      	ComDefaultCodeVO vo = new ComDefaultCodeVO();
        
      	//권한코드를 조회 
      	vo.setTableNm("LETTNAUTHORINFO");
      	model.addAttribute("auth_result", cmmUseService.selectAuthorCodeDetail(vo));

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
        return "sec/rgm/EgovAuthorGroupManage";
    }    

	/**
	 * 그룹별 할당된 권한 목록 조회
	 * @param authorGroupVO AuthorGroupVO
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/sec/rgm/EgovAuthorGroupList.do")
	public String selectAuthorGroupList(@ModelAttribute("authorGroupVO") AuthorGroupVO authorGroupVO,
			                            @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
			                            HttpServletRequest request,
			                             ModelMap model) throws Exception {
    	// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
    	request.getSession().setAttribute("baseMenuNo", "6000000");

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorGroupVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorGroupVO.getPageUnit());
		paginationInfo.setPageSize(authorGroupVO.getPageSize());
		
		authorGroupVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorGroupVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorGroupVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		authorGroupVO.setAuthorGroupList(egovAuthorGroupService.selectAuthorGroupList(authorGroupVO));
        model.addAttribute("authorGroupList", authorGroupVO.getAuthorGroupList());
        
        int totCnt = egovAuthorGroupService.selectAuthorGroupListTotCnt(authorGroupVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

    	authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        //사용자상태코드를 코드정보로부터 조회
      	ComDefaultCodeVO vo = new ComDefaultCodeVO();
      	//권한코드를 조회 
      	vo.setTableNm("LETTNAUTHORINFO");
      	model.addAttribute("auth_result", cmmUseService.selectAuthorCodeDetail(vo));

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
        
        return "/sec/rgm/EgovAuthorGroupManage";
	}

	/**
	 * 그룹에 권한정보를 할당하여 데이터베이스에 등록
	 * @param userIds String
	 * @param authorCodes String
	 * @param authorGroup AuthorGroup
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/sec/rgm/EgovAuthorGroupInsert.do")
	public String insertAuthorGroup(@RequestParam("userIds") String userIds,
			                        @RequestParam("authorCodes") String authorCodes,
			                        @ModelAttribute("authorGroup") AuthorGroup authorGroup,
			                         SessionStatus status,
			                         ModelMap model) throws Exception {
		
    	String [] strUserIds = userIds.split(";");
    	String [] strAuthorCodes = authorCodes.split(";");
    	
    	for(int i=0; i<strUserIds.length;i++) {
    		authorGroup.setUniqId(strUserIds[i]);
    		authorGroup.setAuthorCode(strAuthorCodes[i]);
    		egovAuthorGroupService.updateAuthorGroup(authorGroup);
    	}

        status.setComplete();
        model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));		
		return "forward:/sec/rgm/EgovAuthorGroupList.do";
	}

	/**
	 * 그룹별 할당된 시스템 메뉴 접근권한을 삭제
	 * @param userIds String
	 * @param authorGroup AuthorGroup
	 * @return String
	 * @exception Exception
	 */ 
	/**
	@RequestMapping(value="/sec/rgm/EgovAuthorGroupDelete.do")
	public String deleteAuthorGroup(@RequestParam("userIds") String userIds,
                                    @ModelAttribute("authorGroup") AuthorGroup authorGroup,
                                     SessionStatus status,
                                     ModelMap model) throws Exception {
		
    	String [] strUserIds = userIds.split(";");
    	for(int i=0; i<strUserIds.length;i++) {
    		authorGroup.setUniqId(strUserIds[i]);
    		egovAuthorGroupService.deleteAuthorGroup(authorGroup);
    	}
    	
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/sec/rgm/EgovAuthorGroupList.do";
	}
	*/


}