-- Description:
-- This query is designed to extract and format detailed contract, customer, and logistics data for a given LOT.
-- It performs conditional transformations, date formatting, numeric aggregations, and joins with related user-created forms.

SELECT 
    -- Report Date in format YYYY/MM/DD
    REPLACE(CONVERT(varchar, GETDATE(), 111), '-', '/') AS in_ReportDate,

    -- Boolean flags converted from text values in the title table
    CASE WHEN title.fldColumn_10 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_ShipmentDateOfPO,
    CASE WHEN title.fldColumn_14 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_DispatchedDateFromFactory,
    CASE WHEN title.fldColumn_15 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_DepartureDate,
    CASE WHEN title.fldColumn_16 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_DeliveryTimeETA,
    CASE WHEN title.fldColumn_34 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_PrepaidDate,
    CASE WHEN title.fldColumn_39 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_InvoicePaidDate,
    CASE WHEN title.fldColumn_42 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_ProductionDate,
    CASE WHEN title.fldColumn_43 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_BestBeforeDate,
    CASE WHEN contract.fldColumn_1 IN ('1', 'True') THEN 'true' ELSE 'false' END AS chek_DateOfContract,
    CASE WHEN contract.fldColumn_11 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_ShipmentPeriodFrom,
    CASE WHEN contract.fldColumn_12 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_ShipmentPeriodTo,
    CASE WHEN contract.fldColumn_21 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_AdvancedPaymentDate,
    CASE WHEN contract.fldColumn_24 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_CashDate,
    CASE WHEN contract.fldColumn_26 IN ('1', 'True') THEN 'true' ELSE 'false' END AS lbl_CreditDate,

    -- Conditional date conversions from title table (formatting date as YYYY/MM/DD)
    CASE WHEN title.fldColumn_10 IN ('1', 'True') THEN REPLACE(CAST(title.fldColumn_11 AS DATE), '-', '/') ELSE '' END AS in_ShipmentDateOfPO,
    CASE WHEN title.fldColumn_14 IN ('1', 'True') THEN REPLACE(CAST(title.fldColumn_17 AS DATE), '-', '/') ELSE '' END AS in_DispatchedDateFromFactory,
    CASE WHEN title.fldColumn_15 IN ('1', 'True') THEN REPLACE(CAST(title.fldColumn_18 AS DATE), '-', '/') ELSE '' END AS in_DepartureDate,
    CASE WHEN title.fldColumn_16 IN ('1', 'True') THEN REPLACE(CAST(title.fldColumn_20 AS DATE), '-', '/') ELSE '' END AS in_DeliveryTimeETA,
    CASE WHEN title.fldColumn_34 IN ('1', 'True') THEN REPLACE(CAST(title.fldColumn_36 AS DATE), '-', '/') ELSE '' END AS in_PrepaidDate,
    CASE WHEN title.fldColumn_39 IN ('1', 'True') THEN REPLACE(CAST(title.fldColumn_41 AS DATE), '-', '/') ELSE '' END AS in_InvoicePaidDate,
    CASE WHEN title.fldColumn_42 IN ('1', 'True') THEN REPLACE(CAST(title.fldColumn_44 AS DATE), '-', '/') ELSE '' END AS in_ProductionDate,
    CASE WHEN title.fldColumn_43 IN ('1', 'True') THEN REPLACE(CAST(title.fldColumn_45 AS DATE), '-', '/') ELSE '' END AS in_BestBeforeDate,
    CASE WHEN contract.fldColumn_1 IN ('1', 'True') THEN REPLACE(CAST(contract.fldColumn_2 AS DATE), '-', '/') ELSE '' END AS in_DateOfContract,
    CASE WHEN contract.fldColumn_11 IN ('1', 'True') THEN REPLACE(CAST(contract.fldColumn_13 AS DATE), '-', '/') ELSE '' END AS in_ShipmentPeriodFrom,
    CASE WHEN contract.fldColumn_12 IN ('1', 'True') THEN REPLACE(CAST(contract.fldColumn_14 AS DATE), '-', '/') ELSE '' END AS in_ShipmentPeriodTo,
    CASE WHEN contract.fldColumn_21 IN ('1', 'True') THEN REPLACE(CAST(contract.fldColumn_22 AS DATE), '-', '/') ELSE '' END AS in_AdvancedPaymentDate,
    CASE WHEN contract.fldColumn_24 IN ('1', 'True') THEN REPLACE(CAST(contract.fldColumn_25 AS DATE), '-', '/') ELSE '' END AS in_CashDate,
    CASE WHEN contract.fldColumn_26 IN ('1', 'True') THEN REPLACE(CAST(contract.fldColumn_27 AS DATE), '-', '/') ELSE '' END AS in_CreditDate,

    -- Check if LOTNumbers exists then show contract key from title, otherwise empty
    CASE WHEN ISNULL(alongKey.LOTNumbers, '') <> '' THEN title.fldColumn_1 ELSE '' END AS in_contract_Along,

    -- Contract and production details (from both title and contract tables)
    contract.fldColumn_3 AS in_CompanyContractNumber,
    title.fldColumn_1 AS in_ContractNumber,
    title.fldColumn_2 AS in_CompanyContractProduct,
    title.fldColumn_3 AS in_LOTNumber,
    tbl_factory.fldColumn_2 AS in_Factory,
    title.fldColumn_5 AS Auto_LOTNumber,
    title.fldColumn_6 AS in_ProductDetail,
    ISNULL(allProductDetails.ProductDetails, '') AS in_ProductDetailS,
    title.fldColumn_7 AS in_NumOfPacking,
    title.fldColumn_8 AS in_NetWeight_lot,
    SUM(TRY_CAST(title.fldColumn_8 AS numeric(18,2))) OVER () AS in_NetWeight_lotTotal,
    title.fldColumn_9 AS in_GrossWeight_lot,
    SUM(TRY_CAST(title.fldColumn_9 AS numeric(18,2))) OVER () AS in_GrossWeight_lotTotal,
    title.fldColumn_19 AS in_Daystodestination,
    title.fldColumn_21 AS in_DuePeymentDate,
    title.fldColumn_22 AS in_HSCode,
    tbl_CarrierList.fldColumn_2 AS in_CarrierName,
    title.fldColumn_24 AS in_BLNumber,
    title.fldColumn_25 AS in_ContainerNumber,
    title.fldColumn_26 AS in_GrossWeight1,
    title.fldColumn_27 AS in_VoyageNumber,
    title.fldColumn_28 AS in_VesselName,
    title.fldColumn_29 AS in_SealNumber,
    title.fldColumn_30 AS in_PackingNumber,
    title.fldColumn_31 AS in_InvoiceNumber,
    tbl_Incoterms_port.fldColumn_2 AS in_IncotermsPort,
    title.fldColumn_33 AS in_BookingNumber,
    title.fldColumn_35 AS in_Prepaid,
    title.fldColumn_37 AS in_Discount,
    title.fldColumn_38 AS in_FreightCharges,
    title.fldColumn_46 AS in_SpecialNote,
    
    -- Construct packing label string from number of packs and main packing label
    CAST(title.fldColumn_7 AS NVARCHAR) + N' × ' + tbl_MainPacking.fldColumn_2 AS in_PackingLabaleSolo,
    tbl_DestinationPort_dep.fldColumn_2 AS in_DeparturePort,
    tbl_DestinationPort_dest.fldColumn_2 AS in_DestinationPort,
    tbl_Incoterms_inco.fldColumn_2 AS in_IncoTerm,
    tbl_DestinationPort_dest2.fldColumn_2 AS in_DestinationPort_Contract,
    tbl_TransportModes.fldColumn_2 AS in_TransportMode,
    tbl_Container.fldColumn_2 AS in_Container,
    tbl_Currencies.fldColumn_2 AS in_Currency,
    tbl_PaymentTerms.fldColumn_2 AS in_PaymentTerms,
    tbl_FumigationTypes.fldColumn_2 AS in_FumigationType,

    -- Notify party and additional parties details
    tbl_NotifyParty.fldColumn_2 AS in_NotifyParty,
    tbl_NotifyParty.fldColumn_3 AS in_NotifyPartyAddress,
    tbl_Incoterms_inco.fldColumn_2 AS in_IncoTerm,
    tbl_DestinationPort_dest2.fldColumn_2 AS in_DestinationPort,
    tbl_TransportModes.fldColumn_2 AS in_TransportMode,
    tbl_Container.fldColumn_2 AS in_Container,
    tbl_Currencies.fldColumn_2 AS in_Currency,
    tbl_PaymentTerms.fldColumn_2 AS in_PaymentTerms,
    tbl_FumigationTypes.fldColumn_2 AS in_FumigationType,
    tbl_Buyer.fldColumn_3 AS in_Buyer,
    tbl_Consignee.fldColumn_2 AS in_Consignee,
    tbl_Consignee.fldColumn_7 AS in_ConsigneeTel,
    tbl_Consignee.fldColumn_8 AS in_ConsigneeFax,
    tbl_seller.fldColumn_3 AS in_Seller,
    tbl_seller.fldColumn_5 AS in_SellerAdress,
    tbl_seller.fldColumn_6 AS in_SellerTel,
    tbl_seller.fldColumn_7 AS in_SellerFax,
    contract.fldColumn_23 AS in_FreightCharge,
    contract.fldColumn_29 AS in_FumigationQuantity,
    contract.fldColumn_3 AS in_CustomerContractNumber,
    contract.fldColumn_30 AS in_FumigationTime,
    contract.fldColumn_31 AS in_FumigationDegree,
    contract.fldColumn_32 AS in_RequirementDocuments,
    contract.fldColumn_33 AS in_ContractTerms,
    contract.fldColumn_34 AS in_BankDetails,
    contract.fldColumn_35 AS in_PackingListNote,
    contract.fldColumn_36 AS in_Note,
    contract.fldColumn_7 AS in_BuyerAddress,
    contract.fldColumn_6 AS in_BuyerPhone,
    contract.fldColumn_7 AS in_BuyerFax,
    contract.fldColumn_9 AS in_BuyerMobile,
    contract.fldColumn_8 AS in_ConsigneeAddress,
    contract.fldColumn_37 AS in_TotalQuantity,
    contract.fldColumn_38 AS in_TotalAmount,

    -- Aggregated LOT numbers and Product details from related records
    ISNULL(alongKey.LOTNumbers, '') AS in_LOTNumber_Along,
    ISNULL(alongProductDetail.ProductDetails, '') AS in_ProductDetail_Along,
    tblRequirementDocuments.desciption AS in_RequirementDocuments,
    ISNULL(tblContractTerms.desciption, '') AS in_ContractTerms,

    -- Additional product, packaging, and auto-generated LOT details
    tbl_Coating.fldColumn_2 AS in_Coating,
    tbl_Linear.fldColumn_2 AS in_Liner,
    tbl_MainPacking.fldColumn_2 AS in_MainPacking,
    tbl_MainPacking.fldColumn_4 AS in_GrossWeight_MainPacking,
    tbl_MainPacking.fldColumn_3 AS in_NetWeight_MainPacking,
    tbl_MainPackingLabel.fldColumn_2 AS in_MainPLabel,
    tbl_ProductList.fldColumn_2 AS in_Product,
    tbl_ProductList.fldColumn_4 AS ProductGrade,
    tbl_SmallPacking.fldColumn_2 AS in_SmallPacking,
    product_contracts.In_Product_Contract AS In_Product_Contract,
    packingTotal.in_PackingLabaleTotal AS in_PackingLabaleTotal,
    AutoLOTGroup.All_Auto_LOTNumbers AS in_All_AutoLOTNumbers,
    product_grades.All_ProductGrades AS in_ProductGrades_All,
    
    -- Subcontract and pricing information
    subcontract.fldColumn_10 AS in_UnitPrice,
    subcontract.fldColumn_8 AS in_NoPackages,
    subcontract.fldColumn_10 * title.fldColumn_8 AS report_TotalUSD,
    SUM(subcontract.fldColumn_10 * title.fldColumn_8) OVER () AS sum_TotalUSD,
    tbl_SmallPackingLabel.fldColumn_2 AS in_SmallPLabel,
    subcontract.fldColumn_10 * title.fldColumn_8 AS in_TotalUSD

