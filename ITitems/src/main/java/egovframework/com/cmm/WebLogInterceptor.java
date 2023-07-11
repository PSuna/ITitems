package egovframework.com.cmm;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.LogVO;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.web.servlet.HandlerInterceptor;

public class WebLogInterceptor implements HandlerInterceptor{
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	 @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		/* System.out.println("preHandle >>>  Controller 실행 전 실행"); */
		
		 System.out.println("=========================================");
		 System.out.println(">>>>>>>>>> preHandle >>>>>>>>>>>>>>>");
		 System.out.println(request.getRequestURI());
		 System.out.println(request.getHeader("User-Agent"));
		 System.out.println("=========================================");
		 
		 LogVO logVO = cmmUseService.broswserInfo(request);

		 LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		 logVO.setConectId(user.getUniqId());
		 logVO.setConectUri(request.getRequestURI());
		 
		 cmmUseService.InsertActionLog(logVO);

        return true;
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modeAndView) throws Exception {
		/* System.out.println("postHandle >>>  Controller 실행 후 실행"); */
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex){
		/*
		 * System.out.println("afterCompletion >>>  preHandle 메소드 return값이 true일 때 실행");
		 */
    }
    
    
	 
}
