package egovframework.let.aprv.service;

import java.util.Date;

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
	private Date startDate;
	
	/**
	 * 사용종료일
	 */
	private Date endDate;
	
	/**
	 * 사용위치
	 */
	private String place;
	
	/**
	 * 요청일
	 */
	private Date reqDate;
	
	/**
	 * 요청분류
	 */
	private String reqGroup;
	
	/**
	 * 요청상태
	 */
	private String reqStatus;

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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public Date getReqDate() {
		return reqDate;
	}

	public void setReqDate(Date reqDate) {
		this.reqDate = reqDate;
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

}
