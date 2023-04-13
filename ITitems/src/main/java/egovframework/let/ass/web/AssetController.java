package egovframework.let.ass.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.ass.service.AssetService;
import egovframework.let.prj.service.ProjectService;

/**
 * 자산관리를 위한 컨트롤러 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *
 *  </pre>
 */
@Controller
public class AssetController {

	@Resource(name = "AssetService")
	private AssetService assetService;
	
	@Resource(name = "ProjectService")
	protected ProjectService projectService ;
	
	/** 
	 * 자산조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetManagement.do")
	public String AssetManagement(HttpServletRequest request){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		
		return "/ass/AssetManagement";
	}

	/** 
	 * 자산등록 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetRegist.do")
	public String AssetInsert(HttpServletRequest request, ModelMap model){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		return "/ass/AssetRegist";
	}

	/** 
	 * 반납신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/ReturnRequest.do")
	public String ReturnRequest(HttpServletRequest request){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		
		return "/ass/ReturnRequest";
	}

	/** 
	 * 파손신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/DisposeRequest.do")
	public String DisposeRequest(HttpServletRequest request){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		
		return "/ass/DisposeRequest";
	}
	
	/** 
	 *  수리신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/RepairRequest.do")
	public String RepairRequest(HttpServletRequest request){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		
		return "/ass/RepairRequest";
	}

}
