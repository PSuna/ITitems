package egovframework.let.ass.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class AssetMasterVO implements Serializable  {

	/** 자산 분류 ID */
	private String assId;

	/** 자산 분류 이름 */
	private String assNm;

	/** 생성한 사람 */
	private String frstRegisterId;

	/** 생성 날짜 */
	private String frstRegistPnttm;

	/** 수정한 사람 */
	private String lastUpdusrId;

	/** 수정 날짜 */
	private String lastUpdtPnttm;

	public String getAssId() {
		return assId;
	}

	public void setAssId(String assId) {
		this.assId = assId;
	}

	public String getAssNm() {
		return assNm;
	}

	public void setAssNm(String assNm) {
		this.assNm = assNm;
	}

	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	public String getFrstRegistPnttm() {
		return frstRegistPnttm;
	}

	public void setFrstRegistPnttm(String frstRegistPnttm) {
		this.frstRegistPnttm = frstRegistPnttm;
	}

	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	public String getLastUpdtPnttm() {
		return lastUpdtPnttm;
	}

	public void setLastUpdtPnttm(String lastUpdtPnttm) {
		this.lastUpdtPnttm = lastUpdtPnttm;
	}
	
	
}
