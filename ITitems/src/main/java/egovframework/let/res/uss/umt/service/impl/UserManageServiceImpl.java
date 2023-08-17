package egovframework.let.res.uss.umt.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;

import egovframework.let.res.com.service.ExcelUtil;
import egovframework.let.res.sec.rgm.service.AuthorGroup;
import egovframework.let.res.sec.rgm.service.impl.AuthorGroupDAO;
import egovframework.let.res.uss.umt.service.UserDefaultVO;
import egovframework.let.res.uss.umt.service.UserManageService;
import egovframework.let.res.uss.umt.service.UserManageVO;
import egovframework.let.res.utl.sim.service.EgovFileScrty;

/**
 * 사용자관리에 관한 비지니스 클래스를 정의한다.
 * @author 영남사업부 천세훈
 * @since 2023.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.04.10  천세훈          최초 생성
 *
 * </pre>
 */
@Service("userManageService")
public class UserManageServiceImpl extends EgovAbstractServiceImpl implements UserManageService {

	@Resource(name="authorGroup")
    private AuthorGroup authorGroup;
	
	/** userManageDAO */
	@Resource(name="userManageDAO")
	private UserManageDAO userManageDAO;
	
	/** authorGroupDAO */
	@Resource(name="authorGroupDAO")
    private AuthorGroupDAO authorGroupDAO;

	/** egovUsrCnfrmIdGnrService */
	@Resource(name="egovUsrCnfrmIdGnrService")
	private EgovIdGnrService idgenService;

	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
	 * @param checkId 중복여부 확인대상 아이디
	 * @return 사용가능여부(아이디 사용회수 int)
	 */
	@Override
	public int checkIdDplct(String checkId) {
		return userManageDAO.checkIdDplct(checkId);
	}

	/**
	 * 사용자의 정보를 삭제 상태로 변환 후 히스토리 저장
	 * @param checkedIdForDel 삭제대상 업무사용자아이디
	 */
	@Override
	public void deleteUser(String checkedIdForDel) {
		String [] delId = checkedIdForDel.split(",");
		for (int i=0; i<delId.length ; i++){
			String [] id = delId[i].split(":");
			UserManageVO userManageVO = new UserManageVO();
		    //업무사용자(직원)삭제
			userManageVO.setUniqId(id[1]);
			userManageDAO.deleteUser(userManageVO);
			userManageDAO.insertUserHistory(userManageVO);
		}
	}

	/**
	 * @param userManageVO 사용자 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	@Override
	public int insertUser(UserManageVO userManageVO) throws Exception {
		//고유아이디 셋팅
		String uniqId = idgenService.getNextStringId();
		userManageVO.setUniqId(uniqId);
		//패스워드 암호화
		String pass = EgovFileScrty.encryptPassword(userManageVO.getPassword(), userManageVO.getEmplyrId());
		userManageVO.setPassword(pass);
		
		authorGroup.setUniqId(uniqId);
		authorGroup.setAuthorCode(userManageVO.getAuthorCode());
		
		int r =userManageDAO.insertUser(userManageVO);
		authorGroupDAO.insertAuthorGroup(authorGroup);
		userManageDAO.insertUserHistory(userManageVO);
		return r ; 
	}

	/**
	 * 등록된 사용자 중 검색조건에 맞는 사용자의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param uniqId 상세조회대상 아이디
	 * @return userManageVO 상세정보
	 * @throws Exception
	 */
	@Override
	public UserManageVO selectUser(String uniqId) {
		return userManageDAO.selectUser(uniqId);
	}

	/**
	 * 특정 사용자 목록을 데이터베이스에서 읽어와 화면에 출력
	 * @param userSearchVO 검색조건
	 * @return List<UserManageVO> 목록정보
	 * @throws Exception
	 */
	@Override
	public List<?> selectUserList(UserDefaultVO userSearchVO) {
		return userManageDAO.selectUserList(userSearchVO);
	}

	/**
	 * 특정 사용자목록의 전체수를 확인
	 * @param userSearchVO 검색조건
	 * @return 총사용자갯수(int)
	 * @throws Exception
	 */
	@Override
	public int selectUserListTotCnt(UserDefaultVO userSearchVO) {
		return userManageDAO.selectUserListTotCnt(userSearchVO);
	}

	/**
	 * 화면에 조회된 사용자의 기본정보를 수정하여 항목의 적합성을 체크하고 수정된 데이터를 데이터베이스에 반영후 히스토리 저장
	 * @param userManageVO 수정정보
	 * @throws Exception
	 */
	@Override
	public int updateUser(UserManageVO userManageVO) throws Exception {
		//패스워드 암호화
		String pass = EgovFileScrty.encryptPassword(userManageVO.getPassword(), userManageVO.getEmplyrId());
		userManageVO.setPassword(pass);
		int result = userManageDAO.updateUser(userManageVO);
		userManageDAO.insertUserHistory(userManageVO);
		return result;
	}

	/**
	 * 사용자 암호 수정
	 * @param userManageVO 업무사용자 수정정보(비밀번호)
	 */
	@Override
	public void updatePassword(UserManageVO userManageVO) {
		userManageDAO.updatePassword(userManageVO);
	}

	/**
	 * 사용자 암호 불러오기
	 * @param passVO 업무사용자 암호 조회조건정보
	 * @return userManageVO 업무사용자 암호정보
	 */
	@Override
	public UserManageVO selectPassword(UserManageVO passVO) {
		return userManageDAO.selectPassword(passVO);
	}

	/**
	 * 사용자 목록 엑셀 다운로드
	 */
	@Override
	public void xlsxTrsfUserList(UserDefaultVO userSearchVO, HttpServletRequest req, HttpServletResponse res) throws Exception {
		String title = "자산관리솔루션 - 사용자 목록";
		try {
			List<EgovMap> tmpList = userManageDAO.xlsxUserList(userSearchVO);
			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.getxlsxDownload(title , tmpList , req, res);	
		}catch(Exception e) {
			throw e;
		}
	}

	@Override
	public String checkUpper(String uniqId) throws Exception {
		return userManageDAO.checkUpper(uniqId);
	}

	/**
	 * 사용자 검색 팝업창용 회원 목록 조회
	 */
	@Override
	public List<?> selectUserListS(UserDefaultVO userSearchVO) {
		return userManageDAO.selectUserListS(userSearchVO);
	}

	/**
	 * 사용자 검색 팝업창용 회원 목록 수 조회
	 */
	@Override
	public int selectUserListTotCntS(UserDefaultVO userSearchVO) {
		return userManageDAO.selectUserListTotCntS(userSearchVO);
	}

	/**
	 * 사용자 검색 팝업창용 회원 목록 조회(모바일)
	 */
	@Override
	public List<?> mobSelectUserListS(UserDefaultVO userSearchVO) {
		return userManageDAO.mobSelectUserListS(userSearchVO);
	}



}