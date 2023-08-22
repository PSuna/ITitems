package egovframework.let.res.cat.service;

import java.io.Serializable;

/**
 * 카테고리에 대한 데이터 처리 모델 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.19
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.19  주소현          최초 생성
 *  
 *  </pre>
 */

@SuppressWarnings("serial")
public class CategoryVO  implements Serializable {
	
	/** 카테고리 코드 */
	private String catId;
	
	/** 카테고리명 */
	private String catName;
	
	/** 상위 카테고리 코드 */
	private String upperCat;

	/** 카테고리 sorting order */
	private int catOrder;
	
	/** 카테고리 대 중 구분 */
	private String checkUpDown;
	
	public String getCatId() {
		return catId;
	}

	public void setCatId(String catId) {
		this.catId = catId;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public String getUpperCat() {
		return upperCat;
	}

	public void setUpperCat(String upperCat) {
		this.upperCat = upperCat;
	}

	public int getCatOrder() {
		return catOrder;
	}

	public void setCatOrder(int catOrder) {
		this.catOrder = catOrder;
	}

	public String getCheckUpDown() {
		return checkUpDown;
	}

	public void setCheckUpDown(String checkUpDown) {
		this.checkUpDown = checkUpDown;
	}

	
	
	
}
