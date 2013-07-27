DROP TABLE IF EXISTS `qa_user_sessions`;
DROP TABLE IF EXISTS `qa_questions_categories`;
DROP TABLE IF EXISTS `qa_answer_votes`;
DROP TABLE IF EXISTS `qa_user_votes`;
DROP TABLE IF EXISTS `qa_admin_logs`;
DROP TABLE IF EXISTS `qa_categories`;
DROP TABLE IF EXISTS `qa_answers`;
DROP TABLE IF EXISTS `qa_questions`;
DROP TABLE IF EXISTS `qa_admins`;
DROP TABLE IF EXISTS `qa_users`;

CREATE TABLE `qa_users` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    /* 用作登录 */
    `no` varchar(10) NOT NULL,
    `name` varchar(64) NOT NULL,
    `major` varchar(64) NOT NULL,
    `description` varchar(512),
    `password` varchar(64) NOT NULL,
    UNIQUE KEY `no` (`no`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `qa_user_sessions` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `key` varchar(64) NOT NULL,
    `user_id` int,
    FOREIGN KEY(`user_id`) REFERENCES `qa_users` (`id`),
    /* 登录的时候需要更新 */
    `lastest` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `key` (`key`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `qa_admins` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(64) NOT NULL,
    `password` varchar(64) NOT NULL,
    /* 一次只能在一个地方登录 */
    `session_key` varchar(64) NOT NULL,
    UNIQUE KEY `name` (`name`),
    UNIQUE KEY `session_key` (`session_key`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `qa_questions` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `question` varchar(256) NOT NULL,
    `description` varchar(2048),
    `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `edited` timestamp,
    `author_id` int,
    FOREIGN KEY(`author_id`) REFERENCES `qa_users` (`id`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `qa_categories` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(256) NOT NULL,
    `description` varchar(1024),
    `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `qa_questions_categories` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `question_id` int,
    `category_id` int,
    FOREIGN KEY(`question_id`) REFERENCES `qa_questions` (`id`),
    FOREIGN KEY(`category_id`) REFERENCES `qa_categories` (`id`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `qa_answers` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `content` varchar(256) NOT NULL,
    `is_anonymous` TINYINT(1) NOT NULL DEFAULT 0,
    `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `edited` timestamp,
    `question_id` int,
    `author_id` int,
    FOREIGN KEY(`question_id`) REFERENCES `qa_questions` (`id`),
    FOREIGN KEY(`author_id`) REFERENCES `qa_users` (`id`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;

/* 需要经常进行投票操作，所以独立开来 */
CREATE TABLE `qa_answer_votes` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `upvote` int DEFAULT 0,
    `downvote` int DEFAULT 0,
    `answer_id` int,
    FOREIGN KEY(`answer_id`) REFERENCES `qa_answers` (`id`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;

/* 用户投票记录 */
CREATE TABLE `qa_user_votes` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    /* 0 为支持 1 为反对 */
    `vote_type` TINYINT(1) NOT NULL,
    `author_id` int,
    `answer_id` int,
    FOREIGN KEY(`author_id`) REFERENCES `qa_users` (`id`),
    FOREIGN KEY(`answer_id`) REFERENCES `qa_answers` (`id`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;

/* 管理员操作记录 */
CREATE TABLE `qa_admin_logs` (
    `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `admin_id` int,
    `log` varchar(1024) NOT NULL,
    `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    /* TODO 相关问题/答案 */
    FOREIGN KEY(`admin_id`) REFERENCES `qa_admins` (`id`)
) CHARACTER SET utf8 COLLATE utf8_general_ci;
