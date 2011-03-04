/*** set up CAM+ decision strategy tree
1. retain all existing CAM-v2 buyer region
2. incorporate CRM dimension: 
Wanted to ensure we would have the ability (via cutoff tree or rules) to provide differentiated treatment to the segments below:
.	DCC/VT 
.	WAX/Non-WAX
.	eBay/Off-eBay
.	Countries that need/will need special treatment: BR, IL, MX
.	Digital Goods

***/

/** BE Region  -- separate EM from ROW **/

if flow_to_country = 'HK' then be_region='HK';
else if flow_to_country = 'C2' then be_region='C2';
else if flow_to_country = 'AU' then be_region='AU';
else if flow_to_country = 'FR' then be_region='FR';
else if flow_to_country = 'GB' then be_region='UK';
else if flow_to_country = 'DE' then be_region='DE';
else if flow_to_country = 'CA' then be_region='CA';
else if flow_to_country = 'US' then be_region='US';
else if flow_to_country in ('BD','BT','KH','CN','IN','ID','JP','KP','KR','LA','MO','MY','MV','FM','MN','NP',
                                                   'NZ','PK','PH','WS','SG','LK','TW','TH','TO','VN') then be_region='ROA';
else if flow_to_country in ('AX','AL','AD','AT','BE','BA','HR','CY','CZ','DK','EE','FI','GR','GG','HU',
                             'IS','IE','IM','IT','LV','LI','LT','LU','MK','MT','MD','MC','NL','NO','PL','PT','ME','RO',
                             'RU','SM','CS','RS','SK','SI','ES','SE','CH','TR','UA','BG','VA','YU') then be_region='ROE';
else if flow_to_country in ('AR','BR','IL','MX','ZA') then be_region='EM';
else be_region='ROW';


/** 1. Revenue Tree  -- Adding segment 37,38,39, change segment 36  **/
/*c_be_subcat = c_cat mod 65536;
if c_subcat in (0, 10, 11, 12, 20) and c_be_subcat=0 then mc='Fixed'; else mc='Tiered';
*/
if c_cat in (0, 10, 11, 12, 20) and c_subcat=0 then mc='Fixed'; else mc='Tiered';

if cross_border in (2,4) then xb=1; else xb=0;



if VT=1 then cc_beseg=1;
else if VT=0 and dcc=1 then cc_beseg=2;
else do;
        if be_region='CA' then do;
                IF xb=0 THEN do;
                        IF mc='Fixed' then cc_beseg=3;
                        else cc_beseg=4;
                end;
                else do;
                        IF mc='Fixed' then cc_beseg=5;
                        else cc_beseg=6;
                end;
        end;
        else if be_region='US' then do;
                IF xb=0 THEN do;
                        IF mc='Fixed' then cc_beseg=7;
                        else cc_beseg=8;
                end;
		else do;
                        IF mc='Fixed' then cc_beseg=9;
                        else cc_beseg=10;
                end;
        end;
        else if be_region='UK' then do;
                IF xb=0 THEN do;
                        IF mc='Fixed' then cc_beseg=11;
                        else cc_beseg=12;
                end;
                else do;
                        IF mc='Fixed' then cc_beseg=13;
                        else cc_beseg=14;
                end;
        end;
        else if be_region='DE' then do;
                IF xb=0 THEN do;
                        IF mc='Fixed' then cc_beseg=15;
                        else cc_beseg=16;
                end;
                else do;
                        IF mc='Fixed' then cc_beseg=17;
                        else cc_beseg=18;
                end;
        end;
        else if be_region='FR' then do;
                IF xb=0 THEN do;
                        IF mc='Fixed' then cc_beseg=19;
                        else cc_beseg=20;
                end;
                else cc_beseg=21;
        end;
        else if be_region='AU' then do;
                IF xb=0 THEN do;
                        IF mc='Fixed' then cc_beseg=22;
                        else cc_beseg=23;
		end;
                else cc_beseg=24;
        end;
        else if be_region='ROE' then do;
                IF xb=0 THEN do;
                        IF mc='Fixed' then cc_beseg=25;
                        else cc_beseg=26;
                end;
                else do;
                        IF mc='Fixed' then cc_beseg=27;
                        else cc_beseg=28;
                end;
        end;
        else if be_region='C2' then do;
                IF xb=0 THEN cc_beseg= 29;
                else do;
                        IF mc='Fixed' then cc_beseg=30;
                        else cc_beseg=31;
                end;
        end;
        else if be_region='HK' then do;
                IF xb=0 THEN cc_beseg= 29;
                else do;
                        IF mc='Fixed' then cc_beseg=32;
                        else cc_beseg=33;
                end;
        end;
        else if be_region='ROA' then do;
                IF xb=0 THEN cc_beseg= 29;
                else do;
                        IF mc='Fixed' then cc_beseg=34;
                        else cc_beseg=35;
                end;
        end;
        else if be_region='EM' then do; 
                IF xb=0 THEN cc_beseg= 36;
		else
		cc_beseg=37;
	end;
        else if be_region='ROW' then do;
                IF xb=0 THEN cc_beseg= 38;
		else
		cc_beseg=39;
	end;
