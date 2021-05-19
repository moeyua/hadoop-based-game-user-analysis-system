-- 付费总额
SELECT ROUND(SUM(pay_price),2) AS '付费总额' FROM user_log

-- 活跃用户付费比例
SELECT a.付费活跃玩家haAPA,a.活跃玩家AU,a.付费活跃玩家APA/a.活跃玩家AU as '活跃用户付费比例PUR' FROM(SELECT COUNT(CASE WHEN avg_online_minutes>30 THEN user_id ELSE NULL END) '活跃玩家AU',COUNT(CASE WHEN pay_price>0 AND avg_online_minutes>30 THEN user_id ELSE NULL END) '付费活跃玩家APA' FROM user_log ) a

-- 平均每用户收入
SELECT a.AU,ROUND(a.总收入) as 总收入, ROUND(a.总收入/a.AU,2) as 'ARPU' FROM (SELECT COUNT(CASE WHEN avg_online_minutes>30 THEN user_id ELSE NULL END) 'AU', sum(pay_price) '总收入' FROM user_log) a

-- 平均每付费用户收入
SELECT a.APA,ROUND(a.总收入) AS '总收入', ROUND(a.总收入/a.APA,2) as 'ARPPU' FROM (SELECT COUNT(CASE WHEN pay_price>0 AND avg_online_minutes>30 THEN user_id ELSE NULL END) 'APA', sum(pay_price) '总收入' FROM user_log) a

-- 各等级付费情况
SELECT a.等级,a.总人数,a.付费人数,ROUND(a.付费人数/a.总人数,2) AS '付费转化率',ROUND(a.付费总金额,2) AS '付费总金额',ROUND(a.付费总金额/a.总人数,2) AS '人均付费金额',a.总付费次数, ROUND(a.总付费次数/a.总人数,2) AS '人均付费次数' FROM (SELECT bd_stronghold_level AS'等级',COUNT(DISTINCT user_id) as '总人数',COUNT(CASE WHEN pay_price>0 THEN user_id ELSE NULL END) '付费人数',SUM(pay_price) AS '付费总金额', SUM(pay_count) AS '总付费次数' FROM user_log GROUP BY bd_stronghold_level) a ORDER BY a.等级

-- 玩家游戏习惯分析
-- AU玩家PVP情况
SELECT ROUND(AVG(pvp_battle_count)) AS 'AU玩家平均PVP次数',ROUND(sum(pvp_win_count)/SUM(pvp_battle_count),4) AS 'AU玩家PVP胜率',ROUND(SUM(pvp_lanch_count)/SUM(pvp_battle_count),4)AS 'AU玩家主动发起PVP概率' FROM user_log WHERE avg_online_minutes>30

-- APA玩家PVP情况
SELECT ROUND(AVG(pvp_battle_count)) AS 'APA玩家平均PVP次数',ROUND(sum(pvp_win_count)/SUM(pvp_battle_count),4) AS 'APA玩家PVP胜率',ROUND(SUM(pvp_lanch_count)/SUM(pvp_battle_count),4)AS 'APA玩家主动发起PVP概率' FROM user_log WHERE avg_online_minutes>30 AND pay_price>0

-- AU玩家PVE情况
SELECT ROUND(AVG(pve_battle_count)) AS 'AU玩家平均PVE次数', ROUND(sum(pve_win_count)/SUM(pve_battle_count),4) AS 'AU玩家PVE胜率', ROUND(SUM(pve_lanch_count)/SUM(pve_battle_count),4)AS 'AU玩家主动发起PVE概率' FROM user_log WHERE avg_online_minutes>30

-- APA玩家PVE情况
SELECT ROUND(AVG(pve_battle_count)) AS 'APA玩家平均PVE次数',ROUND(sum(pve_win_count)/SUM(pve_battle_count),4) AS 'APA玩家PVE胜率',ROUND(SUM(pve_lanch_count)/SUM(pve_battle_count),4)AS 'APA玩家主动发起PVE概率' FROM user_log WHERE avg_online_minutes>30 AND pay_price>0

-- AU各类资源使用率
SELECT ROUND(sum(wood_reduce_value)/SUM(wood_add_value),4)AS '木材使用率',ROUND(SUM(stone_reduce_value)/SUM(stone_add_value),4)AS '石头使用率',ROUND(SUM(ivory_reduce_value)/SUM(ivory_add_value),4)AS '象牙使用率',ROUND(SUM(meat_reduce_value)/SUM(meat_add_value),4)AS '肉使用率',ROUND(SUM(magic_reduce_value)/SUM(magic_add_value),4)AS '魔法使用率'FROM user_log WHERE avg_online_minutes>30

-- APA各类资源使用率
SELECT ROUND(sum(wood_reduce_value)/SUM(wood_add_value),4)AS '木材使用率',ROUND(SUM(stone_reduce_value)/SUM(stone_add_value),4)AS '石头使用率',ROUND(SUM(ivory_reduce_value)/SUM(ivory_add_value),4)AS '象牙使用率',ROUND(SUM(meat_reduce_value)/SUM(meat_add_value),4)AS '肉使用率',ROUND(SUM(magic_reduce_value)/SUM(magic_add_value),4)AS '魔法使用率'FROM user_log WHERE avg_online_minutes>30 AND pay_price>0

