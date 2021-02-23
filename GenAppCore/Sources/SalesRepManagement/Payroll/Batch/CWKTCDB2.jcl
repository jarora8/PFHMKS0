//* INSERT JOB CARD HERE
//*
//*********************************************************************
//*  USE THIS JCL TO PREPARE THE SAMPLE COBOL PROGRAM AND ITS
//*  ASSOCIATED DB2 TABLE FOR TOPAZ FOR TOTAL TEST VERIFICATION.
//*********************************************************************
//*
//*  THIS JCL PREPARES THE COBOL PROGRAM, CWKTDB2X, AND ITS DB2 TABLE,
//*  KT_DEMOTAB, FOR TESTING THE DB2 SUPPORT OF TOPAZ FOR TOTAL TEST.
//*  THIS COBOL APPLICATION IS BOUND USING PLAN PACKAGE SUPPORT.
//*
//*  WHEN RUN UNDER XPEDITER ECLIPSE TO GENERATE A UNIT TEST CASE,
//*  SQL STUBS WILL BE CREATED FOR OPEN, FETCH, CLOSE
//*  AND SELECT STATEMENTS.
//*
//*  NOTE: DB2 AUTHORIZATION IS REQUIRED FOR THIS JOB.
//*        IF THE TABLESPACE AND DATABASE REFERENCED BY THIS
//*        JCL ARE NOT DEFINED, THEY WILL NEED TO BE CREATED
//*        BY A DBA.  VERIFY THAT THE CREATED TABLESPACE AND
//*        DATABASE NAMES MATCH THOSE BEING USED IN THIS JCL.
//*
//*  REQUIRED: CHANGE THE JOBCARD, DATASET NAMES IN PROC SECTION
//*  DB2 DATABASE, TABLESPACE, SSID, AND PLAN NAMES.
//*
//KTDB2X   PROC UNIT='SYSALLDA',
//         SDSNLOAD='DB2 SDSNLOAD',
//         RUNLIB='DB2 RUNLIB.LOAD',
//         DSNEXIT='DB2 SDSNEXIT',
//         COBCOMP='IGY.SIGYCOMP',
//         COBLINK='CEE.SCEELKED',
//         COBRUN='CEE.SCEERUN',
//         CXLOAD='CPWR.MLCXNNN.SLCXLOAD',
//         CXCNTL='CPWR.MLCXNNN.SLCXCNTL',
//         CLPPARM='CXLPCOBB',  <== ECC SOURCE COMPILE OPTIONS
//         TSTLOAD='CWKTDB2X LOAD LIBRARY',
//         LSTFILE='SOURCE LISTING DATASET'
//*****************************************************************
//*  CREATE THE DB2 TABLE                                         *
//*****************************************************************
//CREATE       EXEC PGM=IKJEFT01,DYNAMNBR=20
//STEPLIB      DD  DISP=SHR,DSN=&SDSNLOAD
//             DD  DISP=SHR,DSN=&RUNLIB
//SYSTSPRT     DD  SYSOUT=*,DCB=BLKSIZE=2420
//SYSPRINT     DD  SYSOUT=*
//SYSUDUMP     DD  SYSOUT=*
//*****************************************************************
//* PRECOMPILE THE COBOL PROGRAM                                  *
//*****************************************************************
//PC           EXEC PGM=DSNHPC,REGION=4096K,
//             PARM='HOST(COBOL),APOST,APOSTSQL,SOURCE,VERSION(AUTO)'
//DBRMLIB      DD  DSN=&&DBRM(CWKTDB2X),DISP=(NEW,PASS),
//             SPACE=(TRK,(1,1,5)),UNIT=&UNIT,DCB=SYS1.MACLIB
//STEPLIB      DD  DISP=SHR,DSN=&DSNEXIT
//             DD  DISP=SHR,DSN=&SDSNLOAD
//SYSCIN       DD  DSN=&&DSNHOUT,DISP=(MOD,PASS),UNIT=&UNIT,
//             SPACE=(800,(500,500))
//SYSLIB       DD  DSN=SYS1.MACLIB,DISP=SHR
//SYSPRINT     DD  SYSOUT=*
//SYSTERM      DD  SYSOUT=*
//SYSUDUMP     DD  SYSOUT=*
//SYSUT1       DD  SPACE=(800,(500,500),,,ROUND),UNIT=&UNIT
//SYSUT2       DD  SPACE=(800,(500,500),,,ROUND),UNIT=&UNIT
//SYSIN        DD  DSN=&CXCNTL(CWKTDB2X),
//             DISP=SHR
//*****************************************************************
//* COMPILE COBOL PROGRAM IF PRECOMPILE RC <= 4                   *
//*****************************************************************
//COB      EXEC PGM=CWPCMAIN,REGION=4096K,COND=(4,LT,PC),
//  PARM=(NOADV,LANGUAGE('COBOLZ/OS'),APOST,NOSEQ,NONAME,NODYN,NORES,
//             LIST)
//STEPLIB  DD  DSN=&CXLOAD,DISP=SHR
//         DD  DSN=&COBCOMP,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  DSN=&&DSNHOUT,DISP=(OLD,DELETE)
//CWPDDIO  DD  DSN=&LSTFILE,DISP=SHR
//CWPPRMO  DD  DSN=&CXCNTL(&CLPPARM),
//         DISP=SHR
//SYSLIN   DD  DSN=&&LOADSET,DISP=(MOD,PASS),UNIT=&UNIT,
//         SPACE=(800,(500,500))
//SYSUT1   DD  DSN=&&SYSUT1,UNIT=&UNIT,
//         SPACE=(1024,(120,120),,,ROUND)
//SYSUT2   DD  DSN=&&SYSUT2,UNIT=&UNIT,
//         SPACE=(1024,(120,120),,,ROUND)
//SYSUT3   DD  DSN=&&SYSUT3,UNIT=&UNIT,
//         SPACE=(1024,(120,120),,,ROUND)
//SYSUT4   DD  DSN=&&SYSUT4,UNIT=&UNIT,
//         SPACE=(1024,(120,120),,,ROUND)
//SYSUT5   DD  DSN=&&SYSUT5,UNIT=&UNIT,
//         SPACE=(1024,(120,120),,,ROUND)
//SYSUT6   DD  DSN=&&SYSUT6,UNIT=&UNIT,
//         SPACE=(1024,(120,120),,,ROUND)
//SYSUT7   DD  DSN=&&SYSUT7,UNIT=&UNIT,
//         SPACE=(1024,(120,120),,,ROUND)
//SYSUT8   DD  DSN=&&SYSUT8,UNIT=&UNIT,
//         SPACE=(1024,(120,120),,,ROUND)
//SYSUT9   DD  UNIT=SYSALLDA,SPACE=(CYL,(1,1))
//SYSUT10  DD  UNIT=SYSALLDA,SPACE=(CYL,(1,1))
//SYSUT11  DD  UNIT=SYSALLDA,SPACE=(CYL,(1,1))
//SYSUT12  DD  UNIT=SYSALLDA,SPACE=(CYL,(1,1))
//SYSUT13  DD  UNIT=SYSALLDA,SPACE=(CYL,(1,1))
//SYSUT14  DD  UNIT=SYSALLDA,SPACE=(CYL,(1,1))
//SYSUT15  DD  UNIT=SYSALLDA,SPACE=(CYL,(1,1))
//SYSMDECK DD  UNIT=SYSALLDA,SPACE=(CYL,(1,1))
//*
//*****************************************************************
//* LINKEDIT IF PRECOMPILE & COMPILE RC <= 4                      *
//*****************************************************************
//LKED         EXEC PGM=IEWL,PARM='XREF',
//             COND=((4,LT,COB),(4,LT,PC))
//SYSLIB       DD  DSN=&COBLINK,
//             DISP=SHR
//             DD  DSN=&SDSNLOAD,
//             DISP=SHR
//             DD  DSN=&TSTLOAD,
//             DISP=SHR
//             DD  DSN=&RUNLIB,
//             DISP=SHR
//             DD  DSN=&CXLOAD,
//             DISP=SHR
//SYSLIN       DD  DSN=&&LOADSET,DISP=(OLD,DELETE)
//             DD  DDNAME=SYSIN
//SYSLMOD      DD  DSN=&TSTLOAD(CWKTDB2X),
//             DISP=SHR
//SYSPRINT     DD  SYSOUT=*
//SYSUDUMP     DD  SYSOUT=*
//SYSUT1       DD  SPACE=(1024,(50,50)),UNIT=&UNIT
//*****************************************************************
//* BIND THE DB2 APPLICATION PLAN.                                *
//*****************************************************************
//BINDKTDB     EXEC PGM=IKJEFT01,DYNAMNBR=64,TIME=0005,
//             REGION=4096K
//STEPLIB      DD  DSN=&SDSNLOAD,
//             DISP=SHR
//             DD  DSN=&COBRUN,
//             DISP=SHR
//             DD  DSN=&CXLOAD,
//             DISP=SHR
//             DD  DSN=&TSTLOAD,
//             DISP=SHR
//DBRMLIB      DD  DSN=&&DBRM,DISP=(OLD,DELETE)
//SYSUDUMP     DD  SYSOUT=*
//SYSOUT       DD  SYSOUT=*
//SYSTSPRT     DD  SYSOUT=*
//****************************************************************      00490006
//*  GRANT ALL NECESSARY AUTHORIZATIONS                          *
//****************************************************************
//GRANT    EXEC PGM=IKJEFT01,DYNAMNBR=20
//STEPLIB      DD  DSN=&SDSNLOAD,
//             DISP=SHR
//             DD  DSN=&RUNLIB,
//             DISP=SHR
//             DD  DSN=&TSTLOAD,
//             DISP=SHR
//SYSTSPRT DD SYSOUT=*,DCB=BLKSIZE=2420
//SYSPRINT DD SYSOUT=*                                                  00560006
//SYSUDUMP DD SYSOUT=*                                                  00570006
//*****************************************************************
//* RUN THE PROGRAM TO VERIFY IT CAN EXECUTE.                     *
//*****************************************************************
//RUNDB2X      EXEC PGM=IKJEFT01,DYNAMNBR=64,TIME=0005,
//             REGION=4096K
//STEPLIB      DD  DSN=&SDSNLOAD,
//             DISP=SHR
//             DD  DSN=&COBRUN,
//             DISP=SHR
//             DD  DSN=&CXLOAD,
//             DISP=SHR
//             DD  DSN=&TSTLOAD,
//             DISP=SHR
//SYSUDUMP     DD  SYSOUT=*
//SYSOUT       DD  SYSOUT=*
//SYSTSPRT     DD  SYSOUT=*
//KTDB2X       PEND
//KTDB2X       EXEC PROC=KTDB2X
//CREATE.SYSTSIN DD  *
  DSN SYSTEM(SSID)
  RUN PROGRAM(DSNTIAD) PLAN(DSNTIANN)
