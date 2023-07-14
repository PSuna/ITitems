package egovframework.let.sec.ram.service;

import egovframework.com.cmm.ComDefaultVO;

/**
 * 권한관리에 대한 model 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */

public class AuthorManage extends ComDefaultVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 권한관리
	 */	
	private AuthorManage authorManage;
	/**
	 * 권한코드
	 */
	private String authorCode;
	/**
	 * 권한등록일자
	 */
	private String authorCreatDe;
	/**
	 * 권한코드설명
	 */
	private String authorDc;
	/**
	 * 권한 명
	 */
	private String authorNm;
	
	private String uniqId;
	
	/** 검색Keyword */
    private String searchKeyword = "";
    
    private String searchAuthor = "";
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
	
	/**
	 * authorManage attribute 를 리턴한다.
	 * @return AuthorManage
	 */
	public AuthorManage getAuthorManage() {
		return authorManage;
	}
	/**
	 * authorManage attribute 값을 설정한다.
	 * @param authorManage AuthorManage 
	 */
	public void setAuthorManage(AuthorManage authorManage) {
		this.authorManage = authorManage;
	}
	/**
	 * authorCode attribute 를 리턴한다.
	 * @return String
	 */
	public String getAuthorCode() {
		return authorCode;
	}
	/**
	 * authorCode attribute 값을 설정한다.
	 * @param authorCode String 
	 */
	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}
	/**
	 * authorCreatDe attribute 를 리턴한다.
	 * @return String
	 */
	public String getAuthorCreatDe() {
		return authorCreatDe;
	}
	/**
	 * authorCreatDe attribute 값을 설정한다.
	 * @param authorCreatDe String 
	 */
	public void setAuthorCreatDe(String authorCreatDe) {
		this.authorCreatDe = authorCreatDe;
	}
	/**
	 * authorDc attribute 를 리턴한다.
	 * @return String
	 */
	public String getAuthorDc() {
		return authorDc;
	}
	/**
	 * authorDc attribute 값을 설정한다.
	 * @param authorDc String 
	 */
	public void setAuthorDc(String authorDc) {
		this.authorDc = authorDc;
	}
	/**
	 * authorNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getAuthorNm() {
		return authorNm;
	}
	/**
	 * authorNm attribute 값을 설정한다.
	 * @param authorNm String 
	 */
	public void setAuthorNm(String authorNm) {
		this.authorNm = authorNm;
	}
	public String getUniqId() {
		return uniqId;
	}
	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
	
	/**
	 * searchKeyword attribute 값을  리턴한다.
	 * @return String
	 */
	public String getSearchKeyword() {
		return searchKeyword;
	}

	/**
	 * searchKeyword attribute 값을 설정한다.
	 * @param searchKeyword String
	 */
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	/**
	 * pageIndex attribute 값을  리턴한다.
	 * @return int
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	/**
	 * pageIndex attribute 값을 설정한다.
	 * @param pageIndex int
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	/**
	 * pageUnit attribute 값을  리턴한다.
	 * @return int
	 */
	public int getPageUnit() {
		return pageUnit;
	}

	/**
	 * pageUnit attribute 값을 설정한다.
	 * @param pageUnit int
	 */
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	/**
	 * pageSize attribute 값을  리턴한다.
	 * @return int
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * pageSize attribute 값을 설정한다.
	 * @param pageSize int
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * firstIndex attribute 값을  리턴한다.
	 * @return int
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * firstIndex attribute 값을 설정한다.
	 * @param firstIndex int
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * lastIndex attribute 값을  리턴한다.
	 * @return int
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * lastIndex attribute 값을 설정한다.
	 * @param lastIndex int
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * recordCountPerPage attribute 값을  리턴한다.
	 * @return int
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * recordCountPerPage attribute 값을 설정한다.
	 * @param recordCountPerPage int
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public String getSearchAuthor() {
		return searchAuthor;
	}
	public void setSearchAuthor(String searchAuthor) {
		this.searchAuthor = searchAuthor;
	}

}