FROM UserForm.tbl_UserCreatedForm_28 AS title

-- Join with contract table (UserForm.tbl_UserCreatedForm_29)
LEFT JOIN UserForm.tbl_UserCreatedForm_29 AS contract
    ON contract.fldColumn_4 = title.fldColumn_1

-- Aggregated LOT numbers from form 32 (alongKey)
LEFT JOIN (
    SELECT 
        fldSubkeyGroupReletionID AS fldSubkey, 
        fldColumn_2 AS ContractKey,
        STRING_AGG(CAST(fldColumn_1 AS NVARCHAR(MAX)), ', ') AS LOTNumbers
    FROM UserForm.tbl_UserCreatedForm_32
    WHERE fldColumn_1 IS NOT NULL 
      AND fldColumn_2 IS NOT NULL
    GROUP BY fldSubkeyGroupReletionID, fldColumn_2
) AS alongKey
    ON alongKey.fldSubkey = title.fldID 
   AND alongKey.ContractKey = title.fldColumn_1

-- Aggregated Product Details from form 32 and related title records
LEFT JOIN (
    SELECT 
        link.fldSubkeyGroupReletionID AS fldSubkey, 
        link.fldColumn_2 AS ContractKey,
        STRING_AGG(related.fldColumn_5, ' , ') AS ProductDetails
    FROM UserForm.tbl_UserCreatedForm_32 AS link
    INNER JOIN UserForm.tbl_UserCreatedForm_28 AS related
        ON link.fldColumn_1 = related.fldColumn_3
    WHERE link.fldColumn_1 IS NOT NULL 
      AND link.fldColumn_2 IS NOT NULL
    GROUP BY link.fldSubkeyGroupReletionID, link.fldColumn_2
) AS alongProductDetail
    ON alongProductDetail.fldSubkey = title.fldID 
   AND alongProductDetail.ContractKey = title.fldColumn_1

