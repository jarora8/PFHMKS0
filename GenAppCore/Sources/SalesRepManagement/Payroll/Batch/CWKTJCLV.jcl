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
//CWKTVSKS EXEC PGM=CWKTVSKS,PARM=00001
//*********************************************************************
//*  UPDATE THE CWKTVSKS.LOADLIB DATASET BELOW TO THE LOADLIB THAT    *
//*  CONTAINS THE CWKTVSKS TOPAZ FOR TOTAL TEST DEMO PROGRAM          *
//*********************************************************************
//*
//STEPLIB  DD   DISP=SHR,DSN=SALESSUP.GITx.UTn.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.FTn.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.STG.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.DEVL.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.MAIN.LOAD
//         DD   DISP=SHR,DSN=SALESSUP.GITx.PROD.LOAD
//         DD   DSN=CEE.SCEERUN,DISP=SHR
//*
//*********************************************************************
//*  UPDATE THE EMPFILE DD BELOW WITH THE DATASET NAME                *
//*  CREATED IN THE ECC 17 SLCXCNTL VSAMKSDS MEMBER                   *
//*********************************************************************
//EMPFILE  DD DISP=SHR,DSN=SALESSUP.GITx.TEST.CWKTKSDS
//RPTFILE  DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//