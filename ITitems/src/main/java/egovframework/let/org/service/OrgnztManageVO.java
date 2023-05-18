package egovframework.let.org.service;


/**
 * 부서에 대한 데이터 처리 모델 클래스
 * @author 영남사업부 천세훈
 * @since 2023.05.18
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.05.18  천세훈          최초 생성
 *  
 *  </pre>
 */
public class OrgnztManageVO extends OrgnztDefaultVO{
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/** 카테고리 코드 */
	private String orgnztId;
	
	/** 카테고리명 */
	private String orgnztNm;
	
	/** 상위 카테고리 코드 */
	private String orgnztDc;

	/** 카테고리 sorting order */
	private int orgnztUp;

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

	public int getOrgnztUp() {
		return orgnztUp;
	}

	public void setOrgnztUp(int orgnztUp) {
		this.orgnztUp = orgnztUp;
	}

}
