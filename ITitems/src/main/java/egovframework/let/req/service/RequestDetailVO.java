package egovframework.let.req.service;

import java.io.Serializable;

/**
 * 신청상세정보에 대한 데이터 처리 모델 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.27
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.27  주소현          최초 생성
 *  
 *  </pre>
 */

@SuppressWarnings("serial")
public class RequestDetailVO implements Serializable {

	@Override
	public String toString() {
		return "RequestDetailVO [redId=" + redId + ", reqId=" + reqId + ", largeCategory=" + largeCategory
				+ ", middleCategory=" + middleCategory + ", assetId=" + assetId + ", reqQty=" + reqQty + ", maker="
				+ maker + ", user=" + user + ", useId=" + useId + ", rcptId=" + rcptId + ", assetSn=" + assetSn
				+ ", reqOrder=" + reqOrder + "]";
	}

	/** 신청상세코드 */
	private String redId;

	/** 신청코드 */
	private String reqId;

	/** 중분류 */
	private String largeCategory;
	
	/** 중분류 */
	private String middleCategory;

	/** 자산코드 */
	private String assetId;

	/** 수량 */
	private Integer reqQty;

	/** 제조사 */
	private String maker;

	/** 사용자 */
	private String user;
	
	/** 사용자 고유 ID */
	private String useId;
	
	/** 수령자 */
	private String rcptId;
	
	/** 시리얼넘버 */
	private String assetSn;
	
	/** 신청상세 순서 */
	private Integer reqOrder;

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

	public String getMiddleCategory() {
		return middleCategory;
	}

	public void setMiddleCategory(String middleCategory) {
		this.middleCategory = middleCategory;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public Integer getReqQty() {
		return reqQty;
	}

	public void setReqQty(Integer reqQty) {
		this.reqQty = reqQty;
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

	public String getLargeCategory() {
		return largeCategory;
	}

	public void setLargeCategory(String largeCategory) {
		this.largeCategory = largeCategory;
	}

	public Integer getReqOrder() {
		return reqOrder;
	}

	public void setReqOrder(Integer reqOrder) {
		this.reqOrder = reqOrder;
	}

	public String getRcptId() {
		return rcptId;
	}

	public void setRcptId(String rcptId) {
		this.rcptId = rcptId;
	}

	public String getAssetSn() {
		return assetSn;
	}

	public void setAssetSn(String assetSn) {
		this.assetSn = assetSn;
	}

	public String getUseId() {
		return useId;
	}

	public void setUseId(String useId) {
		this.useId = useId;
	}
	
	
}
