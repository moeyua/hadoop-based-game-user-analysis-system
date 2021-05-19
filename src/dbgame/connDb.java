package dbgame;
import java.sql.*;
import java.util.ArrayList;
 
public class connDb {
    private static Connection con = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;
 
    //连接数据库方法
    public static void startConn(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            //连接数据库中间件
            try{
                con = DriverManager.getConnection("jdbc:MySQL://localhost:3306/dbgame","root","root");
            }catch(SQLException e){
                e.printStackTrace();
            }
        }catch(ClassNotFoundException e){
            e.printStackTrace();
        }
    }
 
    //关闭连接数据库方法
    public static void endConn() throws SQLException{
        if(con != null){
            con.close();
            con = null;
        }
        if(rs != null){
            rs.close();
            rs = null;
        }
        if(stmt != null){
            stmt.close();
            stmt = null;
        }
    }
    
//    public static ArrayList index() throws SQLException{
//        ArrayList<DataAnalysis> list = new ArrayList();
//        startConn();
//        stmt = con.createStatement();
//        rs = stmt.executeQuery("select * from 表名");
//        while(rs.next()){
//            DataAnalysis  data =  new DataAnalysis();
//            //比如userId;
//            data.setUserId(rs.getString("user_id"));
//            list.add(data);
//        }
//            endConn();
//        return list;
//    }
    
    // test方法
    public static ArrayList test() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT COUNT(DISTINCT user_id)FROM user_log");
        while(rs.next()){
        	String[] temp={rs.getString(1)};
//        	System.out.print(rs.next());
//            String[] temp={rs.getString("action"),rs.getString("num")};
            list.add(temp);
        }
            endConn();
        return list;
    }
    
    // 3.1新增用户分析
    // 3.1.1新增用户人数
    public static ArrayList f1_1() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT COUNT(DISTINCT user_id)FROM user_log");
        while(rs.next()){
        	String[] temp={rs.getString(1)};
            list.add(temp);
        }
            endConn();
        return list;
    }
    // 3.1.2新增付费玩家数
    public static ArrayList f1_2() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT COUNT( DISTINCT user_id ) FROM user_log  WHERE pay_price >0");
        while(rs.next()){
        	String[] temp={rs.getString(1)};
            list.add(temp);
        }
            endConn();
        return list;
    }
 // 3.1.3注册玩家付费转化率
    public static ArrayList f1_3() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT ( SELECT COUNT( DISTINCT user_id ) FROM user_log WHERE pay_price > 0 )/( SELECT COUNT( DISTINCT user_id ) FROM user_log )");
        while(rs.next()){
        	String[] temp={rs.getString(1)};
            list.add(temp);
        }
            endConn();
        return list;
    }

    // 3.1.4每日新增玩家DNU
    public static ArrayList f1_4() throws SQLException{
           ArrayList<String[]> list = new ArrayList();
           startConn();
           stmt = con.createStatement();
           rs = stmt.executeQuery("SELECT DATE( register_time ) AS '时间',COUNT( DISTINCT user_id ) AS '新增玩家数' FROM user_log GROUP BY DATE(register_time)");
           while(rs.next()){
        	   
               String[] temp={rs.getString(1),rs.getString(2)};
               list.add(temp);
           }
           endConn();
           return list;
       }
    
 // 3.1.5每日新增付费玩家数
    public static ArrayList f1_5() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT DATE( register_time ) AS '时间',COUNT( DISTINCT user_id ) AS '新增玩家数' FROM user_log WHERE pay_price>0 GROUP BY DATE(register_time)");
        while(rs.next()){
            String[] temp={rs.getString(1),rs.getString(2)};
            list.add(temp);
        }
        endConn();
        return list;
    }

