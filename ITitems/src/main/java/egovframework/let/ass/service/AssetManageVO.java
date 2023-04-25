package egovframework.let.ass.service;

import java.io.Serializable;
import java.util.Date;

/**
 * 자산내역 관리를 위한 VO 클래스
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
public class AssetManageVO implements Serializable {

	/** 자산코드 */
	private String assetId;
	
	/** 검색위치 */
    private String searchOrgnzt = "";
    
    /** 검색프로젝트 */
    private String searchPrj = "";
    
    /** 프로젝트명 */
    private String prjNm = "";
    
    /** 검색대분류 */
    private String searchLCat = "";
    
    /** 검색중분류 */
    private String searchdMCat = "";
    
    /** 검색상태 */
    private String searchStatus = "";
	
	/** 검색시작일 */
    private String startDate  = "";
    
    /** 검색종료일 */
    private String endDate  = "";
    
    /** 검색단어 */
    private String searchWord = "";
    
    /** 페이징 */
    
    /** 정렬순서(DESC,ASC) */
    private long sortOrdr = 0L;

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 첫페이지 인덱스 */
    private int startPage = 1;

    /** 마지막페이지 인덱스 */
    private int lastPage = 1;

    /** 전체 레코드 개수 */
    private int totalRecord = 100;
    
    /** 시작 레코드 번호 */
    private int first;
    
    /** 마지막 레코드 번호 */
    private int last;
    
    /** 전체 마지막페이지 인덱스*/
    private int endPage;
    
    /** row_number */
   	private int rum;
    
   	/** 대분류 */
	private String largeCategory;
	
	/** 중분류 */
	private String middleCategory;
	
	/** 품명 */
	private String assetName;
	
	/** 자산내역수량 */
	private int histQty;
	
	/** 취득일자 */
	private String acquiredDate;
	
	/** 취득가액 */
	private int acquiredPrice;
	
	/** 제조사 */
	private String maker;
	
	/** 자산내역상태 */
	private String histStatus;
	
	
	
    public int getFirst() {
		first = (getPageIndex() - 1) * getPageUnit() + 1;
		return first;
	}
	public int getLast() {
		last = getPageIndex() * getPageUnit();
		return last;
	}

	
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getLastPage() {
		lastPage = totalRecord / pageUnit + 
				   ( totalRecord % pageUnit>0 ? 1 : 0 );
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public Integer getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getStartPage() {
		startPage = (pageIndex-1)/pageSize * pageSize + 1;
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		endPage = (pageIndex-1)/pageSize  * pageSize  + pageSize ;
		if ( endPage > getLastPage() )
			endPage = getLastPage() ;
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public String getSearchOrgnzt() {
		return searchOrgnzt;
	}
	public void setSearchOrgnzt(String searchOrgnzt) {
		this.searchOrgnzt = searchOrgnzt;
	}
	public String getSearchPrj() {
		return searchPrj;
	}
	public void setSearchPrj(String searchPrj) {
		this.searchPrj = searchPrj;
	}
	public String getSearchLCat() {
		return searchLCat;
	}
	public void setSearchLCat(String searchLCat) {
		this.searchLCat = searchLCat;
	}
	public String getSearchdMCat() {
		return searchdMCat;
	}
	public void setSearchdMCat(String searchdMCat) {
		this.searchdMCat = searchdMCat;
	}
	public String getSearchStatus() {
		return searchStatus;
	}
	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
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
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public long getSortOrdr() {
		return sortOrdr;
	}
	public void setSortOrdr(long sortOrdr) {
		this.sortOrdr = sortOrdr;
	}
	public void setPage(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public void setFirst(int first) {
		this.first = first;
	}
	public void setLast(int last) {
		this.last = last;
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
	public int getHistQty() {
		return histQty;
	}
	public void setHistQty(int histQty) {
		this.histQty = histQty;
	}
	public String getAcquiredDate() {
		return acquiredDate;
	}
	public void setAcquiredDate(String acquiredDate) {
		this.acquiredDate = acquiredDate;
	}
	public int getAcquiredPrice() {
		return acquiredPrice;
	}
	public void setAcquiredPrice(int acquiredPrice) {
		this.acquiredPrice = acquiredPrice;
	}
	public String getMaker() {
		return maker;
	}
	public void setMaker(String maker) {
		this.maker = maker;
	}
	public String getHistStatus() {
		return histStatus;
	}
	public void setHistStatus(String histStatus) {
		this.histStatus = histStatus;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public String getAssetId() {
		return assetId;
	}
	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}
	
	
}
