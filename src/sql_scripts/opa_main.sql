SELECT OPA.[OPA_Ident]
      ,OPA.[Ethnic_Category]
	  ,ETH.[Ethnic_Category_Desc]
	  ,PG.[Person_Gender_Desc]
	  ,OPA.[Der_Postcode_LSOA_Code]
	  ,LSOA.[LSOA_Name]
	  ,IMD.[IMD_Score]
      ,IMD.[IMD_Decile]
      ,IMD.[IMD_Rank]
	  ,ADMCAT.[Administrative_Category_Desc]
	  ,CSI.[Carer_Support_Ind_Desc]
	  ,WIR.[Withheld_Identity_Reason_Desc]
	  ,ORGPRO.[Organisation_Name]
      ,ORGPRO.[STP_Code] as [Provider_ICB_Code]
      ,ORGPRO.[STP_Name] as [Provider_ICB_Name]
      ,ORGPRO.[Region_Code] as [Provider_Region_Code]
      ,ORGPRO.[Region_Name] as [Provider_Region_Name]
	  ,PRO_SITE.[Site_Name]
	  ,ORGCOMM.[Organisation_Name] as [Commissioner_Name]
	  ,ORGCOMM.[STP_Code] as [Commissioner_ICB_Code]
	  ,ORGCOMM.[STP_Name] as [Commissioner_ICB_Name]
	  ,ORGCOMM.[Region_Code] as [Commissioner_Region_Code]
	  ,ORGCOMM.[Region_Name] as [Commissioner_Region_Name]
	  ,LSOA.[LSOA_Name]
	  ,WARD.[Ward_Name]
	  ,OPA.[Main_Specialty_Code]
      ,MSPEC.[Main_Specialty_Desc]
      ,MSPEC.[Main_Specialty_Group]
	  ,OPA.[Treatment_Function_Code]
	  ,TFC.[Treatment_Function_Desc]
	  ,TFC.[Treatment_Function_Group]
	  ,FFU.[First_Attendance_Desc]
	  ,ATTSTAT.[Attendance_Status_Desc_Short]
	  ,ATTOUT.[Attendance_Outcome_Desc]
	  ,OPA_DIAG.[Primary_Diagnosis_Code]
      ,REPLACE(OPA_DIAG.[Primary_Diagnosis_Code],'-','') as [Primary_Diagnosis_Code_TRUNC]
      ,ICD.[ICD10_L4_Code]
      ,ICD.[ICD10_L4_Desc]
      ,ICD.[ICD10_L2_Desc]
	  ,OPA_PROC.[Primary_Procedure_Code]
      ,OPCS.[OPCS_L4_Desc]
      ,OPCS.[OPCS_L2_Desc]
	  ,CONMED.[Consultation_Medium_Used_Desc]
	  ,PT.[Priority_Type_Desc]
	  ,RS.[Referral_Source_Desc]
	  ,STREQ.[Service_Type_Requested_Desc]

FROM [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SEM_OPA] as [OPA]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_EthnicCategory] as [ETH]
ON OPA.[Ethnic_Category] = ETH.[Ethnic_Category]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_PersonGender] as [PG]
ON OPA.[Sex] = PG.[Person_Gender_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_LSOA] as [LSOA]
ON OPA.[Der_Postcode_LSOA_Code] = LSOA.[LSOA]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_Other_Deprivation_By_LSOA] as [IMD]
ON LSOA.[LSOA] = IMD.[LSOA_Code]
AND IMD.[Effective_Snapshot_Date] = '2019-12-31'

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_AdministrativeCategory] as [ADMCAT]
ON OPA.[Administrative_Category] = ADMCAT.[Administrative_Category]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_CarerSupportIndicator] as [CSI]
ON OPA.[Carer_Support_Indicator] = CSI.[Carer_Support_Ind]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_WithheldIdentityReason] as [WIR]
ON OPA.[Withheld_Identity_Reason] = WIR.[Withheld_Identity_Reason]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Provider_Hierarchies] as [ORGPRO]
ON OPA.[Der_Provider_Code] = ORGPRO.[Organisation_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Provider_Site_Mappings] as [PRO_SITE]
ON OPA.[Der_Provider_Site_Code] = PRO_SITE.[Site_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Commissioner_Hierarchies] as [ORGCOMM]
ON OPA.[Der_Commissioner_Code] = ORGCOMM.[Organisation_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Wards] as [WARD]
ON OPA.[Der_Postcode_Electoral_Ward] = WARD.[Ward_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_MainSpecialty] as [MSPEC]
ON OPA.[Main_Specialty_Code] = MSPEC.[Main_Specialty_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_TreatmentFunction] as [TFC]
ON OPA.[Treatment_Function_Code] = TFC.[Treatment_Function_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_OPA_FirstAttendance] as [FFU]
ON OPA.[First_Attendance] = FFU.[First_Attendance]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_OPA_AttendanceStatus] as [ATTSTAT]
ON OPA.[Attendance_Status] = ATTSTAT.[Attendance_Status]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_OPA_AttendanceOutcome] as [ATTOUT]
ON OPA.[Outcome_of_Attendance] = ATTOUT.[Attendance_Outcome]

LEFT JOIN [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SEM_OPA_Diag] as [OPA_DIAG]
ON OPA.[OPA_Ident] = OPA_DIAG.[OPA_Ident]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ClinCode_ICD10_5ed] as [ICD]
ON REPLACE(OPA_DIAG.[Primary_Diagnosis_Code],'-','') = ICD.[ICD10_L4_Code]

LEFT JOIN [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SEM_OPA_Proc] as [OPA_PROC]
ON OPA.[OPA_Ident] = OPA_PROC.[OPA_Ident]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ClinCode_OPCS] as [OPCS]
ON OPA_PROC.[Primary_Procedure_Code] = OPCS.[OPCS_L4_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_OPA_ConsultationMediumUsed] as [CONMED]
ON OPA.[Consultation_Medium_Used] = CONMED.[Consultation_Medium_Used]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_OPA_PriorityType] as [PT]
ON OPA.[Priority_Type] = PT.[Priority_Type]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_OPA_ReferralSource] as [RS]
ON OPA.[OPA_Referral_Source] = RS.[Referral_Source]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_OPA_ServiceTypeRequested] as [STREQ]
ON OPA.[Service_Type_Requested] = STREQ.[Service_Type_Requested]

WHERE OPA.[Der_Provider_Code] = 'RXR'
AND OPA.[Appointment_Date] = '2022-10-11'
