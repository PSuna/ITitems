package egovframework.let.rent.service;

import java.io.Serializable;

/**
 * 렌탈정보에 대한 데이터 처리 모델 클래스
 * @author 영남사업부 주소현
 * @since 2023.06.07
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.06.07  주소현          최초 생성
 *  
 *  </pre>
 */
@SuppressWarnings("serial")
public class RentalVO implements Serializable {

	/** 렌탈 ID */
	private String rentalId;

	/** 등록일자 */
	private String regDate;

	/** 등록자 */
	private String regId;

	/** 렌탈 개수 */
	private String rentalQty;

	/** 렌탈상세 ID */
	private String rId;

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

	/** 렌탈 시작일 */
	private String rentalStart;

	/** 렌탈 종료일 */
	private String rentalEnd;

	/** 렌탈 비용 */
	private String rentalPrice;

	/** 렌탈 업체명 */
	private String rentalCompany;

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
	
	/** 수령일자 */
	private String rcptDate;

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

	/** 내역 신청자 */
	private String histUser;
	
	/** 내역 등록일자 */
	private String creatDt;

	/** 내역 분류 */
	private String histGroup;

	public String getRentalId() {
		return rentalId;
	}

	public void setRentalId(String rentalId) {
		this.rentalId = rentalId;
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

	public String getRentalQty() {
		return rentalQty;
	}

	public void setRentalQty(String rentalQty) {
		this.rentalQty = rentalQty;
	}

	public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
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

	public String getRentalStart() {
		return rentalStart;
	}

	public void setRentalStart(String rentalStart) {
		this.rentalStart = rentalStart;
	}

	public String getRentalEnd() {
		return rentalEnd;
	}

	public void setRentalEnd(String rentalEnd) {
		this.rentalEnd = rentalEnd;
	}

	public String getRentalPrice() {
		return rentalPrice;
	}

	public void setRentalPrice(String rentalPrice) {
		this.rentalPrice = rentalPrice;
	}

	public String getRentalCompany() {
		return rentalCompany;
	}

	public void setRentalCompany(String rentalCompany) {
		this.rentalCompany = rentalCompany;
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

	public String getUseId() {
		return useId;
	}

	public void setUseId(String useId) {
		this.useId = useId;
	}

	public String getHistStatus() {
		return histStatus;
	}

	public void setHistStatus(String histStatus) {
		this.histStatus = histStatus;
	}

	public String getRcptId() {
		return rcptId;
	}

	public void setRcptId(String rcptId) {
		this.rcptId = rcptId;
	}

	public String getHistGroup() {
		return histGroup;
	}

	public void setHistGroup(String histGroup) {
		this.histGroup = histGroup;
	}

	public String getHistUser() {
		return histUser;
	}

	public void setHistUser(String histUser) {
		this.histUser = histUser;
	}

	public String getCreatDt() {
		return creatDt;
	}

	public void setCreatDt(String creatDt) {
		this.creatDt = creatDt;
	}

	public String getRcptNm() {
		return rcptNm;
	}

	public void setRcptNm(String rcptNm) {
		this.rcptNm = rcptNm;
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

	public String getMcatNm() {
		return mcatNm;
	}

	public void setMcatNm(String mcatNm) {
		this.mcatNm = mcatNm;
	}

	public String getRcptDate() {
		return rcptDate;
	}

	public void setRcptDate(String rcptDate) {
		this.rcptDate = rcptDate;
	}
	
	
}
