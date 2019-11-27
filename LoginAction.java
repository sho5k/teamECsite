package com.internousdev.radish.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.radish.dao.CartInfoDAO;
import com.internousdev.radish.dao.UserInfoDAO;
import com.internousdev.radish.dto.CartInfoDTO;
import com.internousdev.radish.util.InputChecker;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements SessionAware{
	Map<String,Object> session = new HashMap<String,Object>();
	List<String> userIdErrorList = new ArrayList<String>();
	List<String> passwordErrorList = new ArrayList<String>();
	List<CartInfoDTO> cartInfoDTOList = new ArrayList<CartInfoDTO>();
	private String userId;
	private String password;
	private String loginErrorMessage;
	private boolean keepUserId;
	private long totalPrice;
	
	public String execute(){
		UserInfoDAO userDAO = new UserInfoDAO();
		InputChecker check = new InputChecker();
		String result = ERROR;
		
		session.remove("keepUserId");
		if(session.containsKey("createUserFlag")){//ユーザー登録から遷移
			userId=session.get("createUserId").toString();
			session.remove("createUserId");
			session.remove("password");
			session.remove("createUserFlag");
			result=sessionAndRelationCart();
		}else{//ユーザー登録以外からの遷移
			//入力チェック
			userIdErrorList = check.doCheck("ユーザーID", userId, 1, 8, true, false, false, true, false, false);
			passwordErrorList = check.doCheck("パスワード", password, 1, 16, true, false, false, true, false, false);
			if(userIdErrorList != null && userIdErrorList.size() > 0 
			|| passwordErrorList != null&& passwordErrorList.size() > 0){//入力チェックエラー
				return ERROR;
			}
			//入力チェックエラー無し
			int count=userDAO.loginCheck(userId, password);
			if(count>0){
				//ID,PASSの合致
				result=sessionAndRelationCart();
			}else{
				loginErrorMessage="ユーザーIDまたはパスワードが異なります。";
				session.put("logined", 0);
			}
		}
		return result;
	}
	
	public String sessionAndRelationCart(){
		String result = ERROR;
		CartInfoDAO cartDAO = new CartInfoDAO();
		if(!session.containsKey("tempUserId")){//仮ユーザーIDのセッションタイムアウトチェック
			return "sessionTimeout";
		}
		cartInfoDTOList=cartDAO.getCartInfoDTOList(session.get("tempUserId").toString());
		if(cartInfoDTOList != null && cartInfoDTOList.size()>0){//カート情報有り
			int count = 0;
			//カート情報の紐付け
			for (CartInfoDTO cartDTO:cartInfoDTOList){//仮ユーザーIDのカート情報書き出し
				if(cartDAO.isExistsCartInfo(userId,cartDTO.getProductId())){//ユーザーIDのカート情報にcartDTOの商品がある
					count += cartDAO.updateProductCount(userId, cartDTO.getProductId(), cartDTO.getProductCount());//個数の更新
					cartDAO.delete(String.valueOf(cartDTO.getProductId()),session.get("tempUserId").toString());
				}else{//ユーザーIDのカート情報にcartDTOの商品がない
					count += cartDAO.linkToUserId(session.get("tempUserId").toString(),userId,cartDTO.getProductId());//カート情報の仮ユーザーIDをユーザーIDに変更
				}
			}
			if(count==cartInfoDTOList.size()){//紐付け成功
				session.put("userId", userId);
				session.put("logined", 1);
				session.put("keepUserId", keepUserId);
				if(session.containsKey("cartFlag")){//カート画面から遷移
					cartInfoDTOList = cartDAO.getCartInfoDTOList(userId);
					totalPrice = cartDAO.getTotalPrice(userId);
					result="cart";
				}else{//カート画面以外からの遷移
					result=SUCCESS;
				}
			}else{//紐付け失敗
				return "DBError";
			}
		}else{//カート情報無し
		 	session.put("userId", userId);
			session.put("logined", 1);
			session.put("keepUserId", keepUserId);
			result=SUCCESS;
		}
		return result;
	}
	
	public Map<String,Object> getSession(){
		return session;
	}
	public void setSession(Map<String,Object> session){
		this.session=session;
	}
	public String getUserId(){
		return userId;
	}
	public void setUserId(String userId){
		this.userId=userId;
	}
	public String getPassword(){
		return password;
	}
	public void setPassword(String password){
		this.password=password;
	}
	public boolean getKeepUserId(){
		return keepUserId;
	}
	public void setKeepUserId(boolean keepUserId){
		this.keepUserId=keepUserId;
	}
	public String getLoginErrorMessage(){
		return loginErrorMessage;
	}
	public void setLoginErrorMessage(String loginErrorMessage){
		this.loginErrorMessage=loginErrorMessage;
	}
	public long getTotalPrice(){
		return totalPrice;
	}
	public void setTotalPrice(long totalPrice){
		this.totalPrice=totalPrice;
	}
	public List<String> getUserIdErrorList(){
		return userIdErrorList;
	}
	public void setUserIdErrorList(List<String> userIdErrorList){
		this.userIdErrorList=userIdErrorList;
	}
	public List<String> getPasswordErrorList(){
		return passwordErrorList;
	}
	public void setPasswordErrorList(List<String> passwordErrorList){
		this.passwordErrorList=passwordErrorList;
	}
	public List<CartInfoDTO> getCartInfoDTOList(){
		return cartInfoDTOList;
	}
	public void setCartInfoDTOList(List<CartInfoDTO> cartInfoDTOList){
		this.cartInfoDTOList=cartInfoDTOList;
	}
}
