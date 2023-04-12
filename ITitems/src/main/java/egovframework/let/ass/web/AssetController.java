package egovframework.let.ass.web;

import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.let.sec.ram.service.AuthorManageVO;

@Controller
public class AssetController {

	@RequestMapping(value = "/ass/AssetManagement.do")
	public String AssetManagement(HttpServletRequest request){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		
		return "/ass/assManage";
	}

	@RequestMapping(value = "/ass/AssetInsert.do")
	public String AssetInsert(HttpServletRequest request){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		
		return "/ass/assManage";
	}

	@RequestMapping(value = "/ass/ReturnRequest.do")
	public String ReturnRequest(HttpServletRequest request){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		
		return "/ass/ReturnRequest";
	}

	@RequestMapping(value = "/ass/BreakageRequest.do")
	public String BreakageRequest(HttpServletRequest request){
		request.getSession().setAttribute("baseMenuNo", "100");
		
		
		return "/ass/BreakageRequest";
	}

}
