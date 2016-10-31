CREATE DATABASE db;

CREATE TABLE `db`.`tbl_user` (
  `user_uid` BIGINT UNIQUE AUTO_INCREMENT,
  `user_email` VARCHAR(45) NULL,
  `user_username` VARCHAR(45) NULL,
  `user_password` VARCHAR(45) NULL,
  PRIMARY KEY (`user_uid`));

CREATE TABLE `db`.`tbl_notes` (
  `note_nid` BIGINT UNIQUE AUTO_INCREMENT,
  `note_name` VARCHAR(45) NULL,
  `note_created` DATETIME,
  `note_content` VARCHAR(2048) NULL,
  `note_creator` BIGINT,
  PRIMARY KEY (`note_nid`));

CREATE TABLE `db`.`tbl_events` (
  `events_eid` BIGINT UNIQUE AUTO_INCREMENT,
  `events_name` VARCHAR(45) NULL,
  `event_created` DATETIME,
  `event_content` VARCHAR(2048) NULL,
  `event_creator` BIGINT,
  PRIMARY KEY (`events_eid`));
