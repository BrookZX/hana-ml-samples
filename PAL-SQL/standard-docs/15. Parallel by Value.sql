SET SCHEMA DM_PAL;

DROP TABLE PAL_SES_DATA_GRP_TBL;
CREATE COLUMN TABLE PAL_SES_DATA_GRP_TBL (
    "GROUP_ID" NVARCHAR(10),
    "ID" INT,
    "RAWDATA" DOUBLE
);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  1, 200.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  2, 135.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  3, 195.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  4, 197.5);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  5, 310.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  6, 175.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  7, 155.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  8, 130.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1',  9, 220.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1', 10, 277.5);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_1', 11, 235.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  1, 200.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  2, 135.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  3, 195.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  4, 197.5);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  5, 310.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  6, 175.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  7, 155.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  8, 130.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2',  9, 220.0);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2', 10, 277.5);
INSERT INTO PAL_SES_DATA_GRP_TBL VALUES ('GROUP_2', 11, 235.0);

DROP TABLE PAL_SES_PARAMETER_GRP_TBL;
CREATE COLUMN TABLE PAL_SES_PARAMETER_GRP_TBL (
    "GROUP_ID" NVARCHAR(10),
	"PARAM_NAME" NVARCHAR(100),
	"INT_VALUE" INTEGER, 
	"DOUBLE_VALUE" DOUBLE, 
	"STRING_VALUE" NVARCHAR(100)
);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_1', 'ADAPTIVE_METHOD',0, NULL, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_1', 'MEASURE_NAME', NULL, NULL, 'MSE');
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_1', 'ALPHA', NULL,0.1, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_1', 'DELTA', NULL,0.2, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_1', 'FORECAST_NUM',12, NULL,NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_1', 'EXPOST_FLAG',1, NULL,NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_1', 'PREDICTION_CONFIDENCE_1', NULL, 0.8, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_1', 'PREDICTION_CONFIDENCE_2', NULL, 0.95, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_2', 'ADAPTIVE_METHOD',0, NULL, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_2', 'MEASURE_NAME', NULL, NULL, 'MSE');
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_2', 'ALPHA', NULL,0.1, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_2', 'DELTA', NULL,0.2, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_2', 'FORECAST_NUM',12, NULL,NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_2', 'EXPOST_FLAG',1, NULL,NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_2', 'PREDICTION_CONFIDENCE_1', NULL, 0.75, NULL);
INSERT INTO PAL_SES_PARAMETER_GRP_TBL VALUES ('GROUP_2', 'PREDICTION_CONFIDENCE_2', NULL, 0.8, NULL);

DROP TABLE PAL_SES_RESULT_GRP_TBL;
CREATE COLUMN TABLE PAL_SES_RESULT_GRP_TBL (
    "GROUP_ID" NVARCHAR(10),
    "TIMESTAMP" INT,
    "VALUE" DOUBLE,
    "PI1_LOWER" DOUBLE,
    "PI1_UPPER" DOUBLE,
    "PI2_LOWER" DOUBLE,
    "PI2_UPPER" DOUBLE
);

DROP TABLE PAL_SES_STAT_GRP_TBL;
CREATE COLUMN TABLE PAL_SES_STAT_GRP_TBL (
    "GROUP_ID" NVARCHAR(10),
    "STAT_NAME" NVARCHAR(100),
    "STAT_VALUE" DOUBLE
);

CALL _SYS_AFL.PAL_SINGLE_EXPSMOOTH(PAL_SES_DATA_GRP_TBL, PAL_SES_PARAMETER_GRP_TBL, PAL_SES_RESULT_GRP_TBL, PAL_SES_STAT_GRP_TBL)
    WITH OVERVIEW WITH HINT( PARALLEL_BY_PARAMETER_VALUES(p1.GROUP_ID, p2.GROUP_ID) );

SELECT * FROM PAL_SES_RESULT_GRP_TBL;
SELECT * FROM PAL_SES_STAT_GRP_TBL;