-- AU各类兵种损失率
SELECT ROUND(SUM(infantry_reduce_value-wound_infantry_reduce_value)/
						 SUM(infantry_add_value),4) AS '勇士损失率',
			 ROUND(SUM(cavalry_reduce_value-wound_cavalry_reduce_value)/
						 SUM(cavalry_add_value),4)AS'驯兽师损失率',
			 ROUND(SUM(shaman_reduce_value-wound_shaman_reduce_value)/
						 SUM(shaman_add_value),4)AS '萨满损失率'
FROM user_log
WHERE avg_online_minutes>30

-- APA各种兵种损失率
SELECT ROUND(SUM(infantry_reduce_value-wound_infantry_reduce_value)/SUM(infantry_add_value),4) AS '勇士损失率',ROUND(SUM(cavalry_reduce_value-wound_cavalry_reduce_value)/SUM(cavalry_add_value),4)AS'驯兽师损失率',ROUND(SUM(shaman_reduce_value-wound_shaman_reduce_value)/SUM(shaman_add_value),4)AS '萨满损失率' FROM user_log WHERE avg_online_minutes>30 AND pay_price>0

-- AU加速卷使用率
SELECT ROUND(SUM(general_acceleration_reduce_value)/
						 SUM(general_acceleration_add_value),4) AS '通用类',
						 ROUND(SUM(building_acceleration_reduce_value)/
						 SUM(building_acceleration_add_value),4)AS '建筑类',
			 ROUND(SUM(reaserch_acceleration_reduce_value)/
				     SUM(reaserch_acceleration_add_value),4)AS '科研类',
			 ROUND(SUM(training_acceleration_reduce_value)/
				     SUM(training_acceleration_add_value),4)AS '训练类',
			 ROUND(SUM(treatment_acceleration_reduce_value)/
						 SUM(treatment_acceleraion_add_value),4)AS '治疗类'
FROM user_log
WHERE avg_online_minutes>30

-- APA加速卷使用率
SELECT ROUND(SUM(general_acceleration_reduce_value)/
						 SUM(general_acceleration_add_value),4) AS '通用类',
						 ROUND(SUM(building_acceleration_reduce_value)/
						 SUM(building_acceleration_add_value),4)AS '建筑类',
			 ROUND(SUM(reaserch_acceleration_reduce_value)/
				     SUM(reaserch_acceleration_add_value),4)AS '科研类',
			 ROUND(SUM(training_acceleration_reduce_value)/
				     SUM(training_acceleration_add_value),4)AS '训练类',
			 ROUND(SUM(treatment_acceleration_reduce_value)/
						 SUM(treatment_acceleraion_add_value),4)AS '治疗类'
FROM user_log
WHERE avg_online_minutes>30
AND pay_price>0

-- AU玩家个建筑等级
SELECT ROUND(AVG(bd_training_hut_level),2)AS '士兵小屋',
			 ROUND(AVG(bd_healing_lodge_level),2)AS '治疗小井',
			 ROUND(AVG(bd_stronghold_level),2)AS '要塞',
			 ROUND(AVG(bd_outpost_portal_level),2)AS '据点传送门',
			 ROUND(AVG(bd_barrack_level),2)AS '兵营',
			 ROUND(AVG(bd_healing_spring_level),2)AS '治疗之泉',
			 ROUND(AVG(bd_dolmen_level),2)AS '智慧神庙',
			 ROUND(AVG(bd_guest_cavern_level),2)AS '联盟大厅',
			 ROUND(AVG(bd_warehouse_level),2)AS'仓库',
			 ROUND(AVG(bd_watchtower_level),2)AS'瞭望塔',
			 ROUND(AVG(bd_magic_coin_tree_level),2)AS'魔法幸运树',
			 ROUND(AVG(bd_hall_of_war_level),2)AS'战争大厅',
			 ROUND(AVG(bd_market_level),2)AS'联盟货车',
			 ROUND(AVG(bd_hero_gacha_level),2)AS'占卜台',
			 ROUND(AVG(bd_hero_strengthen_level),2)AS'祭坛',
			 ROUND(AVG(bd_hero_pve_level),2)AS'冒险传送门'
FROM user_log
WHERE avg_online_minutes>30

-- APA玩家各建筑等级
SELECT ROUND(AVG(bd_training_hut_level),2)AS '士兵小屋',
			 ROUND(AVG(bd_healing_lodge_level),2)AS 'a',
			 ROUND(AVG(bd_stronghold_level),2)AS '要塞',
			 ROUND(AVG(bd_outpost_portal_level),2)AS '据点传送门',
			 ROUND(AVG(bd_barrack_level),2)AS '兵营',
			 ROUND(AVG(bd_healing_spring_level),2)AS '治疗之泉',
			 ROUND(AVG(bd_dolmen_level),2)AS '智慧神庙',
			 ROUND(AVG(bd_guest_cavern_level),2)AS '联盟大厅',
			 ROUND(AVG(bd_warehouse_level),2)AS'仓库',
			 ROUND(AVG(bd_watchtower_level),2)AS'瞭望塔',
			 ROUND(AVG(bd_magic_coin_tree_level),2)AS'魔法幸运树',
			 ROUND(AVG(bd_hall_of_war_level),2)AS'战争大厅',
			 ROUND(AVG(bd_market_level),2)AS'联盟货车',
			 ROUND(AVG(bd_hero_gacha_level),2)AS'占卜台',
			 ROUND(AVG(bd_hero_strengthen_level),2)AS'祭坛',
			 ROUND(AVG(bd_hero_pve_level),2)AS'冒险传送门'
FROM user_log
WHERE avg_online_minutes>30
AND pay_price>0