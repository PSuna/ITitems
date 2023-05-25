package egovframework.let.com.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;


/**
*
* String 관련 Utils
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
public class StringUtil {

	
	
	/**
     * <pre>
     * 1. 개요 : null 값을 ''로 리턴한다 
 	 * 2. 처리내용 : 
 	 * 인자로 받은 String이 null일 경우 &quot;&quot;로 리턴한다.
     * &#064;param src null값일 가능성이 있는 String 값.
     * &#064;return 만약 String이 null 값일 경우 &quot;&quot;로 바꾼 String 값.
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
    public static String nullConvert(Object src) {
    	if (src != null && src instanceof java.math.BigDecimal) {
    		return ((BigDecimal)src).toString();
    	}

    	if (src == null || src.equals("null")) {
    		return "";
    	} else {
    		return ((String)src).trim();
    	}
    }
    
    
    
    /**
     * <pre>
     * 1. 개요 : null 값을 ''로 리턴한다 
 	 * 2. 처리내용 : 
 	 * 인자로 받은 String이 null일 경우 &quot;&quot;로 리턴한다.
     * &#064;param src null값일 가능성이 있는 String 값.
     * &#064;return 만약 String이 null 값일 경우 &quot;&quot;로 바꾼 String 값.
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
    public static String nullConvert(Object src, String defaultStr) {
    	if (src != null && src instanceof java.math.BigDecimal) {
    		return ((BigDecimal)src).toString();
    	}

    	if (src == null || src.equals("null")) {
    		return defaultStr;
    	} else {
    		return ((String)src).trim();
    	}
    }
    
    /**
     * <pre>
     * 1. 개요 : String이 비었거나("") 혹은 null 인지 검증한다.
 	 * 2. 처리내용 : 
 	 *  StringUtil.isEmpty(null)      = true
     *  StringUtil.isEmpty("")        = true
     *  StringUtil.isEmpty(" ")       = false
     *  StringUtil.isEmpty("bob")     = false
     *  StringUtil.isEmpty("  bob  ") = false
     * </pre>
     * @Method Name : nvl
     * @date : 2022. 7. 21
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 7. 21		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */ 
    public static String nvl(String str, String rStr) {
    	return isEmpty(str) ? rStr : str;
    }
    
   
    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }
    
    /**
     * <pre>
     * 1. 개요 : 원본 문자열의 포함된 특정 문자열 뒤에서 첫번째까지 리턴하는 메서드
 	 * 2. 처리내용 : 원본 문자열의 포함된 특정 문자열 뒤에서 첫번째까지 리턴하는 메서드
     * </pre>
     * @Method Name : returnLastOnce
     * @date : 2022. 7. 21
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 7. 21		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */
    public static String returnLastOnce(String source, String subject) {
    	String rtnStr = source;
    	if (source.lastIndexOf(subject) >= 0) {
    		rtnStr = source.substring(0, source.lastIndexOf(subject));
    		return rtnStr;
    	} else {
    		return source;
    	}
    }
    /**
     * <pre>
     * 1. 개요 : 기준 문자열에 포함된 모든 대상 문자(char)를 제거한다.
 	 * 2. 처리내용 : 기준 문자열에 포함된 모든 대상 문자(char)를 제거한다.
     * </pre>
     * @Method Name : remove
     * @date : 2022. 7. 21
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 7. 21		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */
    public static String remove(String str, char remove) {
        if (isEmpty(str) || str.indexOf(remove) == -1) {
            return str;
        }
        char[] chars = str.toCharArray();
        int pos = 0;
        for (int i = 0; i < chars.length; i++) {
            if (chars[i] != remove) {
                chars[pos++] = chars[i];
            }
        }
        return new String(chars, 0, pos);
    }
    
    /**
     * <pre>
     * 1. 개요 : 받은 문자열을 날짜 형식으로 변환되는지 체크한다.
 	 * 2. 처리내용 : 받은 문자열을 날짜 형식으로 변환되는지 체크한다.
     * </pre>
     * @Method Name : isDateFormat
     * @date : 2022. 7. 21
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 9. 24		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */
    public static boolean isDateFormat(String str2cmp, String dateFormat) {
    	try {
            //  검증할 날짜 포맷 설정
            SimpleDateFormat dateFormatParser = new SimpleDateFormat(dateFormat);
            //  parse()에 잘못된 값이 들어오면 Exception을 리턴하도록 setLenient(false) 설정
            dateFormatParser.setLenient(false);
            // 대상 인자 검증
            dateFormatParser.parse(str2cmp);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * <pre>
     * 1. 개요 : HTML의 특수문자를 표시하기 위해 사용
 	 * 2. 처리내용 : HTML의 특수문자를 표시하기 위해 사용
     * </pre>
     * @Method Name : isDateFormat
     * @date : 2022. 10. 05
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 10. 05		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */
	public static String getHtmlStrCnvr(String srcString) {

		String tmpString = srcString;

		tmpString = tmpString.replaceAll("&lt;", "<");
		tmpString = tmpString.replaceAll("&gt;", ">");
		tmpString = tmpString.replaceAll("&amp;", "&");
		tmpString = tmpString.replaceAll("&nbsp;", " ");
		tmpString = tmpString.replaceAll("&apos;", "\'");
		tmpString = tmpString.replaceAll("&quot;", "\"");

		return tmpString;

	}
    
	
	 /**
     * <pre>
     * 1. 개요 : HTML의 특수문자를 표시하기 위해 사용
 	 * 2. 처리내용 : HTML의 특수문자를 표시하기 위해 사용
     * </pre>
     * @Method Name : isDateFormat
     * @date : 2022. 10. 05
     * @author : gwjeon
     * @history : 
     *	-----------------------------------------------------------------------
     *	변경일				작성자						변경내용 
     *	----------- ------------------- ---------------------------------------
     *	2022. 10. 05		gwjeon				최초 작성 
     *	-----------------------------------------------------------------------
     */
	public static String isNullToString(Object object) {
		String string = "";

		if (object != null) {
			string = object.toString().trim();
		}

		return string;
	}
}

