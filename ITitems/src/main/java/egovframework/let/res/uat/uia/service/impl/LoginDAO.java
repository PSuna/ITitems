package egovframework.let.res.uat.uia.service.impl;

import egovframework.com.cmm.LoginVO;
import egovframework.let.res.uat.uia.service.MobPlayLogVO;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
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
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *      </pre>
 */
@Repository("loginDAO")
public class LoginDAO extends EgovAbstractMapper {

	/**
	 * 일반 로그인을 처리한다
	 * 
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	public LoginVO actionLogin(LoginVO vo) throws Exception {
		return (LoginVO) selectOne("loginDAO.actionLogin", vo);
	}

	/**
	 * 아이디를 찾는다.
	 * 
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	public LoginVO searchId(LoginVO vo) throws Exception {

		return (LoginVO) selectOne("loginDAO.searchId", vo);
	}

	/**
	 * 비밀번호를 찾는다.
	 * 
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	public LoginVO searchPassword(LoginVO vo) throws Exception {

		return (LoginVO) selectOne("loginDAO.searchPassword", vo);
	}

	/**
	 * 변경된 비밀번호를 저장한다.
	 * 
	 * @param vo LoginVO
	 * @exception Exception
	 */
	public void updatePassword(LoginVO vo) throws Exception {
		update("loginDAO.updatePassword", vo);
	}

	// 모바일 =========================================================
	String selectParsingGrade(String uniqId) throws Exception {
		return (String) selectOne("loginDAO.selectParsingGrade", uniqId);
	};

	// 중복 확인
	int isValidPlayLog(MobPlayLogVO playVO) throws Exception {
		return selectOne("loginDAO.isValidPlayLog", playVO);
	};

	// 등록
	int insertPlayLog(MobPlayLogVO playVO) throws Exception {
		System.out.println("insertPlayLog DAO");
		return insert("loginDAO.insertPlayLog", playVO);
	};
	// 푸쉬토큰 상태 변경
	public int updatePlayLog(MobPlayLogVO playVO) throws Exception {
		return update("loginDAO.updatePlayLog", playVO);
	}
	public int insertOsLoginLog(LoginVO vo) throws Exception {
		return update("loginDAO.insertOsLoginLog", vo);
	}

// // 푸쉬토큰 리스트 출력
//
// 	public List<MobPushTokenVO> selectListMobPushToken(MobPushTokenVO pushVO) throws Exception {
// 		System.out.println("list 출력 dao ==========="+pushVO);
// 		return selectList("loginDAO.selectListMobPushToken", pushVO);
// 	}

}
