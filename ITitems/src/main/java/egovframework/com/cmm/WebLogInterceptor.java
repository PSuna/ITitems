package egovframework.com.cmm;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.LogVO;
import egovframework.let.uat.uia.service.MobPlayLogVO;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.web.servlet.HandlerInterceptor;

public class WebLogInterceptor implements HandlerInterceptor {

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modeAndView) throws Exception {
		LogVO logVO = cmmUseService.broswserInfo(request);
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		logVO.setConectId(user.getUniqId());
		logVO.setConectUri(request.getRequestURI());
		MobPlayLogVO Mob = (MobPlayLogVO) request.getSession().getAttribute("mobileSession");
		if (Mob == null) {
			cmmUseService.InsertActionLog(logVO);
		} else {
			logVO.setBrand(Mob.getBrand());
			logVO.setModel(Mob.getModel());
			logVO.setOs(Mob.getOs());
			logVO.setBroswser(null);
			logVO.setHeader(null);
			cmmUseService.InsertActionLog(logVO);
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		/*
		 * System.out.println("afterCompletion >>>  preHandle 메소드 return값이 true일 때 실행");
		 */
	}

}
