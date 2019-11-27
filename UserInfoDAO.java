package com.internousdev.radish.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.internousdev.radish.dto.UserInfoDTO;
import com.internousdev.radish.util.DBConnector;

public class UserInfoDAO {
	DBConnector db= new DBConnector();
	Connection con=db.getConnection();
	//ユーザー存在チェック(userId)
	public int isUserIdAvailable(String userId){
		String sql="select count(*) as cnt from user_info where user_id=?";
		int count = 0;	
		try{
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				count=rs.getInt("cnt");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return count;
	}
	//ユーザー存在チェック(userId.password)
	public int loginCheck(String userId,String password){
		String sql="select count(*) as cnt from user_info where user_id=? and password=?";
		int count = 0;	
		try{
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, userId);
			ps.setString(2,password);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				count=rs.getInt("cnt");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return count;
	}
	//ユーザー登録
	public int addUser(String userId,String password,String familyName,String firstName,String familyNameKana,String firstNameKana,int sex,String email){
		String sql="insert into user_info(user_id,password,family_name,first_name,family_name_kana,first_name_kana,sex,email,status,logined,regist_date,update_date) value(?,?,?,?,?,?,?,?,0,1,now(),now())";
		int updateCount=0;
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, userId);
			ps.setString(2, password);
			ps.setString(3, familyName);
			ps.setString(4, firstName);
			ps.setString(5, familyNameKana);
			ps.setString(6, firstNameKana);
			ps.setInt(7, sex);
			ps.setString(8, email);
			updateCount=ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return updateCount;
	}
	//パスワード再設定
	public int updatePassword(String userId,String password){
		String sql="update user_info set password=? where user_id=?";
		int count=0;
		try{
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, password);
			ps.setString(2, userId);
			count=ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return count;
	}
	//マイページ
	public UserInfoDTO getUserInfo(String userId){
		UserInfoDTO dto = new UserInfoDTO();
		String sql="select * from user_info where user_id=?";
		try{
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs= ps.executeQuery();
			if(rs.next()){
				dto.setUserId(rs.getString("user_id"));
				dto.setFamilyName(rs.getString("family_name"));
				dto.setFirstName(rs.getString("first_name"));
				dto.setFamilyNameKana(rs.getString("family_name_kana"));
				dto.setFirstNameKana(rs.getString("first_name_kana"));
				dto.setSex(rs.getInt("sex"));
				dto.setEmail(rs.getString("email"));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return dto;
	}
}