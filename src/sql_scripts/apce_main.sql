SELECT APCE.[APCE_Ident]
      ,APCE.[Admission_Date]
	  ,APCE.[Discharge_Date]
	  ,APCE.[Episode_Start_Date]
	  ,APCE.[Episode_End_Date]
	  ,APCE.[Episode_Number]
      ,APCE.[Ethnic_Group]
      ,ETH.[Ethnic_Category_Desc]
	  ,PG.[Person_Gender_Desc]
	  ,MSTAT.[Marital_Status_Desc]
	  ,APCE.[Der_Postcode_LSOA_Code]
	  ,LSOA.[LSOA_Name]
	  ,IMD.[IMD_Score]
	  ,IMD.[IMD_Decile]
	  ,IMD.[IMD_Rank]
	  ,PPSTAT.[Psychiatric_Patient_Status_Reason_Desc]
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
	  ,APCE.[Main_Specialty_Code]
	  ,MSPEC.[Main_Specialty_Desc]
	  ,MSPEC.[Main_Specialty_Group]
	  ,APCE.[Treatment_Function_Code]
	  ,TFC.[Treatment_Function_Desc]
	  ,TFC.[Treatment_Function_Group]
	  ,APCE_PROC.[Primary_Procedure_Code]
	  ,OPCS.[OPCS_L4_Desc]
	  ,OPCS.[OPCS_L2_Desc]
	  ,APCE_PROC.[Primary_Procedure_Date]
	  ,APCE_DIAG.[Primary_Diagnosis_Code]
	  ,REPLACE(APCE_DIAG.[Primary_Diagnosis_Code],'-','') as [Primary_Diagnosis_Code_TRUNC]
	  ,ICD.[ICD10_L4_Code]
	  ,ICD.[ICD10_L4_Desc]
	  ,ICD.[ICD10_L2_Desc]
	  ,APCE.[Admission_Method]
	  ,ADM.[Admission_Method_Desc]
	  ,APCE.[Source_of_Admission]
	  ,ADMS.[Admission_Source_Desc]
	  ,APCE.[Discharge_Destination]
	  ,DISDES.[Discharge_Destination_Desc]
	  ,APCE.[Discharge_Method]
	  ,DISMET.[Discharge_Method_Desc]
	  ,APCE.[Intended_Management]
	  ,INTM.[Intended_Management_Desc]
	  ,APCE.[Patient_Classification]
	  ,PTCLASS.[Patient_Classification_Desc]

FROM [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SEM_APCE] as [APCE]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_EthnicCategory] as [ETH]
ON APCE.[Ethnic_Group] = ETH.[Ethnic_Category]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_PersonGender] as [PG]
ON APCE.[Sex] = PG.[Person_Gender_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_MaritalStatus] as [MSTAT]
ON APCE.[Marital_Status] = MSTAT.[Marital_Status]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_LSOA] as [LSOA]
ON APCE.[Der_Postcode_LSOA_Code] = LSOA.[LSOA]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_Other_Deprivation_By_LSOA] as [IMD]
ON LSOA.[LSOA] = IMD.[LSOA_Code]
AND IMD.[Effective_Snapshot_Date] = '2019-12-31'

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_PsychiatricPatientStatus] as [PPSTAT]
ON APCE.[Psychiatric_Patient_Status] = PPSTAT.[Psychiatric_Patient_Status_Reason]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_AdministrativeCategory] as [ADMCAT]
ON APCE.[Administrative_Category] = ADMCAT.[Administrative_Category]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_CarerSupportIndicator] as [CSI]
ON APCE.[Carer_Support_Indicator] = CSI.[Carer_Support_Ind]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_WithheldIdentityReason] as [WIR]
ON APCE.[Withheld_Identity_Reason] = WIR.[Withheld_Identity_Reason]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Provider_Hierarchies] as [ORGPRO]
ON APCE.[Der_Provider_Code] = ORGPRO.[Organisation_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Provider_Site_Mappings] as [PRO_SITE]
ON APCE.[Der_Provider_Site_Code] = PRO_SITE.[Site_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Commissioner_Hierarchies] as [ORGCOMM]
ON APCE.[Der_Commissioner_Code] = ORGCOMM.[Organisation_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Wards] as [WARD]
ON APCE.[Der_Postcode_Electoral_Ward] = WARD.[Ward_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_MainSpecialty] as [MSPEC]
ON APCE.[Main_Specialty_Code] = MSPEC.[Main_Specialty_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_TreatmentFunction] as [TFC]
ON APCE.[Treatment_Function_Code] = TFC.[Treatment_Function_Code]

LEFT JOIN [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SEM_APCE_Proc] as [APCE_PROC]
ON APCE.[APCE_Ident] = APCE_PROC.[APCE_Ident]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ClinCode_OPCS] as [OPCS]
ON APCE_PROC.[Primary_Procedure_Code] = OPCS.[OPCS_L4_Code]

LEFT JOIN [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SEM_APCE_Diag] as [APCE_DIAG]
ON APCE.[APCE_Ident] = APCE_DIAG.[APCE_Ident]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ClinCode_ICD10_5ed] as [ICD]
ON REPLACE(APCE_DIAG.[Primary_Diagnosis_Code],'-','') = ICD.[ICD10_L4_Code]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_APC_AdmissionMethod] as [ADM]
ON APCE.[Admission_Method] = ADM.[Admission_Method_Der]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_APC_AdmissionSource] as [ADMS]
ON APCE.[Source_of_Admission] = ADMS.[Admission_Source]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_APC_DischargeDestination] as [DISDES]
ON APCE.[Discharge_Destination] = DISDES.[Discharge_Destination]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_APC_DischargeMethod] as [DISMET]
ON APCE.[Discharge_Method] = DISMET.[Discharge_Method]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_APC_IntendedManagement] as [INTM]
ON APCE.[Intended_Management] = INTM.[Intended_Management]

LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_APC_PatientClassification] as [PTCLASS]
ON APCE.[Patient_Classification] = PTCLASS.[Patient_Classification]

WHERE APCE.[Episode_Number] = 1
AND APCE.[Der_Provider_Code] = 'RJN'
AND APCE.[Admission_Date] = '2022-12-01'