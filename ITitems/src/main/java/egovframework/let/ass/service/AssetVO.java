package egovframework.let.ass.service;

import java.io.Serializable;

/**
 * 자산정보 관리를 위한 데이터 접근 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *
 *      </pre>
 */
@SuppressWarnings("serial")
public class AssetVO implements Serializable {
	
	/** 자산코드 */
	private String assetId;

	/** 등록일자 */
	private String regDate;

	/** 등록자 */
	private String regId;

	/** 자산 개수 */
	private String assetQty;
	
	/** 대분류 */
	private String largeCategory;
	
	/** 중분류 */
	private String middleCategory;
	
	/** 중분류 이름*/
	private String mcatNm;

	/** 중분류 기타 */
	private String mcatEtc;

	/** 제품명(모델명) */
	private String assetName;

	/** 취득일자 */
	private String acquiredDate;

	/** 취득가액 */
	private String acquiredPrice;

	/** 제조사 */
	private String maker;

	/** 제조사 코드 */
	private String makerCode;

	/** 비고 */
	private String note;

	/** 시리얼넘버 */
	private String assetSn;

	/** 자산관리번호 */
	private String mngNum;

	/** 수령자 */
	private String rcptId;
	
	/** 수령자 이름 */
	private String rcptNm;
	
	/** 자산상세 ID */
	private String aId;

	/** 본부 */
	private String orgnztId;
	
	/** 본부 이름 */
	private String orgnztNm;
	
	/** 부서 */
	private String lowerOrgnztId;
	
	/** 부서 이름 */
	private String lowerOrgnztNm;

	/** 프로젝트 */
	private String prjId;
	
	/** 프로젝트 이름 */
	private String prjNm;

	/** 사용자 */
	private String useId;

	/** 사용자 이름*/
	private String useNm;

	/** 내역 상태 */
	private String histStatus;

	/** 내역 신청일자 */
	private String histDate;

	/** 내역 신청자 */
	private String histUser;

	/** 내역 분류 */
	private String histGroup;

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getAssetQty() {
		return assetQty;
	}

	public void setAssetQty(String assetQty) {
		this.assetQty = assetQty;
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

	public String getMcatNm() {
		return mcatNm;
	}

	public void setMcatNm(String mcatNm) {
		this.mcatNm = mcatNm;
	}

	public String getMcatEtc() {
		return mcatEtc;
	}

	public void setMcatEtc(String mcatEtc) {
		this.mcatEtc = mcatEtc;
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

	public String getMakerCode() {
		return makerCode;
	}

	public void setMakerCode(String makerCode) {
		this.makerCode = makerCode;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getAssetSn() {
		return assetSn;
	}

	public void setAssetSn(String assetSn) {
		this.assetSn = assetSn;
	}

	public String getMngNum() {
		return mngNum;
	}

	public void setMngNum(String mngNum) {
		this.mngNum = mngNum;
	}

	public String getRcptId() {
		return rcptId;
	}

	public void setRcptId(String rcptId) {
		this.rcptId = rcptId;
	}

	public String getRcptNm() {
		return rcptNm;
	}

	public void setRcptNm(String rcptNm) {
		this.rcptNm = rcptNm;
	}

	public String getaId() {
		return aId;
	}

	public void setaId(String aId) {
		this.aId = aId;
	}

	public String getOrgnztId() {
		return orgnztId;
	}

	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}

	public String getOrgnztNm() {
		return orgnztNm;
	}

	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}

	public String getLowerOrgnztId() {
		return lowerOrgnztId;
	}

	public void setLowerOrgnztId(String lowerOrgnztId) {
		this.lowerOrgnztId = lowerOrgnztId;
	}

	public String getLowerOrgnztNm() {
		return lowerOrgnztNm;
	}

	public void setLowerOrgnztNm(String lowerOrgnztNm) {
		this.lowerOrgnztNm = lowerOrgnztNm;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String getPrjNm() {
		return prjNm;
	}

	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	public String getUseId() {
		return useId;
	}

	public void setUseId(String useId) {
		this.useId = useId;
	}

	public String getUseNm() {
		return useNm;
	}

	public void setUseNm(String useNm) {
		this.useNm = useNm;
	}

	public String getHistStatus() {
		return histStatus;
	}

	public void setHistStatus(String histStatus) {
		this.histStatus = histStatus;
	}

	public String getHistDate() {
		return histDate;
	}

	public void setHistDate(String histDate) {
		this.histDate = histDate;
	}

	public String getHistUser() {
		return histUser;
	}

	public void setHistUser(String histUser) {
		this.histUser = histUser;
	}

	public String getHistGroup() {
		return histGroup;
	}

	public void setHistGroup(String histGroup) {
		this.histGroup = histGroup;
	}
	
	
}
