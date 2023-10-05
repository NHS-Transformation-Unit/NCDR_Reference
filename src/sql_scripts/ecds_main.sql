SELECT ECDS.[EC_Ident]
	  ,ECDS.[EC_Department_Type]
	  ,ECDS.[Der_EC_Arrival_Date_Time]
	  ,ECDS.[Der_EC_Departure_Date_Time]
	  ,ECDS.[EC_Initial_Assessment_Time_Since_Arrival]
	  ,ECDS.[EC_Seen_For_Treatment_Time_Since_Arrival]
	  ,ECDS.[EC_Decision_To_Admit_Time_Since_Arrival]
	  ,ECDS.[Clinically_Ready_To_Proceed_Time_Since_Arrival]
	  ,ECDS.[EC_Conclusion_Time_Since_Arrival]
	  ,ECDS.[EC_Departure_Time_Since_Arrival]
	  ,ECDS.[Der_Age_At_CDS_Activity_Date] as [Age]
	  ,PG.[Person_Gender_Desc] as [Gender]
	  ,ETH.[Ethnic_Category_Desc]
	  ,ECDS.[Der_Postcode_LSOA_Code]
      ,LSOA.[LSOA_Name]
      ,IMD.[IMD_Score]
	  ,IMD.[IMD_Decile]
      ,IMD.[IMD_Rank]
      ,WIR.[Withheld_Identity_Reason_Desc]
	  ,LSOA.[LSOA_Name]
      ,WARD.[Ward_Name]
	  ,ECDS.[Der_Provider_Site_Code]
	  ,PRO_Site.[Provider_Site_Name] as [Provider_Site]
	  ,ECDS.[Der_Provider_Code]
	  ,ORGPRO.[Organisation_Name] as [Provider_Name]
	  ,ORGPRO.[STP_Code] as [Provider_ICB_Code]
	  ,ORGPRO.[STP_Name] as [Provider_ICB_Name]
	  ,ORGPRO.[Region_Code] as [Provider_Region_Code]
	  ,ORGPRO.[Region_Name] as [Provider_Region_Name]
	  ,ORGCOMM.[Organisation_Name] as [Commissioner_Name]
	  ,ORGCOMM.[STP_Code] as [Commissioner_ICB_Code]
	  ,ORGCOMM.[STP_Name] as [Commissioner_ICB_Name]
	  ,ORGCOMM.[Region_Code] as [Commissioner_Region_Code]
	  ,ORGCOMM.[Region_Name] as [Commissioner_Region_Name]
	  ,ECDS.[EC_Chief_Complaint_SNOMED_CT]
      ,CCOM.[ChiefComplaintCodeDescription]
      ,CCOMG.[ChiefComplaintGrouping]
	  ,ECDS_DIAG.[EC_Diagnosis_01]
      ,DIAGS.[DiagnosisDescription]
	  ,ECDS_INV.[EC_Investigation_01]
      ,INVS.[InvestigationDescription]
	  ,ECDS_TRT.[EC_Treatment_01]
      ,TRTS.[ProcedureDescription] as [TreatmentDescription]
	  ,ECDS.[EC_Injury_Intent_SNOMED_CT]
      ,INJINT.[InjuryIntentDescription]
	  ,ECDS.[EC_Arrival_Mode_SNOMED_CT]
      ,ARI.[ArrivalModeDescription]
	  ,ECDS.[Discharge_Destination_SNOMED_CT]
      ,DISDES.[DischargeDestinationDescription]
	  ,ECDS.[EC_Acuity_SNOMED_CT]
      ,ACT.[AcuityDescription]
      ,ACT.[AcuityKey]
	  ,ECDS.[EC_Attendance_Source_SNOMED_CT]
      ,ATTSRC.[AttendanceSourceDescription]
	  ,HRG_2223.[Attend_Core_HRG]

  FROM [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC] AS [ECDS]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_PersonGender] as [PG]
  ON ECDS.[Sex] = PG.[Person_Gender_Code]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_EthnicCategory] as [ETH]
  ON ECDS.[Ethnic_Category] = ETH.[Ethnic_Category]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_LSOA] as [LSOA]
  ON ECDS.[Der_Postcode_LSOA_Code] = LSOA.[LSOA]
  
  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_Other_Deprivation_By_LSOA] as [IMD]
  ON LSOA.[LSOA] = IMD.[LSOA_Code]
  AND IMD.[Effective_Snapshot_Date] = '2019-12-31'

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ZZZ_WithheldIdentityReason] as [WIR]
  ON ECDS.[Withheld_Identity_Reason] = WIR.[Withheld_Identity_Reason]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_ProviderSite] as [PRO_Site]
  ON ECDS.[Der_Provider_Site_Code] = PRO_Site.[Provider_Site_Code]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Provider_Hierarchies] as [ORGPRO]
  ON ECDS.[Der_Provider_Code] = ORGPRO.[Organisation_Code]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Commissioner_Hierarchies] as [ORGCOMM]
  ON ECDS.[Der_Commissioner_Code] = ORGCOMM.[Organisation_Code]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_Wards] as [WARD]
  ON ECDS.[Der_Postcode_Electoral_Ward] = WARD.[Ward_Code]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Chief_Complaint] as [CCOM]
  ON ECDS.[EC_Chief_Complaint_SNOMED_CT] = CCOM.[ChiefComplaintCode]
  
  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Chief_Complaint_Group] as [CCOMG]
  ON ECDS.[EC_Chief_Complaint_SNOMED_CT] = CCOMG.[ChiefComplaintCode]

  LEFT JOIN [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC_Diagnosis] as [ECDS_DIAG]
  ON ECDS.[EC_Ident] = ECDS_DIAG.[EC_Ident]
  
  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Diagnosis] as [DIAGS]
  ON [ECDS_DIAG].[EC_Diagnosis_01] = DIAGS.[DiagnosisCode]

  LEFT JOIN [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC_Investigation] as [ECDS_INV]
  ON ECDS.[EC_Ident] = ECDS_INV.[EC_Ident]
  
  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Investigation] as [INVS]
  ON ECDS_INV.[EC_Investigation_01] = INVS.[InvestigationCode]

  LEFT JOIN [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC_Treatment] as [ECDS_TRT]
  ON ECDS.[EC_Ident] = ECDS_TRT.[EC_Ident]
  
  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Procedure] as [TRTS]
  ON ECDS_TRT.[EC_Treatment_01] = TRTS.[ProcedureCode]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Injury_Intent] as [INJINT]
  ON ECDS.[EC_Injury_Intent_SNOMED_CT] = INJINT.[InjuryIntentCode]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Arrival_Mode] as [ARI]
  ON ECDS.[EC_Arrival_Mode_SNOMED_CT] = ARI.[ArrivalModeCode]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Discharge_Destination] as [DISDES]
  ON ECDS.[Discharge_Destination_SNOMED_CT] = DISDES.[DischargeDestinationCode]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Acuity] as [ACT]
  ON ECDS.[EC_Acuity_SNOMED_CT] = ACT.[AcuityCode]

  LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_DataDic_ECDS_Attendance_Source] as [ATTSRC]
  ON ECDS.[EC_Attendance_Source_SNOMED_CT] = ATTSRC.[AttendanceSourceCode]

  LEFT JOIN [NHSE_SUSPlus_Live].[dbo].[tbl_Data_SUS_EC_2223_Der] as [HRG_2223]
  ON ECDS.[EC_Ident] = HRG_2223.[EC_Ident]

  WHERE ECDS.[Der_Provider_Site_Code] = 'R0A07'
  AND ECDS.[Arrival_Date] = '2023-01-10'
  AND ECDS.[Der_Dupe_Flag] = 0
  AND ECDS.[Arrival_Planned] = 'FALSE'
