package egovframework.let.com.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Reader;
import java.lang.reflect.Field;
import java.sql.Timestamp;
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

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

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
	 * 1. 개요 : xlsx형태로 다운로드 한다. -출하배송
	 * 2. 처리내용 : xlsx형태로 다운로드 한다. -출하배송
	 * </pre>
	 * 
	 * @Method Name : getxlsxDownloadSd
	 * @date : 2022.11.25
	 * @author : khong2
	 * @history :
	 *          -----------------------------------------------------------------------
	 *          변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2022.11.25 khong2 최초 작성
	 *          -----------------------------------------------------------------------
	 */
	public void getxlsxDownloadSd(String type, String title, List excelldata, HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		SXSSFWorkbook wb = new SXSSFWorkbook();

		Sheet sheet = wb.createSheet();
		Row row = sheet.createRow(0);
		Cell cell = null;
		CellStyle cs = wb.createCellStyle();
		Font font = wb.createFont();

		Properties prop = new Properties();
		Reader reader = Resources.getResourceAsReader("egovframework/egovProps/conf/exceldic.properties");

		// header를 담을 list 배열
		List headerListSingle = new ArrayList();
		List headerListOver = new ArrayList();
		List headerListUnder = new ArrayList();
		List detail = new ArrayList();

		int detailsize;
		int headersize1;
		int headersize2;
		int headersize3;
		int rowIndex;
		int valsize = excelldata.size();
//		
//		DataFormat fmt = wb.createDataFormat();
//		cs.setDataFormat(fmt.getFormat("@"));
//		cell.setCellStyle(cs);

		try {
			prop.load(reader);
			reader.close();
		} catch (FileNotFoundException e2) {
//			e2.printStackTrace();
			reader.close();
		}

		// header 모양
		switch (type) {

		case "SDO00110":

			headerListSingle.add("주문상태");
			headerListSingle.add("주문번호");
			headerListSingle.add("주문일시");

			headerListOver.add("구매자");
			headerListUnder.add("(담당자)");
			headerListOver.add("판매자");
			headerListUnder.add("(담당자)");

			headerListSingle.add("요청일시");
			headerListSingle.add("요청물량");

			headersize1 = headerListSingle.size(); // 6
			headersize2 = headerListOver.size(); // 2
			headersize3 = headerListUnder.size(); // 2

			// 제목
			cell = row.createCell(0);
			cell.setCellValue(title);
			setHeaderCS(cs, font, cell);

			cell = row.createCell(headersize1 + headersize2);
			setHeaderCS(cs, font, cell);

			sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, headersize1 + headersize2));

			// 헤더-1
			row = sheet.createRow(1);
			cell = null;
			cs = wb.createCellStyle();
			font = wb.createFont();
			cell = row.createCell(0);
			cell.setCellValue("NO");
			sheet.setColumnWidth((0), 1500);
			setHeaderCS(cs, font, cell);

			for (int i = 1; i <= headersize1; i++) {
				if (i >= 4) {
					cell = row.createCell(i + 2);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
					sheet.setColumnWidth((i + 2), 6000);
					setHeaderCS(cs, font, cell);
				} else {
					cell = row.createCell(i);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
					sheet.setColumnWidth((i), 6000);
					setHeaderCS(cs, font, cell);
				}

			}

			for (int i = 1; i <= headersize2; i++) {
				// 헤더데이터 temp

				String headertemp = StringUtil.nullConvert(headerListOver.get(i - 1));
				cell = row.createCell(i + 3);
				cell.setCellValue(headertemp);
				sheet.setColumnWidth(i + 3, 6000);
				setHeaderCS(cs, font, cell);

			}

			// 헤더-2
			row = sheet.createRow(2);

			// merge시 css 이슈 해결
			for (int i = 0; i <= headersize1; i++) {
				if (i >= 4) {
					cell = row.createCell(i + 2);
					setHeaderCS(cs, font, cell);
					sheet.addMergedRegion(new CellRangeAddress(1, 2, i + 2, i + 2));
				} else {
					cell = row.createCell(i);
					setHeaderCS(cs, font, cell);
					sheet.addMergedRegion(new CellRangeAddress(1, 2, i, i));
				}

			}

			for (int i = 1; i <= headersize2; i++) {

				String headertemp = StringUtil.nullConvert(headerListUnder.get(i - 1));

				cell = row.createCell(i + 3);
				cell.setCellValue(headertemp);
				sheet.setColumnWidth(i + 3, 6000);
				setHeaderCS(cs, font, cell);

			}

			// 빈칸-내용
			row = sheet.createRow(3);

			rowIndex = 3;

			for (int i = 0; i < valsize; i++) {

				List dataList = new ArrayList();
				HashMap map = (HashMap) excelldata.get(i);

				// 값 치환
				Iterator entries = map.values().iterator();

				while (entries.hasNext()) {

					dataList.add(entries.next());

				}

				row = sheet.createRow(rowIndex);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				cell = row.createCell(0);
				cs = wb.createCellStyle();
				setCmmnCS2(cs, cell);
				cell.setCellValue(i + 1);

				for (int j = 0; j < dataList.size() - 3; j++) {

					cell = row.createCell(j + 1);
					String tmpValue = "";
					Double tmpDoubleValue = 0d;
					boolean numFlag = true;
					cs = wb.createCellStyle();
					if (j == 6) {
						if (dataList.get(j + 3).equals("02")) {
							numFlag = false;
							tmpValue = "회수요청";
						} else {
							try {
								tmpDoubleValue = Double.parseDouble(dataList.get(j + 2).toString());

							} catch (Exception e) {

								numFlag = false;
								tmpValue = StringUtil.nullConvert(dataList.get(j + 2));
							}
						}
					} else if (j == 5) {
						try {
							tmpDoubleValue = Double.parseDouble(dataList.get(j + 2).toString());

						} catch (Exception e) {

							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j + 2));
						}
					} else {
						try {
							tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());

						} catch (Exception e) {

							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j));
						}
					}

					if (numFlag) {
						setCmmnNumCS2(cs, cell);

						cell.setCellValue(tmpDoubleValue);
					} else {
						setCmmnCS2(cs, cell);

						cell.setCellValue(tmpValue);
					}
				}

				row = sheet.createRow(rowIndex + 1);
				cell = null;

				font = wb.createFont();
