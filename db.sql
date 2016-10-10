-- Initialize our Database with application.

CREATE TABLE `TodoList`.`tbl_user` (
  `user_id` BIGINT UNIQUE AUTO_INCREMENT,
  `user_name` VARCHAR(45) NULL,
  `user_username` VARCHAR(45) NULL,
  `user_password` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`));

CREATE TABLE `TodoList`.`tbl_tasks` (
  `task_id` BIGINT UNIQUE AUTO_INCREMENT,
  `task_name` VARCHAR(45) NULL,
  `task_create` DATETIME,
  PRIMARY KEY (`task_id`));

CREATE TABLE `TodoList`.`tbl_assignments` (
  `assignments_UID` BIGINT,
  `assignments_TID` BIGINT,
  PRIMARY KEY (`assignments_UID`));

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
	IN init_name VARCHAR(20),
	IN init_username VARCHAR(20),
	IN inti_password VARCHAR(20))
BEGIN
	IF(SELECT exists(SELECT 1 from tbl_user WHERE user_username = init_username) )
		THEN SELECT 'User already exists.';
	ELSE
		insert into tbl_user
        (
            user_name,
            user_username,
            user_password
        )
        values
        (
            init_name,
            init_username,
			init_password
		);
	END IF;
END$$
DELIMITER ;