-- Retrieve Requirement Documents by splitting the field and aggregating descriptions
LEFT JOIN (
    SELECT 
        x.fldID, 
        STRING_AGG(u27.fldColumn_2, ',') AS desciption
    FROM (
        SELECT TRIM(value) AS value, t29.fldID
        FROM UserForm.tbl_UserCreatedForm_29 AS t29
        CROSS APPLY STRING_SPLIT(fldColumn_32, '|')
        WHERE fldColumn_32 <> ''
    ) AS x
    INNER JOIN UserForm.tbl_UserCreatedForm_27 AS u27
        ON x.value = u27.fldColumn_1
    GROUP BY x.fldID
) tblRequirementDocuments
    ON contract.fldID = tblRequirementDocuments.fldID

-- Retrieve Contract Terms by splitting the field and aggregating descriptions
LEFT JOIN (
    SELECT 
        x.fldID, 
        STRING_AGG(u1.fldColumn_2, ',') AS desciption
    FROM (
        SELECT TRIM(value) AS value, t29.fldID
        FROM UserForm.tbl_UserCreatedForm_29 AS t29
        CROSS APPLY STRING_SPLIT(fldColumn_33, '|')
        WHERE fldColumn_33 <> ''
    ) AS x
    INNER JOIN UserForm.tbl_UserCreatedForm_1 AS u1
        ON x.value = u1.fldColumn_1
    GROUP BY x.fldID
) tblContractTerms
    ON contract.fldID = tblContractTerms.fldID