//					  System.out.println("데이터사이즈 :" + (dataList.size()-2));
				for (int j = 0; j < dataList.size() - 2; j++) {

					cs = wb.createCellStyle();
					cell = row.createCell(j);

					if (j <= 3 || j >= 6) {
						setCmmnNumCS2(cs, cell);
						sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex + 1, j, j));

					} else { // j가 6

						String tmpValue = "";
						Double tmpDoubleValue = 0d;
						boolean numFlag = true;

						try {
							tmpDoubleValue = Double.parseDouble(dataList.get(j + 1).toString());

						} catch (Exception e) {

							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j + 1));
//								  System.out.println("이 값은 : " + dataList.get(j+1) + " 이고 현재  numFlag 는 " + numFlag + " 입니다.");

						}

						if (numFlag) {
							setCmmnNumCS2(cs, cell);

							cell.setCellValue(tmpDoubleValue);
						} else {
							setCmmnCS2(cs, cell);

							cell.setCellValue(tmpValue);
//								  System.out.println("차별하지마");
						}
					}

				}

				rowIndex = rowIndex + 2;

			}

			break;

		case "SDT00110":

			headerListSingle.add("운송상태");
			headerListSingle.add("주문번호");

			headerListOver.add("구매자");
			headerListUnder.add("(담당자)");
			headerListOver.add("판매자");
			headerListUnder.add("(담당자)");

			headerListSingle.add("요청일시");
			headerListSingle.add("요청물량");

			detail.add("요청/수정/변경");
			detail.add("확정/배정");
			detail.add("진행");
			detail.add("완료");
			detail.add("취소/반려");

			headersize1 = headerListSingle.size() + 4; // 4
			headersize2 = headerListOver.size(); // 4
			headersize3 = headerListUnder.size(); // 4
			detailsize = detail.size();

			// 제목
			cell = row.createCell(0);
			cell.setCellValue(title);
			setHeaderCS(cs, font, cell);

			cell = row.createCell(headersize1 + headersize2);
			setHeaderCS(cs, font, cell);

			sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, headersize1 + headersize2));

			// 헤더-1
			row = sheet.createRow(1);
			cell = null;
			cs = wb.createCellStyle();
			font = wb.createFont();
			cell = row.createCell(0);
			cell.setCellValue("NO");
			sheet.setColumnWidth((0), 1500);
			setHeaderCS(cs, font, cell);
			// 헤더사이즈1 은 8 헤더리스트싱글은 4 다 총
			for (int i = 1; i <= headersize1; i++) {

				if (i >= 7 && i < 9) {
					cell = row.createCell(i + 2);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 5)));
					sheet.setColumnWidth((i + 2), 6000);
					setHeaderCS(cs, font, cell);
				} else if (i >= 2 && i <= 5) {
					cell = row.createCell(i);
					sheet.setColumnWidth((i), 3500);
					setHeaderCS(cs, font, cell);
				} else if (i == 1) {
					cell = row.createCell(i);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
					sheet.setColumnWidth((i), 1000);
					setHeaderCS(cs, font, cell);
				} else {
					cell = row.createCell(i);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 5)));
					sheet.setColumnWidth((i), 5000);
					setHeaderCS(cs, font, cell);
				}

			}

			for (int i = 1; i <= headersize2; i++) {
				// 헤더데이터 temp

				String headertemp = StringUtil.nullConvert(headerListOver.get(i - 1));
				cell = row.createCell(6 + i);
				cell.setCellValue(headertemp);
				sheet.setColumnWidth(6 + i, 6000);
				setHeaderCS(cs, font, cell);

			}

			// 헤더-2
			row = sheet.createRow(2);

			// merge시 css 이슈 해결
			for (int i = 0; i <= headersize1; i++) {
				if (i >= 7) {
					cell = row.createCell(i + 2);
					setHeaderCS(cs, font, cell);
					sheet.addMergedRegion(new CellRangeAddress(1, 2, i + 2, i + 2));
				} else if (i >= 1 && i <= 5) {
					cell = row.createCell(i);
					setHeaderCS(cs, font, cell);
					sheet.addMergedRegion(new CellRangeAddress(1, 1, i, i + 4));
					i += 4;
				} else {
					cell = row.createCell(i);
					setHeaderCS(cs, font, cell);
					sheet.addMergedRegion(new CellRangeAddress(1, 2, i, i));

				}
			}

			for (int i = 1; i <= detailsize; i++) {

				String headertemp = StringUtil.nullConvert(detail.get(i - 1));

				cell = row.createCell(i);
				cell.setCellValue(headertemp);
				sheet.setColumnWidth(i, 3500);
				setHeaderCS(cs, font, cell);

			}

			for (int i = 1; i <= headersize2; i++) {

				String headertemp = StringUtil.nullConvert(headerListUnder.get(i - 1));

				cell = row.createCell(6 + i);
				cell.setCellValue(headertemp);
				sheet.setColumnWidth(6 + i, 6000);
				setHeaderCS(cs, font, cell);

			}

