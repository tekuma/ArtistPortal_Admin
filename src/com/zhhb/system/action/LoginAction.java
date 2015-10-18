package com.zhhb.system.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.pintu.pub.action.BaseAction;
import com.pintu.pub.page.PageResult;
import com.zhhb.system.service.TekumaService;
import com.zhhb.system.entity.Member;
import com.zhhb.system.entity.User;


@SuppressWarnings({ "unused","serial" })
@Scope("prototype")
@Controller(value = "loginAction")
public class LoginAction extends BaseAction {
	@Resource
	private TekumaService tekumaservice;
	
	private User userNew;
	private List<Member> membertypelist;


	public User getUserNew() {
		return userNew;
	}
	public void setUserNew(User userNew) {
		this.userNew = userNew;
	}
	public List<Member> getMembertypelist() {
		return membertypelist;
	}
	public void setMembertypelist(List<Member> membertypelist) {
		this.membertypelist = membertypelist;
	}

	
	
	
	/**
	 * 登录验证
	 * @throws IOException 
	 * */
	public String login() throws IOException {
		String sql="select count(1) from tk_user_t where LoginName='"+this.userNew.getLoginname()+"' and LoginPwd='"+this.userNew.getLoginpwd()+"'";
		int iCount=this.tekumaservice.getPsychologyJdbcDao().getTempInt(sql, 0);
		if(iCount>0){
			this.userNew=this.tekumaservice.findUser(this.userNew);
			this.request.getSession().setAttribute("yhxm", this.userNew.getUsername());
			this.pageResultInit();
			String pageNo="1";
			String letters=this.request.getParameter("letters");
			String categories=this.request.getParameter("categories");
			String styles=this.request.getParameter("styles");
			String subjects=this.request.getParameter("subjects");
			this.pageResult=new PageResult();
			this.pageResult.setPageNo(Integer.valueOf(pageNo));
			this.pageResult.setPageSize(14);
			this.pageResult=this.tekumaservice.findMemberlist(this.pageResult,letters,categories,styles,subjects);
			// 查询出文件图片地址
			this.request.getSession().setAttribute("sissionFileSerURL", this.tekumaservice.getPsychologyJdbcDao().getTempStr("select csz from sys_param_t where csmc='文件服务器地址'", ""));
			return "index";
		}else{
			response.sendRedirect("http://52.1.199.42/TekumaServer//");
		}
			return "index";
	}
	
	
	
}
