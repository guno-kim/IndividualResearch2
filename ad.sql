--데이터
INSERT INTO users(username,password,name) VALUES ('a','a','guno');

--더하기 수동
INSERT INTO problems(id,name,content,category,input,output,remarks,auto) 
VALUES (1,'더하기','컨텐트','plus','두개의 정수 A,B','A와 B의 합','-100<=A,B<=100',false);

INSERT INTO testCases(input,output,problem) VALUES('1 2','3',1);
INSERT INTO testCases(input,output,problem) VALUES('-1 7','6',1);
INSERT INTO testCases(input,output,problem) VALUES('-1 7','8',1);

--더하기 문제 자동

INSERT INTO problems(id,name,content,category,input,output,remarks,auto) 
VALUES (2,'더하기','컨텐트','plus','두개의 정수 A,B','A와 B의 합','-100<=A,B<=100',true);

INSERT INTO auto_testcases(problems_id,testcase_num) VALUES(2,10);

INSERT INTO answer_codes(id,language,problems_id,code) VALUES(
  1,'java',2,
  'import java.util.*;\n
class Main{\n
	public static void main(String[]t){\n
		Scanner x=new Scanner(System.in);\n
		System.out.print(x.nextInt()+x.nextInt());\n
	}\n
}'
);

INSERT INTO int_variables(name,min,max,fix,problems_id) VALUES('a',-100,100,true,2);
INSERT INTO int_variables(name,min,max,fix,problems_id) VALUES('b',-100,100,true,2);
INSERT INTO char_variables(name,candidates,fix,problems_id) VALUES('c','{"data":["a","b","c","d"]}',true,2);




------------------------



INSERT INTO AutoTestCaseBlock(problem_id,box) VALUES(1,{"block":[[a,b],[1,2]]});
INSERT INTO AutoTestCaseBlock(problem_id,box) VALUES(1,{"asd":"12"});

CREATE TABLE caseTest (box json);
INSERT INTO caseTest(box) VALUES('{"data":[["a","b"],[1,2]]}');
INSERT INTO caseTest(box) VALUES('{"block":[1,2]}');

INSERT INTO `int`(AutoTestCase_Problem_id,name,fix) VALUES(1,'a',true);
INSERT INTO AutoTestCase(problem_id) VALUES (1);

