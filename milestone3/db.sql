-- CREATE DATABASE TimelessTest;

CREATE TABLE `TimelessTest`.`tbl_user` (
  `user_uid` BIGINT UNIQUE AUTO_INCREMENT,
  `user_email` VARCHAR(45) NULL,
  `user_username` VARCHAR(45) NULL,
  `user_password` VARCHAR(45) NULL,
  PRIMARY KEY (`user_uid`));

CREATE TABLE `TimelessTest`.`tbl_notes` (
  `note_nid` BIGINT UNIQUE AUTO_INCREMENT,
  `note_name` VARCHAR(45) NULL,
  `note_created` DATETIME,
  `note_content` VARCHAR(2048) NULL,
  `note_creator` BIGINT,
  PRIMARY KEY (`note_nid`));

CREATE TABLE `TimelessTest`.`tbl_events` (
  `events_eid` BIGINT UNIQUE AUTO_INCREMENT,
  `events_name` VARCHAR(45) NULL,
  `event_created` DATETIME,
  `event_content` VARCHAR(2048) NULL,
  `event_creator` BIGINT,
  PRIMARY KEY (`events_eid`));

-- Make a 'create user' procedure

USE `TimelessTest`;

DROP procedure IF EXISTS `spCreateUser`;

DELIMITER $$
USE `TimelessTest`$$
CREATE PROCEDURE `spCreateUser` (
IN p_user_email varchar(45),
IN p_user_password varchar(45)
)
BEGIN

if ( select exists (select 1 from tbl_user where user_email = p_user_email) ) THEN

    select 'Username Exists !!';

ELSE

insert into tbl_user
(
    user_email,
    user_password
)
values
(
    p_user_email,
    p_user_password
);

END IF;

END$$

DELIMITER ;

-- End 'create user' procedure