-- Join with SubContract table ([tbl_SubUserCreatedForm_29])
LEFT JOIN [UserForm].[tbl_SubUserCreatedForm_29] AS subContract
    ON contract.fldID = subContract.fldTitleID
   AND ISNULL(TRY_CAST(title.fldColumn_2 AS uniqueidentifier), 
              '00000000-0000-0000-0000-000000000000') = subContract.fldID

-- Aggregated Product Contract details from title records
LEFT JOIN (
    SELECT 
        title2.fldColumn_1 AS CompanyContractNumber, 
        STRING_AGG(tbl_ProductList.fldColumn_2, ', ') AS In_Product_Contract 
    FROM UserForm.tbl_UserCreatedForm_28 AS title2
    LEFT JOIN [UserForm].[tbl_SubUserCreatedForm_29] AS sub2 
        ON sub2.fldID = TRY_CAST(title2.fldColumn_2 AS uniqueidentifier)
    LEFT JOIN [UserForm].[tbl_UserCreatedForm_15] AS tbl_ProductList 
        ON tbl_ProductList.fldColumn_1 = COALESCE(NULLIF(sub2.fldColumn_1, ''), 0)
    GROUP BY title2.fldColumn_1
) AS product_contracts
    ON product_contracts.CompanyContractNumber = title.fldColumn_1