// 玩家活跃度分析
    //玩家平均在线时长
    public static ArrayList f2_1() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery(" SELECT ROUND(AVG( avg_online_minutes ),2)  FROM user_log");
        while(rs.next()){
        	String[] temp={rs.getString(1)};
            list.add(temp);
        }
            endConn();
        return list;
    }
    
   // #付费玩家平均在线时长
    public static ArrayList f2_2() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT AVG( avg_online_minutes ) '付费玩家平均在线时长'  FROM user_log WHERE pay_price>0");
        while(rs.next()){
        	String[] temp={rs.getString(1)};
            list.add(temp);
        }
            endConn();
        return list;
    }
    //假定用户平均在线时长在30分钟及以上为活跃用户，对比分析每日新增用户数、日活跃用户数以及日付费用户数
   
    public static ArrayList f2_3() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery(" SELECT DATE( register_time ) AS '日期',  COUNT(DISTINCT user_id) AS '每日新增用户', SUM(CASE WHEN avg_online_minutes>=30 THEN 1 ELSE 0 END) AS '每日活跃用户', CONCAT((SUM(CASE WHEN avg_online_minutes>=30 THEN 1 ELSE 0 END)/COUNT(register_time))) AS '每日活跃用户占比',SUM(CASE WHEN pay_price>0 THEN 1 ELSE 0 END) AS '每日付费用户',CONCAT((sum(CASE WHEN pay_price>0 THEN 1 ELSE 0 END)/COUNT(register_time))) AS '每日付费用户占比' FROM user_log GROUP BY  DATE(register_time)");
        while(rs.next()){
        	String[] temp={rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6)};
            list.add(temp);
        }
            endConn();
        return list;
    }
    
    
