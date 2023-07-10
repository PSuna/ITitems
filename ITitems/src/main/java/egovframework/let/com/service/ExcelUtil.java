package egovframework.let.com.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.ibatis.common.resources.Resources;

/**
 *
 * Excel 관련 Utils
 * 
 * @author 전경원 선임
 * @since 2022.07.18
 * @version 1.0
 * @see
 *
 *      <pre>
* << 개정이력(Modification Information) >>
*
*   수정일      수정자           수정내용
*  -------    --------    ---------------------------
* 2022.07.21   전경원 		최초 적용
 * 
 *
 *      </pre>
 */
@Repository("excelUtil")
public class ExcelUtil {

	/**
	 * <pre>
	 * 1. 개요 : Excel 다운로드시 제목 CSS를 지정한다.
	 * 2. 처리내용 : Excel 다운로드시 제목 CSS를 지정한다.
	 * </pre>
	 * 
	 * @Method Name : setHeaderCS
	 * @date : 2022. 7. 19
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 19 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	private void setHeaderCS(CellStyle cs, Font font, Cell cell) {

		XSSFCellStyle headerCSS = (XSSFCellStyle) cs;

		byte[] headerRGB = { (byte) 217, (byte) 225, (byte) 242 };

		headerCSS.setAlignment(HorizontalAlignment.CENTER);
		headerCSS.setVerticalAlignment(VerticalAlignment.CENTER);
		headerCSS.setBorderTop(BorderStyle.THIN);
		headerCSS.setBorderBottom(BorderStyle.THIN);
		headerCSS.setBorderLeft(BorderStyle.THIN);
		headerCSS.setBorderRight(BorderStyle.THIN);
		headerCSS.setFillForegroundColor(new XSSFColor(headerRGB));
		headerCSS.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		setHeaderFont(font, cell);
		headerCSS.setFont(font);
		cell.setCellStyle(headerCSS);
	}

//	/**
//     * <pre>
//     * 1. 개요 : Excel 다운로드시 ROW전체 CSS를 지정한다.
// 	 * 2. 처리내용 : Excel 다운로드시  ROW전체 CSS를 지정한다.
//     * </pre>
//     * @Method Name : setHeaderCS
//     * @date : 2022. 9. 27
//     * @author : gwjeon
//     * @history : 
//     *	-----------------------------------------------------------------------
//     *	변경일				작성자						변경내용 
//     *	----------- ------------------- ---------------------------------------
//     *	2022.  9. 27		    gwjeon				     	최초 작성 .
//     *	2023. 01. 31			gwjeon						미사용
//     *	-----------------------------------------------------------------------
//     */
//	private void setHeaderRowCS(CellStyle cs, Font font, Row row) {
//	  
//	XSSFCellStyle headerCSS = (XSSFCellStyle)cs;
//		
//	  byte[] headerRGB = {(byte)217,(byte)225,(byte)242};
//	
//	  
////	  headerCSS.setAlignment(CellStyle.ALIGN_CENTER);
////	  headerCSS.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
//	  headerCSS.setBorderTop(CellStyle.BORDER_THIN);
//	  headerCSS.setBorderBottom(CellStyle.BORDER_THIN);
//	  headerCSS.setBorderLeft(CellStyle.BORDER_THIN);
//	  headerCSS.setBorderRight(CellStyle.BORDER_THIN);
////	  cs.setFillForegroundColor(HSSFColor.GREY_80_PERCENT.index);
////	  headerCSS.setFillForegroundColor(new XSSFColor(headerRGB));
////	  headerCSS.setFillPattern(CellStyle.SOLID_FOREGROUND);
////	  setHeaderFont(font, cell);
////	  headerCSS.setFont(font);
//	  row.setRowStyle(headerCSS);
//	}

