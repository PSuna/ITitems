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
public class AssetHist implements Serializable {
	
	/** 자산내역코드 */
	private String histId;
	
	/** 자산코드 */
	private String assetId;
	
	/** 부서코드 */
	private String deptId;
	
	/** 프로젝트코드 */
	private String prjId;
	
	/** 사용자아이디 */
	private String id;
	
	/** 자산내역수량 */
	private int histQty;
	
	/** 자산내역상태 */
	private String histStatus;
	
	/** 자산내역비고 */
	private String histNote;
	
	/** 자산내역일자 */
	private Date histDate;

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

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getHistQty() {
		return histQty;
	}

	public void setHistQty(int histQty) {
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

	public Date getHistDate() {
		return histDate;
	}

	public void setHistDate(Date histDate) {
		this.histDate = histDate;
	}
	
	
}
