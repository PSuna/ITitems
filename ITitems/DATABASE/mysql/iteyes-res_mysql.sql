/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 8.0.33 : Database - ititems_res
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ititems_res` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ititems_res`;

/*Table structure for table `aprvtarget` */

DROP TABLE IF EXISTS `aprvtarget`;

CREATE TABLE `aprvtarget` (
  `req_id` varchar(30) DEFAULT NULL,
  `user_id` varchar(30) DEFAULT NULL,
  `target_id` varchar(30) DEFAULT NULL,
  `req_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'A0',
  `target_up` varchar(30) DEFAULT NULL,
  `aprv_date` date DEFAULT NULL,
  `aprv_order` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `aprvtarget` */

/*Table structure for table `asset` */

DROP TABLE IF EXISTS `asset`;

CREATE TABLE `asset` (
  `MNG_NUM` varchar(20) DEFAULT NULL,
  `ASSET_ID` varchar(20) DEFAULT NULL,
  `ASS_ID` char(20) DEFAULT NULL,
  `ASSET_STAUTS` varchar(20) DEFAULT NULL,
  `USAGE_STAUTS` varchar(20) DEFAULT NULL,
  `CREAT_DT` datetime DEFAULT NULL,
  `LARGE_CATEGORY` varchar(10) DEFAULT NULL,
  `MIDDLE_CATEGORY` varchar(10) DEFAULT NULL,
  `MCAT_ETC` varchar(50) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `RCPT_ID` varchar(20) DEFAULT NULL,
  `USE_ID` varchar(20) DEFAULT NULL,
  `ORGNZT_ID` varchar(50) DEFAULT NULL,
  `ASSET_NAME` varchar(30) DEFAULT NULL,
  `ASSET_SN` varchar(50) DEFAULT NULL,
  `ACQUIRED_DATE` datetime DEFAULT NULL,
  `ASSET_START` datetime DEFAULT NULL,
  `ASSET_END` datetime DEFAULT NULL,
  `ACQUIRED_PRICE` varchar(30) DEFAULT NULL,
  `MAKER` varchar(50) DEFAULT NULL,
  `MAKER_CODE` varchar(20) DEFAULT NULL,
  `NOTE` varchar(255) DEFAULT NULL,
  `RCPT_DATE` datetime DEFAULT NULL,
  `ASSET_COMPANY` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `asset` */


/*Table structure for table `assethistory` */

DROP TABLE IF EXISTS `assethistory`;

CREATE TABLE `assethistory` (
  `MNG_NUM` varchar(20) DEFAULT NULL,
  `ASSET_ID` varchar(20) DEFAULT NULL,
  `ASSET_STAUTS` varchar(20) DEFAULT NULL,
  `USAGE_STAUTS` varchar(20) DEFAULT NULL,
  `CREAT_DT` datetime DEFAULT NULL,
  `LARGE_CATEGORY` varchar(10) DEFAULT NULL,
  `MIDDLE_CATEGORY` varchar(10) DEFAULT NULL,
  `MCAT_ETC` varchar(50) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `RCPT_ID` varchar(20) DEFAULT NULL,
  `USE_ID` varchar(20) DEFAULT NULL,
  `ORGNZT_ID` varchar(50) DEFAULT NULL,
  `ASSET_NAME` varchar(30) DEFAULT NULL,
  `ASSET_SN` varchar(50) DEFAULT NULL,
  `ACQUIRED_DATE` datetime DEFAULT NULL,
  `ASSET_START` datetime DEFAULT NULL,
  `ASSET_END` datetime DEFAULT NULL,
  `ACQUIRED_PRICE` varchar(30) DEFAULT NULL,
  `MAKER` varchar(50) DEFAULT NULL,
  `MAKER_CODE` varchar(20) DEFAULT NULL,
  `NOTE` varchar(255) DEFAULT NULL,
  `RCPT_DATE` datetime DEFAULT NULL,
  `ASSET_COMPANY` varchar(50) DEFAULT NULL,
  `CREAT_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Table structure for table `assetmaster` */

DROP TABLE IF EXISTS `assetmaster`;

CREATE TABLE `assetmaster` (
  `ASS_ID` char(20) DEFAULT NULL,
  `ASS_NM` varchar(255) DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `assetmaster` */

insert  into `assetmaster`(`ASS_ID`,`ASS_NM`,`FRST_REGISTER_ID`,`FRST_REGIST_PNTTM`,`LAST_UPDUSR_ID`,`LAST_UPDT_PNTTM`) values 
('ASSMSTR_000000000001','자산','USRCNFRM_00000000000','2011-08-31 12:00:00','USRCNFRM_00000000000','2011-08-31 12:00:00'),
('ASSMSTR_000000000002','렌탈','USRCNFRM_00000000000','2011-08-31 12:00:00','USRCNFRM_00000000000','2011-08-31 12:00:00');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `CAT_ID` varchar(15) NOT NULL,
  `CAT_NAME` varchar(30) NOT NULL,
  `UPPER_CAT` varchar(15) DEFAULT NULL,
  `CAT_ORDER` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`CAT_ID`),
  UNIQUE KEY `uq_catName` (`CAT_NAME`,`UPPER_CAT`),
  KEY `FK_CATEGORY_TO_CATEGORY_1` (`UPPER_CAT`),
  CONSTRAINT `FK_CATEGORY_TO_CATEGORY_1` FOREIGN KEY (`UPPER_CAT`) REFERENCES `category` (`CAT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `category` */

insert  into `category`(`CAT_ID`,`CAT_NAME`,`UPPER_CAT`,`CAT_ORDER`) values 
('cat1','전자기기',NULL,1),
('cat10','기타','cat5',99),
('cat11','모니터','cat1',1),
('cat12','선풍기','cat1',1),
('cat16','수납장','cat5',1),
('cat19','TV','cat1',1),
('cat2','빔프로젝터','cat1',1),
('cat22','USB','cat1',1),
('cat24','파티션','cat5',1),
('cat27','키보드','cat1',1),
('cat28','마우스','cat1',1),
('cat29','데스크탑','cat1',1),
('cat3','냉장고','cat1',1),
('cat30','프린터','cat1',1),
('cat32','세절기','cat1',1),
('cat33','화이트보드','cat5',1),
('cat34','옷걸이','cat5',1),
('cat35','필기구','cat5',1),
('cat5','사무용품',NULL,1),
('cat6','책상','cat5',1),
('cat7','의자','cat5',1),
('cat8','노트북','cat1',1),
('cat9','기타','cat1',99);

/*Table structure for table `exceptions` */

DROP TABLE IF EXISTS `exceptions`;

CREATE TABLE `exceptions` (
  `XCPT_ID` varchar(20) DEFAULT NULL,
  `EXCEPTION` varchar(2500) DEFAULT NULL,
  `PACKAGE_NAME` varchar(100) DEFAULT NULL,
  `CREAT_DT` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Table structure for table `ids` */

DROP TABLE IF EXISTS `ids`;

CREATE TABLE `ids` (
  `TABLE_NAME` varchar(20) NOT NULL,
  `NEXT_ID` decimal(30,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`TABLE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `ids` */

insert  into `ids`(`TABLE_NAME`,`NEXT_ID`) values 
('A_ID',1),
('ASSET_ID',1),
('BBS_ID',1),
('FILE_ID',1),
('GROUP_ID',1),
('HIST_ID',1),
('LOGINLOG_ID',1),
('R_ID',1),
('RED_ID',1),
('RENTAL_ID',1),
('REQ_ID',1),
('ROLE_ID',1),
('SAMPLE',1),
('SYSLOG_ID',1),
('TMPLAT_ID',1),
('USRCNFRM_ID',1);

/*Table structure for table `lettccmmnclcode` */

DROP TABLE IF EXISTS `lettccmmnclcode`;

CREATE TABLE `lettccmmnclcode` (
  `CL_CODE` char(3) NOT NULL,
  `CL_CODE_NM` varchar(60) DEFAULT NULL,
  `CL_CODE_DC` varchar(200) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CL_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettccmmnclcode` */

insert  into `lettccmmnclcode`(`CL_CODE`,`CL_CODE_NM`,`CL_CODE_DC`,`USE_AT`,`FRST_REGIST_PNTTM`,`FRST_REGISTER_ID`,`LAST_UPDT_PNTTM`,`LAST_UPDUSR_ID`) values 
('LET','자산관리 솔루션','자산관리 솔루션','Y','2011-08-02 21:13:03','SYSTEM','2011-08-09 17:17:08',NULL);

/*Table structure for table `lettccmmncode` */

DROP TABLE IF EXISTS `lettccmmncode`;

CREATE TABLE `lettccmmncode` (
  `CODE_ID` varchar(6) NOT NULL,
  `CODE_ID_NM` varchar(60) DEFAULT NULL,
  `CODE_ID_DC` varchar(200) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `CL_CODE` char(3) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CODE_ID`),
  KEY `R_179` (`CL_CODE`),
  CONSTRAINT `LETTCCMMNCODE_ibfk_1` FOREIGN KEY (`CL_CODE`) REFERENCES `lettccmmnclcode` (`CL_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettccmmncode` */

insert  into `lettccmmncode`(`CODE_ID`,`CODE_ID_NM`,`CODE_ID_DC`,`USE_AT`,`CL_CODE`,`FRST_REGIST_PNTTM`,`FRST_REGISTER_ID`,`LAST_UPDT_PNTTM`,`LAST_UPDUSR_ID`) values 
('COM001','등록구분','게시판, 커뮤니티, 동호회 등록구분코드1','Y','LET','2011-08-02 21:13:03','SYSTEM','2011-08-09 17:56:24',NULL),
('COM002','직급','직급구분코드','Y','LET','2023-04-17 17:17:22','SYSTEM','2023-04-17 17:17:30','SYSTEM'),
('COM003','업무구분','업무구분코드','Y','LET','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM'),
('COM004','게시판유형','게시판유형구분코드','Y','LET','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM'),
('COM005','템플릿유형','템플릿유형구분코드','Y','LET','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM'),
('COM006','내역구분코드','자산관리내역을 관리할때 사용하는 구분코드','Y','LET','2023-04-17 17:32:02','SYSTEM','2023-04-17 17:32:06','SYSTEM'),
('COM007','프로젝트구분','프로젝트 진행 여부를 구분하는 코드','Y','LET','2023-04-17 17:35:58','SYSTEM','2023-04-17 17:36:00','SYSTEM'),
('COM008','요청상태코드','요청내역의 상태를 나타내는 구분코드','Y','LET','2023-04-17 17:36:08','SYSTEM','2023-04-17 17:36:14','SYSTEM'),
('COM009','게시판속성','게시판 속성','Y','LET','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM'),
('COM010','사용여부코드','자산의 사용여부를 나타내는 코드','Y','LET','2023-04-17 17:39:31','SYSTEM','2023-04-17 17:39:32','SYSTEM'),
('COM011','신청코드','신청상태를 나타내는 코드','Y','LET','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM'),
('COM012','신청상태','신청상태를 나타내는 코드','Y','LET','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM'),
('COM013','회원상태','회원 가입 신청/승인/삭제를 위한 상태 구분','Y','LET','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM'),
('COM014','성별구분','남녀 성별 구분','Y','LET','2011-08-11 11:32:50','SYSTEM','2011-08-11 11:32:50','SYSTEM'),
('COM015','제조사','제조사 구분 코드','Y','LET','2023-04-17 17:35:58','SYSTEM','2023-04-17 17:32:06','SYSTEM'),
('COM022','비밀번호 힌트','비밀번호 힌트 구분코드','Y','LET','2011-08-11 11:31:02','SYSTEM','2011-08-11 11:31:02','SYSTEM'),
('COM025','소속기관','소속기관정보를 관리할때 사용하는 구분코드(시스템별로 재정의)','Y','LET','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM'),
('COM029','롤유형코드','','Y','LET','2011-08-12 10:45:16','SYSTEM','2011-08-12 10:45:16','SYSTEM');

/*Table structure for table `lettccmmndetailcode` */

DROP TABLE IF EXISTS `lettccmmndetailcode`;

CREATE TABLE `lettccmmndetailcode` (
  `CODE_ID` varchar(6) NOT NULL,
  `CODE` varchar(15) NOT NULL,
  `CODE_NM` varchar(60) DEFAULT NULL,
  `CODE_DC` varchar(200) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `CODE_ORDER` int DEFAULT NULL,
  PRIMARY KEY (`CODE_ID`,`CODE`),
  CONSTRAINT `LETTCCMMNDETAILCODE_ibfk_1` FOREIGN KEY (`CODE_ID`) REFERENCES `lettccmmncode` (`CODE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettccmmndetailcode` */

insert  into `lettccmmndetailcode`(`CODE_ID`,`CODE`,`CODE_NM`,`CODE_DC`,`USE_AT`,`FRST_REGIST_PNTTM`,`FRST_REGISTER_ID`,`LAST_UPDT_PNTTM`,`LAST_UPDUSR_ID`,`CODE_ORDER`) values 
('COM001','REGC01','단일 게시판 이용등록','단일 게시판 이용등록','Y','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM001','REGC07','게시판사용자등록','게시판사용자등록','Y','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM002','ADD','고문','고문','Y','2023-04-17 17:27:41','SYSTEM','2023-04-17 17:28:08','SYSTEM',13),
('COM002','AM','대리','대리','Y','2023-04-17 17:27:43','SYSTEM','2023-04-17 17:28:10','SYSTEM',16),
('COM002','AUD','감사','감사','Y','2023-04-17 17:27:45','SYSTEM','2023-04-17 17:28:11','SYSTEM',11),
('COM002','CBO','사업부문대표','사업부문대표','Y','2023-04-17 17:27:49','SYSTEM','2023-04-17 17:28:13','SYSTEM',1),
('COM002','CEO','대표이사','대표이사','Y','2023-04-17 17:27:51','SYSTEM','2023-04-17 17:28:16','SYSTEM',0),
('COM002','CMT','위원','위원','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:28:14','SYSTEM',12),
('COM002','ED','이사','이사','Y','2023-04-17 17:27:54','SYSTEM','2023-04-17 17:28:18','SYSTEM',4),
('COM002','EMD','전무','전무','Y','2023-04-17 17:27:55','SYSTEM','2023-04-17 17:28:19','SYSTEM',2),
('COM002','GM','부장','부장','Y','2023-04-17 17:27:56','SYSTEM','2023-04-17 17:28:22','SYSTEM',14),
('COM002','JRE1','선임(S1)','선임(S1)','Y','2023-04-17 17:28:03','SYSTEM','2023-04-17 17:28:28','SYSTEM',9),
('COM002','MD','상무','상무','Y','2023-04-17 17:28:00','SYSTEM','2023-04-17 17:28:24','SYSTEM',3),
('COM002','MNG','과장','과장','Y','2023-04-17 17:28:02','SYSTEM','2023-04-17 17:28:26','SYSTEM',15),
('COM002','PRE1','수석(G1)','수석(G1)','Y','2023-04-17 17:28:03','SYSTEM','2023-04-17 17:28:28','SYSTEM',6),
('COM002','PRE2','수석(G2)','수석(G2)','Y','2023-04-17 17:28:03','SYSTEM','2023-04-17 17:28:28','SYSTEM',5),
('COM002','SC','주임','주임','Y','2023-04-17 17:28:04','SYSTEM','2023-04-17 17:28:27','SYSTEM',17),
('COM002','SRE1','책임(M1)','책임(M1)','Y','2023-04-17 17:28:06','SYSTEM','2023-04-17 17:28:30','SYSTEM',8),
('COM002','SRE2','책임(M2)','책임(M2)','Y','2023-04-17 17:28:06','SYSTEM','2023-04-17 17:28:30','SYSTEM',7),
('COM003','BBS','게시판','게시판','Y','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM004','BBST01','문의게시판','문의게시판','Y','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM004','BBST02','익명게시판','익명게시판','N','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM004','BBST03','공지게시판','공지게시판','Y','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM005','TMPT01','게시판템플릿','게시판템플릿','Y','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM006','H0','사용중','사용중','Y','2023-04-17 17:33:01','SYSTEM','2023-04-17 17:33:01','SYSTEM',NULL),
('COM006','H1','보관중(사용가능)','보관중(사용가능)','Y','2023-04-17 17:33:01','SYSTEM','2023-04-17 17:33:01','SYSTEM',NULL),
('COM006','H2','보관중(파손)','보관중(파손)','Y','2023-04-17 17:33:01','SYSTEM','2023-04-17 17:33:01','SYSTEM',NULL),
('COM006','H3','보관중(수리)','보관중(수리)','Y','2023-04-17 17:33:01','SYSTEM','2023-04-17 17:33:01','SYSTEM',NULL),
('COM006','H4','처분','처분','Y','2023-04-17 17:33:01','SYSTEM','2023-04-17 17:33:01','SYSTEM',NULL),
('COM007','P0','진행중','진행중','Y','2023-04-17 17:34:48','SYSTEM','2023-04-17 17:34:48','SYSTEM',NULL),
('COM007','P1','종료','종료','Y','2023-04-17 17:34:48','SYSTEM','2023-04-17 17:34:48','SYSTEM',NULL),
('COM008','A0','결재대기','결재대기','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM008','A1','결재완료','결재완료','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM008','A2','반려','반려','Y',NULL,NULL,NULL,NULL,NULL),
('COM009','BBSA01','유효게시판','유효게시판','N','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM009','BBSA02','갤러리','갤러리','Y','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM009','BBSA03','일반게시판','일반게시판','Y','2011-08-02 21:13:03','SYSTEM','2011-08-02 21:13:03','SYSTEM',NULL),
('COM010','U0','사용안함','사용안함','Y','2023-04-17 17:40:27','SYSTEM','2023-04-17 17:40:27','SYSTEM',NULL),
('COM010','U1','사용중','사용중','Y','2023-04-17 17:40:27','SYSTEM','2023-04-17 17:40:27','SYSTEM',NULL),
('COM011','C0','반입신청','반입신청','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM011','C1','반출신청','반출신청','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM011','C2','신규등록','신규등록','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM011','C3','정보수정','정보수정','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM011','C4','삭제','삭제','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM011','C5','자산관리번호 수정','자산관리번호 수정','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM012','R0','대기중','대기중','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM012','R1','승인','승인','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM012','R2','반려','반려','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM012','R3','완료','완료','Y','2023-04-17 17:38:35','SYSTEM','2023-04-17 17:38:35','SYSTEM',NULL),
('COM013','A','회원 가입 신청 상태','회원 가입 신청 상태','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM013','D','회원 가입 삭제 상태','회원 가입 삭제 상태','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM013','P','회원 가입 승인 상태','회원 가입 승인 상태','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM014','F','여자','여자','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM014','M','남자','남자','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM015','MK00','기타','기타','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',99),
('COM015','MK01','삼성전자','삼성전자','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',0),
('COM015','MK02','LG전자','LG전자','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',1),
('COM015','MK03','애플','애플','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',2),
('COM015','MK04','레노버','레노버','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',3),
('COM015','MK06','HP','HP','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',5),
('COM015','MK07','DELL','DELL','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',6),
('COM015','MK08','한성','한성','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',7),
('COM015','MK09','마이크로소프트','마이크로소프트','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',8),
('COM015','MK10','에이서','에이서','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',9),
('COM015','MK11','로지텍','로지텍','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',10),
('COM015','MK12','MSI','MSI','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',11),
('COM015','MK13','ASUS ','ASUS ','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',12),
('COM015','MK14','SIDIZ ','SIDIZ ','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',13),
('COM015','MK15','CUCKOO ','CUCKOO ','Y','2023-04-17 17:27:52','SYSTEM','2023-04-17 17:27:52','SYSTEM',14),
('COM022',' P01','가장 기억에 남는 장소는?','가장 기억에 남는 장소는?','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM022',' P02','나의 좌우명은?','나의 좌우명은?','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM022',' P03','나의 보물 제1호는?','나의 보물 제1호는?','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM022',' P04','가장 기억에 남는 선생님 성함은?','가장 기억에 남는 선생님 성함은?','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM022',' P05','다른 사람은 모르는 나만의 신체비밀은?','다른 사람은 모르는 나만의 신체비밀은?','N','2011-08-11 11:32:57','SYSTEM','2011-08-11 11:32:57','SYSTEM',NULL),
('COM025','00000001','공공기관','공공기관','Y','2011-08-11 11:33:10','SYSTEM','2011-08-11 11:33:10','SYSTEM',NULL),
('COM025','00000002','금융기관','금융기관','Y','2011-08-11 11:33:10','SYSTEM','2011-08-11 11:33:10','SYSTEM',NULL),
('COM025','00000003','교육기관','교육기관','Y','2011-08-11 11:33:10','SYSTEM','2011-08-11 11:33:10','SYSTEM',NULL),
('COM025','00000004','의료기관','의료기관','Y','2011-08-11 11:33:10','SYSTEM','2011-08-11 11:33:10','SYSTEM',NULL),
('COM029','url','URL','URL','Y','2011-08-12 10:46:18','SYSTEM','2011-08-12 10:46:18','SYSTEM',NULL);

/*Table structure for table `letthemplyrinfochangedtls` */

DROP TABLE IF EXISTS `letthemplyrinfochangedtls`;

CREATE TABLE `letthemplyrinfochangedtls` (
  `EMPLYR_ID` varchar(40) NOT NULL,
  `CHANGE_DE` datetime NOT NULL,
  `ORGNZT_ID` char(20) DEFAULT NULL,
  `GROUP_ID` char(20) DEFAULT NULL,
  `EMPL_NO` varchar(20) DEFAULT NULL,
  `SEXDSTN_CODE` char(1) DEFAULT NULL,
  `BRTHDY` char(20) DEFAULT NULL,
  `FXNUM` varchar(20) DEFAULT NULL,
  `HOUSE_ADRES` varchar(100) DEFAULT NULL,
  `HOUSE_END_TELNO` varchar(4) DEFAULT NULL,
  `AREA_NO` varchar(4) DEFAULT NULL,
  `DETAIL_ADRES` varchar(100) DEFAULT NULL,
  `ZIP` varchar(6) DEFAULT NULL,
  `OFFM_TELNO` varchar(20) DEFAULT NULL,
  `MBTLNUM` varchar(20) DEFAULT NULL,
  `EMAIL_ADRES` varchar(50) DEFAULT NULL,
  `HOUSE_MIDDLE_TELNO` varchar(4) DEFAULT NULL,
  `PSTINST_CODE` char(8) DEFAULT NULL,
  `EMPLYR_STTUS_CODE` varchar(15) DEFAULT NULL,
  `ESNTL_ID` char(20) DEFAULT NULL,
  PRIMARY KEY (`EMPLYR_ID`,`CHANGE_DE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Table structure for table `lettnauthorgroupinfo` */

DROP TABLE IF EXISTS `lettnauthorgroupinfo`;

CREATE TABLE `lettnauthorgroupinfo` (
  `GROUP_ID` char(20) NOT NULL DEFAULT '',
  `GROUP_NM` varchar(60) NOT NULL,
  `GROUP_CREAT_DE` char(20) NOT NULL,
  `GROUP_DC` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnauthorgroupinfo` */

insert  into `lettnauthorgroupinfo`(`GROUP_ID`,`GROUP_NM`,`GROUP_CREAT_DE`,`GROUP_DC`) values 
('GROUP_00000000000000','ITeyes','2023-04-18 17:03:21','ITeyes');

/*Table structure for table `lettnauthorinfo` */

DROP TABLE IF EXISTS `lettnauthorinfo`;

CREATE TABLE `lettnauthorinfo` (
  `AUTHOR_CODE` varchar(30) NOT NULL DEFAULT '',
  `AUTHOR_NM` varchar(60) NOT NULL,
  `AUTHOR_DC` varchar(200) DEFAULT NULL,
  `AUTHOR_CREAT_DE` char(20) NOT NULL,
  PRIMARY KEY (`AUTHOR_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnauthorinfo` */

insert  into `lettnauthorinfo`(`AUTHOR_CODE`,`AUTHOR_NM`,`AUTHOR_DC`,`AUTHOR_CREAT_DE`) values 
('ROLE_ADMIN','관리자','시스템관리자','2011-08-03'),
('ROLE_HIGH_ADMIN','최고관리자','최고관리자','2023-05-10'),
('ROLE_USER_MEMBER','사용자','일반사용자','2011-08-03');

/*Table structure for table `lettnauthorrolerelate` */

DROP TABLE IF EXISTS `lettnauthorrolerelate`;

CREATE TABLE `lettnauthorrolerelate` (
  `AUTHOR_CODE` varchar(30) NOT NULL,
  `ROLE_CODE` varchar(50) NOT NULL,
  `CREAT_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`AUTHOR_CODE`,`ROLE_CODE`),
  KEY `R_292` (`ROLE_CODE`),
  CONSTRAINT `LETTNAUTHORROLERELATE_ibfk_1` FOREIGN KEY (`AUTHOR_CODE`) REFERENCES `lettnauthorinfo` (`AUTHOR_CODE`) ON DELETE CASCADE,
  CONSTRAINT `LETTNAUTHORROLERELATE_ibfk_2` FOREIGN KEY (`ROLE_CODE`) REFERENCES `lettnroleinfo` (`ROLE_CODE`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnauthorrolerelate` */

insert  into `lettnauthorrolerelate`(`AUTHOR_CODE`,`ROLE_CODE`,`CREAT_DT`) values 
('ROLE_ADMIN','sec-gmt','2009-08-25 00:00:00'),
('ROLE_ADMIN','sec-ram','2009-08-25 00:00:00'),
('ROLE_ADMIN','sec-rmt','2009-08-25 00:00:00'),
('ROLE_ADMIN','sym-ccm-cca','2009-08-25 00:00:00'),
('ROLE_ADMIN','sym-ccm-ccc','2009-08-25 00:00:00'),
('ROLE_ADMIN','sym-ccm-cde','2009-08-25 00:00:00'),
('ROLE_ADMIN','sym-ccm-zip','2009-08-25 00:00:00'),
('ROLE_ADMIN','sym-mnu-mcm','2009-08-25 00:00:00'),
('ROLE_ADMIN','sym-mnu-mpm','2009-08-25 00:00:00'),
('ROLE_ADMIN','sym-prm','2009-08-25 00:00:00'),
('ROLE_ADMIN','uat-uap','2009-08-25 00:00:00'),
('ROLE_ADMIN','uss-umt-cmm','2009-08-25 00:00:00'),
('ROLE_HIGH_ADMIN','sec-rgm','2009-08-25 00:00:00'),
('ROLE_USER_MEMBER','cop-com','2009-08-25 00:00:00'),
('ROLE_USER_MEMBER','sts-cst','2009-08-25 00:00:00'),
('ROLE_USER_MEMBER','sym-log-clg','2009-08-25 00:00:00'),
('ROLE_USER_MEMBER','uss-ion-uas','2009-08-25 00:00:00'),
('ROLE_USER_MEMBER','uss-umt-user','2009-08-25 00:00:00');

/*Table structure for table `lettnbbs` */

DROP TABLE IF EXISTS `lettnbbs`;

CREATE TABLE `lettnbbs` (
  `NTT_ID` decimal(20,0) NOT NULL,
  `BBS_ID` char(20) NOT NULL,
  `NTT_NO` decimal(20,0) DEFAULT NULL,
  `NTT_SJ` varchar(2000) DEFAULT NULL,
  `NTT_CN` mediumtext,
  `ANSWER_AT` char(1) DEFAULT NULL,
  `PARNTSCTT_NO` decimal(10,0) DEFAULT NULL,
  `ANSWER_LC` int DEFAULT NULL,
  `SORT_ORDR` decimal(8,0) DEFAULT NULL,
  `RDCNT` decimal(10,0) DEFAULT NULL,
  `USE_AT` char(1) NOT NULL,
  `NTCE_BGNDE` char(20) DEFAULT NULL,
  `NTCE_ENDDE` char(20) DEFAULT NULL,
  `NTCR_ID` varchar(20) DEFAULT NULL,
  `NTCR_NM` varchar(20) DEFAULT NULL,
  `PASSWORD` varchar(200) DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime NOT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`NTT_ID`,`BBS_ID`),
  KEY `LETTNBBS_ibfk_1` (`BBS_ID`),
  CONSTRAINT `LETTNBBS_ibfk_1` FOREIGN KEY (`BBS_ID`) REFERENCES `lettnbbsmaster` (`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnbbs` */

insert  into `lettnbbs`(`NTT_ID`,`BBS_ID`,`NTT_NO`,`NTT_SJ`,`NTT_CN`,`ANSWER_AT`,`PARNTSCTT_NO`,`ANSWER_LC`,`SORT_ORDR`,`RDCNT`,`USE_AT`,`NTCE_BGNDE`,`NTCE_ENDDE`,`NTCR_ID`,`NTCR_NM`,`PASSWORD`,`ATCH_FILE_ID`,`FRST_REGIST_PNTTM`,`FRST_REGISTER_ID`,`LAST_UPDT_PNTTM`,`LAST_UPDUSR_ID`) values 
(1,'BBSMSTR_AAAAAAAAAAAA',1,'자산관리 솔루션 정식 오픈 공지','자산관리솔루션은 6월 26일 (월) 에 정식 오픈 합니다.\r\n현재 기능 테스트와 오류수정 및 추가요구사항 반영 중에 있으니 \r\n사이트 이용 중 불편함이 있으시더라도 양해 부탁드립니다.','N',0,0,1,64,'Y','10000101','99991231','','','',NULL,'2023-06-14 14:52:24','USRCNFRM_00000000053','2023-06-26 06:32:25','USRCNFRM_00000000221'),
(2,'BBSMSTR_AAAAAAAAAAAA',1,'이 글은 작성자에 의해서 삭제되었습니다.','123','N',0,0,2,2,'N','10000101','99991231','','','',NULL,'2023-06-15 15:08:33','USRCNFRM_00000000061','2023-06-15 15:08:52','USRCNFRM_00000000061'),
(3,'BBSMSTR_AAAAAAAAAAAA',1,'이 글은 작성자에 의해서 삭제되었습니다.','ㄴㅇㄹ','N',0,0,3,1,'N','10000101','99991231','','','',NULL,'2023-06-15 15:08:59','USRCNFRM_00000000061','2023-06-15 15:09:27','USRCNFRM_00000000061'),
(4,'BBSMSTR_AAAAAAAAAAAA',1,'이 글은 작성자에 의해서 삭제되었습니다.','ㅁㄴㅇ','N',0,0,4,5,'N','10000101','99991231','','','',NULL,'2023-06-19 20:54:24','USRCNFRM_00000000061','2023-06-19 21:00:01','USRCNFRM_00000000061'),
(5,'BBSMSTR_AAAAAAAAAAAA',1,'이 글은 작성자에 의해서 삭제되었습니다.','asd','N',0,0,5,5,'N','10000101','99991231','','','',NULL,'2023-06-20 09:46:59','USRCNFRM_00000000061','2023-06-20 10:24:36','USRCNFRM_00000000061'),
(6,'BBSMSTR_AAAAAAAAAAAA',1,'공지사항 1','공지사항 1 내용','N',0,0,6,3,'Y','10000101','99991231','','','','FILE_000000000001641','2023-06-26 13:19:56','USRCNFRM_00000000221','2023-06-26 14:22:02','USRCNFRM_00000000221');

/*Table structure for table `lettnbbsmaster` */

DROP TABLE IF EXISTS `lettnbbsmaster`;

CREATE TABLE `lettnbbsmaster` (
  `BBS_ID` char(20) NOT NULL,
  `BBS_NM` varchar(255) NOT NULL,
  `BBS_INTRCN` varchar(2400) DEFAULT NULL,
  `BBS_TY_CODE` char(6) NOT NULL,
  `BBS_ATTRB_CODE` char(6) NOT NULL,
  `REPLY_POSBL_AT` char(1) DEFAULT NULL,
  `FILE_ATCH_POSBL_AT` char(1) NOT NULL,
  `ATCH_POSBL_FILE_NUMBER` decimal(2,0) NOT NULL,
  `ATCH_POSBL_FILE_SIZE` decimal(8,0) DEFAULT NULL,
  `USE_AT` char(1) NOT NULL,
  `TMPLAT_ID` char(20) DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `FRST_REGIST_PNTTM` datetime NOT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  PRIMARY KEY (`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnbbsmaster` */

insert  into `lettnbbsmaster`(`BBS_ID`,`BBS_NM`,`BBS_INTRCN`,`BBS_TY_CODE`,`BBS_ATTRB_CODE`,`REPLY_POSBL_AT`,`FILE_ATCH_POSBL_AT`,`ATCH_POSBL_FILE_NUMBER`,`ATCH_POSBL_FILE_SIZE`,`USE_AT`,`TMPLAT_ID`,`FRST_REGISTER_ID`,`FRST_REGIST_PNTTM`,`LAST_UPDUSR_ID`,`LAST_UPDT_PNTTM`) values 
('BBSMSTR_AAAAAAAAAAAA','공지사항','공지사항게시판','BBST03','BBSA03','Y','Y',2,5242880,'Y','TMPLAT_BOARD_DEFAULT','USRCNFRM_00000000000','2011-08-31 12:00:00','USRCNFRM_00000000000','2011-08-31 12:00:00'),
('BBSMSTR_BBBBBBBBBBBB','갤러리','갤러리게시판','BBST02','BBSA02','Y','Y',2,5242880,'Y','TMPLAT_BOARD_DEFAULT','USRCNFRM_00000000000','2011-08-31 12:00:00','USRCNFRM_00000000000','2011-08-31 12:00:00'),
('BBSMSTR_CCCCCCCCCCCC','문의게시판','문의게시판','BBST01','BBSA03','Y','Y',2,5242880,'Y','TMPLAT_BOARD_DEFAULT','USRCNFRM_00000000000','2011-08-31 12:00:00','USRCNFRM_00000000000','2011-08-31 12:00:00');

/*Table structure for table `lettnbbsmasteroptn` */

DROP TABLE IF EXISTS `lettnbbsmasteroptn`;

CREATE TABLE `lettnbbsmasteroptn` (
  `BBS_ID` char(20) NOT NULL DEFAULT '',
  `ANSWER_AT` char(1) NOT NULL DEFAULT '',
  `STSFDG_AT` char(1) NOT NULL DEFAULT '',
  `FRST_REGIST_PNTTM` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL DEFAULT '',
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnbbsmasteroptn` */

/*Table structure for table `lettnbbsuse` */

DROP TABLE IF EXISTS `lettnbbsuse`;

CREATE TABLE `lettnbbsuse` (
  `BBS_ID` char(20) NOT NULL,
  `TRGET_ID` char(20) NOT NULL DEFAULT '',
  `USE_AT` char(1) NOT NULL,
  `REGIST_SE_CODE` char(6) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`BBS_ID`,`TRGET_ID`),
  CONSTRAINT `LETTNBBSUSE_ibfk_1` FOREIGN KEY (`BBS_ID`) REFERENCES `lettnbbsmaster` (`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnbbsuse` */

insert  into `lettnbbsuse`(`BBS_ID`,`TRGET_ID`,`USE_AT`,`REGIST_SE_CODE`,`FRST_REGIST_PNTTM`,`FRST_REGISTER_ID`,`LAST_UPDT_PNTTM`,`LAST_UPDUSR_ID`) values 
('BBSMSTR_AAAAAAAAAAAA','SYSTEM_DEFAULT_BOARD','Y','REGC01','2011-08-31 12:00:00','USRCNFRM_00000000000','2011-08-31 12:00:00','USRCNFRM_00000000000'),
('BBSMSTR_BBBBBBBBBBBB','SYSTEM_DEFAULT_BOARD','Y','REGC01','2011-08-31 12:00:00','USRCNFRM_00000000000','2011-08-31 12:00:00','USRCNFRM_00000000000'),
('BBSMSTR_CCCCCCCCCCCC','SYSTEM_DEFAULT_BOARD','Y','REGC01','2011-08-31 12:00:00','USRCNFRM_00000000000','2011-08-31 12:00:00','USRCNFRM_00000000000');

/*Table structure for table `lettnemplyrinfo` */

DROP TABLE IF EXISTS `lettnemplyrinfo`;

CREATE TABLE `lettnemplyrinfo` (
  `ESNTL_ID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '고유넘버',
  `EMPLYR_ID` varchar(40) NOT NULL COMMENT 'id',
  `PASSWORD` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'password',
  `USER_NM` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'name',
  `MBTLNUM` varchar(20) DEFAULT NULL COMMENT 'phone',
  `ORGNZT_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'organization_id',
  `GRADE` varchar(10) DEFAULT NULL COMMENT 'grade',
  `EMP_UNIQ_NUM` char(20) DEFAULT NULL COMMENT '직원고유번호',
  `EMPLYR_STTUS_CODE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SBSCRB_DE` datetime DEFAULT NULL,
  `EM_ORDER` int DEFAULT '1' COMMENT '공통소유 상위 노출용 ORDER',
  `IHIDNUM` varchar(200) DEFAULT NULL,
  `EMPL_NO` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SEXDSTN_CODE` char(1) DEFAULT NULL,
  `BRTHDY` char(20) DEFAULT NULL,
  `FXNUM` varchar(20) DEFAULT NULL,
  `GROUP_ID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `HOUSE_ADRES` varchar(100) DEFAULT NULL,
  `PSTINST_CODE` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PASSWORD_HINT` varchar(100) DEFAULT NULL,
  `PASSWORD_CNSR` varchar(100) DEFAULT NULL,
  `HOUSE_END_TELNO` varchar(4) DEFAULT NULL,
  `AREA_NO` varchar(4) DEFAULT NULL,
  `DETAIL_ADRES` varchar(100) DEFAULT NULL,
  `ZIP` varchar(6) DEFAULT NULL,
  `OFFM_TELNO` varchar(20) DEFAULT NULL,
  `EMAIL_ADRES` varchar(50) DEFAULT NULL,
  `OFCPS_NM` varchar(60) DEFAULT NULL,
  `HOUSE_MIDDLE_TELNO` varchar(4) DEFAULT NULL,
  `CRTFC_DN_VALUE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ESNTL_ID`,`EMPLYR_ID`),
  KEY `LETTNEMPLYRINFO_ibfk_2` (`GROUP_ID`),
  KEY `LETTNEMPLYRINFO_ibfk_1` (`ORGNZT_ID`),
  CONSTRAINT `LETTNEMPLYRINFO_ibfk_1` FOREIGN KEY (`ORGNZT_ID`) REFERENCES `lettnorgnztinfo` (`ORGNZT_ID`) ON DELETE CASCADE,
  CONSTRAINT `LETTNEMPLYRINFO_ibfk_2` FOREIGN KEY (`GROUP_ID`) REFERENCES `lettnauthorgroupinfo` (`GROUP_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnemplyrinfo` */

insert  into `lettnemplyrinfo`(`ESNTL_ID`,`EMPLYR_ID`,`PASSWORD`,`USER_NM`,`MBTLNUM`,`ORGNZT_ID`,`GRADE`,`EMP_UNIQ_NUM`,`EMPLYR_STTUS_CODE`,`SBSCRB_DE`,`EM_ORDER`,`IHIDNUM`,`EMPL_NO`,`SEXDSTN_CODE`,`BRTHDY`,`FXNUM`,`GROUP_ID`,`HOUSE_ADRES`,`PSTINST_CODE`,`PASSWORD_HINT`,`PASSWORD_CNSR`,`HOUSE_END_TELNO`,`AREA_NO`,`DETAIL_ADRES`,`ZIP`,`OFFM_TELNO`,`EMAIL_ADRES`,`OFCPS_NM`,`HOUSE_MIDDLE_TELNO`,`CRTFC_DN_VALUE`) values 
('USRCNFRM_00000000000','admin','JfQ7FIatlaE5jj7rPYO8QBABX8yb7bNbQy4AKY1QIfc=','관리자','010-1234-5678','MNG2',NULL,NULL,'P','2011-08-02 21:13:03',1,NULL,NULL,NULL,NULL,NULL,'GROUP_00000000000000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

/*Table structure for table `lettnemplyrscrtyestbs` */

DROP TABLE IF EXISTS `lettnemplyrscrtyestbs`;

CREATE TABLE `lettnemplyrscrtyestbs` (
  `SCRTY_DTRMN_TRGET_ID` varchar(20) NOT NULL,
  `MBER_TY_CODE` varchar(15) DEFAULT NULL,
  `AUTHOR_CODE` varchar(30) NOT NULL,
  PRIMARY KEY (`SCRTY_DTRMN_TRGET_ID`),
  KEY `LETTNEMPLYRSCRTYESTBS_ibfk_4` (`AUTHOR_CODE`),
  CONSTRAINT `LETTNEMPLYRSCRTYESTBS_ibfk_4` FOREIGN KEY (`AUTHOR_CODE`) REFERENCES `lettnauthorinfo` (`AUTHOR_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnemplyrscrtyestbs` */

insert  into `lettnemplyrscrtyestbs`(`SCRTY_DTRMN_TRGET_ID`,`MBER_TY_CODE`,`AUTHOR_CODE`) values 
('USRCNFRM_00000000000','','ROLE_HIGH_ADMIN'),

/*Table structure for table `lettnfile` */

DROP TABLE IF EXISTS `lettnfile`;

CREATE TABLE `lettnfile` (
  `ATCH_FILE_ID` char(20) NOT NULL,
  `CREAT_DT` datetime NOT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  PRIMARY KEY (`ATCH_FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnfile` */

/*Table structure for table `lettnfiledetail` */

DROP TABLE IF EXISTS `lettnfiledetail`;

CREATE TABLE `lettnfiledetail` (
  `ATCH_FILE_ID` char(20) NOT NULL,
  `FILE_SN` decimal(10,0) NOT NULL,
  `FILE_STRE_COURS` varchar(2000) NOT NULL,
  `STRE_FILE_NM` varchar(255) NOT NULL,
  `ORIGNL_FILE_NM` varchar(255) DEFAULT NULL,
  `FILE_EXTSN` varchar(20) NOT NULL,
  `FILE_CN` mediumtext,
  `FILE_SIZE` decimal(8,0) DEFAULT NULL,
  `FILE_GROUP` varchar(50) DEFAULT NULL,
  `FILE_TYPE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ATCH_FILE_ID`,`FILE_SN`),
  CONSTRAINT `LETTNFILEDETAIL_ibfk_1` FOREIGN KEY (`ATCH_FILE_ID`) REFERENCES `lettnfile` (`ATCH_FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnfiledetail` */

/*Table structure for table `lettnloginlog` */

DROP TABLE IF EXISTS `lettnloginlog`;

CREATE TABLE `lettnloginlog` (
  `LOG_ID` char(20) NOT NULL,
  `CONECT_ID` varchar(20) DEFAULT NULL,
  `CONECT_IP` varchar(23) DEFAULT NULL,
  `CONECT_MTHD` char(4) DEFAULT NULL,
  `ERROR_OCCRRNC_AT` char(1) DEFAULT NULL,
  `ERROR_CODE` char(3) DEFAULT NULL,
  `CREAT_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnloginlog` */

/*Table structure for table `lettnloginpolicy` */

DROP TABLE IF EXISTS `lettnloginpolicy`;

CREATE TABLE `lettnloginpolicy` (
  `EMPLYR_ID` varchar(20) NOT NULL DEFAULT '',
  `IP_INFO` varchar(23) NOT NULL,
  `DPLCT_PERM_AT` char(1) NOT NULL,
  `LMTT_AT` char(1) NOT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  PRIMARY KEY (`EMPLYR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnloginpolicy` */

/*Table structure for table `lettnmenucreatdtls` */

DROP TABLE IF EXISTS `lettnmenucreatdtls`;

CREATE TABLE `lettnmenucreatdtls` (
  `MENU_NO` decimal(20,0) NOT NULL,
  `AUTHOR_CODE` varchar(30) NOT NULL,
  `MAPNG_CREAT_ID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`MENU_NO`,`AUTHOR_CODE`),
  KEY `R_247` (`MAPNG_CREAT_ID`),
  KEY `R_303` (`AUTHOR_CODE`),
  CONSTRAINT `LETTNMENUCREATDTLS_ibfk_1` FOREIGN KEY (`MENU_NO`) REFERENCES `lettnmenuinfo` (`MENU_NO`) ON DELETE CASCADE,
  CONSTRAINT `LETTNMENUCREATDTLS_ibfk_3` FOREIGN KEY (`AUTHOR_CODE`) REFERENCES `lettnauthorinfo` (`AUTHOR_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnmenucreatdtls` */

insert  into `lettnmenucreatdtls`(`MENU_NO`,`AUTHOR_CODE`,`MAPNG_CREAT_ID`) values 
(100,'ROLE_ADMIN',NULL),
(100,'ROLE_USER_MEMBER',NULL),
(101,'ROLE_ADMIN',NULL),
(101,'ROLE_USER_MEMBER',NULL),
(200,'ROLE_ADMIN',NULL),
(200,'ROLE_HIGH_ADMIN',NULL),
(201,'ROLE_ADMIN',NULL),
(201,'ROLE_HIGH_ADMIN',NULL),
(300,'ROLE_ADMIN',NULL),
(300,'ROLE_USER_MEMBER',NULL),
(301,'ROLE_ADMIN',NULL),
(301,'ROLE_USER_MEMBER',NULL),
(400,'ROLE_ADMIN',NULL),
(400,'ROLE_HIGH_ADMIN',NULL),
(400,'ROLE_USER_MEMBER',NULL),
(401,'ROLE_ADMIN',NULL),
(401,'ROLE_HIGH_ADMIN',NULL),
(401,'ROLE_USER_MEMBER',NULL),
(501,'ROLE_HIGH_ADMIN',NULL),
(501,'ROLE_USER_MEMBER',NULL),
(1000000,'ROLE_ADMIN',NULL),
(1000000,'ROLE_HIGH_ADMIN',NULL),
(1000000,'ROLE_USER_MEMBER',NULL),
(1010000,'ROLE_ADMIN',NULL),
(1010000,'ROLE_HIGH_ADMIN',NULL),
(1010000,'ROLE_USER_MEMBER',NULL),
(2000000,'ROLE_ADMIN',NULL),
(2000000,'ROLE_HIGH_ADMIN',NULL),
(2000000,'ROLE_USER_MEMBER',NULL),
(2010000,'ROLE_ADMIN',NULL),
(2010000,'ROLE_HIGH_ADMIN',NULL),
(2010000,'ROLE_USER_MEMBER',NULL),
(6000000,'ROLE_ADMIN',NULL),
(6000000,'ROLE_HIGH_ADMIN',NULL),
(6010000,'ROLE_ADMIN',NULL),
(6010000,'ROLE_HIGH_ADMIN',NULL),
(6010100,'ROLE_ADMIN',NULL),
(6010100,'ROLE_HIGH_ADMIN',NULL),
(6020300,'ROLE_HIGH_ADMIN',NULL),
(6040000,'ROLE_ADMIN',NULL),
(6040000,'ROLE_HIGH_ADMIN',NULL),
(6050000,'ROLE_ADMIN',NULL),
(6050000,'ROLE_HIGH_ADMIN',NULL),
(6060000,'ROLE_ADMIN',NULL);

/*Table structure for table `lettnmenuinfo` */

DROP TABLE IF EXISTS `lettnmenuinfo`;

CREATE TABLE `lettnmenuinfo` (
  `MENU_NM` varchar(60) NOT NULL,
  `PROGRM_FILE_NM` varchar(60) NOT NULL,
  `MENU_NO` decimal(20,0) NOT NULL,
  `UPPER_MENU_NO` decimal(20,0) DEFAULT NULL,
  `MENU_ORDR` decimal(5,0) NOT NULL,
  `MENU_DC` varchar(250) DEFAULT NULL,
  `RELATE_IMAGE_PATH` varchar(100) DEFAULT NULL,
  `RELATE_IMAGE_NM` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`MENU_NO`),
  KEY `R_2` (`PROGRM_FILE_NM`),
  KEY `R_4` (`UPPER_MENU_NO`),
  CONSTRAINT `LETTNMENUINFO_ibfk_1` FOREIGN KEY (`PROGRM_FILE_NM`) REFERENCES `lettnprogrmlist` (`PROGRM_FILE_NM`) ON DELETE CASCADE,
  CONSTRAINT `LETTNMENUINFO_ibfk_2` FOREIGN KEY (`UPPER_MENU_NO`) REFERENCES `lettnmenuinfo` (`MENU_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnmenuinfo` */

insert  into `lettnmenuinfo`(`MENU_NM`,`PROGRM_FILE_NM`,`MENU_NO`,`UPPER_MENU_NO`,`MENU_ORDR`,`MENU_DC`,`RELATE_IMAGE_PATH`,`RELATE_IMAGE_NM`) values 
('root','dir',0,0,1,'root','/','/'),
('내자산조회','MyAssetManagement',100,0,1,'내자산조회','/','/'),
('내자산조회','MyAssetManagement',101,100,1,'내자산조회','/','/'),
('전체자산조회','AssetManagement',200,0,1,'전체자산조회','/','/'),
('전체자산조회','AssetManagement',201,200,1,'전체자산조회','/','/'),
('신규자산등록','AssetRegist',300,0,1,'신규자산등록','/','/'),
('신규자산등록','AssetRegist',301,300,1,'신규자산등록','/','/'),
('반출입','CarryRequset',400,0,1,'반출입','/','/'),
('반출입','CarryRequset',401,400,1,'반출입','/','/'),
('처분신청조회','DisposeRequest',500,0,1,'파손신청조회','/','/'),
('처분신청조회','DisposeRequest',501,500,1,'파손신청조회','/','/'),
('공지사항','dir',1000000,0,1,'알림정보','/','/'),
('사이트공지','EgovInfoNotice',1010000,1000000,1,'공지사항','/','/'),
('업무게시판','EgovInfoWork',1020000,1000000,2,'업무게시판','/','/'),
('결재요청','dir',2000000,0,2,'결재게시판조회','/','/'),
('결재요청','ApprovalManage',2010000,2000000,1,'결재게시판조회','/','/'),
('사이트관리','dir',6000000,0,6,'내부시스템관리','/','/'),
('사용자관리','EgovUserManage',6010000,6000000,1,'사용자관리','/','/'),
('사용자목록','EgovUserManage',6010100,6010000,1,'사용자목록 전체조회/등록/수정/삭제','/','/'),
('이용권한관리','EgovAuthorManage',6020000,6000000,2,'이용권한관리','/','/'),
('사이트이용권한관리','EgovAuthorManage',6020100,6020000,1,'사이트이용권한','/','/'),
('사용자별권한관리','EgovAuthorRoleManage',6020300,6010000,3,'사용자별권한관리','/','/'),
('메뉴관리','EgovMenuCreatManage',6030000,6000000,3,'메뉴관리','/','/'),
('프로그램목록관리','EgovProgramListManage',6030100,6030000,1,'프로그램목록관리','/','/'),
('메뉴생성관리','EgovMenuCreatManage',6030200,6030000,2,'메뉴생성관리','/','/'),
('메뉴목록관리','EgovMenuManage',6030300,6030000,4,'메뉴목록관리','/','/'),
('카테고리관리','CategoryManage',6040000,6000000,4,'카테고리관리','/','/'),
('카테고리목록관리','CategoryManage',6040100,6040000,1,'카테고리목록관리','/','/'),
('프로젝트관리','ProjectManage',6050000,6000000,5,'프로젝트관리','/','/'),
('프로젝트목록관리','ProjectManage',6050100,6050000,1,'프로젝트목록관리','/','/'),
('중복데이터조회','DistinctManage',6060000,6000000,6,'중복데이터조회','/','/');

/*Table structure for table `lettnorgnztinfo` */

DROP TABLE IF EXISTS `lettnorgnztinfo`;

CREATE TABLE `lettnorgnztinfo` (
  `ORGNZT_ID` varchar(20) NOT NULL DEFAULT '',
  `ORGNZT_NM` varchar(20) NOT NULL,
  `ORGNZT_DC` varchar(100) DEFAULT NULL,
  `ORGNZT_UP` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ORGNZT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnorgnztinfo` */

insert  into `lettnorgnztinfo`(`ORGNZT_ID`,`ORGNZT_NM`,`ORGNZT_DC`,`ORGNZT_UP`) values 
('AUD','사외이사 및 감사',NULL,NULL),
('BSN','사업부문대표',NULL,NULL),
('CEO','대표이사',NULL,NULL),
('DIH','디지털혁신 본부',NULL,NULL),
('DIH1','기술연구소1',NULL,'DIH'),
('DIH2','클라우드 센터',NULL,'DIH'),
('DIH3','디지털혁신지원부',NULL,'DIH'),
('DPH','디지털플랫폼 본부',NULL,NULL),
('DPH1','마케팅 기획부',NULL,'DPH'),
('DPH2','에너지/재정 사업부',NULL,'DPH'),
('DPH3','공금융 사업부',NULL,'DPH'),
('ETC','기타',NULL,NULL),
('FIN','핀테크본부',NULL,NULL),
('FIN1','금융 영업부',NULL,'FIN'),
('FIN2','Neo Tech 사업부',NULL,'FIN'),
('FIN3','Digital Finance 사업부',NULL,'FIN'),
('FIN4','차세대추진전략 TF',NULL,'FIN'),
('FIN5','Smart Securities TF',NULL,'FIN'),
('MNG','경영관리실',NULL,NULL),
('MNG1','전략기획팀',NULL,'MNG'),
('MNG2','인사총무팀',NULL,'MNG'),
('MNG3','재무회계팀',NULL,'MNG'),
('NBS','신사업실',NULL,NULL),
('RBH','지역사업본부',NULL,NULL),
('RBH1','본부지원부',NULL,'RBH'),
('RBH2','영남사업부',NULL,'RBH'),
('RBH3','호남사업부',NULL,'RBH'),
('SMT','스마트헬스케어 본부',NULL,NULL),
('SMT1','헬스케어혁신 성장부',NULL,'SMT'),
('SMT2','스마트헬스케어 사업부',NULL,'SMT');

/*Table structure for table `lettnprogrmlist` */

DROP TABLE IF EXISTS `lettnprogrmlist`;

CREATE TABLE `lettnprogrmlist` (
  `PROGRM_FILE_NM` varchar(60) NOT NULL DEFAULT '',
  `PROGRM_STRE_PATH` varchar(100) NOT NULL,
  `PROGRM_KOREAN_NM` varchar(60) DEFAULT NULL,
  `PROGRM_DC` varchar(200) DEFAULT NULL,
  `URL` varchar(100) NOT NULL,
  PRIMARY KEY (`PROGRM_FILE_NM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnprogrmlist` */

insert  into `lettnprogrmlist`(`PROGRM_FILE_NM`,`PROGRM_STRE_PATH`,`PROGRM_KOREAN_NM`,`PROGRM_DC`,`URL`) values 
('ApprovalManage','/aprv','결재목록조회','결재목록조회','/aprv/ApprovalManage.do'),
('AssetInsert','/ass','자산등록','자산등록','/ass/AssetInsert.do'),
('AssetManagement','/ass','자산관리','자산조회','/ass/AssetManagement.do'),
('AssetRegist','/ass','자산등록','자산등록','/ass/AssetRegist.do'),
('CarryRequset','/req','반출/반입신청조회','반출/반입신청조회','/req/CarryRequset.do'),
('CategoryManage','/cat','카테고리목록관리','카테고리목록관리','/cat/CategoryManage.do'),
('dir','/','디렉토리','디렉토리','/'),
('DisposeRequest','/req','처분신청조회','처분신청조회','/req/DisposeRequest.do'),
('DistinctManage','/ass/','중복데이터조회','시리얼넘버중복 조회','/ass/DistinctManage.do'),
('EgovAuthorGroupManage','/sec/rgm/','권한그룹관리','권한그룹관리','/sec/rgm/EgovAuthorGroupListView.do'),
('EgovAuthorInsert','/sec/ram/','권한등록','권한등록','/sec/ram/EgovAuthorInsertView.do'),
('EgovAuthorManage','/sec/ram/','권한관리','권한관리','/sec/ram/EgovAuthorList.do'),
('EgovAuthorRoleManage','/sec/ram/','사용자별권한관리','사용자별권한롤관리','/sec/rgm/EgovAuthorGroupListView.do'),
('EgovAuthorUpdt','/sec/ram/','권한수정','권한수정','/sec/ram/EgovAuthor.do'),
('EgovBoardMstrList','/cop/bbs/','게시판 목록조회','게시판 목록조회','/cop/bbs/SelectBBSMasterInfs.do'),
('EgovBoardMstrRegist','/cop/bbs/','게시판 생성','게시판 생성','/cop/bbs/addBBSMaster.do'),
('EgovBoardMstrUpdt','/cop/bbs/','게시판 수정','게시판 수정','/cop/bbs/SelectBBSMasterInf.do'),
('EgovBoardUseInfInqire','/cop/com/','게시판사용여부 상세조회','게시판사용여부 상세조회','/cop/com/selectBBSUseInf.do'),
('EgovBoardUseInfList','/cop/com/','게시판사용여부 목록 조회','게시판사용여부 목록 조회','/cop/com/selectBBSUseInfs.do'),
('EgovBoardUseInfRegist','/cop/com/','게시판사용여부 등록','게시판사용여부 등록','/cop/com/addBBSUseInf.do'),
('EgovCcmCmmnClCodeDetail','/sym/ccm/ccc/','공통분류코드 상세조회','공통분류코드 상세조회','/sym/ccm/ccc/EgovCcmCmmnClCodeDetail.do'),
('EgovCcmCmmnClCodeList','/sym/ccm/ccc/','공통분류코드목록 조회','공통분류코드목록 조회','/sym/ccm/ccc/EgovCcmCmmnClCodeList.do'),
('EgovCcmCmmnClCodeModify','/sym/ccm/ccc/','공통분류코드 수정','공통분류코드 수정','/sym/ccm/ccc/EgovCcmCmmnClCodeModify.do'),
('EgovCcmCmmnClCodeRegist','/sym/ccm/ccc/','공통분류코드 등록','공통분류코드 등록','/sym/ccm/ccc/EgovCcmCmmnClCodeRegist.do'),
('EgovCcmCmmnCodeDetail','/sym/ccm/cca/','공통코드 상세조회','공통코드 상세조회','/sym/ccm/cca/EgovCcmCmmnCodeDetail.do'),
('EgovCcmCmmnCodeList','/sym/ccm/cca/','공통코드목록 조회','공통코드목록 조회','/sym/ccm/cca/EgovCcmCmmnCodeList.do'),
('EgovCcmCmmnCodeModify','/sym/ccm/cca/','공통코드 수정','공통코드 수정','/sym/ccm/cca/EgovCcmCmmnCodeModify.do'),
('EgovCcmCmmnCodeRegist','/sym/ccm/cca/','공통코드 등록','공통코드 등록','/sym/ccm/cca/EgovCcmCmmnCodeRegist.do'),
('EgovCcmCmmnDetailCodeDetail','/sym/ccm/cde/','공통상세코드 상세조회','공통상세코드 상세조회','/sym/ccm/cde/EgovCcmCmmnDetailCodeDetail.do'),
('EgovCcmCmmnDetailCodeList','/sym/ccm/cde/','공통상세코드목록 조회','공통상세코드목록 조회','/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do'),
('EgovCcmCmmnDetailCodeModify','/sym/ccm/cde/','공통상세코드 수정','공통상세코드 수정','/sym/ccm/cde/EgovCcmCmmnDetailCodeModify.do'),
('EgovCcmCmmnDetailCodeRegist','/sym/ccm/cde/','공통상세코드 등록','공통상세코드 등록','/sym/ccm/cde/EgovCcmCmmnDetailCodeRegist.do'),
('EgovCcmExcelZipRegist','/sym/ccm/zip/','우편번호 엑셀파일 등록','우편번호 엑셀파일 등록','/sym/ccm/zip/EgovCcmExcelZipRegist.do'),
('EgovCcmZipDetail','/sym/ccm/zip/','우편번호 상세조회','우편번호 상세조회','/sym/ccm/zip/EgovCcmZipDetail.do'),
('EgovCcmZipList','/sym/ccm/zip/','우편번호목록 조회','우편번호목록 조회','/sym/ccm/zip/EgovCcmZipList.do'),
('EgovCcmZipModify','/sym/ccm/zip/','우편번호 수정','우편번호 수정','/sym/ccm/zip/EgovCcmZipModify.do'),
('EgovCcmZipRegist','/sym/ccm/zip/','우편번호 등록','우편번호 등록','/sym/ccm/zip/EgovCcmZipRegist.do'),
('EgovCcmZipSearchPopup','/sym/cmm/','우편번호 찾기','우편번호 찾기','/sym/cmm/EgovCcmZipSearchPopup.do'),
('EgovConectStats','/sts/cst/','접속통계','접속통계','/sts/cst/selectConectStats.do'),
('EgovFileNmSearch','/sym/prm/','파일명검색','파일명검색','/sym/prm/EgovProgramListSearch.do'),
('EgovGroupInsert','/sec/gmt/','그룹등록','그룹등록','/sec/gmt/EgovGroupInsertView.do'),
('EgovGroupManage','/sec/gmt/','그룹관리','그룹관리','/sec/gmt/EgovGroupList.do'),
('EgovGroupUpdt','/sec/gmt/','그룹수정','그룹수정','/sec/gmt/EgovGroup.do'),
('EgovIdDplctCnfirm','/uss/umt/cmm/','아이디중복확인','아이디중복확인','/uss/umt/cmm/EgovIdDplctCnfirmView.do'),
('EgovInfoNotice','/cop/bbs/','공지사항','공지사항','/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'),
('EgovInfoNoticeAdmin','/cop/bbs/admin/','공지사항관리','공지사항관리','/cop/bbs/admin/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'),
('EgovInfoWork','/cop/bbs/','업무게시판','업무게시판','/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_CCCCCCCCCCCC'),
('EgovInfoWorkAdmin','/cop/bbs/admin/','업무게시판관리','업무게시판관리','/cop/bbs/admin/selectBoardList.do?bbsId=BBSMSTR_CCCCCCCCCCCC'),
('EgovJoinHistory','/','입퇴사정보 관리','입퇴사정보 관리','/EgovPageLink.do?link=main/sample_menu/Sample'),
('EgovLoginLogInqire','/sym/log/clg/','로그인로그상세조회','로그인로그상세조회','/sym/log/clg/SelectLoginLogList.do'),
('EgovLoginLogList','/sym/log/clg/','로그인로그조회','로그인로그조회','/sym/log/clg/SelectLoginLogList.do'),
('EgovLoginPolicyList','/uat/uap/','로그인정책관리','로그인정책관리','/uat/uap/selectLoginPolicyList.do'),
('EgovLoginPolicyRegist','/uat/uap/','로그인정책등록','로그인정책등록','/uat/uap/getLoginPolicy.do'),
('EgovLoginPolicyUpdt','/uat/uia/','로그인정책수정','로그인정책수정','/uat/uap/getLoginPolicy.do'),
('EgovLoginUsr','/uat/uia/','내부업무 로그인','내부업무 로그인','/uat/uia/egovLoginUsr.do'),
('EgovMainHome','/uat/uia/','내부업무 메인','내부업무 메인','/uat/uia/actionMain.do'),
('EgovMberPositionl','/','직위정보 관리','직위정보 관리','/EgovPageLink.do?link=main/sample_menu/Sample'),
('EgovMberRank','/','직급정보 관리','직급정보 관리','/EgovPageLink.do?link=main/sample_menu/Sample'),
('EgovMenuBndeRegist','/sym/mnu/mpm/','메뉴일괄등록','메뉴일괄등록','/sym/mnu/mpm/EgovMenuBndeRegist.do'),
('EgovMenuCreat','/sym/mnu/mcm/','메뉴생성','메뉴생성','/sym/mnu/mcm/EgovMenuCreatSelect.do'),
('EgovMenuCreatManage','/sym/mnu/mcm/','메뉴생성관리','메뉴생성관리','/sym/mnu/mcm/EgovMenuCreatManageSelect.do'),
('EgovMenuDetailSelectUpdt','/sym/mnu/mpm/','메뉴상세조회/수정','메뉴상세조회/수정','/sym/mnu/mpm/EgovMenuManageListDetailSelect.do'),
('EgovMenuManage','/sym/mnu/mpm/','메뉴관리','메뉴관리','/sym/mnu/mpm/EgovMenuManageSelect.do'),
('EgovMenuRegist','/sym/mnu/mpm/','메뉴등록','메뉴등록','/sym/mnu/mpm/EgovMenuRegistInsert.do'),
('EgovNoticeInqire','/cop/bbs/','게시물조회','게시물조회','/cop/bbs/selectBoardArticle.do'),
('EgovNoticeList','/cop/bbs/','게시물 목록','게시물 목록','/cop/bbs/selectBoardList.do'),
('EgovNoticeRegist','/cop/bbs/','게시물 등록','게시물 등록','/cop/bbs/addBoardArticle.do'),
('EgovNoticeReply','/cop/bbs/','답글 작성','답글 작성','/cop/bbs/addReplyBoardArticle.do'),
('EgovNoticeUpdt','/cop/bbs/','게시물 수정','게시물 수정','/cop/bbs/forUpdateBoardArticle.do'),
('EgovProgramListDetailSelectUpdt','/sym/prm/','프로그램목록상세조회/수정','프로그램목록상세조회/수정','/sym/prm/EgovProgramListDetailSelect.do'),
('EgovProgramListManage','/sym/prm/','프로그램목록관리','프로그램목록관리','/sym/prm/EgovProgramListManageSelect.do'),
('EgovProgramListRegist','/sym/prm/','프로그램목록등록','프로그램목록등록','/sym/prm/EgovProgramListRegist.do'),
('EgovRoleInsert','/sec/rmt/','롤등록','롤등록','/sec/rmt/EgovRoleInsertView.do'),
('EgovRoleManage','/sec/rmt/','롤관리','롤관리','/sec/rmt/EgovRoleList.do'),
('EgovRoleUpdt','/sec/rmt/','롤수정','롤수정','/sec/rmt/EgovRole.do'),
('EgovTemplateInqirePopup','/cop/com/','템플릿 조회팝업','템플릿 조회팝업','/cop/com/selectTemplateInfs.do'),
('EgovTemplateList','/cop/com/','템플릿 목록 조회','템플릿 목록 조회','/cop/com/selectTemplateInfs.do'),
('EgovTemplateRegist','/cop/com/','템플릿 등록','템플릿 등록','/cop/com/addTemplateInf.do'),
('EgovTemplateUpdt','/cop/com/','템플릿 수정','템플릿 수정','/cop/com/selectTemplateInf.do'),
('EgovUserAbsnceList','/uss/ion/uas/','사용자부재관리','사용자부재관리','/uss/ion/uas/selectUserAbsnceListView.do'),
('EgovUserAbsnceRegist','/uss/ion/uas/','사용자부재등록','사용자부재등록','/uss/ion/uas/addViewUserAbsnce.do'),
('EgovUserAbsnceUpdt','/uss/ion/uas/','사용자부재수정','사용자부재수정','/uss/ion/uas/getUserAbsnce.do'),
('EgovUserInsert','/uss/umt/user/','사용자등록','사용자등록','/uss/umt/user/EgovUserInsertView.do'),
('EgovUserManage','/uss/umt/user/','사용자관리(조회,삭제)','사용자관리(조회,삭제)','/uss/umt/user/EgovUserManage.do'),
('EgovUserPasswordUpdt','/uss/umt/user/','사용자암호수정','사용자암호수정','/uss/umt/user/EgovUserPasswordUpdtView.do'),
('EgovUserSelectUpdt','/uss/umt/user/','사용자상세조회,수정','사용자상세조회,수정','/uss/umt/user/EgovUserSelectUpdtView.do'),
('EgovWorkAttendance','/','출퇴근정보 관리','출퇴근정보 관리','/EgovPageLink.do?link=main/sample_menu/Sample'),
('EgovWorkAward','/','상벌정보 관리','상벌정보 관리','/EgovPageLink.do?link=main/sample_menu/Sample'),
('EgovWorkEstimation','/','업무평가점수 관리','업무평가점수 관리','/EgovPageLink.do?link=main/sample_menu/Sample'),
('EgovWorkVacation','/','휴무정보 관리','휴무정보 관리','/EgovPageLink.do?link=main/sample_menu/Sample'),
('GetMCategoryList','/cat','중분류조회','대분류에 해당하는 중분류 조회','/cat/GetMCategoryList.do'),
('MyAssetManagement','/ass','내자산조회','내자산조회','/ass/MyAssetManagement.do'),
('MyManage','/uss/myp','마이페이지','마이페이지','/uss/myp/MyManage.do'),
('ProjectManage','/prj','프로젝트목록관리','프로젝트목록관리','/prj/ProjectManage.do'),
('ProjectSearchList','/prj','프로젝트 검색','프로젝트 검색','/prj/ProjectSearchList.do'),
('RepairRequest','/req','파손내역조회','파손내역조회','/req/RepairRequest.do'),
('SearchUserList','/uss/umt/user','회원 검색','회원 검색','/uss/umt/user/SearchUserList.do');

/*Table structure for table `lettnqstn` */

DROP TABLE IF EXISTS `lettnqstn`;

CREATE TABLE `lettnqstn` (
  `NTT_ID` decimal(20,0) NOT NULL,
  `BBS_ID` char(20) NOT NULL,
  `NTT_NO` decimal(20,0) DEFAULT NULL,
  `NTT_SJ` varchar(2000) DEFAULT NULL,
  `NTT_CN` mediumtext,
  `ANSWER_AT` char(1) DEFAULT NULL,
  `PARNTSCTT_NO` decimal(10,0) DEFAULT NULL,
  `ANSWER_LC` int DEFAULT NULL,
  `SORT_ORDR` decimal(8,0) DEFAULT NULL,
  `RDCNT` decimal(10,0) DEFAULT NULL,
  `USE_AT` char(1) NOT NULL,
  `NTCE_BGNDE` char(20) DEFAULT NULL,
  `NTCE_ENDDE` char(20) DEFAULT NULL,
  `NTCR_ID` varchar(20) DEFAULT NULL,
  `NTCR_NM` varchar(20) DEFAULT NULL,
  `PASSWORD` varchar(200) DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime NOT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`NTT_ID`,`BBS_ID`),
  KEY `LETTNBBS_ibfk_1` (`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnqstn` */

/*Table structure for table `lettnroleinfo` */

DROP TABLE IF EXISTS `lettnroleinfo`;

CREATE TABLE `lettnroleinfo` (
  `ROLE_CODE` varchar(50) NOT NULL DEFAULT '',
  `ROLE_NM` varchar(60) NOT NULL,
  `ROLE_PTTRN` varchar(300) DEFAULT NULL,
  `ROLE_DC` varchar(200) DEFAULT NULL,
  `ROLE_TY` varchar(80) DEFAULT NULL,
  `ROLE_SORT` varchar(10) DEFAULT NULL,
  `ROLE_CREAT_DE` char(20) NOT NULL,
  PRIMARY KEY (`ROLE_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnroleinfo` */

insert  into `lettnroleinfo`(`ROLE_CODE`,`ROLE_NM`,`ROLE_PTTRN`,`ROLE_DC`,`ROLE_TY`,`ROLE_SORT`,`ROLE_CREAT_DE`) values 
('cop-bbs','cop-bbs','/cop/bbs/.*.do.*','게시판','url','1','2011-08-31 15:41:24'),
('cop-com','cop-com','/cop/com/.*.do.*','게시판사용','url','2','2011-08-24 0:00'),
('sec-gmt','sec-gmt','/sec/gmt/.*.do.*','그룹관리','url','3','2011-08-24 0:00'),
('sec-ram','sec-ram','/sec/ram/.*.do.*','권한관리','url','4','2011-08-24 0:00'),
('sec-rgm','sec-rgm','/sec/rgm/.*.do.*','권한그룹관리','url','5','2011-08-24 0:00'),
('sec-rmt','sec-rmt','/sec/rmt/.*.do.*','롤관리','url','6','2011-08-24 0:00'),
('sts-cst','sts-cst','/sts/cst/.*.do.*','접속통계','url','7','2011-08-24 0:00'),
('sym-ccm-cca','sym-ccm-cca','/sym/ccm/cca/.*.do.*','공통코드 등록','url','8','2011-08-24 0:00'),
('sym-ccm-ccc','sym-ccm-ccc','/sym/ccm/ccc/.*.do.*','공통분류코드 상세조회','url','9','2011-08-24 0:00'),
('sym-ccm-cde','sym-ccm-cde','/sym/ccm/cde/.*.do.*','공통상세코드 등록','url','10','2011-08-24 0:00'),
('sym-ccm-zip','sym-ccm-zip','/sym/ccm/zip/.*.do.*','우편번호','url','11','2011-08-24 0:00'),
('sym-cmm','sym-cmm','/sym/cmm/.*.do.*','우편번호 찾기','url','12','2011-08-24 0:00'),
('sym-log-clg','sym-log-clg','/sym/log/clg/.*.do.*','로그인로그조회','url','13','2011-08-24 0:00'),
('sym-mnu-mcm','sym-mnu-mcm','/sym/mnu/mcm/.*.do.*','메뉴생성관리','url','14','2011-08-24 0:00'),
('sym-mnu-mpm','sym-mnu-mpm','/sym/mnu/mpm/.*.do.*','메뉴관리','url','15','2011-08-24 0:00'),
('sym-prm','sym-prm','/sym/prm/.*.do.*','프로그램목록관리','url','16','2011-08-24 0:00'),
('uat-uap','uat-uap','/uat/uap/.*.do.*','로그인정책관리','url','17','2011-08-24 0:00'),
('uat-uia','uat-uia','/uat/uia/.*.do.*','로그인메인','url','18','2011-08-24 0:00'),
('uss-ion-uas','uss-ion-uas','/uss/ion/uas/.*.do.*','사용자부재관리','url','19','2011-08-24 0:00'),
('uss-umt-cmm','uss-umt-cmm','/uss/umt/cmm/.*.do.*','아이디중복확인','url','20','2011-08-24 0:00'),
('uss-umt-user','uss-umt-user','/uss/umt/user/.*.do.*','사용자등록','url','21','2011-08-24 0:00');

/*Table structure for table `lettnroles_hierarchy` */

DROP TABLE IF EXISTS `lettnroles_hierarchy`;

CREATE TABLE `lettnroles_hierarchy` (
  `PARNTS_ROLE` varchar(30) NOT NULL,
  `CHLDRN_ROLE` varchar(30) NOT NULL,
  PRIMARY KEY (`PARNTS_ROLE`,`CHLDRN_ROLE`),
  KEY `R_308` (`CHLDRN_ROLE`),
  CONSTRAINT `LETTNROLES_HIERARCHY_ibfk_1` FOREIGN KEY (`PARNTS_ROLE`) REFERENCES `lettnauthorinfo` (`AUTHOR_CODE`) ON DELETE CASCADE,
  CONSTRAINT `LETTNROLES_HIERARCHY_ibfk_2` FOREIGN KEY (`CHLDRN_ROLE`) REFERENCES `lettnauthorinfo` (`AUTHOR_CODE`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnroles_hierarchy` */

insert  into `lettnroles_hierarchy`(`PARNTS_ROLE`,`CHLDRN_ROLE`) values 
('ROLE_USER_MEMBER','ROLE_ADMIN'),
('ROLE_ADMIN','ROLE_HIGH_ADMIN');

/*Table structure for table `lettntmplatinfo` */

DROP TABLE IF EXISTS `lettntmplatinfo`;

CREATE TABLE `lettntmplatinfo` (
  `TMPLAT_ID` char(20) NOT NULL DEFAULT '',
  `TMPLAT_NM` varchar(255) DEFAULT NULL,
  `TMPLAT_COURS` varchar(2000) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `TMPLAT_SE_CODE` char(6) DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  PRIMARY KEY (`TMPLAT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettntmplatinfo` */

insert  into `lettntmplatinfo`(`TMPLAT_ID`,`TMPLAT_NM`,`TMPLAT_COURS`,`USE_AT`,`TMPLAT_SE_CODE`,`FRST_REGISTER_ID`,`FRST_REGIST_PNTTM`,`LAST_UPDUSR_ID`,`LAST_UPDT_PNTTM`) values 
('TMPLAT_BOARD_DEFAULT','게시판 기본템플릿','/css/egovframework/cop/bbs/egovbbsTemplate.css','Y','TMPT01','USRCNFRM_00000000000','2011-08-02 21:01:59','USRCNFRM_00000000000','2011-08-08 16:12:57');

/*Table structure for table `lettnuserabsnce` */

DROP TABLE IF EXISTS `lettnuserabsnce`;

CREATE TABLE `lettnuserabsnce` (
  `EMPLYR_ID` varchar(20) NOT NULL DEFAULT '',
  `USER_ABSNCE_AT` char(1) NOT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `FRST_REGIST_PNTTM` datetime DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDT_PNTTM` datetime DEFAULT NULL,
  PRIMARY KEY (`EMPLYR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettnuserabsnce` */

/*Table structure for table `lettssyslogsummary` */

DROP TABLE IF EXISTS `lettssyslogsummary`;

CREATE TABLE `lettssyslogsummary` (
  `OCCRRNC_DE` char(20) NOT NULL,
  `SRVC_NM` varchar(255) NOT NULL,
  `METHOD_NM` varchar(60) NOT NULL,
  `CREAT_CO` decimal(10,0) DEFAULT NULL,
  `UPDT_CO` decimal(10,0) DEFAULT NULL,
  `RDCNT` decimal(10,0) DEFAULT NULL,
  `DELETE_CO` decimal(10,0) DEFAULT NULL,
  `OUTPT_CO` decimal(10,0) DEFAULT NULL,
  `ERROR_CO` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`OCCRRNC_DE`,`SRVC_NM`,`METHOD_NM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `lettssyslogsummary` */

/*Table structure for table `media` */

DROP TABLE IF EXISTS `media`;

CREATE TABLE `media` (
  `MEDIA_ID` varchar(30) NOT NULL,
  `GROUP_ID` varchar(30) NOT NULL,
  `FILE_NAME` varchar(200) NOT NULL,
  `FILE_ROUTE` varchar(1000) NOT NULL,
  `MEDIA_NAME` varchar(200) NOT NULL,
  `MEDIA_ORDER` int NOT NULL,
  `MEDIA_STATUS` varchar(30) NOT NULL,
  PRIMARY KEY (`MEDIA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `media` */

/*Table structure for table `projects` */

DROP TABLE IF EXISTS `projects`;

CREATE TABLE `projects` (
  `PRJ_ID` varchar(15) NOT NULL,
  `PRJ_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PRJ_NAME` varchar(50) NOT NULL,
  `PRJ_START` varchar(20) DEFAULT NULL,
  `PRJ_END` varchar(20) DEFAULT NULL,
  `ID` varchar(40) NOT NULL,
  `CLIENT` varchar(30) DEFAULT NULL,
  `PRJ_STATE` varchar(10) DEFAULT 'P0',
  PRIMARY KEY (`PRJ_ID`),
  KEY `FK_MEMBERS_TO_PROJECTS_1` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `projects` */

/*Table structure for table `requestdetail` */

DROP TABLE IF EXISTS `requestdetail`;

CREATE TABLE `requestdetail` (
  `RED_ID` varchar(20) NOT NULL,
  `REQ_ID` varchar(20) DEFAULT NULL,
  `ASSET_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `REQ_ORDER` int DEFAULT NULL,
  PRIMARY KEY (`RED_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `requestdetail` */

/*Table structure for table `requests` */

DROP TABLE IF EXISTS `requests`;

CREATE TABLE `requests` (
  `REQ_ID` varchar(20) NOT NULL,
  `ID` varchar(40) NOT NULL,
  `PRJ_ID` varchar(10) DEFAULT NULL,
  `PM` varchar(20) DEFAULT NULL,
  `START_DATE` varchar(20) DEFAULT NULL,
  `END_DATE` varchar(20) DEFAULT NULL,
  `PLACE` varchar(30) DEFAULT NULL,
  `REQ_DATE` datetime DEFAULT CURRENT_TIMESTAMP,
  `REQ_GROUP` varchar(20) DEFAULT NULL,
  `REQ_STATUS` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'A0',
  PRIMARY KEY (`REQ_ID`),
  KEY `FK_MEMBERS_TO_REQUESTS_1` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `requests` */

/*Table structure for table `tb_timezone` */

DROP TABLE IF EXISTS `tb_timezone`;

CREATE TABLE `tb_timezone` (
  `fd_datetime` datetime DEFAULT NULL,
  `fd_timestamp` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tb_timezone` */

/*Table structure for table `comvnusermaster` */

DROP TABLE IF EXISTS `comvnusermaster`;

/*!50001 DROP VIEW IF EXISTS `comvnusermaster` */;
/*!50001 DROP TABLE IF EXISTS `comvnusermaster` */;

/*!50001 CREATE TABLE  `comvnusermaster`(
 `ESNTL_ID` char(20) ,
 `USER_ID` varchar(40) ,
 `PASSWORD` varchar(200) ,
 `USER_NM` varchar(20) ,
 `USER_ZIP` varchar(6) ,
 `USER_ADRES` varchar(100) ,
 `USER_EMAIL` varchar(50) ,
 `GROUP_ID` char(20) ,
 `USER_SE` varchar(3) ,
 `ORGNZT_ID` varchar(20) 
)*/;

/*View structure for view comvnusermaster */

/*!50001 DROP TABLE IF EXISTS `comvnusermaster` */;
/*!50001 DROP VIEW IF EXISTS `comvnusermaster` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `comvnusermaster` (`ESNTL_ID`,`USER_ID`,`PASSWORD`,`USER_NM`,`USER_ZIP`,`USER_ADRES`,`USER_EMAIL`,`GROUP_ID`,`USER_SE`,`ORGNZT_ID`) AS select `lettnemplyrinfo`.`ESNTL_ID` AS `ESNTL_ID`,`lettnemplyrinfo`.`EMPLYR_ID` AS `EMPLYR_ID`,`lettnemplyrinfo`.`PASSWORD` AS `PASSWORD`,`lettnemplyrinfo`.`USER_NM` AS `USER_NM`,`lettnemplyrinfo`.`ZIP` AS `ZIP`,`lettnemplyrinfo`.`HOUSE_ADRES` AS `HOUSE_ADRES`,`lettnemplyrinfo`.`EMAIL_ADRES` AS `EMAIL_ADRES`,`lettnemplyrinfo`.`GROUP_ID` AS `GROUP_ID`,'USR' AS `USER_SE`,`lettnemplyrinfo`.`ORGNZT_ID` AS `ORGNZT_ID` from `lettnemplyrinfo` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
