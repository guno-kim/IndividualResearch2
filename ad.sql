
INSERT INTO users(username,password,name) VALUES ('test','1234','guno');

CREATE TABLE `problems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8_bin,
  `content` text COLLATE utf8_bin,
  `rank` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `category` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `input` text COLLATE utf8_bin,
  `output` text COLLATE utf8_bin,
  `remarks` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO problems(id,name,content,category,input,output,remarks) 
VALUES (1,'더하기','컨텐트','plus','두개의 정수 A,B','A와 B의 합','-100<=A,B<=100');
SELECT * FROM problems LIMIT 0, 10

DELETE FROM users WHERE id = 4;
DELETE FROM users WHERE id = 4;
DELETE FROM problems WHERE id = 27;

CREATE TABLE `testCases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `input` varchar(45) DEFAULT NULL,
  `output` varchar(45) DEFAULT NULL,
  `problem` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO testCases(input,output,problem) VALUES('1 2','3',1);
INSERT INTO testCases(input,output,problem) VALUES('-1 7','6',1);
INSERT INTO testCases(input,output,problem) VALUES('-1 7','8',1);

