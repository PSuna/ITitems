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

	/** 자산관리번호 */
	private String mngNum;
	
	/** 새 자산관리번호 */
	private String newMngNum;
	
	/** 임시 자산코드 */
	private String assetId;

	/** 대분류 */
	private String largeCategory;
	
	/** 대분류 코드*/
	private String largeCategoryCode;
	
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
	
	/** 자산 시작일 */
	private String assetStart;
	
	/** 자산 종료일 */
	private String assetEnd;

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
	
	/** 업체 */
	private String assetCompany;
	
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
	
	/** 자산 상태 */
	private String assetStauts;
	
	/** 등록날짜 */
	private String creatDt;
	
	/** 등록자 */
	private String creatId;
	
	/** 등록자 이름 */
	private String creatNm;
	
	/** 사용 상태 */
	private String usageStauts;
	
	/** 자산 개수 */
	private String assetQty;
	
	/** 자산 분류 ID */
	private String assId;
	
	/** 요청분류 */
	private String reqGroup;
	
	/** 요청날짜 */
	private String reqDate;
	
	private int result;
	
	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
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


	public String getRcptDate() {
		return rcptDate;
	}

	public void setRcptDate(String rcptDate) {
		this.rcptDate = rcptDate;
	}


	public String getMcatNm() {
		return mcatNm;
	}

	public void setMcatNm(String mcatNm) {
		this.mcatNm = mcatNm;
	}

	public String getAssetStart() {
		return assetStart;
	}

	public void setAssetStart(String assetStart) {
		this.assetStart = assetStart;
	}

	public String getAssetEnd() {
		return assetEnd;
	}

	public void setAssetEnd(String assetEnd) {
		this.assetEnd = assetEnd;
	}

	public String getAssetStauts() {
		return assetStauts;
	}

	public void setAssetStauts(String assetStauts) {
		this.assetStauts = assetStauts;
	}

	public String getCreatDt() {
		return creatDt;
	}

	public void setCreatDt(String creatDt) {
		this.creatDt = creatDt;
	}

	public String getCreatId() {
		return creatId;
	}

	public void setCreatId(String creatId) {
		this.creatId = creatId;
	}

	public String getCreatNm() {
		return creatNm;
	}

	public void setCreatNm(String creatNm) {
		this.creatNm = creatNm;
	}

	public String getLargeCategoryCode() {
		return largeCategoryCode;
	}

	public void setLargeCategoryCode(String largeCategoryCode) {
		this.largeCategoryCode = largeCategoryCode;
	}

	public String getAssId() {
		return assId;
	}

	public void setAssId(String assId) {
		this.assId = assId;
	}

	public String getUsageStauts() {
		return usageStauts;
	}

	public void setUsageStauts(String usageStauts) {
		this.usageStauts = usageStauts;
	}

	public String getAssetCompany() {
		return assetCompany;
	}

	public void setAssetCompany(String assetCompany) {
		this.assetCompany = assetCompany;
	}

	public String getNewMngNum() {
		return newMngNum;
	}

	public void setNewMngNum(String newMngNum) {
		this.newMngNum = newMngNum;
	}

	public String getReqGroup() {
		return reqGroup;
	}

	public void setReqGroup(String reqGroup) {
		this.reqGroup = reqGroup;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}


	
}
