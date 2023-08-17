package egovframework.let.res.aprv.service;

import java.io.Serializable;

/**
 * 결재게시판상세항목VO클래스로서 결재게시판상세항목관리 비지니스로직 처리용 항목을 구성한다.
 * @author 영남사업부 천세훈
 * @since 2023.05.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.05.10  천세훈          최초 생성
 *
 * </pre>
 */

public class ApprovalDetailVO implements Serializable{
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 요청세부고유번호
	 */
	private String redId;
	
	/**
	 * 해당요청고유번호
	 */
	private String reqId;
	
	/**
	 * 대분류
	 */
	private String largeCategory;
	
	/**
	 * 중분류
	 */
	private String middleCategory;
	
	
	/**
	 * 제조사
	 */
	private String maker;
	
	/**
	 * 실사용자
	 */
	private String user;
	
	/**
	 * 자산ID
	 */
	private String assetId;
	
	/**
	 * 요청순서
	 */
	private int reqOrder;
	/**
	 * 실사용자 이름
	 */
	private String userNm;
	/**
	 * 실사용자 직급
	 */
	private String grade;
	
	public String getRedId() {
		return redId;
	}

	public void setRedId(String redId) {
		this.redId = redId;
	}

	public String getReqId() {
		return reqId;
	}

	public void setReqId(String reqId) {
		this.reqId = reqId;
	}

	public String getLargeCategory() {
		return largeCategory;
	}

	public void setLargeCategory(String largeCategory) {
		this.largeCategory = largeCategory;
	}

	public String getMiddleCategory() {
		return middleCategory;
	}

	public void setMiddleCategory(String middleCategory) {
		this.middleCategory = middleCategory;
	}


	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public int getReqOrder() {
		return reqOrder;
	}

	public void setReqOrder(int reqOrder) {
		this.reqOrder = reqOrder;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}
}

