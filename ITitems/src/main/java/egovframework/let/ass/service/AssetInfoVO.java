package egovframework.let.ass.service;

import java.io.Serializable;
import java.util.Date;

import egovframework.com.cmm.service.FileVO;

/**
 * 자산정보에 대한 데이터 처리 모델 클래스
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
public class AssetInfoVO implements Serializable {
	
	/** 자산코드 */
	private String assetId;
	
	/** 대분류 */
	private String largeCategory;
	
	/** 중분류 */
	private String middleCategory;
	
	/** 품명 */
	private String assetName;
	
	/** 수량 */
	private String assetQty;
	
	/** 취득일자 */
	private String acquiredDate;
	
	/** 취득가액 */
	private String acquiredPrice;
	
	/** 제조사 */
	private String maker;
	
	/** 비고 */
	private String note;
	
	/** 등록자 */
	private String regId;
	
	/** 등록일자 */
	private String regDate;
	
	/** 사용상태 */
	private String usageStatus;
	
	/** 부서 */
	private String orgnztId;
	
	/** 프로젝트 */
	private String prjId;
	
	/** 프로젝트 이름 */
	private String prjNm;
	
	/** 사진코드 */
	private String photoId;
	
	/** 내역 상태 */
	private String histStatus;
	
	/** 제품번호(S/N) */
	private String assetSn;
	
	/** 지급확인서 코드 */
	private String fileId;
	
	/** 결재 */
	private String approval;
	
	/** 실사용자 */
	private String useId;
	
	/** 실사용자 이름 */
	private String useNm;
	
	/** 수령일자 */
	private String rcptDate;
	
	/** 수령자 */
	private String rcptId;
	
	/** 수령자 이름 */
	private String rcptNm;
	
	/** 반출사유 */
	private String carryReason;

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
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

	public String getAssetQty() {
		return assetQty;
	}

	public void setAssetQty(String assetQty) {
		this.assetQty = assetQty;
	}

	public String getAcquiredDate() {
		return acquiredDate;
	}

	public void setAcquiredDate(String acquiredDate) {
		this.acquiredDate = acquiredDate;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUsageStatus() {
		return usageStatus;
	}

	public void setUsageStatus(String usageStatus) {
		this.usageStatus = usageStatus;
	}

	public String getAcquiredPrice() {
		return acquiredPrice;
	}

	public void setAcquiredPrice(String acquiredPrice) {
		this.acquiredPrice = acquiredPrice;
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

	public String getPhotoId() {
		return photoId;
	}

	public void setPhotoId(String photoId) {
		this.photoId = photoId;
	}

	public String getHistStatus() {
		return histStatus;
	}

	public void setHistStatus(String histStatus) {
		this.histStatus = histStatus;
	}

	public String getAssetSn() {
		return assetSn;
	}

	public void setAssetSn(String assetSn) {
		this.assetSn = assetSn;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getApproval() {
		return approval;
	}

	public void setApproval(String approval) {
		this.approval = approval;
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

	public String getPrjNm() {
		return prjNm;
	}

	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	public String getUseNm() {
		return useNm;
	}

	public void setUseNm(String useNm) {
		this.useNm = useNm;
	}

	public String getRcptNm() {
		return rcptNm;
	}

	public void setRcptNm(String rcptNm) {
		this.rcptNm = rcptNm;
	}
	
	
	
}
