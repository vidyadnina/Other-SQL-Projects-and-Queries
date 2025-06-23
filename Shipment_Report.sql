SELECT * FROM Data_q1.margin;


DROP TABLE IF EXISTS `shipment-report-q1.Data_q1.MMN_LMK`;
CREATE TABLE `shipment-report-q1.Data_q1.MMN_LMK`
AS
(SELECT 
    m.PT, 
    m.Project_No, 
    m.BL_Date, 
    m.BL_Month, 
    m.Source, 
    m.Enduser, 
    m.Owner, 
    m.Selling_Term, 
    m.HMA,
    m.Ni_LP, 
    m.Ni_DP, 
    m.MC_LP, 
    m.MC_DP, 
    m.SiO2_LP, 
    m.SiO2_DP, 
    m.MgO_LP, 
    m.MgO_DP, 
    m.Fe_LP, 
    m.Fe_DP,
    m.Qty_load_port AS QTY_LP, 
    m.Qty_Disch_Port AS QTY_DP, 
    m.Feet_Tongkang, 
    m.Freight_Vendor AS Freight, 
    m.Harga_Kontrak_Vendor, 
    m.Detail_Harga_Vendor, 
    m.Acuan_Coa_Vendor,
    m.HPM_Vendor_FINAL, 
    m.Buying_Price_ AS Buy_Price, 
    m.Perhitungan_Bonus_Ni_Vendor AS Bonus_Ni_Vendor,
    m.Perhitungan_Penalty_Ni_Vendor AS Penalty_Ni_Vendor,
    m.Perhitungan_Bonus_SM_Vendor AS Bonus_SM_Vendor,
    m.Perhitungan_Penalty_SM_Vendor AS Penalty_SM_Vendor,
    m.Perhitungan_Bonus_Fe_Vendor AS Bonus_Fe_Vendor,
    m.Perhitungan_Penalty_Fe_Vendor AS Penalty_Fe_Vendor,
    m.Perhitungan_Penalty_MC_Vendor AS Penalty_MC_Vendor,
    m.Perhitungan_Penalty_SiO2_Vendor AS Penalty_SiO2_Vendor,
    m.Bonus_QTY_Vendor__Marketing_fee AS Bonus_QTY_orMF_Vendor,
    m.Subtotal_Vendor_Nickel_only + Freight_Vendor + PPN_Freight_11 AS COGS,
    m.Harga_Kontrak_Enduser, 
    m.Detail_Harga_Enduser, 
    m.Acuan_Coa_Enduser,
    m.HPM_Enduser_FINAL, 
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
    m.Nickel_Margin_USD AS Margin
FROM `shipment-report-q1.Data_q1.margin` m
JOIN `shipment-report-q1.Data_q1.shipsched` s
ON m.Project_No = s.Project_No
WHERE m.BL_Month IN ('January','February','March') AND m.Exclude_VAS = TRUE
ORDER BY m.Project_No
);