//	玩家付费行为分析
    //    活跃用户付费比例
    // 返回值为付费【活跃玩家，活跃玩家，活跃用户付费比例】
	public static ArrayList f3_1() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT a.APA,a.AU,a.APA/a.AU as 'PUR' FROM(SELECT COUNT(CASE WHEN avg_online_minutes>30 THEN user_id ELSE NULL END) 'AU',COUNT(CASE WHEN pay_price>0 AND avg_online_minutes>30 THEN user_id ELSE NULL END) 'APA' FROM user_log ) a");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3) };
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//		平均每用户收入
	public static ArrayList f3_2() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(a.income/a.AU,2) as 'ARPU' FROM (SELECT COUNT(CASE WHEN avg_online_minutes>30 THEN user_id ELSE NULL END) 'AU', sum(pay_price) 'income' FROM user_log) a");
	    while(rs.next()){
	        String[] temp={ rs.getString(1) };
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	平均每付费用户收入
	public static ArrayList f3_3() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT  ROUND(a.income/a.APA,2) as 'ARPPU' FROM (SELECT COUNT(CASE WHEN pay_price>0 AND avg_online_minutes>30 THEN user_id ELSE NULL END) 'APA', sum(pay_price) 'income' FROM user_log) a");
	    while(rs.next()){
	        String[] temp={ rs.getString(1),};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	各等级付费情况
	// 返回值为【等级，总人数，付费人数，付费转化率，付费总金额，人均付费金额，总付费次数，人均付费次数】
	public static ArrayList f3_4() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT a.level,a.totalNumber,a.paidNumber,ROUND(a.paidNumber/a.totalNumber,2) AS '付费转化率',ROUND(a.totalPaid,2) AS 'totalPaid',ROUND(a.totalPaid/a.totalNumber,2) AS '人均付费金额',a.totalPaidNumber, ROUND(a.totalPaidNumber/a.totalNumber,2) AS '人均付费次数' FROM (SELECT bd_stronghold_level AS'level',COUNT(DISTINCT user_id) as 'totalNumber',COUNT(CASE WHEN pay_price>0 THEN user_id ELSE NULL END) 'paidNumber',SUM(pay_price) AS 'totalPaid', SUM(pay_count) AS 'totalPaidNumber' FROM user_log GROUP BY bd_stronghold_level) a ORDER BY (a.level+0) ASC");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//总收入
	public static ArrayList f3_5() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(SUM(pay_price),2) AS '付费总额' FROM user_log");
	    while(rs.next()){
	        String[] temp={ rs.getString(1),};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
//	玩家游戏习惯分析
	//	AU玩家PVP情况
	public static ArrayList f4_1() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(AVG(pvp_battle_count)) AS 'AU玩家平均PVP次数',ROUND(sum(pvp_win_count)/SUM(pvp_battle_count),4) AS 'AU玩家PVP胜率',ROUND(SUM(pvp_lanch_count)/SUM(pvp_battle_count),4)AS 'AU玩家主动发起PVP概率' FROM user_log WHERE avg_online_minutes>30");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	//	APA玩家PVP情况
	public static ArrayList f4_2() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(AVG(pvp_battle_count)) AS 'APA玩家平均PVP次数',ROUND(sum(pvp_win_count)/SUM(pvp_battle_count),4) AS 'APA玩家PVP胜率',ROUND(SUM(pvp_lanch_count)/SUM(pvp_battle_count),4)AS 'APA玩家主动发起PVP概率' FROM user_log WHERE avg_online_minutes>30 AND pay_price>0");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
//	AU玩家PVE情况
	public static ArrayList f4_3() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(AVG(pve_battle_count)) AS 'AU玩家平均PVE次数', ROUND(sum(pve_win_count)/SUM(pve_battle_count),4) AS 'AU玩家PVE胜率', ROUND(SUM(pve_lanch_count)/SUM(pve_battle_count),4)AS 'AU玩家主动发起PVE概率' FROM user_log WHERE avg_online_minutes>30");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	//	APA玩家PVE情况
	public static ArrayList f4_4() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(AVG(pve_battle_count)) AS 'APA玩家平均PVE次数',ROUND(sum(pve_win_count)/SUM(pve_battle_count),4) AS 'APA玩家PVE胜率',ROUND(SUM(pve_lanch_count)/SUM(pve_battle_count),4)AS 'APA玩家主动发起PVE概率' FROM user_log WHERE avg_online_minutes>30 AND pay_price>0");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	AU各类资源使用率
	public static ArrayList f4_5() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(sum(wood_reduce_value)/SUM(wood_add_value),4)AS '木材使用率',ROUND(SUM(stone_reduce_value)/SUM(stone_add_value),4)AS '石头使用率',ROUND(SUM(ivory_reduce_value)/SUM(ivory_add_value),4)AS '象牙使用率',ROUND(SUM(meat_reduce_value)/SUM(meat_add_value),4)AS '肉使用率',ROUND(SUM(magic_reduce_value)/SUM(magic_add_value),4)AS '魔法使用率'FROM user_log WHERE avg_online_minutes>30");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	//	APA各类资源使用率
	public static ArrayList f4_6() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(sum(wood_reduce_value)/SUM(wood_add_value),4)AS '木材使用率',ROUND(SUM(stone_reduce_value)/SUM(stone_add_value),4)AS '石头使用率',ROUND(SUM(ivory_reduce_value)/SUM(ivory_add_value),4)AS '象牙使用率',ROUND(SUM(meat_reduce_value)/SUM(meat_add_value),4)AS '肉使用率',ROUND(SUM(magic_reduce_value)/SUM(magic_add_value),4)AS '魔法使用率'FROM user_log WHERE avg_online_minutes>30 AND pay_price>0");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	AU各类兵种损失率
	public static ArrayList f4_7() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(SUM(infantry_reduce_value-wound_infantry_reduce_value)/SUM(infantry_add_value),4) AS '勇士损失率',ROUND(SUM(cavalry_reduce_value-wound_cavalry_reduce_value)/SUM(cavalry_add_value),4)AS'驯兽师损失率',ROUND(SUM(shaman_reduce_value-wound_shaman_reduce_value)/SUM(shaman_add_value),4)AS '萨满损失率' FROM user_log WHERE avg_online_minutes>30");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	APA各类兵种损失率
	public static ArrayList f4_8() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(SUM(infantry_reduce_value-wound_infantry_reduce_value)/SUM(infantry_add_value),4) AS '勇士损失率',ROUND(SUM(cavalry_reduce_value-wound_cavalry_reduce_value)/SUM(cavalry_add_value),4)AS'驯兽师损失率',ROUND(SUM(shaman_reduce_value-wound_shaman_reduce_value)/SUM(shaman_add_value),4)AS '萨满损失率' FROM user_log WHERE avg_online_minutes>30 AND pay_price>0");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	APA加速卷使用率
	public static ArrayList f4_9() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(SUM(general_acceleration_reduce_value)/SUM(general_acceleration_add_value),4) AS '通用类',ROUND(SUM(building_acceleration_reduce_value)/SUM(building_acceleration_add_value),4)AS '建筑类',ROUND(SUM(reaserch_acceleration_reduce_value)/SUM(reaserch_acceleration_add_value),4)AS '科研类',ROUND(SUM(training_acceleration_reduce_value)/SUM(training_acceleration_add_value),4)AS '训练类',ROUND(SUM(treatment_acceleration_reduce_value)/SUM(treatment_acceleraion_add_value),4)AS '治疗类' FROM user_log WHERE avg_online_minutes>30 ");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	APA加速卷使用率
	public static ArrayList f4_10() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(SUM(general_acceleration_reduce_value)/SUM(general_acceleration_add_value),4) AS '通用类',ROUND(SUM(building_acceleration_reduce_value)/SUM(building_acceleration_add_value),4)AS '建筑类',ROUND(SUM(reaserch_acceleration_reduce_value)/SUM(reaserch_acceleration_add_value),4)AS '科研类',ROUND(SUM(training_acceleration_reduce_value)/SUM(training_acceleration_add_value),4)AS '训练类',ROUND(SUM(treatment_acceleration_reduce_value)/SUM(treatment_acceleraion_add_value),4)AS '治疗类' FROM user_log WHERE avg_online_minutes>30 AND pay_price>0");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	AU玩家各建筑等级
	public static ArrayList f4_11() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(AVG(bd_training_hut_level),2)AS '士兵小屋',ROUND(AVG(bd_healing_lodge_level),2)AS 'a',ROUND(AVG(bd_stronghold_level),2)AS '要塞',ROUND(AVG(bd_outpost_portal_level),2)AS '据点传送门',ROUND(AVG(bd_barrack_level),2)AS '兵营',ROUND(AVG(bd_healing_spring_level),2)AS '治疗之泉',ROUND(AVG(bd_dolmen_level),2)AS '智慧神庙',ROUND(AVG(bd_guest_cavern_level),2)AS '联盟大厅',ROUND(AVG(bd_warehouse_level),2)AS'仓库',ROUND(AVG(bd_watchtower_level),2)AS'瞭望塔',ROUND(AVG(bd_magic_coin_tree_level),2)AS'魔法幸运树',ROUND(AVG(bd_hall_of_war_level),2)AS'战争大厅',ROUND(AVG(bd_market_level),2)AS'联盟货车',ROUND(AVG(bd_hero_gacha_level),2)AS'占卜台',ROUND(AVG(bd_hero_strengthen_level),2)AS'祭坛',ROUND(AVG(bd_hero_pve_level),2)AS'冒险传送门'FROM user_log WHERE avg_online_minutes>30");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
	
	//	APA玩家各建筑等级
	public static ArrayList f4_12() throws SQLException{
	    ArrayList<String[]> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("SELECT ROUND(AVG(bd_training_hut_level),2)AS '士兵小屋',ROUND(AVG(bd_healing_lodge_level),2)AS 'a',ROUND(AVG(bd_stronghold_level),2)AS '要塞',ROUND(AVG(bd_outpost_portal_level),2)AS '据点传送门',ROUND(AVG(bd_barrack_level),2)AS '兵营',ROUND(AVG(bd_healing_spring_level),2)AS '治疗之泉',ROUND(AVG(bd_dolmen_level),2)AS '智慧神庙',ROUND(AVG(bd_guest_cavern_level),2)AS '联盟大厅',ROUND(AVG(bd_warehouse_level),2)AS'仓库',ROUND(AVG(bd_watchtower_level),2)AS'瞭望塔',ROUND(AVG(bd_magic_coin_tree_level),2)AS'魔法幸运树',ROUND(AVG(bd_hall_of_war_level),2)AS'战争大厅',ROUND(AVG(bd_market_level),2)AS'联盟货车',ROUND(AVG(bd_hero_gacha_level),2)AS'占卜台',ROUND(AVG(bd_hero_strengthen_level),2)AS'祭坛',ROUND(AVG(bd_hero_pve_level),2)AS'冒险传送门'FROM user_log WHERE avg_online_minutes>30 AND pay_price>0");
	    while(rs.next()){
	        String[] temp={ rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16)};
	        list.add(temp);
	    }
	    endConn();
	    return list;
	}
}