//*********************************************************************
//* THE CREATE TABLE SQL IS NEEDED FOR THE DB2 SAMPLE PROGRAM.
//* IF RESUBMITTING THIS JCL AFTER THE TABLE IS CREATED, AN ERROR WILL
//* OCCUR.  THIS CAN BE AVOIDED WITH THE DROP TABLE SQL.
//* REMOVE THE JCL COMMENT AND MOVE THE DROP TABLE SQL STATEMENT TO
//* BEFORE THE CREATE TABLE STATEMENT.
//*********************************************************************
//* DROP   TABLE KT_DEMOTAB;
//* COMMIT;
//CREATE.SYSIN DD  *
  CREATE TABLE KT_DEMOTAB
  (EMP_NUM        CHAR(5)       NOT NULL,
   WAGE_TYPE      CHAR(1)               ,
   REGION         SMALLINT              ,
   FIRST_LAST_NAME VARCHAR(15)          ,
   STREET_ADDR    VARCHAR(15)           ,
   CITY           VARCHAR(8)            ,
   STATE          CHAR(2)               ,
   ZIP            CHAR(6)               ,
   HIREDATE       CHAR(6)               ,
   HOURS          DECIMAL(2)            ,
   RATE           DECIMAL(6,2)          ,
   WAGES          DECIMAL(6,2)          ,
   OVERTIME       DECIMAL(6,2)          ,
   COMM           DECIMAL(6,2)          )
   IN DATABASE.TABLESPACE;
  INSERT INTO KT_DEMOTAB
        (EMP_NUM        ,
         WAGE_TYPE      ,
         REGION         ,
         FIRST_LAST_NAME ,
         STREET_ADDR    ,
         CITY           ,
         STATE          ,
         ZIP            ,
         HOURS          ,
         RATE           ,
         WAGES          ,
         HIREDATE       ,
         OVERTIME       ,
         COMM           )
         VALUES
         ('03431',
          'H', 2,
          'GAIL LAWRENCE', '123 NORTH AVE', 'PLANO', 'TX', '57010',
            38, 2.50,
            0.00,
            '840625',
            0.00,
            0.00);
  INSERT INTO KT_DEMOTAB
        (EMP_NUM        ,
         WAGE_TYPE      ,
         REGION         ,
         FIRST_LAST_NAME ,
         STREET_ADDR    ,
         CITY           ,
         STATE          ,
         ZIP            ,
         HOURS          ,
         RATE           ,
         WAGES          ,
         HIREDATE       ,
         OVERTIME       ,
         COMM           )
         VALUES
         ('02523',
          'H', 1,
          'JOHN SMITH   ', '5456 ELM STREET', 'WAYNE', 'IL', '77902',
            30, 2.50,
            0.00,
            '811015',
            0.00,
            0.00);
  INSERT INTO KT_DEMOTAB
        (EMP_NUM        ,
         WAGE_TYPE      ,
         REGION         ,
         FIRST_LAST_NAME ,
         STREET_ADDR    ,
         CITY           ,
         STATE          ,
         ZIP            ,
         HOURS          ,
         RATE           ,
         WAGES          ,
         HIREDATE       ,
         OVERTIME       ,
         COMM           )
         VALUES
         ('01568',
          'H', 4,
          'THOMAS LONG  ', '12 RACE STREET', 'SAN JOSE', 'CA', '95126',
            40, 2.50,
            0.00,
            '870331',
            0.00,
            0.00);
  INSERT INTO KT_DEMOTAB
        (EMP_NUM        ,
         WAGE_TYPE      ,
         REGION         ,
         FIRST_LAST_NAME ,
         STREET_ADDR    ,
         CITY           ,
         STATE          ,
         ZIP            ,
         HOURS          ,
         RATE           ,
         WAGES          ,
         HIREDATE       ,
         OVERTIME       ,
         COMM           )
         VALUES
          ('03241', 'H', 3,
           'MARCIA SULLIVAN','55 SOUTH STREET',
            'NEW YORK', 'NY', '10017', 44, 3.00,
            0.0,
            '930405', 0.0, 0.0
            );
  INSERT INTO KT_DEMOTAB
        (EMP_NUM        ,
         WAGE_TYPE      ,
         REGION         ,
         FIRST_LAST_NAME ,
         STREET_ADDR    ,
         CITY           ,
         STATE          ,
         ZIP            ,
         HOURS          ,
         RATE           ,
         WAGES          ,
         HIREDATE       ,
         OVERTIME       ,
         COMM           )
           VALUES
          ('01343', 'H', 3,
           'JAMES MORRISON ','11-A MAPLE AVE ',
            'SYRACUSE', 'NY', '12123', 37, 2.75,
            0.0,
            '910913', 0.0, 0.0
            );
  INSERT INTO KT_DEMOTAB
        (EMP_NUM        ,
         WAGE_TYPE      ,
         REGION         ,
         FIRST_LAST_NAME ,
         STREET_ADDR    ,
         CITY           ,
         STATE          ,
         ZIP            ,
         HOURS          ,
         RATE           ,
         WAGES          ,
         HIREDATE       ,
         OVERTIME       ,
         COMM           )
         VALUES
          ('02171', 'H', 4,
           'SAMUEL ADDAMS ','900 LINCOLN CT',
            'RENO', 'NV', '82433', 42, 2.75,
            0.0,
            '860102', 0.0, 0.0
            );
  INSERT INTO KT_DEMOTAB
        (EMP_NUM        ,
         WAGE_TYPE      ,
         REGION         ,
         FIRST_LAST_NAME ,
         STREET_ADDR    ,
         CITY           ,
         STATE          ,
         ZIP            ,
         HOURS          ,
         RATE           ,
         WAGES          ,
         HIREDATE       ,
         OVERTIME       ,
         COMM           )
         VALUES
          ('59999', 'H', 4,
           'MAX E MILLION ','100 MAIN ST   ',
            'MAIN', 'OH', '34093', 88, 2.50,
            0.0,
            '910203', 0.0, 0.0
            );
  COMMIT;
