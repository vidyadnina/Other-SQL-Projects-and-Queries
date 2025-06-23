SELECT  * FROM `shipment-report-q1.Data_q1.MMN` LIMIT 1000;

DROP TABLE IF EXISTS Data_q1.MMN_LMK_Q1;
CREATE TABLE Data_q1.MMN_LMK_Q1
AS
(SELECT PT, Project_No,BL_Date,BL_Month, Source, Enduser, Owner, Selling_Term,HMA,Ni_LP,Ni_DP, MC_LP,MC_DP, SiO2_LP,SiO2_DP,MgO_LP, MgO_DP,Fe_LP,Fe_DP,Qty_load_port AS QTY_LP, Qty_Disch_Port AS QTY_DP, Feet_Tongkang,Freight_Vendor AS Freight,Harga_Kontrak_Vendor,Detail_Harga_Vendor,Acuan_Coa_Vendor,HPM_Vendor_FINAL,Buying_Price_ AS Buy_Price, Perhitungan_Bonus_Ni_Vendor AS Bonus_Ni_Vendor,Perhitungan_Penalty_Ni_Vendor AS Penalty_Ni_Vendor,Perhitungan_Bonus_SM_Vendor AS Bonus_SM_Vendor,Perhitungan_Penalty_SM_Vendor AS Penalty_SM_Vendor, Perhitungan_Bonus_Fe_Vendor AS Bonus_Fe_Vendor,Perhitungan_Penalty_Fe_Vendor AS Penalty_Fe_Vendor, Perhitungan_Penalty_MC_Vendor AS Penalty_MC_Vendor, Perhitungan_Penalty_SiO2_Vendor AS Penalty_SiO2_Vendor,Bonus_QTY_Vendor__Marketing_fee AS Bonus_QTY_orMF_Vendor, `Total_Vendor_Nickel_+_Freight` AS COGS, Harga_Kontrak_Enduser,Detail_Harga_Enduser,Acuan_Coa_Enduser,HPM_Enduser_FINAL,Buying_Price_ AS Sell_Price, Perhitungan_Bonus_Ni_Enduser AS Bonus_Ni_Enduser,Perhitungan_Penalty_Ni_Enduser AS Penalty_Ni_Enduser,Perhitungan_Bonus_SM_Enduser AS Bonus_SM_Enduser,Perhitungan_Penalty_SM_Enduser AS Penalty_SM_Enduser, Perhitungan_Bonus_Fe_Enduser AS Bonus_Fe_Enduser,Perhitungan_Penalty_Fe_Enduser AS Penalty_Fe_Enduser, Perhitungan_Penalty_MC_Enduser AS Penalty_MC_Enduser, Perhitungan_Penalty_SiO2_Enduser AS Penalty_SiO2_Enduser,Bonus_QTY_Enduser AS Bonus_QTY_Enduser, Grand_Total_Enduser AS Revenue, Nickel_Margin_USD AS Margin
FROM Data_q1.MMN
WHERE BL_Month in ('January','February',"March") AND Exclude_VAS = TRUE
ORDER BY Project_No
        );

SELECT * FROM Data_q1.MMN_LMK_Q1;