end;



/** 2. Buyer Region: requirement from CRM and BU **/

If buyer_region = 'NA' then buyer_region_num = 1;
else If buyer_region = 'EU' then buyer_region_num = 2;
else If buyer_region = 'ROW' then buyer_region_num = 3;
else if flow_from_country = 'AR' then buyer_region_num = 4;
else if flow_from_country = 'BR' then buyer_region_num = 5;
else if flow_from_country = 'IL' then buyer_region_num = 6;
else if flow_from_country = 'MX' then buyer_region_num = 7;
else if flow_from_country = 'ZA' then buyer_region_num = 8;
else If flow_from_country = 'AU' then buyer_region_num = 9;
else if flow_from_country = 'BT' then buyer_region_num=10;
else if flow_from_country = 'C2' then buyer_region_num=11;
else if flow_from_country = 'CN' then buyer_region_num=12;
else if flow_from_country = 'FM' then buyer_region_num=13;
else if flow_from_country = 'HK' then buyer_region_num=14;
else if flow_from_country = 'ID' then buyer_region_num=15;
else if flow_from_country = 'IN' then buyer_region_num=16;
else if flow_from_country = 'JP' then buyer_region_num=17;
else if flow_from_country = 'KH' then buyer_region_num=18;
else if flow_from_country = 'KR' then buyer_region_num=19;
else if flow_from_country = 'LA' then buyer_region_num=20;
else if flow_from_country = 'LK' then buyer_region_num=21;
else if flow_from_country = 'MH' then buyer_region_num=22;
else if flow_from_country = 'MN' then buyer_region_num=23;
else if flow_from_country = 'MV' then buyer_region_num=24;
else if flow_from_country = 'MY' then buyer_region_num=25;
else if flow_from_country = 'NP' then buyer_region_num=26;
else if flow_from_country = 'NZ' then buyer_region_num=27;
else if flow_from_country = 'PH' then buyer_region_num=28;
else if flow_from_country = 'SG' then buyer_region_num=29;
else if flow_from_country = 'TH' then buyer_region_num=30;
else if flow_from_country = 'TO' then buyer_region_num=31;
else if flow_from_country = 'TW' then buyer_region_num=32;
else if flow_from_country = 'VN' then buyer_region_num=33;
else if flow_from_country = 'WS' then buyer_region_num=34;

/** 2. net-to-gross ratio tree **/

/************************************************************* 
this is the segmentation for net to gross for bad type (3,4)
created by YMP 2011-02-07
**************************************************************/

