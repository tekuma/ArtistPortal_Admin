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

@SuppressWarnings({ "unused", "serial" })
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

	public static String uname="";//缓存用户名
	public static String upwd="";//缓存密码
	
	/**
	 * 登录验证
	 * 
	 * @throws IOException
	 * */
	public void login() throws IOException {
		String sql;
		String iError="0";
		int iCount=0;
		sql="select count(1) from tk_user_t where LoginName='"+ this.userNew.getLoginname() + "'";
		iCount=this.tekumaservice.getPsychologyJdbcDao().getTempInt(sql, 0);
		if(iCount>0){
			sql = "select count(1) from tk_user_t where LoginName='"+ this.userNew.getLoginname() + "' and LoginPwd='"
					+ this.userNew.getLoginpwd() + "'";
			iCount = this.tekumaservice.getPsychologyJdbcDao().getTempInt(sql,0);
			if (iCount > 0) {
				uname=this.userNew.getLoginname();
				upwd=this.userNew.getLoginpwd();
				iError="0";
			} else {
				iError="2";//登录用户和口令不匹配
			}
		}else{
			iError="1";//没有找到该用户
		}
		this.strReturnJson(iError);
	}
	
	/**
	 * 登录跳转
	 * @return
	 */
	public String longining(){
		User userNew=new User();
		userNew.setLoginname(uname);
		userNew.setLoginpwd(upwd);
		this.userNew = this.tekumaservice.findUser(userNew);
		this.request.getSession().setAttribute("yhxm",this.userNew.getUsername());
		this.pageResultInit();
		String pageNo = "1";
		String letters = this.request.getParameter("letters");
		String categories = this.request.getParameter("categories");
		String styles = this.request.getParameter("styles");
		String subjects = this.request.getParameter("subjects");
		this.pageResult = new PageResult();
		this.pageResult.setPageNo(Integer.valueOf(pageNo));
		this.pageResult.setPageSize(14);
		this.pageResult = this.tekumaservice.findMemberlist(
				this.pageResult, letters, categories, styles, subjects);
		// 查询出文件图片地址
		this.request.getSession().setAttribute("sissionFileSerURL",this.tekumaservice.getPsychologyJdbcDao().getTempStr(
						"select csz from sys_param_t where bh='3'",""));
		return "index";
	}

}
