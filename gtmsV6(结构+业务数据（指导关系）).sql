/*
Navicat MySQL Data Transfer

Source Server         : MySql
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : gtms

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2014-05-14 22:27:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
INSERT INTO `act_ge_property` VALUES ('next.dbid', '1', '1');
INSERT INTO `act_ge_property` VALUES ('schema.history', 'create(5.15)', '1');
INSERT INTO `act_ge_property` VALUES ('schema.version', '5.15', '1');

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_group
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_membership
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------

-- ----------------------------
-- Table structure for institute
-- ----------------------------
DROP TABLE IF EXISTS `institute`;
CREATE TABLE `institute` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `institute_name_` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of institute
-- ----------------------------
INSERT INTO `institute` VALUES ('1', '商学院');
INSERT INTO `institute` VALUES ('2', '会计与金融学院');
INSERT INTO `institute` VALUES ('3', '计算机学院');

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `major_name_` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES ('1', '信息管理与信息系统');
INSERT INTO `major` VALUES ('2', '会计');
INSERT INTO `major` VALUES ('3', '市场营销');

-- ----------------------------
-- Table structure for mark
-- ----------------------------
DROP TABLE IF EXISTS `mark`;
CREATE TABLE `mark` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date_` date DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `lecture_grade_` int(11) DEFAULT '0',
  `total_grade_` int(11) DEFAULT '0',
  `tutor_grade_` int(11) DEFAULT '0',
  `uuid_` varchar(255) DEFAULT NULL,
  `viewer_grade_` int(11) DEFAULT '0',
  `user_id_` bigint(20) DEFAULT NULL,
  `student_id_` bigint(20) DEFAULT NULL,
  `tutor_id_` bigint(20) DEFAULT NULL,
  `viewer_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FK3306CDC83E8594` (`user_id_`),
  KEY `FK3306CDE3C6DCA2` (`student_id_`),
  KEY `FK3306CDD6BC45C4` (`tutor_id_`),
  KEY `FK3306CD213512A0` (`viewer_id_`),
  CONSTRAINT `FK3306CD213512A0` FOREIGN KEY (`viewer_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK3306CDC83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FK3306CDD6BC45C4` FOREIGN KEY (`tutor_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK3306CDE3C6DCA2` FOREIGN KEY (`student_id_`) REFERENCES `student` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mark
-- ----------------------------

-- ----------------------------
-- Table structure for midcheck
-- ----------------------------
DROP TABLE IF EXISTS `midcheck`;
CREATE TABLE `midcheck` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date_` date DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `first_content_` text,
  `second_content_` text,
  `third_content_` text,
  `user_id_` bigint(20) DEFAULT NULL,
  `teacher_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FK9BD3FBA0C83E8594` (`user_id_`),
  KEY `FK9BD3FBA0D4924470` (`teacher_id_`),
  CONSTRAINT `FK9BD3FBA0D4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK9BD3FBA0C83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of midcheck
-- ----------------------------

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `url_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', '/security/');
INSERT INTO `resource` VALUES ('2', '/process/');
INSERT INTO `resource` VALUES ('3', '/process/task!findPage.action');
INSERT INTO `resource` VALUES ('4', '/druid/index.html');
INSERT INTO `resource` VALUES ('5', '/manageMajor/teacher!findPage.action');
INSERT INTO `resource` VALUES ('6', '/thesis/');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员');
INSERT INTO `role` VALUES ('2', '领导小组');
INSERT INTO `role` VALUES ('3', '工作小组');
INSERT INTO `role` VALUES ('4', '指导老师');
INSERT INTO `role` VALUES ('5', '评阅老师');
INSERT INTO `role` VALUES ('6', '学生');

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource` (
  `role_id_` bigint(20) NOT NULL,
  `resource_id_` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id_`,`resource_id_`),
  KEY `FKAEE599B7FB2DE81A` (`resource_id_`),
  KEY `FKAEE599B7C83B616A` (`role_id_`),
  CONSTRAINT `FKAEE599B7C83B616A` FOREIGN KEY (`role_id_`) REFERENCES `role` (`id_`),
  CONSTRAINT `FKAEE599B7FB2DE81A` FOREIGN KEY (`resource_id_`) REFERENCES `resource` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES ('1', '1');
INSERT INTO `role_resource` VALUES ('1', '2');
INSERT INTO `role_resource` VALUES ('1', '3');
INSERT INTO `role_resource` VALUES ('2', '3');
INSERT INTO `role_resource` VALUES ('3', '3');
INSERT INTO `role_resource` VALUES ('4', '3');
INSERT INTO `role_resource` VALUES ('5', '3');
INSERT INTO `role_resource` VALUES ('6', '3');
INSERT INTO `role_resource` VALUES ('1', '4');
INSERT INTO `role_resource` VALUES ('3', '5');
INSERT INTO `role_resource` VALUES ('2', '6');
INSERT INTO `role_resource` VALUES ('3', '6');
INSERT INTO `role_resource` VALUES ('4', '6');
INSERT INTO `role_resource` VALUES ('5', '6');

-- ----------------------------
-- Table structure for role_user
-- ----------------------------
DROP TABLE IF EXISTS `role_user`;
CREATE TABLE `role_user` (
  `role_id_` bigint(20) NOT NULL,
  `user_id_` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id_`,`user_id_`),
  KEY `FK1407FDF4C83E8594` (`user_id_`),
  KEY `FK1407FDF4C83B616A` (`role_id_`),
  CONSTRAINT `FK1407FDF4C83B616A` FOREIGN KEY (`role_id_`) REFERENCES `role` (`id_`),
  CONSTRAINT `FK1407FDF4C83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_user
-- ----------------------------
INSERT INTO `role_user` VALUES ('1', '1');
INSERT INTO `role_user` VALUES ('3', '2');
INSERT INTO `role_user` VALUES ('4', '2');
INSERT INTO `role_user` VALUES ('5', '2');
INSERT INTO `role_user` VALUES ('2', '3');
INSERT INTO `role_user` VALUES ('4', '3');
INSERT INTO `role_user` VALUES ('5', '3');
INSERT INTO `role_user` VALUES ('4', '4');
INSERT INTO `role_user` VALUES ('5', '4');
INSERT INTO `role_user` VALUES ('4', '5');
INSERT INTO `role_user` VALUES ('5', '5');
INSERT INTO `role_user` VALUES ('4', '6');
INSERT INTO `role_user` VALUES ('5', '6');
INSERT INTO `role_user` VALUES ('4', '7');
INSERT INTO `role_user` VALUES ('5', '7');
INSERT INTO `role_user` VALUES ('4', '8');
INSERT INTO `role_user` VALUES ('5', '8');
INSERT INTO `role_user` VALUES ('4', '9');
INSERT INTO `role_user` VALUES ('5', '9');
INSERT INTO `role_user` VALUES ('4', '10');
INSERT INTO `role_user` VALUES ('5', '10');
INSERT INTO `role_user` VALUES ('4', '11');
INSERT INTO `role_user` VALUES ('5', '11');
INSERT INTO `role_user` VALUES ('4', '12');
INSERT INTO `role_user` VALUES ('5', '12');
INSERT INTO `role_user` VALUES ('4', '13');
INSERT INTO `role_user` VALUES ('5', '13');
INSERT INTO `role_user` VALUES ('6', '14');
INSERT INTO `role_user` VALUES ('6', '15');
INSERT INTO `role_user` VALUES ('6', '16');
INSERT INTO `role_user` VALUES ('6', '17');
INSERT INTO `role_user` VALUES ('6', '18');
INSERT INTO `role_user` VALUES ('6', '19');
INSERT INTO `role_user` VALUES ('6', '20');
INSERT INTO `role_user` VALUES ('6', '21');
INSERT INTO `role_user` VALUES ('6', '22');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `gpa_` varchar(255) DEFAULT NULL,
  `name_` varchar(255) DEFAULT NULL,
  `qq_` varchar(255) DEFAULT NULL,
  `sex_` varchar(1) DEFAULT NULL,
  `student_id_` varchar(12) DEFAULT NULL,
  `student_note_` varchar(255) DEFAULT NULL,
  `tel_` varchar(255) DEFAULT NULL,
  `stu_uuid_` varchar(36) DEFAULT NULL,
  `which_grade_` varchar(255) DEFAULT NULL,
  `class_` varchar(255) DEFAULT NULL,
  `institute_id_` bigint(20) DEFAULT NULL,
  `lastThesisScript_id_` bigint(20) DEFAULT NULL,
  `major_id_` bigint(20) DEFAULT NULL,
  `mark_id_` bigint(20) DEFAULT NULL,
  `taskBook_id_` bigint(20) DEFAULT NULL,
  `teacher_id_` bigint(20) DEFAULT NULL,
  `thesisProposal_id_` bigint(20) DEFAULT NULL,
  `topic_id_` bigint(20) DEFAULT NULL,
  `tutorAdvice_id_` bigint(20) DEFAULT NULL,
  `user_id_` bigint(20) DEFAULT NULL,
  `viewerAdvice_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FK8FFE823B39AAF996` (`institute_id_`),
  KEY `FK8FFE823B39560CDB` (`lastThesisScript_id_`),
  KEY `FK8FFE823B53889A5E` (`major_id_`),
  KEY `FK8FFE823B6CAA6991` (`mark_id_`),
  KEY `FK8FFE823B630F0A73` (`taskBook_id_`),
  KEY `FK8FFE823BD4924470` (`teacher_id_`),
  KEY `FK8FFE823B8DFB4493` (`thesisProposal_id_`),
  KEY `FK8FFE823B7838FE71` (`topic_id_`),
  KEY `FK8FFE823B3C60258F` (`tutorAdvice_id_`),
  KEY `FK8FFE823BC83E8594` (`user_id_`),
  KEY `FK8FFE823BCE43A2AB` (`viewerAdvice_id_`),
  CONSTRAINT `FK8FFE823BCE43A2AB` FOREIGN KEY (`viewerAdvice_id_`) REFERENCES `vieweradvice` (`id_`),
  CONSTRAINT `FK8FFE823B39560CDB` FOREIGN KEY (`lastThesisScript_id_`) REFERENCES `thesisscript` (`id_`),
  CONSTRAINT `FK8FFE823B39AAF996` FOREIGN KEY (`institute_id_`) REFERENCES `institute` (`id_`),
  CONSTRAINT `FK8FFE823B3C60258F` FOREIGN KEY (`tutorAdvice_id_`) REFERENCES `tutoradvice` (`id_`),
  CONSTRAINT `FK8FFE823B53889A5E` FOREIGN KEY (`major_id_`) REFERENCES `major` (`id_`),
  CONSTRAINT `FK8FFE823B630F0A73` FOREIGN KEY (`taskBook_id_`) REFERENCES `taskbook` (`id_`),
  CONSTRAINT `FK8FFE823B6CAA6991` FOREIGN KEY (`mark_id_`) REFERENCES `mark` (`id_`),
  CONSTRAINT `FK8FFE823B7838FE71` FOREIGN KEY (`topic_id_`) REFERENCES `topic` (`id_`),
  CONSTRAINT `FK8FFE823B8DFB4493` FOREIGN KEY (`thesisProposal_id_`) REFERENCES `thesisproposal` (`id_`),
  CONSTRAINT `FK8FFE823BC83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FK8FFE823BD4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '3.82', '李力', '445684932', '2', '100802011016', '软件', '13750018757', 'd942a83f-9441-43d2-aade-0e5488c161f9', '2014', '信管1班', '1', null, '1', null, null, '1', null, null, null, '14', null);
INSERT INTO `student` VALUES ('2', '3.83', '肖纪威', '445684933', '2', '100802011017', '软件', '13750018757', '7f64ba48-c95a-4baf-a6ad-3c99263feda7', '2014', '信管2班', '1', null, '1', null, null, '3', null, null, null, '15', null);
INSERT INTO `student` VALUES ('3', '3.84', '罗健辉', '445684934', '2', '100802011018', '软件', '13750018757', 'd632e3f7-28dd-4929-8db0-e458f802303e', '2014', '信管3班', '1', null, '1', null, null, '2', null, null, null, '16', null);
INSERT INTO `student` VALUES ('4', '3.85', '张小红', '445684935', '2', '100802011019', '财务', '13750018757', 'eade0560-17b9-4dd4-beac-98c7f6ffe1af', '2014', '会计1班', '2', null, '2', null, null, null, null, null, null, '17', null);
INSERT INTO `student` VALUES ('5', '3.86', '张梅', '445684936', '2', '100802011020', '财务', '13750018757', '69f4cab6-3601-4ad0-91a5-4e308ca6cbbb', '2014', '会计2班', '2', null, '2', null, null, null, null, null, null, '18', null);
INSERT INTO `student` VALUES ('6', '3.87', '毛邓', '445684937', '2', '100802011021', '营销', '13750018757', '535b8966-e916-4367-96c4-855f4b7f49b8', '2014', '市营1班', '1', null, '3', null, null, null, null, null, null, '19', null);
INSERT INTO `student` VALUES ('7', '3.88', '邓红', '445684938', '2', '100802011022', '营销', '13750018757', 'c8d0dfdd-f2bd-46be-8fac-ce14b80aae91', '2014', '市营2班', '1', null, '3', null, null, null, null, null, null, '20', null);
INSERT INTO `student` VALUES ('8', '3.89', '李小龙', '445684939', '2', '100802011023', '营销', '13750018757', 'af9d58c1-cefd-4cdf-842f-644f8802acb8', '2014', '市营3班', '1', null, '3', null, null, null, null, null, null, '21', null);
INSERT INTO `student` VALUES ('9', '3.90', '陈升', '445684940', '2', '100802011024', '营销', '13750018757', '80225154-3462-456e-9637-476407a56d0b', '2014', '市营4班', '1', null, '3', null, null, null, null, null, null, '22', null);

-- ----------------------------
-- Table structure for student_thesisscript
-- ----------------------------
DROP TABLE IF EXISTS `student_thesisscript`;
CREATE TABLE `student_thesisscript` (
  `student_id_` bigint(20) NOT NULL,
  `thesisScripts_id_` bigint(20) NOT NULL,
  PRIMARY KEY (`student_id_`,`thesisScripts_id_`),
  KEY `FKF5136E3B391459EA` (`thesisScripts_id_`),
  KEY `FKF5136E3BE3C6DCA2` (`student_id_`),
  CONSTRAINT `FKF5136E3BE3C6DCA2` FOREIGN KEY (`student_id_`) REFERENCES `student` (`id_`),
  CONSTRAINT `FKF5136E3B391459EA` FOREIGN KEY (`thesisScripts_id_`) REFERENCES `thesisscript` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student_thesisscript
-- ----------------------------

-- ----------------------------
-- Table structure for taskbook
-- ----------------------------
DROP TABLE IF EXISTS `taskbook`;
CREATE TABLE `taskbook` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date_` date DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `first_content_` text,
  `second_content_` text,
  `user_id_` bigint(20) DEFAULT NULL,
  `student_id_` bigint(20) DEFAULT NULL,
  `teacher_id_` bigint(20) DEFAULT NULL,
  `topic_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FKE7859A0EC83E8594` (`user_id_`),
  KEY `FKE7859A0EE3C6DCA2` (`student_id_`),
  KEY `FKE7859A0ED4924470` (`teacher_id_`),
  KEY `FKE7859A0E7838FE71` (`topic_id_`),
  CONSTRAINT `FKE7859A0E7838FE71` FOREIGN KEY (`topic_id_`) REFERENCES `topic` (`id_`),
  CONSTRAINT `FKE7859A0EC83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FKE7859A0ED4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FKE7859A0EE3C6DCA2` FOREIGN KEY (`student_id_`) REFERENCES `student` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taskbook
-- ----------------------------

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `choose_student_run_num` varchar(1) DEFAULT '0',
  `forward_lecture_grade_status_` int(11) DEFAULT '1',
  `forward_tutor_grade_status_` int(11) DEFAULT '1',
  `forward_viewer_grade_status_` int(11) DEFAULT '1',
  `level_` varchar(255) DEFAULT NULL,
  `name_` varchar(255) DEFAULT NULL,
  `real_teach_num_` int(11) DEFAULT '0',
  `sex_` varchar(1) DEFAULT NULL,
  `teach_num_` varchar(255) DEFAULT NULL,
  `teacher_email_` varchar(255) DEFAULT NULL,
  `teacher_id_` varchar(10) DEFAULT NULL,
  `teacher_note_` varchar(255) DEFAULT NULL,
  `teacher_tel_` varchar(255) DEFAULT NULL,
  `teacher_uuid_` varchar(36) DEFAULT NULL,
  `institute_id_` bigint(20) DEFAULT NULL,
  `midCheck_id_` bigint(20) DEFAULT NULL,
  `user_id_` bigint(20) DEFAULT NULL,
  `viewer_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FKAA31CBE239AAF996` (`institute_id_`),
  KEY `FKAA31CBE2E004F8D7` (`midCheck_id_`),
  KEY `FKAA31CBE2C83E8594` (`user_id_`),
  KEY `FKAA31CBE2213512A0` (`viewer_id_`),
  CONSTRAINT `FKAA31CBE2213512A0` FOREIGN KEY (`viewer_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FKAA31CBE239AAF996` FOREIGN KEY (`institute_id_`) REFERENCES `institute` (`id_`),
  CONSTRAINT `FKAA31CBE2C83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FKAA31CBE2E004F8D7` FOREIGN KEY (`midCheck_id_`) REFERENCES `midcheck` (`id_`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '4', '1', '1', '1', '讲师', '李玉敏', '1', '2', '2', 'alan.lili@163.com', '08067', '信息系统分析、设计与实施', '618757', '8af400c8-b8f7-4bec-887e-5510f22fb3e1', '1', null, '2', null);
INSERT INTO `teacher` VALUES ('2', '4', '1', '1', '1', '教授', '田艳', '1', '2', '1', 'alan.lili@163.com', '08036', '物联网', '618758', 'd6cfbb78-2b47-49ac-8007-1dbad3840ebf', '1', null, '3', null);
INSERT INTO `teacher` VALUES ('3', '4', '1', '1', '1', '副教授', '高集荣', '1', '2', '1', 'alan.lili@163.com', '08066', '信息系统分析', '618759', '2df98d4e-129d-405e-853f-152b929bfba8', '1', null, '4', null);
INSERT INTO `teacher` VALUES ('4', '0', '1', '1', '1', '教授', '修桂华', '0', '2', '20', 'alan.lili@163.com', '08191', '信息系统分析', '618760', '501d2579-e3f7-48e2-96e4-5a352fcbe468', '2', null, '5', null);
INSERT INTO `teacher` VALUES ('5', '0', '1', '1', '1', '副教授', '钟扬', '0', '2', '20', 'alan.lili@163.com', '08207', '国际物流，供应链管理', '618761', '9385998a-11b4-4833-b4f6-a616e81855be', '2', null, '6', null);
INSERT INTO `teacher` VALUES ('6', '0', '1', '1', '1', '教授', '钱东人', '0', '2', '20', 'alan.lili@163.com', '08206', '物流与供应链', '618762', '7c3a980a-b458-41d9-82fc-b77a22b65b64', '1', null, '7', null);
INSERT INTO `teacher` VALUES ('7', '0', '1', '1', '1', '讲师', '吴浩然', '0', '2', '20', 'alan.lili@163.com', '08082', '决策理论与方法、统计分析', '618763', '675179e5-be87-4d3c-86cd-cc202547d745', '1', null, '8', null);
INSERT INTO `teacher` VALUES ('8', '0', '1', '1', '1', '讲师', '兰淑娟', '0', '2', '20', 'alan.lili@163.com', '08086', '决策理论与方法、统计分析', '618764', '4f6f2967-bc4d-4156-8cbc-2c7f52f99677', '1', null, '9', null);
INSERT INTO `teacher` VALUES ('9', '0', '1', '1', '1', '讲师', '廖爱红', '0', '2', '20', 'alan.lili@163.com', '08121', '信息系统、网站建设', '618765', '0f5cd1c1-6844-49be-8ccc-385aa7a2a594', '1', null, '10', null);
INSERT INTO `teacher` VALUES ('10', '0', '1', '1', '1', '讲师', '李万辰', '0', '2', '20', 'alan.lili@163.com', '15029', '信息管理、电子商务', '618766', '049bbec1-0df2-4bd9-ae64-fe657ba3d936', '1', null, '11', null);
INSERT INTO `teacher` VALUES ('11', '0', '1', '1', '1', '讲师', '王淞春', '0', '2', '20', 'alan.lili@163.com', '08081', '信息系统设计、电子商务技术', '618767', 'a226942f-d686-4877-8562-eaeba470af87', '1', null, '12', null);
INSERT INTO `teacher` VALUES ('12', '0', '1', '1', '1', '讲师', '王二威', '0', '2', '20', 'alan.lili@163.com', '08119', '电子商务、信息系统', '618768', '28ff689b-ffb6-4b4e-bd05-9a1c8d14563e', '1', null, '13', null);

-- ----------------------------
-- Table structure for teacher_major
-- ----------------------------
DROP TABLE IF EXISTS `teacher_major`;
CREATE TABLE `teacher_major` (
  `teacher_id_` bigint(20) NOT NULL,
  `major_id_` bigint(20) NOT NULL,
  PRIMARY KEY (`teacher_id_`,`major_id_`),
  KEY `FK6DF7F31C53889A5E` (`major_id_`),
  KEY `FK6DF7F31CD4924470` (`teacher_id_`),
  CONSTRAINT `FK6DF7F31CD4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK6DF7F31C53889A5E` FOREIGN KEY (`major_id_`) REFERENCES `major` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_major
-- ----------------------------
INSERT INTO `teacher_major` VALUES ('1', '1');
INSERT INTO `teacher_major` VALUES ('2', '1');
INSERT INTO `teacher_major` VALUES ('3', '1');
INSERT INTO `teacher_major` VALUES ('4', '2');
INSERT INTO `teacher_major` VALUES ('5', '2');
INSERT INTO `teacher_major` VALUES ('6', '3');
INSERT INTO `teacher_major` VALUES ('7', '3');
INSERT INTO `teacher_major` VALUES ('8', '3');
INSERT INTO `teacher_major` VALUES ('9', '3');
INSERT INTO `teacher_major` VALUES ('10', '3');
INSERT INTO `teacher_major` VALUES ('11', '3');
INSERT INTO `teacher_major` VALUES ('12', '3');

-- ----------------------------
-- Table structure for teacher_student
-- ----------------------------
DROP TABLE IF EXISTS `teacher_student`;
CREATE TABLE `teacher_student` (
  `teacher_id_` bigint(20) NOT NULL,
  `students_id_` bigint(20) NOT NULL,
  PRIMARY KEY (`teacher_id_`,`students_id_`),
  KEY `FK2E2EF2DE575F297F` (`students_id_`),
  KEY `FK2E2EF2DED4924470` (`teacher_id_`),
  CONSTRAINT `FK2E2EF2DED4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK2E2EF2DE575F297F` FOREIGN KEY (`students_id_`) REFERENCES `student` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_student
-- ----------------------------
INSERT INTO `teacher_student` VALUES ('1', '1');
INSERT INTO `teacher_student` VALUES ('3', '2');
INSERT INTO `teacher_student` VALUES ('2', '3');

-- ----------------------------
-- Table structure for teacher_teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher_teacher`;
CREATE TABLE `teacher_teacher` (
  `teacher_id_` bigint(20) NOT NULL,
  `teachers_id_` bigint(20) NOT NULL,
  PRIMARY KEY (`teacher_id_`,`teachers_id_`),
  KEY `FK48623C856DFE19DF` (`teachers_id_`),
  KEY `FK48623C85D4924470` (`teacher_id_`),
  CONSTRAINT `FK48623C85D4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK48623C856DFE19DF` FOREIGN KEY (`teachers_id_`) REFERENCES `teacher` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_teacher
-- ----------------------------

-- ----------------------------
-- Table structure for teacher_tutoradvice
-- ----------------------------
DROP TABLE IF EXISTS `teacher_tutoradvice`;
CREATE TABLE `teacher_tutoradvice` (
  `teacher_id_` bigint(20) NOT NULL,
  `tutorAdvices_id_` bigint(20) NOT NULL,
  PRIMARY KEY (`teacher_id_`,`tutorAdvices_id_`),
  KEY `FK9371A6F13FD2B0E6` (`tutorAdvices_id_`),
  KEY `FK9371A6F1D4924470` (`teacher_id_`),
  CONSTRAINT `FK9371A6F1D4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK9371A6F13FD2B0E6` FOREIGN KEY (`tutorAdvices_id_`) REFERENCES `tutoradvice` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_tutoradvice
-- ----------------------------

-- ----------------------------
-- Table structure for teacher_vieweradvice
-- ----------------------------
DROP TABLE IF EXISTS `teacher_vieweradvice`;
CREATE TABLE `teacher_vieweradvice` (
  `teacher_id_` bigint(20) NOT NULL,
  `viewerAdvices_id_` bigint(20) NOT NULL,
  PRIMARY KEY (`teacher_id_`,`viewerAdvices_id_`),
  KEY `FKDE34C2E787F7B9CA` (`viewerAdvices_id_`),
  KEY `FKDE34C2E7D4924470` (`teacher_id_`),
  CONSTRAINT `FKDE34C2E7D4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FKDE34C2E787F7B9CA` FOREIGN KEY (`viewerAdvices_id_`) REFERENCES `vieweradvice` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_vieweradvice
-- ----------------------------

-- ----------------------------
-- Table structure for thesisproposal
-- ----------------------------
DROP TABLE IF EXISTS `thesisproposal`;
CREATE TABLE `thesisproposal` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date_` date DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `fifth_content_` text,
  `first_content_` text,
  `fourth_content_` text,
  `second_content_` text,
  `third_content_` text,
  `user_id_` bigint(20) DEFAULT NULL,
  `student_id_` bigint(20) DEFAULT NULL,
  `teacher_id_` bigint(20) DEFAULT NULL,
  `topic_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FKBF169DDEC83E8594` (`user_id_`),
  KEY `FKBF169DDEE3C6DCA2` (`student_id_`),
  KEY `FKBF169DDED4924470` (`teacher_id_`),
  KEY `FKBF169DDE7838FE71` (`topic_id_`),
  CONSTRAINT `FKBF169DDE7838FE71` FOREIGN KEY (`topic_id_`) REFERENCES `topic` (`id_`),
  CONSTRAINT `FKBF169DDEC83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FKBF169DDED4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FKBF169DDEE3C6DCA2` FOREIGN KEY (`student_id_`) REFERENCES `student` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thesisproposal
-- ----------------------------

-- ----------------------------
-- Table structure for thesisscript
-- ----------------------------
DROP TABLE IF EXISTS `thesisscript`;
CREATE TABLE `thesisscript` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date_` date DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `answer_` varchar(255) DEFAULT NULL,
  `file_name_` varchar(255) DEFAULT NULL,
  `last_script` int(11) DEFAULT NULL,
  `path_` varchar(255) DEFAULT NULL,
  `question_` varchar(255) DEFAULT NULL,
  `uuid_` varchar(255) DEFAULT NULL,
  `user_id_` bigint(20) DEFAULT NULL,
  `student_id_` bigint(20) DEFAULT NULL,
  `teacher_id_` bigint(20) DEFAULT NULL,
  `topic_id_` bigint(20) DEFAULT NULL,
  `viewer_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FKE731CEB7C83E8594` (`user_id_`),
  KEY `FKE731CEB7E3C6DCA2` (`student_id_`),
  KEY `FKE731CEB7D4924470` (`teacher_id_`),
  KEY `FKE731CEB77838FE71` (`topic_id_`),
  KEY `FKE731CEB7213512A0` (`viewer_id_`),
  CONSTRAINT `FKE731CEB7213512A0` FOREIGN KEY (`viewer_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FKE731CEB77838FE71` FOREIGN KEY (`topic_id_`) REFERENCES `topic` (`id_`),
  CONSTRAINT `FKE731CEB7C83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FKE731CEB7D4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FKE731CEB7E3C6DCA2` FOREIGN KEY (`student_id_`) REFERENCES `student` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thesisscript
-- ----------------------------

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date_` date DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `level_` varchar(255) DEFAULT NULL,
  `old_or_new_` varchar(255) DEFAULT NULL,
  `origin_` varchar(255) DEFAULT NULL,
  `quality_` varchar(255) DEFAULT NULL,
  `topic_name_` varchar(255) DEFAULT NULL,
  `type_` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `user_id_` bigint(20) DEFAULT NULL,
  `student_id_` bigint(20) DEFAULT NULL,
  `teacher_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FK696CD2FC83E8594` (`user_id_`),
  KEY `FK696CD2FE3C6DCA2` (`student_id_`),
  KEY `FK696CD2FD4924470` (`teacher_id_`),
  CONSTRAINT `FK696CD2FD4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK696CD2FC83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FK696CD2FE3C6DCA2` FOREIGN KEY (`student_id_`) REFERENCES `student` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic
-- ----------------------------

-- ----------------------------
-- Table structure for tutoradvice
-- ----------------------------
DROP TABLE IF EXISTS `tutoradvice`;
CREATE TABLE `tutoradvice` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date_` date DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `agree_or_not` int(11) DEFAULT '1',
  `opinion_` varchar(255) DEFAULT NULL,
  `tutor_grade_` int(11) DEFAULT '0',
  `uuid_` varchar(255) DEFAULT NULL,
  `user_id_` bigint(20) DEFAULT NULL,
  `student_id_` bigint(20) DEFAULT NULL,
  `teacher_id_` bigint(20) DEFAULT NULL,
  `topic_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FK5A003FCEC83E8594` (`user_id_`),
  KEY `FK5A003FCEE3C6DCA2` (`student_id_`),
  KEY `FK5A003FCED4924470` (`teacher_id_`),
  KEY `FK5A003FCE7838FE71` (`topic_id_`),
  CONSTRAINT `FK5A003FCE7838FE71` FOREIGN KEY (`topic_id_`) REFERENCES `topic` (`id_`),
  CONSTRAINT `FK5A003FCEC83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FK5A003FCED4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FK5A003FCEE3C6DCA2` FOREIGN KEY (`student_id_`) REFERENCES `student` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tutoradvice
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `password_` varchar(255) DEFAULT NULL,
  `real_name_` varchar(255) DEFAULT NULL,
  `user_name_` varchar(12) DEFAULT NULL,
  `user_type_` varchar(1) DEFAULT NULL,
  `uuid_` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'D41D8CD98F00B204E9800998ECF8427E', '', 'admin', '2', null);
INSERT INTO `user` VALUES ('2', 'D41D8CD98F00B204E9800998ECF8427E', '李玉敏', '08067', '2', '8af400c8-b8f7-4bec-887e-5510f22fb3e1');
INSERT INTO `user` VALUES ('3', 'D41D8CD98F00B204E9800998ECF8427E', '田艳', '08036', '2', 'd6cfbb78-2b47-49ac-8007-1dbad3840ebf');
INSERT INTO `user` VALUES ('4', 'D41D8CD98F00B204E9800998ECF8427E', '高集荣', '08066', '2', '2df98d4e-129d-405e-853f-152b929bfba8');
INSERT INTO `user` VALUES ('5', 'D41D8CD98F00B204E9800998ECF8427E', '修桂华', '08191', '2', '501d2579-e3f7-48e2-96e4-5a352fcbe468');
INSERT INTO `user` VALUES ('6', 'D41D8CD98F00B204E9800998ECF8427E', '钟扬', '08207', '2', '9385998a-11b4-4833-b4f6-a616e81855be');
INSERT INTO `user` VALUES ('7', 'D41D8CD98F00B204E9800998ECF8427E', '钱东人', '08206', '2', '7c3a980a-b458-41d9-82fc-b77a22b65b64');
INSERT INTO `user` VALUES ('8', 'D41D8CD98F00B204E9800998ECF8427E', '吴浩然', '08082', '2', '675179e5-be87-4d3c-86cd-cc202547d745');
INSERT INTO `user` VALUES ('9', 'D41D8CD98F00B204E9800998ECF8427E', '兰淑娟', '08086', '2', '4f6f2967-bc4d-4156-8cbc-2c7f52f99677');
INSERT INTO `user` VALUES ('10', 'D41D8CD98F00B204E9800998ECF8427E', '廖爱红', '08121', '2', '0f5cd1c1-6844-49be-8ccc-385aa7a2a594');
INSERT INTO `user` VALUES ('11', 'D41D8CD98F00B204E9800998ECF8427E', '李万辰', '15029', '2', '049bbec1-0df2-4bd9-ae64-fe657ba3d936');
INSERT INTO `user` VALUES ('12', 'D41D8CD98F00B204E9800998ECF8427E', '王淞春', '08081', '2', 'a226942f-d686-4877-8562-eaeba470af87');
INSERT INTO `user` VALUES ('13', 'D41D8CD98F00B204E9800998ECF8427E', '王二威', '08119', '2', '28ff689b-ffb6-4b4e-bd05-9a1c8d14563e');
INSERT INTO `user` VALUES ('14', 'D41D8CD98F00B204E9800998ECF8427E', '李力', '100802011016', '1', 'd942a83f-9441-43d2-aade-0e5488c161f9');
INSERT INTO `user` VALUES ('15', 'D41D8CD98F00B204E9800998ECF8427E', '肖纪威', '100802011017', '1', '7f64ba48-c95a-4baf-a6ad-3c99263feda7');
INSERT INTO `user` VALUES ('16', 'D41D8CD98F00B204E9800998ECF8427E', '罗健辉', '100802011018', '1', 'd632e3f7-28dd-4929-8db0-e458f802303e');
INSERT INTO `user` VALUES ('17', 'D41D8CD98F00B204E9800998ECF8427E', '张小红', '100802011019', '1', 'eade0560-17b9-4dd4-beac-98c7f6ffe1af');
INSERT INTO `user` VALUES ('18', 'D41D8CD98F00B204E9800998ECF8427E', '张梅', '100802011020', '1', '69f4cab6-3601-4ad0-91a5-4e308ca6cbbb');
INSERT INTO `user` VALUES ('19', 'D41D8CD98F00B204E9800998ECF8427E', '毛邓', '100802011021', '1', '535b8966-e916-4367-96c4-855f4b7f49b8');
INSERT INTO `user` VALUES ('20', 'D41D8CD98F00B204E9800998ECF8427E', '邓红', '100802011022', '1', 'c8d0dfdd-f2bd-46be-8fac-ce14b80aae91');
INSERT INTO `user` VALUES ('21', 'D41D8CD98F00B204E9800998ECF8427E', '李小龙', '100802011023', '1', 'af9d58c1-cefd-4cdf-842f-644f8802acb8');
INSERT INTO `user` VALUES ('22', 'D41D8CD98F00B204E9800998ECF8427E', '陈升', '100802011024', '1', '80225154-3462-456e-9637-476407a56d0b');

-- ----------------------------
-- Table structure for vieweradvice
-- ----------------------------
DROP TABLE IF EXISTS `vieweradvice`;
CREATE TABLE `vieweradvice` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date_` date DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  `agree_or_not` int(11) DEFAULT NULL,
  `opinion_` varchar(255) DEFAULT NULL,
  `uuid_` varchar(255) DEFAULT NULL,
  `viewer_grade_` int(11) DEFAULT NULL,
  `user_id_` bigint(20) DEFAULT NULL,
  `student_id_` bigint(20) DEFAULT NULL,
  `teacher_id_` bigint(20) DEFAULT NULL,
  `topic_id_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  KEY `FKE97945AAC83E8594` (`user_id_`),
  KEY `FKE97945AAE3C6DCA2` (`student_id_`),
  KEY `FKE97945AAD4924470` (`teacher_id_`),
  KEY `FKE97945AA7838FE71` (`topic_id_`),
  CONSTRAINT `FKE97945AA7838FE71` FOREIGN KEY (`topic_id_`) REFERENCES `topic` (`id_`),
  CONSTRAINT `FKE97945AAC83E8594` FOREIGN KEY (`user_id_`) REFERENCES `user` (`id_`),
  CONSTRAINT `FKE97945AAD4924470` FOREIGN KEY (`teacher_id_`) REFERENCES `teacher` (`id_`),
  CONSTRAINT `FKE97945AAE3C6DCA2` FOREIGN KEY (`student_id_`) REFERENCES `student` (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vieweradvice
-- ----------------------------

-- ----------------------------
-- Table structure for wish
-- ----------------------------
DROP TABLE IF EXISTS `wish`;
CREATE TABLE `wish` (
  `id_` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_result_uuid_` varchar(36) DEFAULT NULL,
  `first_teacher_uuid_` varchar(36) DEFAULT NULL,
  `second_result_uuid_` varchar(36) DEFAULT NULL,
  `second_teacher_uuid_` varchar(36) DEFAULT NULL,
  `third_result_uuid_` varchar(36) DEFAULT NULL,
  `third_teacher_uuid_` varchar(36) DEFAULT NULL,
  `student_uuid_` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wish
-- ----------------------------
INSERT INTO `wish` VALUES ('1', '8af400c8-b8f7-4bec-887e-5510f22fb3e1', '8af400c8-b8f7-4bec-887e-5510f22fb3e1', '0', 'd6cfbb78-2b47-49ac-8007-1dbad3840ebf', '0', '2df98d4e-129d-405e-853f-152b929bfba8', 'd942a83f-9441-43d2-aade-0e5488c161f9');
INSERT INTO `wish` VALUES ('2', '0', '8af400c8-b8f7-4bec-887e-5510f22fb3e1', '2df98d4e-129d-405e-853f-152b929bfba8', '2df98d4e-129d-405e-853f-152b929bfba8', '0', 'd6cfbb78-2b47-49ac-8007-1dbad3840ebf', '7f64ba48-c95a-4baf-a6ad-3c99263feda7');
INSERT INTO `wish` VALUES ('3', 'd6cfbb78-2b47-49ac-8007-1dbad3840ebf', 'd6cfbb78-2b47-49ac-8007-1dbad3840ebf', '0', '2df98d4e-129d-405e-853f-152b929bfba8', '0', '8af400c8-b8f7-4bec-887e-5510f22fb3e1', 'd632e3f7-28dd-4929-8db0-e458f802303e');
