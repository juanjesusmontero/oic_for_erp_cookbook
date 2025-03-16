CREATE SEQUENCE "TEST_USER_01"."DEPT_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1
START WITH 21 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE GLOBAL;
/
CREATE SEQUENCE "TEST_USER_01"."EMP_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1
START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE GLOBAL;
/
CREATE TABLE "TEST_USER_01"."DEPT"
        (
                "DEPTNO" NUMBER(2,0) NOT NULL ENABLE                ,
                "DNAME"  VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP",
                "LOC"    VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP",
                CONSTRAINT "DEPT_PK" PRIMARY KEY ("DEPTNO") USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "DATA" ENABLE
        )
DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
        (
                INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
        )
TABLESPACE "DATA";
/
CREATE
OR REPLACE EDITIONABLE TRIGGER "TEST_USER_01"."DEPT_TRG" BEFORE
INSERT  ON DEPT FOR EACH ROW
BEGIN
        <<COLUMN_SEQUENCES>>
                BEGIN
                        IF
                                INSERTING
                                AND :NEW.DEPTNO IS NULL
                        THEN
                                SELECT
                                        DEPT_SEQ.NEXTVAL
                                INTO
                                        :NEW.DEPTNO
                                FROM
                                        SYS.DUAL;
                        END IF;
                END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "TEST_USER_01"."DEPT_TRG" ENABLE;
CREATE TABLE "TEST_USER_01"."EMP"
        (
                "EMPNO"    NUMBER(4,0) NOT NULL ENABLE                ,
                "ENAME"    VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP",
                "JOB"      VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP",
                "MGR"      NUMBER(4,0)                                ,
                "HIREDATE" DATE                                       ,
                "SAL"      NUMBER(7,2)                                ,
                "COMM"     NUMBER(7,2)                                ,
                "DEPTNO"   NUMBER(2,0)                                ,
                CONSTRAINT "EMP_PK" PRIMARY KEY ("EMPNO") USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS TABLESPACE "DATA" ENABLE
        )
DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION DEFERRED PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 NOCOMPRESS LOGGING TABLESPACE "DATA";
/
CREATE
OR REPLACE EDITIONABLE TRIGGER "TEST_USER_01"."EMP_TRG" BEFORE
INSERT  ON EMP FOR EACH ROW
BEGIN
        <<COLUMN_SEQUENCES>>
                BEGIN
                        IF
                                INSERTING
                                AND :NEW.EMPNO IS NULL
                        THEN
                                SELECT
                                        EMP_SEQ.NEXTVAL
                                INTO
                                        :NEW.EMPNO
                                FROM
                                        SYS.DUAL;
                        END IF;
                END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "TEST_USER_01"."EMP_TRG" ENABLE;
create or replace type short_string_tt
        as table of varchar2(100);
        /

create or replace function get_employees ( p_ename varchar2)
        return short_string_tt
as
        l_employee_list short_string_tt;
begin
        select
                ename bulk collect
        into
                l_employee_list
        from
                emp;
        return l_employee_list;
end;
/
CREATE TABLE "TEST_USER_01"."XX_ITEMS"
        (
                "ID"          NUMBER NOT NULL ENABLE                     ,
                "DESCRIPTION" VARCHAR2(255 BYTE) COLLATE "USING_NLS_COMP",
                "NAME"        VARCHAR2(255 BYTE) COLLATE "USING_NLS_COMP",
                "COL_CLOB" CLOB COLLATE "USING_NLS_COMP"                 ,
                PRIMARY KEY ("ID") USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "DATA" ENABLE
        )
DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
        (
                INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
        )
TABLESPACE "DATA" LOB
        (
                "COL_CLOB"
        )
STORE AS SECUREFILE
        (
                TABLESPACE "DATA" ENABLE STORAGE IN ROW CHUNK 8192 NOCACHE LOGGING NOCOMPRESS KEEP_DUPLICATES STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
        )
;
/