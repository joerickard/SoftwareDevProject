/*
CREATE DATABASE Timeless;
CREATE TABLE `Timeless`.`tbl_user` (
  `user_uid` BIGINT UNIQUE AUTO_INCREMENT,
  `user_email` VARCHAR(45) NULL,
  `user_username` VARCHAR(45) NULL,
  `user_password` VARCHAR(45) NULL,
  PRIMARY KEY (`user_uid`));

CREATE TABLE `Timeless`.`tbl_notes` (
  `note_nid` BIGINT UNIQUE AUTO_INCREMENT,
  `note_name` VARCHAR(45) NULL,
  `note_created` DATETIME,
  `note_content` VARCHAR(2048) NULL,
  `note_creator` BIGINT,
  PRIMARY KEY (`note_nid`));

CREATE TABLE `Timeless`.`tbl_events` (
  `events_eid` BIGINT UNIQUE AUTO_INCREMENT,
  `events_name` VARCHAR(45) NULL,
  `event_created` DATETIME,
  `event_content` VARCHAR(2048) NULL,
  `event_creator` BIGINT,
  PRIMARY KEY (`events_eid`));
*/

-- Make a 'create user' procedure

USE `Timeless`;

DROP procedure IF EXISTS `spCreateUser`;

DELIMITER $$
USE `Timeless`$$
CREATE PROCEDURE `spCreateUser` (
IN p_user_email varchar(45),
IN p_user_password varchar(45),
IN p_user_username varchar(45)
)
BEGIN

if ( select exists (select 1 from tbl_user where user_email = p_user_email) ) THEN

    select 'Username already exists !!';

ELSE

insert into tbl_user
(
    user_email,
    user_password,
    user_username
)
values
(
    p_user_email,
    p_user_password,
    p_user_username
);

END IF;

END$$

DELIMITER ;

-- End 'create user' procedure

-- 'spGetNote' procedure


DROP procedure IF EXISTS `spGetNote`;

DELIMITER $$
USE `Timeless`$$
CREATE PROCEDURE `spGetNote` (
IN p_note_id varchar(45)
)
BEGIN

if ( SELECT EXISTS (select 1 FROM tbl_notes WHERE note_nid = p_note_id) ) THEN
    
    select * FROM tbl_notes WHERE note_nid = p_note_id;

ELSE

    select 'Mysql error: Note corresponding to note_id not found';

END IF;

END$$

DELIMITER ;

-- End 'spGetNote' procedure



-- TODO: Make a 'save note' procedure

USE `Timeless`;

DROP procedure IF EXISTS `spSaveNote`;

DELIMITER $$
USE `Timeless`$$
-- Take in 2 arguments
CREATE PROCEDURE `spSaveNote` (
IN p_note_id varchar(45),
IN p_note_body varchar(2048)
)
BEGIN

if ( select exists (select 1 from tbl_notes where note_nid = p_note_id) ) THEN
    UPDATE tbl_notes
    SET note_content=p_note_body
    WHERE note_nid = p_note_id;
-- Send the newly changed note
    select * FROM tbl_notes WHERE note_nid = p_note_id;

ELSE

    select 'Mysql error: Note corresponding to note_id not found, didnt update';


END IF;

END$$

DELIMITER ;

-- End 'save note' procedure


-- Begin 'create note' procedure

-- blah blah

/*
insert into tbl_notes
(
    note_content
)
values
(
    p_note_body
);

*/
-- End 'create note' procedure