	/**
	 * <pre>
	 * 1. 개요 : Excel 다운로드시 제목 Font를 지정한다.
	 * 2. 처리내용 : Excel 다운로드시 제목 Font를 지정한다.
	 * </pre>
	 * 
	 * @Method Name : setHeaderFont
	 * @date : 2022. 7. 19
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 19 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	private void setHeaderFont(Font font, Cell cell) {
		font.setFontHeight((short) 400);
		font.setColor(IndexedColors.BLACK.getIndex());
	}

	/**
	 * <pre>
	 * 1. 개요 : Excel 다운로드시 기본 CSS를 지정한다.
	 * 2. 처리내용 : Excel 다운로드시 기본 CSS를 지정한다.
	 * </pre>
	 * 
	 * @Method Name : setHeaderFont
	 * @date : 2022. 7. 19
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 19 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	private void setCmmnCS2(CellStyle cs, Cell cell) {
		cs.setAlignment(HorizontalAlignment.CENTER);
		cs.setVerticalAlignment(VerticalAlignment.CENTER);
		cs.setBorderTop(BorderStyle.THIN);
		cs.setBorderBottom(BorderStyle.THIN);
		cs.setBorderLeft(BorderStyle.THIN);
		cs.setBorderRight(BorderStyle.THIN);
		cell.setCellStyle(cs);
	}

	
	/**
	 * <pre>
	 * 1. 개요 : Excel 다운로드시 기본 CSS (좌측정렬)를 지정한다.
	 * 2. 처리내용 : Excel 다운로드시 기본 CSS (좌측정렬)를 지정한다.
	 * </pre>
	 * 
	 * @Method Name : setHeaderFont
	 * @date : 2022. 7. 19
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 19 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	private void setCmmnLeftCS2(CellStyle cs, Cell cell) {
		cs.setAlignment(HorizontalAlignment.LEFT);
		cs.setVerticalAlignment(VerticalAlignment.CENTER);
		cs.setBorderTop(BorderStyle.THIN);
		cs.setBorderBottom(BorderStyle.THIN);
		cs.setBorderLeft(BorderStyle.THIN);
		cs.setBorderRight(BorderStyle.THIN);
		cell.setCellStyle(cs);
	}

	/**
	 * <pre>
	 * 1. 개요 : Excel 다운로드시 숫자 CSS를 지정한다.
	 * 2. 처리내용 : Excel 다운로드시 숫자 CSS를 지정한다.
	 * </pre>
	 * 
	 * @Method Name : setHeaderFont
	 * @date : 2022. 7. 19
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 19 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	private void setCmmnNumCS2(CellStyle cs, Cell cell) {
		cs.setAlignment(HorizontalAlignment.RIGHT);

		cs.setDataFormat((short) 3);
//	  cs.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,###"));

		cs.setVerticalAlignment(VerticalAlignment.CENTER);
		cs.setBorderTop(BorderStyle.THIN);
		cs.setBorderBottom(BorderStyle.THIN);
		cs.setBorderLeft(BorderStyle.THIN);
		cs.setBorderRight(BorderStyle.THIN);
		cell.setCellStyle(cs);
	}

	/**
	 * <pre>
	 * 1. 개요 : Excel 다운로드시 숫자 CSS를 지정한다.
	 * 2. 처리내용 : Excel 다운로드시 숫자 CSS를 지정한다.
	 * </pre>
	 * 
	 * @Method Name : setHeaderFont
	 * @date : 2022. 7. 19
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 19 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	private void setCmmnNumCS2(CellStyle cs, Cell cell, byte[] paramRgb) {

		XSSFCellStyle numberCss = (XSSFCellStyle) cs;

		numberCss.setAlignment(HorizontalAlignment.RIGHT);
		numberCss.setDataFormat((short) 3);
		numberCss.setFillBackgroundColor(new XSSFColor(paramRgb));
		numberCss.setFillForegroundColor(new XSSFColor(paramRgb));
		numberCss.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		numberCss.setVerticalAlignment(VerticalAlignment.CENTER);
		numberCss.setBorderTop(BorderStyle.THIN);
		numberCss.setBorderBottom(BorderStyle.THIN);
		numberCss.setBorderLeft(BorderStyle.THIN);
		numberCss.setBorderRight(BorderStyle.THIN);
		cell.setCellStyle(numberCss);
	}

	/**
	 * <pre>
	 * 1. 개요 : xlsx형태로 다운로드 한다.
	 * 2. 처리내용 : xlsx형태로 다운로드 한다.
	 * </pre>
	 * 
	 * @Method Name : getxlsxDownload
	 * @date : 2022. 7. 19
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 19 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	public void getxlsxDownload(String title, List<EgovMap> excelldata, HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		/**
		 * 하드코딩 혹은 Properties를 이용하여 제목을 지정합니다. 가져오는 데이터 컬럼에 맞는 properties 지정합니다.
		 */
		Properties prop = new Properties();
		Reader reader = Resources.getResourceAsReader("egovframework/egovProps/exceldic.properties");
		try {
			prop.load(reader);
			reader.close();
		} catch (FileNotFoundException e2) {
//			e2.printStackTrace();
			reader.close();
		}

