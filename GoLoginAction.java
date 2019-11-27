package com.internousdev.radish.action;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class GoLoginAction extends ActionSupport implements SessionAware{
	private Map<String,Object> session;
	private String cartFlag;
	
	public String execute(){	
		if (cartFlag != null)  {
			session.put("cartFlag", cartFlag);
		}
		return SUCCESS;
	}
	
	public String getCartFlag(){
		return cartFlag;
	}
	public void setCartFlag(String cartFlag){
		this.cartFlag=cartFlag;
	}
	public Map<String,Object> getSession(){
		return session;
	}
	public void setSession(Map<String,Object> session){
		this.session=session;
	}
}
