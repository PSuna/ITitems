package egovframework.let.res.org.service;

import java.io.Serializable;

public class OrgnztDefaultVO implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/** 상위 검색 */
    private String searchUpperOrg = "";

	public String getSearchUpperOrg() {
		return searchUpperOrg;
	}

	public void setSearchUpperOrg(String searchUpperOrg) {
		this.searchUpperOrg = searchUpperOrg;
	}

}
