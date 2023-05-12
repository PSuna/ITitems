package egovframework.let.ass.service;

import java.io.Serializable;
import java.util.Date;

/**
 * 자산내역에 대한 데이터 처리 모델 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *  
 *  </pre>
 */

@SuppressWarnings("serial")
public class AssetHistVO implements Serializable {
	
	/** 자산내역코드 */
	private String histId;
	
	/** 자산코드 */
	private String assetId;
	
	/** 부서코드 */
	private String orgnztId;
	
	/** 프로젝트코드 */
	private String prjId;
	
	/** 실사용자 */
	private String useId;
	
	/** 자산내역수량 */
	private String histQty;
	
	/** 자산내역상태 */
	private String histStatus;
	
	/** 자산내역비고 */
	private String histNote;
	
	/** 자산내역일자 */
	private String histDate;
	
	 /** row_number */
   	private int rum;
    
   	/** 대분류 */
	private String largeCategory;
	
	/** 중분류 */
	private String middleCategory;
	
	/** 품명 */
	private String assetName;
	
	/** 취득일자 */
	private String acquiredDate;
	
	/** 취득가액 */
	private String acquiredPrice;
	
	/** 제조사 */
	private String maker;
	
	/** 수령일자 */
	private String rcptDate;
	
	/** 수령자 */
	private String rcptId;
	
	/** 반출사유 */
	private String carryReason;
	
	/** 결재 */
	private String approval;
	
	/** CODE */
	private String code;
	
	/** 파일코드 */
	private String fileId;

	/** 내역분류 */
	private String histGroup;
	
	public String getHistId() {
		return histId;
	}

	public void setHistId(String histId) {
		this.histId = histId;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}


	public String getOrgnztId() {
		return orgnztId;
	}

	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	
	public String getHistQty() {
		return histQty;
	}

	public void setHistQty(String histQty) {
		this.histQty = histQty;
	}

	public String getHistStatus() {
		return histStatus;
	}

	public void setHistStatus(String histStatus) {
		this.histStatus = histStatus;
	}

	public String getHistNote() {
		return histNote;
	}

	public void setHistNote(String histNote) {
		this.histNote = histNote;
	}

	public String getHistDate() {
		return histDate;
	}

	public void setHistDate(String histDate) {
		this.histDate = histDate;
	}

	public int getRum() {
		return rum;
	}

	public void setRum(int rum) {
		this.rum = rum;
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

	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	public String getAcquiredDate() {
		return acquiredDate;
	}

	public void setAcquiredDate(String acquiredDate) {
		this.acquiredDate = acquiredDate;
	}

	public String getAcquiredPrice() {
		return acquiredPrice;
	}

	public void setAcquiredPrice(String acquiredPrice) {
		this.acquiredPrice = acquiredPrice;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getUseId() {
		return useId;
	}

	public void setUseId(String useId) {
		this.useId = useId;
	}

	public String getRcptDate() {
		return rcptDate;
	}

	public void setRcptDate(String rcptDate) {
		this.rcptDate = rcptDate;
	}

	public String getRcptId() {
		return rcptId;
	}

	public void setRcptId(String rcptId) {
		this.rcptId = rcptId;
	}

	public String getCarryReason() {
		return carryReason;
	}

	public void setCarryReason(String carryReason) {
		this.carryReason = carryReason;
	}

	public String getApproval() {
		return approval;
	}

	public void setApproval(String approval) {
		this.approval = approval;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getHistGroup() {
		return histGroup;
	}

	public void setHistGroup(String histGroup) {
		this.histGroup = histGroup;
	}
	
	
}
