SELECT * FROM Data_q1.margin;


DROP TABLE IF EXISTS `shipment-report-q1.Data_q1.MMN_LMK`;
CREATE TABLE `shipment-report-q1.Data_q1.MMN_LMK`
AS
(SELECT 
    EXTRACT(MONTH from m.BL_Date) AS month, 
    m.PT, 
    m.Project_No, 
    m.BL_Date,
    m.Source, 
    m.Enduser, 
    m.Type,
    m.Owner as Vendor, 
    m.Selling_Term, 
    m.HMA,
    s._TA_LP AS TA_LP,
    s.Comm_Loading AS Comm_LP,
    s.Comp_Loading AS Comp_LP,
    s.TA_DP,
    s.Comm_Discharge AS Comm_DP,
    s.Comp_Discharge AS Comp_DP,
    s.Issued_Date_LP AS Issued_Cert_LP,
    s.Surveyor_LP,
    m.Ni_LP, 
    m.MC_LP, 
    m.SiO2_LP, 
    m.MgO_LP, 
    m.Fe_LP, 
    s.Surveyor_DP,
    m.Ni_DP, 
    m.MC_DP, 
    m.SiO2_DP,
    m.MgO_DP, 
    m.Fe_DP,
    m.Qty_load_port AS QTY_LP, 
    m.Qty_Disch_Port AS QTY_DP, 
    CASE
        WHEN m.Acuan_Coa_Vendor = "Muat" THEN m.Qty_load_port
        WHEN m.Acuan_Coa_Vendor = "Bongkar" THEN m.Qty_disch_port
    END AS Qty_vendor,
    CASE
        WHEN m.Acuan_Coa_Enduser = "Muat" THEN m.Qty_load_port
        WHEN m.Acuan_Coa_Enduser = "Bongkar" THEN m.Qty_disch_port
    END AS Qty_enduser,
    m.Feet_Tongkang, 
    m.Freight_Vendor AS Freight, 
    m.Harga_Kontrak_Vendor, 
    m.Detail_Harga_Vendor, 
    m.Acuan_Coa_Vendor,
    m.HPM_Vendor_FINAL AS HPM_Vendor, 
    m.Buying_Price_ AS Buy_Price, 
    m.Perhitungan_Bonus_Ni_Vendor AS Bonus_Ni_Vendor,
    m.Perhitungan_Penalty_Ni_Vendor AS Penalty_Ni_Vendor,
    m.Perhitungan_Bonus_SM_Vendor AS Bonus_SM_Vendor,
    m.Perhitungan_Penalty_SM_Vendor AS Penalty_SM_Vendor,
    m.Perhitungan_Bonus_Fe_Vendor AS Bonus_Fe_Vendor,
    m.Perhitungan_Penalty_Fe_Vendor AS Penalty_Fe_Vendor,
    m.Perhitungan_Penalty_MC_Vendor AS Penalty_MC_Vendor,
    m.Perhitungan_Penalty_SiO2_Vendor AS Penalty_SiO2_Vendor,
    m.Bonus_QTY_Vendor__Marketing_fee AS QTY_or_MF_Vendor,
    m.Subtotal_Vendor_Nickel_only + Freight_Vendor + PPN_Freight_11 AS COGS,
    m.Harga_Kontrak_Enduser, 
    m.Detail_Harga_Enduser, 
    m.Acuan_Coa_Enduser,
    m.HPM_Enduser_FINAL AS HPM_Enduser, 
    m.Buying_Price_ AS Sell_Price,
    m.Perhitungan_Bonus_Ni_Enduser AS Bonus_Ni_Enduser,
    m.Perhitungan_Penalty_Ni_Enduser AS Penalty_Ni_Enduser,
    m.Perhitungan_Bonus_SM_Enduser AS Bonus_SM_Enduser,
    m.Perhitungan_Penalty_SM_Enduser AS Penalty_SM_Enduser,
    m.Perhitungan_Bonus_Fe_Enduser AS Bonus_Fe_Enduser,
    m.Perhitungan_Penalty_Fe_Enduser AS Penalty_Fe_Enduser,
    m.Perhitungan_Penalty_MC_Enduser AS Penalty_MC_Enduser,
    m.Perhitungan_Penalty_SiO2_Enduser AS Penalty_SiO2_Enduser,
    m.Bonus_QTY_Enduser AS Bonus_QTY_Enduser,
    m.Grand_Total_Enduser AS Revenue,
    m.Nickel_Margin_USD AS Margin,
    m.Ni_DP - m.Ni_LP as Ni_diff,
    m.MC_DP - m.MC_LP as MC_diff,
    m.HPM_Enduser_FINAL - m.HPM_Vendor_FINAL AS HPM_diff
FROM `shipment-report-q1.Data_q1.margins` m
JOIN `shipment-report-q1.Data_q1.shipschedule` s
ON m.Project_No = s.Project_No
WHERE m.BL_Month IN ('January','February','March') AND m.Exclude_VAS = TRUE AND m.Done_Calculate_1 = TRUE
ORDER BY m.Project_No
);

SELECT * FROM Data_q1.MMN_LMK