//				   빈칸-내용
			row = sheet.createRow(3);

			rowIndex = 3;

			for (int i = 0; i < valsize; i++) {

				List dataList = new ArrayList();
				HashMap map = (HashMap) excelldata.get(i);

				// 값 치환
				Iterator entries = map.values().iterator();

				while (entries.hasNext()) {

					dataList.add(entries.next());

				}

				row = sheet.createRow(rowIndex);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				cell = row.createCell(0);
				cs = wb.createCellStyle();
				setCmmnCS2(cs, cell);
				cell.setCellValue(i + 1);

				for (int j = 0; j < dataList.size() - 3; j++) {

					cell = row.createCell(j + 1);
					String tmpValue = "";
					Double tmpDoubleValue = 0d;
					boolean numFlag = true;
					cs = wb.createCellStyle();

					if (j >= 8) {

						if (dataList.get(j + 3).equals("02")) {
							numFlag = false;
							tmpValue = "회수요청";
						} else {
							try {
								tmpDoubleValue = Double.parseDouble(dataList.get(j + 2).toString());
							} catch (Exception e) {

								numFlag = false;
								tmpValue = StringUtil.nullConvert(dataList.get(j + 2));
							}
						}
					} else {
						if (j >= 0 && j <= 4) {
							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j));
							if (dataList.get(j) == null || dataList.get(j) == "") {
								tmpValue = "요청대기";
							}
						} else {
							try {
								tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());

							} catch (Exception e) {

								numFlag = false;
								tmpValue = StringUtil.nullConvert(dataList.get(j));
							}
						}
					}

					if (numFlag) {

						cell.setCellValue(tmpDoubleValue);
					} else {

						setCmmnCS2(cs, cell);

						cell.setCellValue(tmpValue);
					}

				}

				row = sheet.createRow(rowIndex + 1);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				for (int j = 0; j < dataList.size() - 2; j++) {

					if (j == 0) {
						cell = row.createCell(j);
						setCmmnCS2(cs, cell);
						sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex + 1, j, j));
					} else if (j <= 6 || j == 9 || j == 10) {
						if (dataList.get(j - 1) == null || dataList.get(j - 1) == "") {
							sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex + 1, j, j + 4));
							j += 4;
						} else {
							cell = row.createCell(j);
							setCmmnCS2(cs, cell);
							sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex + 1, j, j));
						}
					} else { // j가 7 ~ 8

						cell = row.createCell(j);
						String tmpValue = "";
						Double tmpDoubleValue = 0d;
						boolean numFlag = true;
						cs = wb.createCellStyle();

						try {
							tmpDoubleValue = Double.parseDouble(dataList.get(j + 1).toString());

						} catch (Exception e) {

							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j + 1));
						}

						if (numFlag) {
							setCmmnNumCS2(cs, cell);
							cell.setCellValue(tmpDoubleValue);
						} else {
							setCmmnCS2(cs, cell);
							cell.setCellValue(tmpValue);
						}
					}

				}

				rowIndex = rowIndex + 2;
			}

			break;

		case "SDT00210":

			headerListSingle.add("운송상태");
			headerListSingle.add("운송번호");
			headerListSingle.add("요청일시");

			headerListOver.add("출발지");
			headerListOver.add("출발일시");
			headerListUnder.add("도착지");
			headerListUnder.add("도착일시");

			headerListSingle.add("요청물량");

			headersize1 = headerListSingle.size(); // 6
			headersize2 = headerListOver.size(); // 2
			headersize3 = headerListUnder.size(); // 2

			// 제목
			cell = row.createCell(0);
			cell.setCellValue(title);
			setHeaderCS(cs, font, cell);

			cell = row.createCell(headersize1 + headersize2);
			setHeaderCS(cs, font, cell);

			sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, headersize1 + headersize2));

			// 헤더-1
			row = sheet.createRow(1);
			cell = null;
			cs = wb.createCellStyle();
			font = wb.createFont();
			cell = row.createCell(0);
			cell.setCellValue("NO");
			sheet.setColumnWidth((0), 1500);
			setHeaderCS(cs, font, cell);

			for (int i = 1; i <= headersize1; i++) {
				if (i == 4) {
					cell = row.createCell(i + 2);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
					sheet.setColumnWidth((i + 2), 5000);
					setHeaderCS(cs, font, cell);
				} else {
					cell = row.createCell(i);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
					sheet.setColumnWidth((i), 5000);
					setHeaderCS(cs, font, cell);
				}

			}
			// ㅈㅅㅈㅅ
			cell = row.createCell(4);
			cell.setCellValue(StringUtil.nullConvert(headerListOver.get(0)));
			sheet.setColumnWidth((4), 14000);
			setHeaderCS(cs, font, cell);

			cell = row.createCell(5);
			cell.setCellValue(StringUtil.nullConvert(headerListOver.get(1)));
			sheet.setColumnWidth((5), 6000);
			setHeaderCS(cs, font, cell);

