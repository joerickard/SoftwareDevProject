-- Initialize our Database with application.
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
  `events_eid` BIGINT,
  `events_name` VARCHAR(45) NULL,
  `event_created` DATETIME,
  `event_content` VARCHAR(2048) NULL,
  `event_creator` BIGINT,
  PRIMARY KEY (`events_eid`));

-- DELIMITER $$
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
-- 	IN init_name VARCHAR(20),
-- 	IN init_username VARCHAR(20),
-- 	IN inti_password VARCHAR(20))
-- BEGIN
-- 	IF(SELECT exists(SELECT 1 from tbl_user WHERE user_username = init_username) )
-- 		THEN SELECT 'User already exists.';
-- 	ELSE
-- 		insert into tbl_user
--         (
--             user_name,
--             user_username,
--             user_password
--         )
--         values
--         (
--             init_name,
--             init_username,
-- 			init_password
-- 		);
-- 	END IF;
-- END$$
-- DELIMITER ;