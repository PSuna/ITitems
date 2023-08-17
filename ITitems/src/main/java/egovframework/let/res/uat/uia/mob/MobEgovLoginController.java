package egovframework.let.res.uat.uia.mob;

import java.util.HashMap;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import org.springframework.ui.ModelMap;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.res.uat.uap.service.EgovLoginPolicyService;
import egovframework.let.res.uat.uap.service.LoginPolicyVO;
import egovframework.let.res.uat.uia.service.EgovLoginService;
import egovframework.let.res.uat.uia.service.MobPlayLogVO;
import egovframework.let.res.utl.sim.service.EgovClntInfo;

import org.egovframe.rte.fdl.cmmn.trace.LeaveaTrace;
import org.egovframe.rte.fdl.property.EgovPropertyService;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * 
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.31  JJY          경량환경 템플릿 커스터마이징버전 생성
 * 
 *
 *      </pre>
 */
@RestController
public class MobEgovLoginController {
	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** EgovLoginPolicyService */
	@Resource(name = "egovLoginPolicyService")
	EgovLoginPolicyService egovLoginPolicyService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** TRACE */
	@Resource(name = "leaveaTrace")
	LeaveaTrace leaveaTrace;

	/**
	 * 일반(스프링 시큐리티) 로그인을 처리한다
	 * 
	 * @param vo      - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */

	// 모바일 실행 정보 로그 남기기
	@RequestMapping(value = "/uat/uia/mob/insertPlayLogHdr.do")
	public Map<String, Object> insertPlayLogHdr(@RequestBody MobPlayLogVO playVO, HttpServletRequest request, ModelAndView model) throws Exception {
		System.out.println("리퀘스트==");
		System.out.println(request);
		request.setAttribute("mob", playVO);
		System.out.println("리퀘스트 담았슈==");
		System.out.println(request);
		System.out.println("모델멥 ===");
		model.addObject("mobile",playVO);
		request.getSession().setAttribute("mobileSession", playVO);
		
		System.out.println(model.getModel().get("mobile"));
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 등록
		String result = "inValid";
		int cnt = loginService.insertPlayLog(playVO);
		result = cnt < 1 ? "fail" : "success";
		
		resultMap.put("result", result);
		resultMap.put("playVO", playVO);
		return resultMap;
	}

	// ❤️ 모바일 로그인
	@RequestMapping(value = "/uat/uia/mob/actionSecurityLogin.do")
	public String actionSecurityLogin(@RequestBody LoginVO loginVO, HttpServletResponse response,
			HttpServletRequest request, ModelMap model) throws Exception {

		// 접속IP
		String userIp = EgovClntInfo.getClntIP(request);

		// 1. 일반 로그인 처리

		loginVO.setId(loginVO.getId() + "@iteyes.co.kr");
		LoginVO resultVO = loginService.actionLogin(loginVO);

		boolean loginPolicyYn = true;

		LoginPolicyVO loginPolicyVO = new LoginPolicyVO();
		loginPolicyVO.setEmplyrId(resultVO.getId());
		loginPolicyVO = egovLoginPolicyService.selectLoginPolicy(loginPolicyVO);

		if (loginPolicyVO == null) {
			loginPolicyYn = true;
		} else {
			if (loginPolicyVO.getLmttAt().equals("Y")) {
				if (!userIp.equals(loginPolicyVO.getIpInfo())) {
					loginPolicyYn = false;
				}
			}
		}

		// spring security 시작
		// 인증 시
		// ▶ return 값 설정
		String result = null;
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") && loginPolicyYn) {

			// spring security 연동
			request.getSession().setAttribute("LoginVO", resultVO);

			UsernamePasswordAuthenticationFilter springSecurity = null;

			ApplicationContext act = WebApplicationContextUtils
					.getRequiredWebApplicationContext(request.getSession().getServletContext());

			Map<String, UsernamePasswordAuthenticationFilter> beans = act
					.getBeansOfType(UsernamePasswordAuthenticationFilter.class);

			if (beans.size() > 0) {

				springSecurity = (UsernamePasswordAuthenticationFilter) beans.values().toArray()[0];
				springSecurity.setUsernameParameter("egov_security_username");
				springSecurity.setPasswordParameter("egov_security_password");
				springSecurity.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher(
						request.getServletContext().getContextPath() + "/egov_security_login", "POST"));

			} else {
				throw new IllegalStateException("No AuthenticationProcessingFilter");
			}
			result = "success";
			resultVO.setIsMob(result);

			springSecurity.doFilter(new RequestWrapperForSecurity(request, resultVO.getUserSe() + resultVO.getId(),
					resultVO.getUniqId()), response, null);

		} else {
			result = "fail";
		}

		return result;
	}

	@RequestMapping(value = "/uat/uia/mob/goMobile.do")
	public Map<String, Object> actionMain(HttpServletRequest request) throws Exception {
		LoginVO loginVO = (LoginVO) request.getSession().getAttribute("LoginVO");
		String parsingGrade = loginService.selectParsingGrade(loginVO.getUniqId());
		loginVO.setParsingGrade(parsingGrade);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", loginVO);

		return returnMap;
	}

	/**
	 * 로그아웃한다.
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/mob/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("LoginVO", null);
		return "redirect:/egov_security_logout";
	}
}

class RequestWrapperForSecurity extends HttpServletRequestWrapper {
	private String username = null;
	private String password = null;

	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);

		this.username = username;
		this.password = password;
	}

	@Override
	public String getServletPath() {
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/egov_security_login";
	}

	@Override
	public String getRequestURI() {
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/egov_security_login";
	}

	@Override
	public String getParameter(String name) {
		if (name.equals("egov_security_username")) {
			return username;
		}

		if (name.equals("egov_security_password")) {
			return password;
		}

		return super.getParameter(name);
	}
}