-- Lookup joins for additional descriptive fields
LEFT JOIN [UserForm].[tbl_UserCreatedForm_20] AS tbl_Coating
    ON tbl_Coating.fldColumn_1 = COALESCE(NULLIF(subContract.fldColumn_7, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_25] AS tbl_Linear
    ON tbl_Linear.fldColumn_1 = COALESCE(NULLIF(subContract.fldColumn_6, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_21] AS tbl_MainPacking
    ON tbl_MainPacking.fldColumn_1 = COALESCE(NULLIF(subContract.fldColumn_2, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_22] AS tbl_MainPackingLabel
    ON tbl_MainPackingLabel.fldColumn_1 = COALESCE(NULLIF(subContract.fldColumn_3, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_15] AS tbl_ProductList
    ON tbl_ProductList.fldColumn_1 = COALESCE(NULLIF(subContract.fldColumn_1, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_23] AS tbl_SmallPacking
    ON tbl_SmallPacking.fldColumn_1 = COALESCE(NULLIF(subContract.fldColumn_4, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_24] AS tbl_SmallPackingLabel
    ON tbl_SmallPackingLabel.fldColumn_1 = COALESCE(NULLIF(subContract.fldColumn_5, ''), 0)

-- Join with Factory and Carrier lookup tables
LEFT JOIN [UserForm].[tbl_UserCreatedForm_30] AS tbl_factory
    ON tbl_factory.fldColumn_1 = COALESCE(NULLIF(title.fldColumn_4, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_13] AS tbl_CarrierList
    ON tbl_CarrierList.fldColumn_1 = COALESCE(NULLIF(title.fldColumn_23, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_14] AS tbl_DestinationPort_dep
    ON tbl_DestinationPort_dep.fldColumn_1 = COALESCE(NULLIF(title.fldColumn_12, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_14] AS tbl_DestinationPort_dest
    ON tbl_DestinationPort_dest.fldColumn_1 = COALESCE(NULLIF(title.fldColumn_13, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_5] AS tbl_Incoterms_port
    ON tbl_Incoterms_port.fldColumn_1 = COALESCE(NULLIF(title.fldColumn_32, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_31] AS tbl_Buyer
    ON tbl_Buyer.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_5, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_10] AS tbl_Consignee
    ON tbl_Consignee.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_6, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_5] AS tbl_Incoterms_inco
    ON tbl_Incoterms_inco.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_15, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_14] AS tbl_DestinationPort_dest2
    ON tbl_DestinationPort_dest2.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_16, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_7] AS tbl_TransportModes
    ON tbl_TransportModes.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_17, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_26] AS tbl_Container
    ON tbl_Container.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_18, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_3] AS tbl_Currencies
    ON tbl_Currencies.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_19, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_6] AS tbl_PaymentTerms
    ON tbl_PaymentTerms.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_20, ''), 0) 
LEFT JOIN [UserForm].[tbl_UserCreatedForm_4] AS tbl_FumigationTypes
    ON tbl_FumigationTypes.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_28, ''), 0)
