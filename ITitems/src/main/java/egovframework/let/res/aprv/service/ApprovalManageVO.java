package egovframework.let.res.aprv.service;

import java.util.List;

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

	@Override
	public String toString() {
		return "ApprovalManageVO [reqId=" + reqId + ", id=" + id + ", userId=" + userId + ", aprvDate=" + aprvDate
				+ ", upreqStatus=" + upreqStatus + ", assetId=" + assetId + ", lastUserName=" + lastUserName
				+ ", userNm=" + userNm + ", prjId=" + prjId + ", prjCode=" + prjCode + ", prjName=" + prjName + ", pm="
				+ pm + ", pmName=" + pmName + ", pmGrade=" + pmGrade + ", startDate=" + startDate + ", endDate="
				+ endDate + ", place=" + place + ", reqDate=" + reqDate + ", reqGroup=" + reqGroup + ", reqStatus="
				+ reqStatus + ", rreqStatus=" + rreqStatus + ", grade=" + grade + ", approvalDetailList="
				+ approvalDetailList + ", targetId=" + targetId + ", targetUp=" + targetUp + ", aprvOrder=" + aprvOrder
				+ "]";
	}

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
	
	private String userId;
	
	private String aprvDate; 

	private String upreqStatus;
	
	/** 자산 Id */
	private String assetId;
	
	/** 최종결재자 구분 */
	private String lastUserName;
	/**
	 * 요청자이름
	 */
	private String userNm;
	
	/**
	 * 프로젝트 ID
	 */
	private String prjId;
	
	private String prjCode;
	
	/*
	 * 프로젝트 이름
	 */
	private String prjName;
	
	/**
	 * PM
	 */
	private String pm;
	
	/**
	 * PM 이름
	 */
	private String pmName;
	/**
	 * PM 지급
	 */
	private String pmGrade;
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
	private String rreqStatus;
	
	/**
	 * 요청자직급
	 */
	private String grade;
	/**
	 * 요청자산 목록
	 */
	private List<ApprovalDetailVO> approvalDetailList;
	/**
	 * 결재자 ID
	 */
	private String targetId;
	/**
	 * 이전결제자 ID
	 */
	private String targetUp;
	
	private String aprvOrder;
	
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

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public List<ApprovalDetailVO> getApprovalDetailList() {
		return approvalDetailList;
	}

	public void setApprovalDetailList(List<ApprovalDetailVO> approvalDetailList) {
		this.approvalDetailList = approvalDetailList;
	}

	public String getPmName() {
		return pmName;
	}

	public void setPmName(String pmName) {
		this.pmName = pmName;
	}

	public String getPmGrade() {
		return pmGrade;
	}

	public void setPmGrade(String pmGrade) {
		this.pmGrade = pmGrade;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	public String getTargetUp() {
		return targetUp;
	}

	public void setTargetUp(String targetUp) {
		this.targetUp = targetUp;
	}

	public String getPrjName() {
		return prjName;
	}

	public void setPrjName(String prjName) {
		this.prjName = prjName;
	}

	public String getAprvDate() {
		return aprvDate;
	}

	public void setAprvDate(String aprvDate) {
		this.aprvDate = aprvDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUpreqStatus() {
		return upreqStatus;
	}

	public void setUpreqStatus(String upreqStatus) {
		this.upreqStatus = upreqStatus;
	}


	public String getAprvOrder() {
		return aprvOrder;
	}

	public void setAprvOrder(String aprvOrder) {
		this.aprvOrder = aprvOrder;
	}

	public String getRreqStatus() {
		return rreqStatus;
	}

	public void setRreqStatus(String rreqStatus) {
		this.rreqStatus = rreqStatus;
	}

	public String getLastUserName() {
		return lastUserName;
	}

	public void setLastUserName(String lastUserName) {
		this.lastUserName = lastUserName;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}


	public String getPrjCode() {
		return prjCode;
	}

	public void setPrjCode(String prjCode) {
		this.prjCode = prjCode;
	}


}
