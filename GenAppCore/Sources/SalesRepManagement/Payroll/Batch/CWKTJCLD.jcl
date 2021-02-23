//HDDRXM0X JOB ('FTS'),'GITDEMO',NOTIFY=&SYSUID,
//             MSGLEVEL=(1,1),MSGCLASS=X,CLASS=A,REGION=6M
/*JOBPARM S=CWCC
//* *******************************************************************
//*
//*  INSTRUCTIONS:
//*  =============
//*
//*  1) C ALL GITx      TO YOUR APPLICATION CODE
//*  2) C UTn           TO THE UT LEVEL YOUR PROGRAM IS CURRENTLY AT
//*  2) C FTn           TO THE FT LEVEL YOUR PROGRAM IS CURRENTLY AT
//*  3) C ALL HDDRXM0   TO YOUR USERID
//*  5) SUB
//*
//* *******************************************************************
//*
//*   EXECUTION JCL FOR COBOL DEMO PROGRAM CWBWCOBX
//*
//CWKTDB2X EXEC PGM=IKJEFT01,DYNAMNBR=64,TIME=0005,
// REGION=2048K
//*
//*********************************************************************
//*  UPDATE THE CWKTDB2X.LOADLIB DATASET BELOW TO THE LOADLIB THAT    *
//*  CONTAINS THE CWKTDB2X TOPAZ FOR TOTAL TEST DEMO PROGRAM          *
//*  ALSO UPDATE THE DB2 DATASETS TO VALID NAMES FOR YOUR SYSTEM      *
//*********************************************************************
//STEPLIB  DD DISP=SHR,DSN=DB2.RUNLIB.LOAD
//         DD DISP=SHR,DSN=DB2.SDSNLOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.UTn.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.FTn.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.STG.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.DEVL.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.MAIN.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.PROD.LOAD
//         DD   DSN=CEE.SCEERUN,DISP=SHR
//         DD DISP=SHR,DSN=CEE.SCEERUN
//*
//SYSUDUMP DD SYSOUT=*
//ABENDAID DD SYSOUT=*
//ABNLTERM DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//*********************************************************************
//*  UPDATE THE EMPFILE DD BELOW WITH THE ECC 17 SLCXCNTL DATASET     *
//*  NAME FOR YOUR SYSTEM                                             *
//*********************************************************************
//*
//EMPFILE  DD DISP=SHR,DSN=SALESSUP.GITx.TEST.CWKTDB2
//*
//RPTFILE  DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//*********************************************************************
//*  UPDATE THE SSID VALUE BELOW TO THAT USED IN THE                  *
//*  CWKTCDB2 MEMBER IN THE ECC SLCXCNTL DATASET                      *
//*********************************************************************
//SYSTSIN  DD *
 DSN SYSTEM(SSID)
 RUN PROGRAM(CWKTDB2X) PLAN(CWKTDB2X) PARMS('00001')
 END
/*
//