LEFT JOIN [UserForm].[tbl_UserCreatedForm_12] AS tbl_seller
    ON tbl_seller.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_9, ''), 0)
LEFT JOIN [UserForm].[tbl_UserCreatedForm_11] AS tbl_NotifyParty
    ON tbl_NotifyParty.fldColumn_1 = COALESCE(NULLIF(contract.fldColumn_10, ''), 0)

-- Aggregated Product Detail from all title records
LEFT JOIN (
    SELECT 
        'all' AS JoinKey, 
        STRING_AGG(title.fldColumn_6, ' , ') AS ProductDetails
    FROM UserForm.tbl_UserCreatedForm_28 AS title
    WHERE title.fldColumn_6 IS NOT NULL
) AS allProductDetails
    ON 'all' = 'all'

-- Aggregated packing label totals from title records and main packing info
LEFT JOIN (
    SELECT 
        inner_title.fldColumn_1 AS ContractNumber, 
        STRING_AGG(CAST(inner_title.fldColumn_7 AS NVARCHAR) + N' × ' + tbl_MainPacking.fldColumn_2, ' | ') AS in_PackingLabaleTotal
    FROM UserForm.tbl_UserCreatedForm_28 AS inner_title
    LEFT JOIN [UserForm].[tbl_SubUserCreatedForm_29] AS sub
        ON ISNULL(TRY_CAST(inner_title.fldColumn_2 AS uniqueidentifier), '00000000-0000-0000-0000-000000000000') = sub.fldID
    LEFT JOIN [UserForm].[tbl_UserCreatedForm_21] AS tbl_MainPacking
        ON tbl_MainPacking.fldColumn_1 = COALESCE(NULLIF(sub.fldColumn_2, ''), 0)
    GROUP BY inner_title.fldColumn_1
) AS packingTotal
    ON packingTotal.ContractNumber = title.fldColumn_1

-- Aggregated all Auto LOT Numbers per contract
LEFT JOIN (
    SELECT 
        fldColumn_1 AS ContractNumber,
        STRING_AGG(fldColumn_5, ', ') AS All_Auto_LOTNumbers
    FROM UserForm.tbl_UserCreatedForm_28
    GROUP BY fldColumn_1
) AS AutoLOTGroup
    ON AutoLOTGroup.ContractNumber = title.fldColumn_1

-- Aggregated Product Grades from title records
LEFT JOIN (
    SELECT 
        title2.fldColumn_1 AS CompanyContractNumber,
        STRING_AGG(tbl_ProductList.fldColumn_4, ', ') AS All_ProductGrades
    FROM UserForm.tbl_UserCreatedForm_28 AS title2
    LEFT JOIN [UserForm].[tbl_SubUserCreatedForm_29] AS sub2
        ON sub2.fldID = TRY_CAST(title2.fldColumn_2 AS uniqueidentifier)
    LEFT JOIN [UserForm].[tbl_UserCreatedForm_15] AS tbl_ProductList
        ON tbl_ProductList.fldColumn_1 = COALESCE(NULLIF(sub2.fldColumn_1, ''), 0)
    GROUP BY title2.fldColumn_1
) AS product_grades
    ON product_grades.CompanyContractNumber = title.fldColumn_1;