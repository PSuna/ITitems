package egovframework.let.aprv.service;

/**
 * 결재게시판VO클래스로서 결재게시판관리 비지니스로직 처리용 항목을 구성한다.
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

public class ApprovalManageVO extends ApprovalDefaultVO{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 결재 고유아이디 
	 */
	private String reqId;
	
	/**
	 * 요청자Id
	 */
	private String id;
	
	/**
	 * 프로젝트 ID
	 */
	private String prjId;
	
	/**
	 * PM
	 */
	private String pm;
	
	/**
	 * 사용시작일
	 */
	private String startDate;
	
	/**
	 * 사용종료일
	 */
	private String endDate;
	
	/**
	 * 사용위치
	 */
	private String place;
	
	/**
	 * 요청일
	 */
	private String reqDate;
	
	/**
	 * 요청분류
	 */
	private String reqGroup;
	
	/**
	 * 요청상태
	 */
	private String reqStatus;
	
	/**
	 * 요청자직급
	 */
	private String grade;

	public String getReqId() {
		return reqId;
	}

	public void setReqId(String reqId) {
		this.reqId = reqId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	
	public String getPm() {
		return pm;
	}

	public void setPm(String pm) {
		this.pm = pm;
	}


	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}


	public String getReqGroup() {
		return reqGroup;
	}

	public void setReqGroup(String reqGroup) {
		this.reqGroup = reqGroup;
	}

	public String getReqStatus() {
		return reqStatus;
	}

	public void setReqStatus(String reqStatus) {
		this.reqStatus = reqStatus;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}


}
