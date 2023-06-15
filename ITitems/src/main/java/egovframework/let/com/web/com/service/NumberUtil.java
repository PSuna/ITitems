package egovframework.let.com.service;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.Map;


/**
*
* Number 관련 Utils
* @author 전경원 선임
* @since 2022.07.21
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일      수정자           수정내용
*  -------    --------    ---------------------------
* 2022.07.21   전경원 		최초 적용	
*   
*
* </pre>
*/
public class NumberUtil {

	/**
     * <pre>
     * 1. 개요 :  숫자타입을 BigDecimal 형태로 리턴한다
 	 * 2. 처리내용 : 숫자타입을 BigDecimal 형태로 리턴한다
     * </pre>
     * @Method Name : deleteSurvey
     * @date : 2022. 7. 21
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 7. 21		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
	public static BigDecimal getBigDecimal(Object value) {

		BigDecimal result = new BigDecimal("0");
//		result = new BigDecimal("0");
		try {
			result = new BigDecimal(value.toString());
		}catch (ArithmeticException e1) {
			throw e1;
		}catch (NumberFormatException e1) {
			throw e1;
		}catch (Exception e) {
			throw e;
		}

		return result;
	}

	
	/**
     * <pre>
     * 1. 개요 :  숫자타입을 BigInteger 형태로 리턴한다
 	 * 2. 처리내용 : 숫자타입을 BigInteger 형태로 리턴한다
     * </pre>
     * @Method Name : deleteSurvey
     * @date : 2022. 7. 21
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 7. 21		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
	public static BigInteger getBigInteger(Object value) {

		BigInteger result = new BigInteger("0");

		try {
			result = new BigInteger(value.toString());

		}catch (ArithmeticException e1) {
			throw e1;
		}catch (NumberFormatException e1) {
			throw e1;
		}catch (Exception e) {
			throw e;
		}

		return result;
	}
	
	/**
     * <pre>
     * 1. 개요 :  숫자타입을 String 형태로 리턴
 	 * 2. 처리내용 : 숫자타입을 String 형태로 리턴
     * </pre>
     * @Method Name : getBigDecimalString
     * @date : 2022. 10. 24
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 10. 24		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
	public static Object getBigDecimalString(Map map, String value) {

//		DecimalFormat df = new DecimalFormat("#,###.##########");
		DecimalFormat df = new DecimalFormat("#.##########");
		Object result = "";

		try {
			
//			BigDecimal tmpDouble = NumberUtil.getBigDecimal(map.get("WINBID_VOLM"));
			
			result = df.format(new BigDecimal(new Double((Double)map.get(value))).setScale(10, RoundingMode.HALF_DOWN));
			
		}catch (ArithmeticException e1) {
			throw e1;
		}catch (NumberFormatException e1) {
			throw e1;
		}catch (Exception e) {
			throw e;
		}

		return result;
	}
	
	/**
     * <pre>
     * 1. 개요 :  숫자타입을 BigDecimal 형태로 리턴한다 (엑셀)
 	 * 2. 처리내용 : 숫자타입을 BigDecimal 형태로 리턴한다 (엑셀)
     * </pre>
     * @Method Name : getExcelBigInteger
     * @date : 2022. 9.14
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 9.14	gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
	public static BigDecimal getExcelBigDecimal(Object value) throws Exception {

		BigDecimal result = null;

		result = new BigDecimal(value.toString());

		return result;
	}

	
	/**
     * <pre>
     * 1. 개요 :  숫자타입을 Integer 형태로 리턴한다
 	 * 2. 처리내용 : 숫자타입을 Integer 형태로 리턴한다
     * </pre>
     * @Method Name : getInteger
     * @date : 2022. 7. 21
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 7. 21		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
	public static Integer getInteger(Object value) {

		Integer result = new Integer("0");

		try {
			result = new Integer(value.toString());

		}catch (ArithmeticException e1) {
			throw e1;
		}catch (NumberFormatException e1) {
			throw e1;
		}catch (Exception e) {
			throw e;
		}

		return result;
	}

	/**
     * <pre>
     * 1. 개요 :  숫자타입을 Integer 빈값의 경우 null 형태로 리턴한다
 	 * 2. 처리내용 : 숫자타입을 Integer  빈값의 경우 null 형태로 리턴한다
     * </pre>
     * @Method Name : getIntegerOrNull
     * @date : 2022. 7. 21
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 7. 21		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
	public static Integer getIntegerOrNull(Object value) {

		Integer result = null;

		try {
			result = new Integer(value.toString());

		}catch (ArithmeticException e1) {
			throw e1;
		}catch (NumberFormatException e1) {
			throw e1;
		}catch (Exception e) {
			throw e;
		}

		return result;
	}
	
	/**
     * <pre>
     * 1. 개요 :  숫자타입을 BigInteger 빈값의 경우 null 형태로 리턴한다
 	 * 2. 처리내용 : 숫자타입을 BigInteger  빈값의 경우 null 형태로 리턴한다
     * </pre>
     * @Method Name : getBigIntegerOrNull
     * @date : 2022. 9. 24
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 9. 24		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
	public static BigInteger getBigIntegerOrNull(Object value) {

		BigInteger result = null;

		try {
			result = new BigInteger(value.toString());

		}catch (ArithmeticException e1) {
			throw e1;
		}catch (NumberFormatException e1) {
			throw e1;
		}catch (Exception e) {
			throw e;
		}

		return result;
	}
	
	/**
     * <pre>
     * 1. 개요 :  숫자타입을 BigDecimal 빈값의 경우 null 형태로 리턴한다
 	 * 2. 처리내용 : 숫자타입을 BigDecimal  빈값의 경우 null 형태로 리턴한다
     * </pre>
     * @Method Name : deleteSurvey
     * @date : 2022. 9. 24
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 9. 24		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
	public static BigDecimal getBigDecimalOrNull(Object value) {
		BigDecimal result = null;

		try {
			result = new BigDecimal(value.toString());

		}catch (ArithmeticException e1) {
			throw e1;
		}catch (NumberFormatException e1) {
			throw e1;
		}catch (Exception e) {
			throw e;
		}

		return result;
	}
	
	
}