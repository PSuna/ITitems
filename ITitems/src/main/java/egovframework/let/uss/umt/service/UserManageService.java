package egovframework.let.uss.umt.service;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 사용자관리에 관한 인터페이스클래스를 정의한다.
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
 *   2009.04.10  천세훈          최초 생성
 *
 * </pre>
 */
public interface UserManageService  {

	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
	 * @param checkId 중복여부 확인대상 아이디
	 * @return 사용가능여부(아이디 사용회수 int)
	 * @throws Exception
	 */
	public int checkIdDplct(String checkId) throws Exception;

	/**
	 * 화면에 조회된 사용자의 정보를 데이터베이스에서 삭제
	 * @param checkedIdForDel 삭제대상 업무사용자아이디
	 * @throws Exception
	 */
	public void deleteUser(String checkedIdForDel) throws Exception;

	/**
	 * @param userManageVO 업무사용자 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	public int insertUser(UserManageVO userManageVO) throws Exception;

	/**
	 * 기 등록된 사용자 중 검색조건에 맞는 사용자의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param emplyrId 상세조회대상 업무사용자 아이디
	 * @return userManageVO 업무사용자 상세정보
	 * @throws Exception
	 */
	public UserManageVO selectUser(String emplyrId) throws Exception;

	/**
	 * 기 등록된 특정 사용자의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param userSearchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	public List<?> selectUserList(UserDefaultVO userSearchVO) throws Exception;

	/**
	 * 기 등록된 특정 사용자목록의 전체수를 확인
	 * @param userSearchVO 검색조건
	 * @return 총사용자갯수(int)
	 * @throws Exception
	 */
	public int selectUserListTotCnt(UserDefaultVO userSearchVO) throws Exception;

	/**
	 * 화면에 조회된 사용자의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param userManageVO 업무사용자 수정정보
	 * @return 
	 * @throws Exception
	 */
	public int updateUser(UserManageVO userManageVO) throws Exception;

	/**
	 * 사용자정보 수정시 히스토리 정보를 추가
	 * @param userManageVO 업무사용자 수정정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	public void insertUserHistory(UserManageVO userManageVO) throws Exception;

	/**
	 * 업무사용자 암호 수정
	 * @param userManageVO 업무사용자 수정정보(비밀번호)
	 * @throws Exception
	 */
	public void updatePassword(UserManageVO userManageVO) throws Exception;

	/**
	 * 사용자가 비밀번호를 기억하지 못할 때 비밀번호를 찾을 수 있도록 함
	 * @param passVO 업무사용자 암호 조회조건정보
	 * @return userManageVO 업무사용자 암호정보
	 * @throws Exception
	 */
	public UserManageVO selectPassword(UserManageVO passVO) throws Exception;

	public void xlsxTrsfUserList(UserDefaultVO userSearchVO, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public String checkUpper(String uniqId) throws Exception;

	public List<?> selectUserListS(UserDefaultVO userSearchVO);

	public int selectUserListTotCntS(UserDefaultVO userSearchVO);
	
	//모바일 회원검색
	public List<?> mobSelectUserListS(UserDefaultVO userSearchVO);



}