//				  for(int i=1 ; i <= headersize2; i++) {
//						 
//					  cell = row.createCell(i+3);
//					  cell.setCellValue(StringUtil.nullConvert(headerListOver.get(i-1)));
//					  sheet.setColumnWidth((i+3), 10000);
//					  setHeaderCS(cs, font, cell);	
//					  
//					  }

			// 헤더-2
			row = sheet.createRow(2);

			// merge시 css 이슈 해결
			for (int i = 0; i <= headersize1; i++) {
				if (i == 4) {
					cell = row.createCell(i + 2);
					setHeaderCS(cs, font, cell);
					sheet.addMergedRegion(new CellRangeAddress(1, 2, i + 2, i + 2));
				} else {
					cell = row.createCell(i);
					setHeaderCS(cs, font, cell);
					sheet.addMergedRegion(new CellRangeAddress(1, 2, i, i));
				}

			}

			// ㅈㅅㅈㅅ
			String headertemp = StringUtil.nullConvert(headerListUnder.get(0));

			cell = row.createCell(4);
			cell.setCellValue(headertemp);
			sheet.setColumnWidth(4, 14000);
			setHeaderCS(cs, font, cell);

			headertemp = StringUtil.nullConvert(headerListUnder.get(1));

			cell = row.createCell(5);
			cell.setCellValue(headertemp);
			sheet.setColumnWidth(5, 6000);
			setHeaderCS(cs, font, cell);
//				  
//				  for(int i = 1; i <= headersize2; i++ ) {
//					  
//					  String headertemp = StringUtil.nullConvert(headerListUnder.get(i-1));
//					  
//					  cell = row.createCell(i+3);
//					  cell.setCellValue(headertemp);
//					  sheet.setColumnWidth(i+3, 6000);
//					  setHeaderCS(cs, font, cell);
//
//				  }

