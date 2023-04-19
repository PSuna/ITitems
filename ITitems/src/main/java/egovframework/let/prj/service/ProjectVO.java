 package egovframework.let.prj.service;

import java.io.Serializable;
import java.util.Date;

/**
 * 프로젝트에 대한 데이터 처리 모델 클래스
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
public class ProjectVO  implements Serializable {

    /** 프로젝트코드 */
	private String prjId;

    /** 프로젝트명 */
	private String prjName;
	
    /** 프로젝트 시작일 */
	private String prjStart;
	
    /** 프로젝트 종료일 */
	private String prjEnd;
	
    /** 대표자 */
	private String id;
	
    /** 고객사 */
	private String client;
	
    /** 프로젝트 상태 */
	private String prjState;
	
	/** 대표 이름 */
	private String name;
	
	/** 대표 직급 */
	private String position;

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String getPrjName() {
		return prjName;
	}

	public void setPrjName(String prjName) {
		this.prjName = prjName;
	}

	public String getPrjStart() {
		return prjStart;
	}

	public void setPrjStart(String prjStart) {
		this.prjStart = prjStart;
	}

	public String getPrjEnd() {
		return prjEnd;
	}

	public void setPrjEnd(String prjEnd) {
		this.prjEnd = prjEnd;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getPrjState() {
		return prjState;
	}

	public void setPrjState(String prjState) {
		this.prjState = prjState;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
  
}