IF IS_DIGITAL_GOODS = 0 THEN
DO;
	IF WAX = 0 THEN
	DO;
		IF TRANSACTION_SUBTYPE not in ('G') THEN
		DO;
			IF PMT_AMT_USD < 950 THEN
			DO;
				cam2010_plus_n2g_segment = 1;
			END;
			ELSE IF PMT_AMT_USD >= 950 AND PMT_AMT_USD < 3595 THEN
			DO;
				cam2010_plus_n2g_segment = 2;
			END;
			ELSE IF PMT_AMT_USD >= 3595 THEN
			DO;
				cam2010_plus_n2g_segment = 3;
			END;
		END;

		ELSE IF TRANSACTION_SUBTYPE = 'G' THEN
		DO;
			IF C_PMTS_RCVD_NUM < 80 THEN
			DO;
				cam2010_plus_n2g_segment = 4;
			END;
			ELSE IF C_PMTS_RCVD_NUM >= 80 THEN
			DO;
				cam2010_plus_n2g_segment = 5;
			END;
		END;
	END;


	ELSE IF WAX = 1 THEN
	DO;
		cam2010_plus_n2g_segment = 6;
	END;
END;

ELSE IF IS_DIGITAL_GOODS = 1 THEN
DO;
	cam2010_plus_n2g_segment = 7;
END;

/** 3. CRM policy: requirement from CRM **/

         If S_AUTH_00000010 = 1 then do;
		if transaction_subtype not in ('A', 'I') and wax = 0 and is_digital_goods = 0 then do;
              cam2010_plus_crmseg = 9;
       		end;
        	else if transaction_subtype not in ('A', 'I') and wax = 0 and is_digital_goods = 1 then do;
                cam2010_plus_crmseg = 10;
        	end;

        	else if transaction_subtype not in ('A', 'I') and wax = 1 and is_digital_goods = 0 then do;
                cam2010_plus_crmseg = 11;
        	end;
	
        	else if transaction_subtype not in ('A', 'I') and wax = 1 and is_digital_goods = 1 then do;
                	cam2010_plus_crmseg = 12;
        	end;
	
        	else if transaction_subtype in ('A', 'I') and wax = 0 and is_digital_goods = 0 then do;
                	cam2010_plus_crmseg = 13;
        	end;
	
        	else if transaction_subtype in ('A', 'I') and wax = 0 and is_digital_goods = 1 then do;
                	cam2010_plus_crmseg = 14;
        	end;
	
        	else if transaction_subtype in ('A', 'I') and wax = 1 and is_digital_goods = 0 then do;
                	cam2010_plus_crmseg = 15;
        	end;
	
        	else if transaction_subtype in ('A', 'I') and wax = 1 and is_digital_goods = 1 then do;
                	cam2010_plus_crmseg = 16;
        	end;
         end;
        else  do;
		if transaction_subtype not in ('A', 'I') and wax = 0 and is_digital_goods = 0 then do;
              cam2010_plus_crmseg = 1;
       		end;
        	else if transaction_subtype not in ('A', 'I') and wax = 0 and is_digital_goods = 1 then do;
                cam2010_plus_crmseg = 2;
        	end;

        	else if transaction_subtype not in ('A', 'I') and wax = 1 and is_digital_goods = 0 then do;
                cam2010_plus_crmseg = 3;
        	end;
	
        	else if transaction_subtype not in ('A', 'I') and wax = 1 and is_digital_goods = 1 then do;
                	cam2010_plus_crmseg = 4;
        	end;
	
        	else if transaction_subtype in ('A', 'I') and wax = 0 and is_digital_goods = 0 then do;
                	cam2010_plus_crmseg = 5;
        	end;
	
        	else if transaction_subtype in ('A', 'I') and wax = 0 and is_digital_goods = 1 then do;
                	cam2010_plus_crmseg = 6;
        	end;
	
        	else if transaction_subtype in ('A', 'I') and wax = 1 and is_digital_goods = 0 then do;
                	cam2010_plus_crmseg = 7;
        	end;
	
        	else if transaction_subtype in ('A', 'I') and wax = 1 and is_digital_goods = 1 then do;
                	cam2010_plus_crmseg = 8;
        	end;
	end;

/** Define rule id */


/*
if cc_beseg = 1 THEN cam2010_plus_rule_id = 10000;
else if cc_beseg = 2 THEN cam2010_plus_rule_id = 20000;
*/
cam2010_plus_rule_id = 10000*cc_beseg + 100* buyer_region_num + cam2010_plus_crmseg;