//				   빈칸-내용
			row = sheet.createRow(3);

			rowIndex = 3;

			for (int i = 0; i < valsize; i++) {

				List dataList = new ArrayList();
				HashMap map = (HashMap) excelldata.get(i);

				// 값 치환
				Iterator entries = map.values().iterator();

				while (entries.hasNext()) {

					dataList.add(entries.next());

				}

				row = sheet.createRow(rowIndex);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				cell = row.createCell(0);
				cs = wb.createCellStyle();
				setCmmnCS2(cs, cell);
				cell.setCellValue(i + 1);

				for (int j = 0; j < 6; j++) {

					cell = row.createCell(j + 1);
					String tmpValue = "";
					Double tmpDoubleValue = 0d;
					boolean numFlag = true;
					cs = wb.createCellStyle();

					try {

						tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());

					} catch (Exception e) {

						numFlag = false;
						tmpValue = StringUtil.nullConvert(dataList.get(j));
					}

					if (j == 5) {
						if (dataList.get(j + 3).equals("02")) {
							numFlag = false;
							tmpValue = "회수요청";
						}
					}

					if (numFlag) {
						setCmmnNumCS2(cs, cell);

						cell.setCellValue(tmpDoubleValue);
					} else {
						setCmmnCS2(cs, cell);

						cell.setCellValue(tmpValue);
					}
				}

				row = sheet.createRow(rowIndex + 1);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				for (int j = 0; j < 7; j++) {
					cell = row.createCell(j);
					cs = wb.createCellStyle();

					if (j <= 3 || j == 6) {
						cell = row.createCell(j);
						setCmmnNumCS2(cs, cell);
						sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex + 1, j, j));
					} else { // j가 6

						String tmpValue = "";
						Double tmpDoubleValue = 0d;
						boolean numFlag = true;

						try {
							tmpDoubleValue = Double.parseDouble(dataList.get(j + 2).toString());

						} catch (Exception e) {

							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j + 2));
						}
						if (numFlag) {
							setCmmnNumCS2(cs, cell);

							cell.setCellValue(tmpDoubleValue);
						} else {
							setCmmnCS2(cs, cell);

							cell.setCellValue(tmpValue);
						}
					}

				}

				rowIndex = rowIndex + 2;

			}

			break;

		case "SDT00310":

			headerListSingle.add("운송상태");
			headerListSingle.add("운송주문번호");
			headerListSingle.add("출발지");
			headerListSingle.add("도착지");
			headerListSingle.add("운송출발일시");
			headerListSingle.add("운송도착일시");
			headerListSingle.add("운송내용");

			headersize1 = headerListSingle.size(); // 6

			// 제목
			cell = row.createCell(0);
			cell.setCellValue(title);
			setHeaderCS(cs, font, cell);

			cell = row.createCell(headersize1);
			setHeaderCS(cs, font, cell);

			sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, headersize1));

			// 헤더-1
			row = sheet.createRow(1);
			cell = null;
			cs = wb.createCellStyle();
			font = wb.createFont();
			cell = row.createCell(0);
			cell.setCellValue("NO");
			sheet.setColumnWidth((0), 1500);
			setHeaderCS(cs, font, cell);

			for (int i = 1; i <= headersize1; i++) {
				if (i == 1) {
					cell = row.createCell(i);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
					sheet.setColumnWidth((i), 3000);
					setHeaderCS(cs, font, cell);
				} else if (i == 3 || i == 4) {
					cell = row.createCell(i);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
					sheet.setColumnWidth((i), 14000);
					setHeaderCS(cs, font, cell);
				} else {
					cell = row.createCell(i);
					cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
					sheet.setColumnWidth((i), 5000);
					setHeaderCS(cs, font, cell);
				}

			}

			// 빈칸-내용
			row = sheet.createRow(2);

			rowIndex = 2;

			for (int i = 0; i < valsize; i++) {

				List dataList = new ArrayList();
				HashMap map = (HashMap) excelldata.get(i);

				// 값 치환
				Iterator entries = map.values().iterator();

				while (entries.hasNext()) {

					dataList.add(entries.next());

				}

				row = sheet.createRow(rowIndex);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				cell = row.createCell(0);
				cs = wb.createCellStyle();
				setCmmnCS2(cs, cell);
				cell.setCellValue(i + 1);

				for (int j = 0; j < 7; j++) {

					cell = row.createCell(j + 1);
					String tmpValue = "";
					Double tmpDoubleValue = 0d;
					boolean numFlag = true;
					cs = wb.createCellStyle();

					if (j == 2) {
						if (dataList.get(7).toString() == "02") {
							try {
								tmpDoubleValue = Double.parseDouble(dataList.get(j + 1).toString());

							} catch (Exception e) {

								numFlag = false;
								tmpValue = StringUtil.nullConvert(dataList.get(j + 1));
							}
						} else {
							try {
								tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());

							} catch (Exception e) {

								numFlag = false;
								tmpValue = StringUtil.nullConvert(dataList.get(j));
							}
						}
					} else if (j == 3) {
						if (dataList.get(7).toString() == "02") {
							try {
								tmpDoubleValue = Double.parseDouble(dataList.get(j - 1).toString());

							} catch (Exception e) {

								numFlag = false;
								tmpValue = StringUtil.nullConvert(dataList.get(j - 1));
							}
						} else {
							try {
								tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());

							} catch (Exception e) {

								numFlag = false;
								tmpValue = StringUtil.nullConvert(dataList.get(j));
							}
						}
					} else {
						try {
							tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());

						} catch (Exception e) {

							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j));
						}
					}

					if (numFlag) {
						setCmmnNumCS2(cs, cell);

						cell.setCellValue(tmpDoubleValue);
					} else {
						setCmmnCS2(cs, cell);

						cell.setCellValue(tmpValue);
					}
				}

				rowIndex += 1;

			}

			break;

		case "SDP00110":

			headerListSingle.add("정산상태");
			headerListSingle.add("주문번호");
			headerListSingle.add("구매자");
			headerListSingle.add("계량시작일");
			headerListSingle.add("공급확정일시");
			headerListSingle.add("정산공급량");
			headerListSingle.add("구매자확정공급량");

			headerListUnder.add("판매자");
			headerListUnder.add("계량종료일");
			headerListUnder.add("확정공급량");
			headerListUnder.add("판매자확정공급량");

			headersize1 = headerListSingle.size(); // 6
			headersize3 = headerListUnder.size(); // 2

			// 제목
			cell = row.createCell(0);
			cell.setCellValue(title);
			setHeaderCS(cs, font, cell);

			cell = row.createCell(headersize1);
			setHeaderCS(cs, font, cell);

			sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, headersize1));

			// 헤더-1
			row = sheet.createRow(1);
			cell = null;
			cs = wb.createCellStyle();
			font = wb.createFont();
			cell = row.createCell(0);
			cell.setCellValue("NO");
			sheet.setColumnWidth((0), 1500);
			setHeaderCS(cs, font, cell);

			for (int i = 1; i <= headersize1; i++) {

				cell = row.createCell(i);
				cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
				sheet.setColumnWidth((i), 6000);
				setHeaderCS(cs, font, cell);

			}

			// 헤더-2
			row = sheet.createRow(2);

			// merge시 css 이슈 해결
			for (int i = 0; i <= headersize1; i++) {
				cell = row.createCell(i);
				setHeaderCS(cs, font, cell);

				if (i == 3 || i == 4) {
					cell.setCellValue(StringUtil.nullConvert(headerListUnder.get(i - 3)));
					sheet.setColumnWidth((i), 6000);
				} else if (i == 6 || i == 7) {
					cell.setCellValue(StringUtil.nullConvert(headerListUnder.get(i - 4)));
					sheet.setColumnWidth((i), 6000);
				} else {
					sheet.addMergedRegion(new CellRangeAddress(1, 2, i, i));
				}

			}

			// 빈칸-내용
			row = sheet.createRow(3);

			rowIndex = 3;

			for (int i = 0; i < valsize; i++) {

				List dataList = new ArrayList();
				HashMap map = (HashMap) excelldata.get(i);

				// 값 치환
				Iterator entries = map.values().iterator();

				while (entries.hasNext()) {

					dataList.add(entries.next());

				}

				row = sheet.createRow(rowIndex);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				cell = row.createCell(0);
				cs = wb.createCellStyle();
				setCmmnCS2(cs, cell);
				cell.setCellValue(i + 1);

				for (int j = 0; j < headersize1; j++) {
//					  System.out.println("j를 알려주세요 첫번째 row " + j);
					cell = row.createCell(j + 1);
					String tmpValue = "";
					Double tmpDoubleValue = 0d;
					boolean numFlag = true;
					cs = wb.createCellStyle();

					try {

						tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());

					} catch (Exception e) {

						numFlag = false;
						tmpValue = StringUtil.nullConvert(dataList.get(j));
					}

					if (j == 4) {
						if (StringUtil.nullConvert(dataList.get(j)).equals("")
								|| StringUtil.nullConvert(dataList.get(j)).equals(null)) {

							numFlag = false;
							tmpValue = "미확정";
						}
					}

					if (numFlag) {
						setCmmnNumCS2(cs, cell);

						cell.setCellValue(tmpDoubleValue);
					} else {
						setCmmnCS2(cs, cell);

						cell.setCellValue(tmpValue);
					}
				}

				row = sheet.createRow(rowIndex + 1);
				cell = null;

				for (int j = 0; j < headersize1 + 1; j++) {
					cell = row.createCell(j);
					cs = wb.createCellStyle();
//					  System.out.println("j를 알려주세요 " + j);
					if (j == 3 || j == 4) {
						String tmpValue = "";
						Double tmpDoubleValue = 0d;
						boolean numFlag = true;
						try {
							tmpDoubleValue = Double.parseDouble(dataList.get(j + 4).toString());

						} catch (Exception e) {

							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j + 4));
						}

						if (j == 4) {
							if (StringUtil.nullConvert(dataList.get(j + 4)).equals("")
									|| StringUtil.nullConvert(dataList.get(j + 4)).equals(null)) {
								numFlag = false;
								tmpValue = "미완료";
							}
						}

						if (numFlag) {
							setCmmnNumCS2(cs, cell);

							cell.setCellValue(tmpDoubleValue);
						} else {
							setCmmnCS2(cs, cell);

							cell.setCellValue(tmpValue);
						}

					} else if (j == 6 || j == 7) {

						String tmpValue = "";
						Double tmpDoubleValue = 0d;
						boolean numFlag = true;

						try {
							tmpDoubleValue = Double.parseDouble(dataList.get(j + 3).toString());

						} catch (Exception e) {

							numFlag = false;
							tmpValue = StringUtil.nullConvert(dataList.get(j + 3));

						}

						if (numFlag) {
							setCmmnNumCS2(cs, cell);

							cell.setCellValue(tmpDoubleValue);
						} else {
							setCmmnCS2(cs, cell);

							cell.setCellValue(tmpValue);
						}

					} else {
						setCmmnCS2(cs, cell);
						sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex + 1, j, j));

					}

				}

				rowIndex = rowIndex + 2;

			}

			break;

		case "SDP00310":

			headerListSingle.add("정산상태");
			headerListSingle.add("기준년월");
			headerListSingle.add("정산번호");
			headerListSingle.add("정산건수");
			headerListSingle.add("거래물량");
			headerListSingle.add("정산금액");
			headerListSingle.add("정산세액");

			headersize1 = headerListSingle.size();

			// 제목
			cell = row.createCell(0);
			cell.setCellValue(title);
			setHeaderCS(cs, font, cell);

			cell = row.createCell(headersize1);
			setHeaderCS(cs, font, cell);

			sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, headersize1));

			// 헤더-1
			row = sheet.createRow(1);
			cell = null;
			cs = wb.createCellStyle();
			font = wb.createFont();
			cell = row.createCell(0);
			cell.setCellValue("NO");
			sheet.setColumnWidth((0), 1500);
			setHeaderCS(cs, font, cell);

			for (int i = 1; i <= headersize1; i++) {
				cell = row.createCell(i);
				cell.setCellValue(StringUtil.nullConvert(headerListSingle.get(i - 1)));
				sheet.setColumnWidth((i), 5000);
				setHeaderCS(cs, font, cell);
			}

			// 빈칸-내용
			row = sheet.createRow(2);

			rowIndex = 2;

			for (int i = 0; i < valsize; i++) {

				List dataList = new ArrayList();
				HashMap map = (HashMap) excelldata.get(i);

				// 값 치환
				Iterator entries = map.values().iterator();

				while (entries.hasNext()) {

					dataList.add(entries.next());

				}

				row = sheet.createRow(rowIndex);
				cell = null;
				cs = wb.createCellStyle();
				font = wb.createFont();

				cell = row.createCell(0);
				cs = wb.createCellStyle();
				setCmmnCS2(cs, cell);
				cell.setCellValue(i + 1);

				for (int j = 0; j < dataList.size(); j++) {

					cell = row.createCell(j + 1);
					String tmpValue = "";
					Double tmpDoubleValue = 0d;
					boolean numFlag = true;
					cs = wb.createCellStyle();

					try {
						tmpDoubleValue = Double.parseDouble(dataList.get(j).toString());

					} catch (Exception e) {

						numFlag = false;
						tmpValue = StringUtil.nullConvert(dataList.get(j));
					}

					if (j >= 1 && j <= 2) {
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
			break;

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

	/*
	 * public List<Object> getExcelData(final Map<String, MultipartFile> files, int
	 * sheetNum, int headrow, int firstRow, String keys) throws Exception {
	 * List<Object> result = new ArrayList<Object>(); if (files != null) {
	 * 
	 * Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	 * MultipartFile file = null; InputStream fis = null; while (itr.hasNext()) {
	 * Entry<String, MultipartFile> entry = itr.next(); try { file =
	 * entry.getValue(); fis = file.getInputStream(); String filename =
	 * file.getOriginalFilename().toLowerCase(); if (filename.endsWith(".xls")) {
	 * HSSFWorkbook workbook = new HSSFWorkbook(fis); result =
	 * getSheetData(workbook.getSheetAt(sheetNum), headrow, firstRow, keys); } else
	 * if (filename.endsWith(".xlsx")) { Workbook workbook = new XSSFWorkbook(fis);
	 * result = getSheetDataXlsx(workbook.getSheetAt(sheetNum), headrow, firstRow,
	 * keys);
	 * 
	 * }
	 * 
	 * } finally { try { if (fis != null) { fis.close(); } } catch (IOException ee)
	 * { // ee.printStackTrace(); fis.close(); } } } }
	 * 
	 * return result; }
	 */

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
	/*
	 * private List<Object> getSheetData(HSSFSheet sheet, int headrow, int firstRow,
	 * String keys) throws Exception {
	 * 
	 * List<Object> sheetData = new ArrayList<Object>(); List<String> header = new
	 * ArrayList<String>();
	 * 
	 * String[] key = keys.split(",", -1);
	 * 
	 * for (int i = 0; i < key.length; i++) { header.add(key[i]); }
	 * 
	 * for (int i = firstRow; i <= sheet.getLastRowNum(); i++) {
	 * 
	 * HSSFRow row = sheet.getRow(i); if (isRowEmpty(row)) { continue; }
	 * 
	 * Map<String, Object> rowdata = new HashMap<String, Object>(); for (int ii = 0;
	 * ii <= row.getLastCellNum(); ii++) { HSSFCell cell = row.getCell(ii,
	 * Row.RETURN_BLANK_AS_NULL); if (cell == null) continue;
	 * 
	 * rowdata.put((String) header.get(ii), getCellValue(cell)); }
	 * sheetData.add(rowdata); }
	 * 
	 * return sheetData; }
	 */

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
	/*
	 * private Object getCellValue(HSSFCell cell) throws Exception { int celltype =
	 * cell.getCellType(); Object value = null;
	 * 
	 * switch (celltype) { case HSSFCell.CELL_TYPE_FORMULA: value =
	 * cell.getCellFormula(); break; case HSSFCell.CELL_TYPE_NUMERIC: if
	 * (DateUtil.isCellDateFormatted(cell)) { // 날짜 형식 SimpleDateFormat dateformat =
	 * new SimpleDateFormat("yyyy-MM-dd"); value = "" +
	 * dateformat.format(cell.getDateCellValue()); } else { value = "" +
	 * String.format("%.0f", new Double(cell.getNumericCellValue())); } break; case
	 * HSSFCell.CELL_TYPE_STRING: value = "" + cell.getStringCellValue(); break;
	 * case HSSFCell.CELL_TYPE_BLANK: // value= "" + cell.getBooleanCellValue();
	 * value = ""; break; case HSSFCell.CELL_TYPE_ERROR: value = "" +
	 * cell.getErrorCellValue(); break; default: value = ""; break; } return value;
	 * }
	 */

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
	/*
	 * private List<Object> getSheetDataXlsx(Sheet sheet, int headrow, int firstRow,
	 * String keys) throws Exception { // firstRow = 3; List<Object> sheetData = new
	 * ArrayList<Object>(); List<String> header = new ArrayList<String>();
	 * 
	 * String key[] = keys.split(",",-1);
	 * 
	 * 
	 * for(int i = 0; i < key.length; i++) { header.add(key[i]); }
	 * 
	 * for (int i = firstRow; i <= sheet.getLastRowNum(); i++) {
	 * 
	 * Row row = sheet.getRow(i); if (isRowEmpty(row)) { continue; }
	 * 
	 * Map<String, Object> rowdata = new HashMap<String, Object>(); for (int ii = 0;
	 * ii < row.getLastCellNum(); ii++) { Cell cell = row.getCell(ii,
	 * Row.RETURN_BLANK_AS_NULL); if (cell == null) continue; rowdata.put((String)
	 * header.get(ii), getCellValueXlsx(cell)); } sheetData.add(rowdata); }
	 * 
	 * return sheetData; }
	 */

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
	/*
	 * @SuppressWarnings("deprecation") private Object getCellValueXlsx(Cell cell)
	 * throws Exception { int celltype = cell.getCellType(); Object value = null;
	 * 
	 * switch (celltype) { case Cell.CELL_TYPE_FORMULA: value =
	 * cell.getCellFormula(); break; case Cell.CELL_TYPE_NUMERIC: if
	 * (DateUtil.isCellDateFormatted(cell)) { // 날짜 형식 // 딴건 되는데 하이폰은 빼기로 인식해서 숫자로
	 * 가져간다.... SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
	 * value = "" + dateformat.format(cell.getDateCellValue()); } else {
	 * 
	 * // System.out.println("cell.getNumericCellValue())" +
	 * cell.getNumericCellValue()); //
	 * System.out.println("cell.getNumericCellValue())" + new
	 * BigDecimal(cell.getNumericCellValue()).setScale(10,
	 * RoundingMode.HALF_DOWN).toEngineeringString());
	 * 
	 * // 소수점 10자리까지 표기되도록 DecimalFormat df = new DecimalFormat("0.##########");
	 * 
	 * // 10자리 이후 버림 value = "" + df.format( new BigDecimal(new
	 * Double(cell.getNumericCellValue())).setScale(10, RoundingMode.HALF_DOWN));
	 * 
	 * // System.out.println("value >>>>>>>>>>" + value);
	 * 
	 * } break; case Cell.CELL_TYPE_STRING: value = "" + cell.getStringCellValue();
	 * break; case Cell.CELL_TYPE_BLANK: // value= "" + cell.getBooleanCellValue();
	 * value = ""; break; case Cell.CELL_TYPE_ERROR: value = "" +
	 * cell.getErrorCellValue(); break; default: value = ""; break; } return value;
	 * }
	 */

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

}