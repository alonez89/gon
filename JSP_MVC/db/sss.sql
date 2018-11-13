
DROP SEQUENCE MVCBOARDSEQ;
DROP TABLE MVCBOARD;

CREATE SEQUENCE MVCBOARDSEQ;

--번호(SEQ), 작성자(WRITER), 
--제목(TITLE), 내용(CONTENT), 작성일(REGDATE)
CREATE TABLE MVCBOARD(
	SEQ NUMBER PRIMARY KEY,
	WRITER VARCHAR2(100) NOT NULL,
	TITLE VARCHAR2(1000) NOT NULL,
	CONTENT VARCHAR2(2000) NOT NULL,
	REGDATE DATE NOT NULL
);

INSERT INTO MVCBOARD 
VALUES(MVCBOARDSEQ.NEXTVAL,'관리자','테스트중',
'테스트 1234 ABCD', '18/10/19');

SELECT * FROM MVCBOARD;

