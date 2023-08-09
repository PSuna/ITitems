package egovframework.let.org.service;

import java.io.Serializable;

/**
 * 부서에 대한 데이터 처리 모델 클래스
 * @author 영남사업부 주소현
 * @since 2023.08.09
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.08.09  주소현          최초 생성
 *  
 *  </pre>
 */

@SuppressWarnings("serial")
public class OrgnztVO implements Serializable {

	/** 부서 ID */
	private String orgnztId;

	/** 부서 이름 */
	private String orgnztNm;

	/** 부서 설명 */
	private String orgnztDc;

	/** 상위 부서 */
	private String orgnztUp;
	
	/** 하위 부서 개수 */
	private String lowCnt;
	
	/** 부서 순서 */
	private int orgnztOrder;

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

	public String getOrgnztDc() {
		return orgnztDc;
	}

	public void setOrgnztDc(String orgnztDc) {
		this.orgnztDc = orgnztDc;
	}

	public String getOrgnztUp() {
		return orgnztUp;
	}

	public void setOrgnztUp(String orgnztUp) {
		this.orgnztUp = orgnztUp;
	}

	public String getLowCnt() {
		return lowCnt;
	}

	public void setLowCnt(String lowCnt) {
		this.lowCnt = lowCnt;
	}

	public int getOrgnztOrder() {
		return orgnztOrder;
	}

	public void setOrgnztOrder(int orgnztOrder) {
		this.orgnztOrder = orgnztOrder;
	}
	
	
}
