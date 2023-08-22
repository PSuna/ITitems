package egovframework.let.res.req.service;

import java.io.Serializable;

/**
 * 신청내역에 대한 데이터 처리 모델 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.26
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.26  주소현          최초 생성
 *  
 *  </pre>
 */

@SuppressWarnings("serial")
public class RequestVO implements Serializable {

	/** 신청코드 */
	private String reqId;

	/** 신청자 */
	private String id;

	/** 신청일자 */
	private String reqDate;

	/** 신청상태 */
	private String reqStatus;

	/** 비고 */
	private String reqNote;

	/** 프로젝트 */
	private String prjId;

	/** 대표자 */
	private String pm;

	/** 사용시작일자 */
	private String startDate;

	/** 사용종료일자 */
	private String endDate;
	
	/** 사용장소 */
	private String place;
	
	/** 신청분류 */
	private String reqGroup;
	
	/** 넘버 */
	private Integer rum;

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

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public String getReqStatus() {
		return reqStatus;
	}

	public void setReqStatus(String reqStatus) {
		this.reqStatus = reqStatus;
	}

	public String getReqNote() {
		return reqNote;
	}

	public void setReqNote(String reqNote) {
		this.reqNote = reqNote;
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

	public Integer getRum() {
		return rum;
	}

	public void setRum(Integer rum) {
		this.rum = rum;
	}
	
	
}
