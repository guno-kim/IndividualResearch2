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


INSERT INTO int_variables(name,min,max,fix,problems_id) VALUES('a',-100,100,false,2);
INSERT INTO int_variables(name,min,max,fix,problems_id) VALUES('b',-100,100,false,2);

INSERT INTO blocks(problems_id,id,box,horizon_rep,vertical_rep,space) 
VALUES(2,1,'{"data":[["a","a"]]}',1,1,true);






------------------------




INSERT INTO char_variables(name,candidates,fix,problems_id) 
VALUES('c','{"data":["!","@","#","$"]}',false,2);

INSERT INTO blocks(problems_id,id,box,horizon_rep,vertical_rep,space) 
VALUES(2,1,'{"data":[["a","b"],["a","a","a"]]}',3,2,true);
INSERT INTO blocks(problems_id,id,box,horizon_rep,vertical_rep,space) 
VALUES(2,2,'{"data":[["c","c","c","c"],["c","c"]]}',2,3,false);