/*
//BINDKTDB.SYSTSIN  DD *                                                03420006
 DSN SYSTEM(SSID)
 BIND PACKAGE(KTDEVTST) MEMBER(CWKTDB2X) -
     ACTION(REPLACE)   -
     VALIDATE(BIND)   -
     ISOLATION(CS)    -
     RELEASE(COMMIT)
 BIND PLAN(CWKTDB2X) PKLIST(KTDEVTST.CWKTDB2X) -
     ACTION(REPLACE) RETAIN -
     CACHESIZE(4096)  -
     CURRENTDATA(YES) -
     VALIDATE(RUN)    -
     ISOLATION(CS)    -
     ACQUIRE(USE) -
     RELEASE(COMMIT)
//GRANT.SYSTSIN  DD *
 DSN SYSTEM(SSID)
 RUN PROGRAM(DSNTIAD) PLAN(DSNTIANN)
//GRANT.SYSIN    DD *
 GRANT EXECUTE ON PLAN CWKTDB2X TO PUBLIC;
 GRANT EXECUTE ON PACKAGE KTDEVTST.CWKTDB2X TO PUBLIC;
//RUNDB2X.SYSTSIN  DD *                                                 03420006
 DSN SYSTEM(SSID)
 RUN PROGRAM(CWKTDB2X) PLAN(CWKTDB2X) PARMS('00001')
 END
/*
//EMPFILE  DD  DSN=&CXCNTL(TTTDATD),
//         DISP=SHR
//RPTFILE  DD  SYSOUT=*
//SYSOUT   DD  SYSOUT=*
//