		// header를 담을 list 배열
		List<Object> headerList = new ArrayList<>();

		if (excelldata != null) {

			for (int i = 0; i < excelldata.size(); i++) {
				EgovMap map = (EgovMap) excelldata.get(i);

//				System.out.println("map >>" + map);

				// 값 치환
				Iterator<?> entries = map.keySet().iterator();

				if (i == 0) {
					while (entries.hasNext()) {
						headerList.add(entries.next());
//						break;
					}
					break;
				}
			}

			int valsize = excelldata.size();
			int headersize = headerList.size();

			SXSSFWorkbook wb = new SXSSFWorkbook();
			Sheet sheet = wb.createSheet();

			for (int i = 0; i < headersize; i++) {

				sheet.setColumnWidth((short) i, (short) 5000);

			}

			Row row = sheet.createRow(0);
			Cell cell = null;
			CellStyle cs = wb.createCellStyle();
			Font font = wb.createFont();
			cell = row.createCell(0);
			cell.setCellValue(title);
			setHeaderCS(cs, font, cell);
			sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, headersize - 1));

			row = sheet.createRow(1);
			cell = null;
			cs = wb.createCellStyle();
			cs.setWrapText(true);
			font = wb.createFont();

			// 헤더 치환입력
			for (int i = 0; i < headersize; i++) {

				// 헤더데이터 temp
				String headertemp = prop.getProperty(StringUtil.nullConvert(headerList.get(i)));

				sheet.setColumnWidth((short) i, (short) 5000);
				cell = row.createCell(i);

				if (headertemp == null) {
					headertemp = StringUtil.nullConvert(headerList.get(i));
				}
				cell.setCellValue(headertemp);
				setHeaderCS(cs, font, cell);

			}

			// 빈칸
			row = sheet.createRow(2);

			int rowIndex = 2;
			System.out.println(headersize);

			for (int i = 0; i < valsize; i++) {

				List<Object> dataList = new ArrayList<>();
				EgovMap map = (EgovMap) excelldata.get(i);

				
				
				// 값 치환
				Iterator<?> entries = map.values().iterator();
				
				while (entries.hasNext()) {

					dataList.add(entries.next());

				}
				

//				while (entries.hasNext()) {
//					  Map.Entry e = (Map.Entry) entries.next();
//					  map.put((String)e.getKey(),  e.getValue()==null?"":(String)e.getValue());
//					  dataList.add(e);
//				}

				row = sheet.createRow(rowIndex);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				for (int j = 0; j < dataList.size(); j++) {

					cell = row.createCell(j);
					String tmpValue = "";
					Double tmpDoubleValue = 0d;
					boolean numFlag = false;
					cs = wb.createCellStyle();
					if(dataList.getClass().getName().equals("java.lang.Integer")) {
						numFlag = true;
						tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());
					}else {
						numFlag = false;
						tmpValue = StringUtil.nullConvert(dataList.get(j));
					}

					if (numFlag) {
						setCmmnNumCS2(cs, cell);
						cell.setCellValue(tmpDoubleValue);
					} else {
						setCmmnCS2(cs, cell);
						cell.setCellValue(tmpValue);
					}
				}
				rowIndex++;
			}

			// 한글깨짐
			String outputFileName = new String(title.getBytes("KSC5601"), "8859_1");

			response.setContentType("application/vnd.ms-excel; charset=euc-kr");
			response.setHeader("Set-Cookie", "fileDownload=true; path=/");
			response.setHeader("Content-Disposition",
					String.format("attachment; filename=\"" + outputFileName + ".xlsx\""));

			ServletOutputStream sos = response.getOutputStream();
			wb.write(sos);
			sos.close();
		}
	}

	/**
	 * <pre>
	 * 1. 개요 : Excel의 값을 List형태로 가져온다. 
	 * 2. 처리내용 : Excel의 값을 List형태로 가져온다.
	 * </pre>
	 * 
	 * @Method Name : getExcelData
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */


	public List<Object> getExcelData(final Map<String, MultipartFile> files, int sheetNum, int headrow, int firstRow, String keys) throws Exception {
		List<Object> result = new ArrayList<Object>(); 
		if (files != null) {
			Iterator<java.util.Map.Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file = null; 
			InputStream fis = null;
			while (itr.hasNext()) {
				java.util.Map.Entry<String, MultipartFile> entry = itr.next(); 
				try { 
					file = entry.getValue(); 
					fis = file.getInputStream(); 
					String filename = file.getOriginalFilename().toLowerCase(); 
					if (filename.endsWith(".xls")) {
						HSSFWorkbook workbook = new HSSFWorkbook(fis);
						result = getSheetData(workbook.getSheetAt(sheetNum), headrow, firstRow, keys);
					} else if (filename.endsWith(".xlsx")) { 
						Workbook workbook = new XSSFWorkbook(fis);
						result = getSheetDataXlsx(workbook.getSheetAt(sheetNum), headrow, firstRow, keys);
					}	  
				} finally { 
					try { 
						if (fis != null) { 
						fis.close(); 
						} 
					} catch (IOException ee){ 
					ee.printStackTrace();
					fis.close();
					} 
				} 
			} 
		}
		return result;
	}

	/**
	 * <pre>
	 * 1. 개요 :  xls Sheet값을 가져온다
	 * 2. 처리내용 :  xls의 Sheet값을 가져온다
	 * </pre>
	 * 
	 * @Method Name : getSheetData
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	
	  private List<Object> getSheetData(HSSFSheet sheet, int headrow, int firstRow, String keys) throws Exception {
	  
	  List<Object> sheetData = new ArrayList<Object>();
	  List<String> header = new ArrayList<String>();
	  
	  String[] key = keys.split(",", -1);
	  
	  for (int i = 0; i < key.length; i++) { 
		  header.add(key[i]); 
	  }
	  
	  for (int i = firstRow; i <= sheet.getLastRowNum(); i++) {
		  HSSFRow row = sheet.getRow(i); 
		  if (isRowEmpty(row)) { 
			  continue; 
		  }
		  
		  Map<String, Object> rowdata = new HashMap<String, Object>(); 
		  for (int ii = 0; ii <= row.getLastCellNum(); ii++) { 
			  HSSFCell cell = row.getCell(ii, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL); 
			  if (cell == null) continue;
			  rowdata.put((String) header.get(ii), getCellValue(cell)); 
		  }
		  sheetData.add(rowdata); 
	  }
	  
	  return sheetData; 
	  }
	 

	/**
	 * <pre>
	 * 1. 개요 :  xls의 Cell값을 가져온다
	 * 2. 처리내용 :  xls의 Cell값을 가져온다
	 * </pre>
	 * 
	 * @Method Name : getCellValue
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	
	private Object getCellValue(HSSFCell cell) throws Exception {
		CellType celltype = cell.getCellType();
		Object value = null;
		switch (celltype) {
		case FORMULA:
			value = cell.getCellFormula();
			break;
		case NUMERIC:
			if (DateUtil.isCellDateFormatted(cell)) { // 날짜 형식 
				SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
				value = "" + dateformat.format(cell.getDateCellValue());
			} else {
				value = "" + String.format("%.0f", new Double(cell.getNumericCellValue()));
			}
			break;
		case STRING:
			value = "" + cell.getStringCellValue();
			break;
		case BLANK: // value= "" + cell.getBooleanCellValue();
			value = "";
			break;
		case ERROR:
			value = "" + cell.getErrorCellValue();
			break;
		default:
			value = "";
			break;
		}
		return value;
	}
	 

	/**
	 * <pre>
	 * 1. 개요 :  xlsx의 Sheet값을 가져온다
	 * 2. 처리내용 :  xlsx의 Sheet값을 가져온다
	 * </pre>
	 * 
	 * @Method Name : getSheetDataXlsx
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	
	  private List<Object> getSheetDataXlsx(Sheet sheet, int headrow, int firstRow,
	  String keys) throws Exception { 
		  // firstRow = 3; 
	  List<Object> sheetData = new ArrayList<Object>(); 
	  List<String> header = new ArrayList<String>();
	  
	  String key[] = keys.split(",",-1);
	  
	  
	  for(int i = 0; i < key.length; i++) { header.add(key[i]); }
	  
	  for (int i = firstRow; i <= sheet.getLastRowNum(); i++) {
	  
	  Row row = sheet.getRow(i); 
	  if (isRowEmpty(row)) { continue; }
	  
	  Map<String, Object> rowdata = new HashMap<String, Object>(); 
	  for (int ii = 0; ii < row.getLastCellNum(); ii++) {
		  Cell cell = row.getCell(ii, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL); 
		  if (cell == null) continue; 
		  rowdata.put((String) header.get(ii), getCellValueXlsx(cell)); 
		  } 
	  sheetData.add(rowdata); 
	  }
	  
	  return sheetData; }
	 

	/**
	 * <pre>
	 * 1. 개요 :  xlsx의 CELL값을 가져온다
	 * 2. 처리내용 :  xlsx의 CELL값을 가져온다
	 * </pre>
	 * 
	 * @Method Name : getCellValueXlsx
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          2022. 9. 24 gwjeon 소수형 데이터 및 절사
	 *          -----------------------------------------------------------------------
	 */
	
	@SuppressWarnings("deprecation")
	private Object getCellValueXlsx(Cell cell) throws Exception {
		CellType celltype = cell.getCellType();
		Object value = null;

		switch (celltype) {
		case FORMULA:
			value = cell.getCellFormula();
			break;
		case NUMERIC:
			if (DateUtil.isCellDateFormatted(cell)) { // 날짜 형식 // 딴건 되는데 하이폰은 빼기로 인식해서 숫자 가져간다....
				SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
				value = "" + dateformat.format(cell.getDateCellValue());
			} else {

				// System.out.println("cell.getNumericCellValue())" +
				// cell.getNumericCellValue());
				// System.out.println("cell.getNumericCellValue())" + new
				// BigDecimal(cell.getNumericCellValue()).setScale(10,
				// RoundingMode.HALF_DOWN).toEngineeringString());

				// 소수점 10자리까지 표기되도록
				DecimalFormat df = new DecimalFormat("0.##########");

				// 10자리 이후 버림
				value = "" + df.format(
						new BigDecimal(new Double(cell.getNumericCellValue())).setScale(10, RoundingMode.HALF_DOWN));

				// System.out.println("value >>>>>>>>>>" + value);

			}
			break;
		case STRING:
			value = "" + cell.getStringCellValue();
			break;
		case BLANK: // value= "" + cell.getBooleanCellValue();
			value = "";
			break;
		case ERROR:
			value = "" + cell.getErrorCellValue();
			break;
		default:
			value = "";
			break;
		}
		return value;
	}
	 

	/**
	 * <pre>
	 * 1. 개요 :  xls, xlsx의 값이 빈 값인지 확인한다.
	 * 2. 처리내용 : xls, xlsx의 값이 빈 값인지 확인한다.
	 * </pre>
	 * 
	 * @Method Name : isRowEmpty
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	private static boolean isRowEmpty(Row row) {
		boolean isEmpty = true;
		DataFormatter dataFormatter = new DataFormatter();

		if (row != null) {
			for (Cell cell : row) {
				if (dataFormatter.formatCellValue(cell).trim().length() > 0) {
					isEmpty = false;
					break;
				}
			}
		}

		return isEmpty;
	}

	/**
	 * <pre>
	 * 1. 개요 :  VO를 Map형태로 리턴한다
	 * 2. 처리내용 : VO를 Map형태로 리턴한다
	 * </pre>
	 * 
	 * @Method Name : convertToMap
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */

	public static Map<String, Object> convertToMap(Object obj) {
		try {
			if (Objects.isNull(obj)) {
				return Collections.emptyMap();
			}
			Map<String, Object> convertMap = new HashMap<>();

			Field[] fields = obj.getClass().getDeclaredFields();

			for (Field field : fields) {
				field.setAccessible(true);
				convertMap.put(field.getName(), field.get(obj));
			}
			return convertMap;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * <pre>
	 * 1. 개요 :  Map을 VO형태로 리턴한다
	 * 2. 처리내용 : Map을 VO형태로 리턴한다
	 * </pre>
	 * 
	 * @Method Name : convertToValueObject
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	public static <T> T convertToValueObject(Map<String, Object> map, Class<T> type) {
		try {
			Objects.requireNonNull(type, "Class cannot be null");
			T instance = type.getConstructor().newInstance();

			if (map == null || map.isEmpty()) {
				return instance;
			}

			for (Map.Entry<String, Object> entry : map.entrySet()) {
				Field[] fields = type.getDeclaredFields();

				for (Field field : fields) {
					field.setAccessible(true);
					String name = field.getName();

					boolean isSameType = entry.getValue().getClass().equals(getReferenceType(field.getType()));
					boolean isSameName = entry.getKey().equals(name);

					if (isSameType && isSameName) {
						field.set(instance, map.get(name));
						break;
					}
				}
			}
			return instance;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * <pre>
	 * 1. 개요 :  VO List배열을 Map List배열로 리턴한다
	 * 2. 처리내용 : VO List배열을 Map List배열로 리턴한다
	 * </pre>
	 * 
	 * @Method Name : convertToMaps
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	public static List<Map<String, Object>> convertToMaps(List<?> list) {
		if (list == null || list.isEmpty()) {
			return Collections.emptyList();
		}
		List<Map<String, Object>> convertList = new ArrayList<>(list.size());

		for (Object obj : list) {
			convertList.add(convertToMap(obj));
		}
		return convertList;
	}

	/**
	 * <pre>
	 * 1. 개요 :  Map List배열을 VO List배열로 리턴한다
	 * 2. 처리내용 : Map List배열을 VO List배열로 리턴한다
	 * </pre>
	 * 
	 * @Method Name : convertToValueObjects
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	public static <T> List<T> convertToValueObjects(List<Map<String, Object>> list, Class<T> type) {
		Objects.requireNonNull(type, "Class cannot be null");

		if (list == null || list.isEmpty()) {
			return Collections.emptyList();
		}
		List<T> convertList = new ArrayList<>(list.size());

		for (Map<String, Object> map : list) {
			convertList.add(convertToValueObject(map, type));
		}
		return convertList;
	}

	/**
	 * <pre>
	 * 1. 개요 :  오토박싱이 가능한지 확인한다.
	 * 2. 처리내용 : 오토박싱이 가능한지 확인한다.
	 * </pre>
	 * 
	 * @Method Name : convertToMaps
	 * @date : 2022. 7. 28
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 7. 28 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	private static Class<?> getReferenceType(Class<?> type) {
		switch (type.getName()) {
		case "boolean":
			return Boolean.class;
		case "byte":
			return Byte.class;
		case "short":
			return Short.class;
		case "char":
			return Character.class;
		case "int":
			return Integer.class;
		case "long":
			return Long.class;
		case "float":
			return Float.class;
		case "double":
			return Double.class;
		default:
			return type;
		}
	}

	/**
	 * <pre>
	 * 1. 개요 :  현재날짜.
	 * 2. 처리내용 :현재날짜.
	 * </pre>
	 * 
	 * @Method Name : getTimeStamp
	 * @date : 2022. 09. 12
	 * @author : gwjeon
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022. 09. 12 gwjeon 최초 작성
	 *          -----------------------------------------------------------------------
	 */

	public String getTimeStamp() {

		String rtnStr = null;

		// 문자열로 변환하기 위한 패턴 설정(년도-월-일)
		String pattern = "yyyyMMdd";

		SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		rtnStr = sdfCurrent.format(ts.getTime());

		return rtnStr;
	}
	/**

	 * 엑셀 파일 읽기

	 * @param file

	 * @param sheetNum

	 * @param strartRowNum

	 * @param startCelNum

	 * @return List<HashMap<Integer, String>>

	 * @throws Exception

	 */

	@SuppressWarnings({ "resource", "deprecation" })
	public List<HashMap<Integer, String>> excelReadSetValue(CommonsMultipartFile file, int sheetNum, int strartRowNum, int startCelNum) throws Exception {

		List<HashMap<Integer, String>> resultList = new ArrayList<>();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		

		//xls, xlsx 구분

		Workbook workbook = null;

		if(file.getOriginalFilename().toUpperCase().endsWith("XLSX")) {

			workbook = new XSSFWorkbook(file.getInputStream());

		}

		else {

			workbook = new HSSFWorkbook(file.getInputStream());

		}

		

		//Sheet 수 확인

		int sheetCnt = workbook.getNumberOfSheets();

		int listNum = 0;



		try {

			if (sheetCnt > 0) {

				//첫번째 Sheet 선택

				Sheet sheet = workbook.getSheetAt(sheetNum);

				

				//Sheet의 Row와 Cell 수 확인

				int rows = sheet.getPhysicalNumberOfRows();

				int cells = sheet.getRow(0).getPhysicalNumberOfCells();

				

				HashMap<Integer, String> valueMap = null;

	

				//Header Row 빼고 시작(0에서 시작)

				for(int r = strartRowNum ; r < rows; r++) {

					//String device_id = "";

					valueMap = new HashMap<Integer, String>();

	

					//한 줄씩 읽고 데이터 저장

					Row row = sheet.getRow(r);

					if (row != null) {

						//Cell 기본값 빼고 시작(0에서 시작)

						for(int c = startCelNum ; c <= cells ; c++) {

							Cell cell = row.getCell(c);

							

							if (cell != null) {

								String value = "";

								

								switch(cell.getCellType()) {

								case BLANK :

									value = "";

									break;

								case BOOLEAN :

									value = "" + cell.getBooleanCellValue();

									break;

								case ERROR :

									value = "" + cell.getErrorCellValue();

									break;

								case FORMULA :

									value = cell.getCellFormula();

									break;

								case NUMERIC :

									if(DateUtil.isInternalDateFormat(cell.getCellStyle().getDataFormat())) {

										value = sdf.format(cell.getDateCellValue());

									}

									else {

										cell.setCellType(CellType.STRING ); 

										value = cell.getStringCellValue(); 

									}

									break;

								case STRING :

									value = cell.getStringCellValue();

									break;
								default:
									break;

								}

								

								//공백과 트림 제거

								value = value.trim().replaceAll(" ", "");

								

								valueMap.put(c, value);

							}

						}//end col for

						resultList.add(listNum++, valueMap);

					}//end if

				}//end row for

			}

		} catch(Exception e) {

			e.getStackTrace();

		}

		return resultList;

	}
}