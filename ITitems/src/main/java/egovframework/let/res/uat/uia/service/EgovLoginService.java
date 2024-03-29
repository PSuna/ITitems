package egovframework.let.res.uat.uia.service;

import java.util.List;

import egovframework.com.cmm.LoginVO;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *  
 *  </pre>
 */
public interface EgovLoginService {
	
	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO actionLogin(LoginVO vo) throws Exception;
    
    /**
	 * 아이디를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO searchId(LoginVO vo) throws Exception;
    
    /**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    boolean searchPassword(LoginVO vo) throws Exception;
    
    //모바일 =========================================================
    String selectParsingGrade(String uniqId) throws Exception; //모바일 부서 구분자
    
    //기기 확인
    boolean isValidPlayLog(MobPlayLogVO playVO) throws Exception;//기기 정보 중복 확인
    int insertPlayLog(MobPlayLogVO playVO)throws Exception;// 푸쉬 토큰 등록
    int updatePlayLog(MobPlayLogVO playVO) throws Exception;//푸쉬 토큰 state 변경
//    List<MobPushTokenVO> selectListMobPushToken(MobPushTokenVO pushVO) throws Exception;//푸쉬 리스트
    
    
}
