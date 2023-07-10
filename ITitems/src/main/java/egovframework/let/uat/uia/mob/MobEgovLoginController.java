package egovframework.let.uat.uia.mob;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uat.uap.service.EgovLoginPolicyService;
import egovframework.let.uat.uap.service.LoginPolicyVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import egovframework.let.uat.uia.service.MobPushTokenVO;
import egovframework.let.utl.sim.service.EgovClntInfo;
import io.github.jav.exposerversdk.ExpoPushMessage;
import io.github.jav.exposerversdk.ExpoPushMessageTicketPair;
import io.github.jav.exposerversdk.ExpoPushReceipt;
import io.github.jav.exposerversdk.ExpoPushTicket;
import io.github.jav.exposerversdk.PushClient;
import io.github.jav.exposerversdk.PushClientException;

import org.apache.commons.vfs2.util.DelegatingFileSystemOptionsBuilder;
import org.egovframe.rte.fdl.cmmn.trace.LeaveaTrace;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;

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
 *  2023.06.02  김채은          모바일 로그인 컨트롤러 등록
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

	// 모바일 푸시 정보 등록/리스트 가져가기
	@RequestMapping(value = "/uat/uia/mob/insertPushToken.do")
	public Map<String,Object> setPushToken(@RequestBody MobPushTokenVO pushVO) throws Exception {
		System.out.println("푸쉬 도착 ==========");
		System.out.println(pushVO);
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		
		//등록
		String result = "valid";
		if (loginService.isValidPushToken(pushVO)) {
			System.out.println("push 등록(중복x) ======");
			int cnt = loginService.insertPushToken(pushVO);
			result = cnt < 1 ? "fail" : "success";
		}
		
		//리스트
		if(result!="fail") {
			List<MobPushTokenVO> resultList = loginService.selectListMobPushToken(pushVO);
			resultMap.put("resultList",resultList);
		}
		resultMap.put("result",result);

		return resultMap;
	}
	
//	@RequestMapping(value = "/uat/uia/mob/testPush.do")
//	public Map<String,Object> testPush(@RequestBody MobPushTokenVO pushVO) throws Exception {
//		testPush
//
//		return resultMap;
//	}
//	@RequestMapping(value = "/uat/uia/mob/testPush.do")
//	public Map<String,Object> testPush(@RequestBody MobPushTokenVO pushVO) throws Exception {
//	System.out.println("도착했슈우우우우우우");
//		Map<String,Object> resultMap = new HashMap<String, Object>();
//		List<MobPushTokenVO> resultList = loginService.selectListMobPushToken(pushVO);
//		System.out.println(resultList.get(0).getPushToken());
//        String recipient = resultList.get(0).getPushToken(); // To test, you must replace the recipient with a valid token!
//        String title = "push test";
//        String message = "java test";
//
//        if (!PushClient.isExponentPushToken(recipient))
//            throw new Error("Token:" + recipient + " is not a valid token.");
//
//        ExpoPushMessage expoPushMessage = new ExpoPushMessage();
//        expoPushMessage.getTo().add(recipient);
//        expoPushMessage.setTitle(title);
//        expoPushMessage.setBody(message);
//
//        List<ExpoPushMessage> expoPushMessages = new ArrayList<>();
//        expoPushMessages.add(expoPushMessage);
//
//        PushClient client = new PushClient();
//        List<List<ExpoPushMessage>> chunks = client.chunkPushNotifications(expoPushMessages);
//
//        List<CompletableFuture<List<ExpoPushTicket>>> messageRepliesFutures = new ArrayList<>();
//
//        for (List<ExpoPushMessage> chunk : chunks) {
//            messageRepliesFutures.add(client.sendPushNotificationsAsync(chunk));
//        }
//
//        // Wait for each completable future to finish
//        List<ExpoPushTicket> allTickets = new ArrayList<>();
//        for (CompletableFuture<List<ExpoPushTicket>> messageReplyFuture : messageRepliesFutures) {
//            try {
//                for (ExpoPushTicket ticket : messageReplyFuture.get()) {
//                    allTickets.add(ticket);
//                }
//            } catch (InterruptedException e) {
//                e.printStackTrace();
//            } catch (ExecutionException e) {
//                e.printStackTrace();
//            }
//        }
//
//        List<ExpoPushMessageTicketPair<ExpoPushMessage>> zippedMessagesTickets = client.zipMessagesTickets(expoPushMessages, allTickets);
//
//        List<ExpoPushMessageTicketPair<ExpoPushMessage>> okTicketMessages = client.filterAllSuccessfulMessages(zippedMessagesTickets);
//        String okTicketMessagesString = okTicketMessages.stream().map(
//                p -> "Title: " + p.message.getTitle() + ", Id:" + p.ticket.getId()
//        ).collect(Collectors.joining(","));
//        System.out.println(
//                "Recieved OK ticket for " +
//                        okTicketMessages.size() +
//                        " messages: " + okTicketMessagesString
//        );
//
//        List<ExpoPushMessageTicketPair<ExpoPushMessage>> errorTicketMessages = client.filterAllMessagesWithError(zippedMessagesTickets);
//        String errorTicketMessagesString = errorTicketMessages.stream().map(
//                p -> "Title: " + p.message.getTitle() + ", Error: " + p.ticket.getDetails().getError()
//        ).collect(Collectors.joining(","));
//        System.out.println(
//                "Recieved ERROR ticket for " +
//                        errorTicketMessages.size() +
//                        " messages: " +
//                        errorTicketMessagesString
//        );
//
//
//        // Countdown 30s
//        int wait = 30;
//        for (int i = wait; i >= 0; i--) {
//            System.out.print("Waiting for " + wait + " seconds. " + i + "s\r");
//            Thread.sleep(1000);
//        }
//        System.out.println("Fetching reciepts...");
//
//        List<String> ticketIds = (client.getTicketIdsFromPairs(okTicketMessages));
//        CompletableFuture<List<ExpoPushReceipt>> receiptFutures = client.getPushNotificationReceiptsAsync(ticketIds);
//
//        List<ExpoPushReceipt> receipts = new ArrayList<>();
//        try {
//            receipts = receiptFutures.get();
//        } catch (ExecutionException e) {
//            e.printStackTrace();
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
////
////        System.out.println(
////                "Recieved " + receipts.size() + " receipts:");
////
////        for (ExpoPushReceipt reciept : receipts) {
////            System.out.println(
////                    "Receipt for id: " +
////                            reciept.getId() +
////                            " had status: " +
////                            reciept.getStatus());
////
////        }
////
////        System.exit(0);
//        return resultMap;
//    }
	

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