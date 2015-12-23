package com.zhhb.system.action;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.pintu.pub.action.BaseAction;
import com.pintu.pub.page.PageResult;
import com.zhhb.system.service.TekumaService;
import com.zhhb.system.entity.Collection;
import com.zhhb.system.entity.Display;
import com.zhhb.system.entity.Member;
import com.zhhb.system.entity.Pool;
import com.zhhb.system.entity.Relevancy;

@SuppressWarnings({ "unused", "unchecked", "serial" })
@Scope("prototype")
@Controller(value = "tekumaAction")
public class TekumaAction extends BaseAction {
	@Resource
	private TekumaService tekumaService;

	private Collection collectionNew;// 收藏文件夹表
	private List<Collection> collectionlist;
	private Relevancy relevancyNew;// 关联表
	private List<Relevancy> relevancylist;
	private Pool poolNew;// 作品池表
	private List<Pool> poollist;
	private Member memberNew;
	private List<Member> memberlist;
	private List<Member> membertypelist;
	private Display displayNew;
	private List<Display> displaylist;

	public List<Display> getDisplaylist() {
		return displaylist;
	}

	public void setDisplaylist(List<Display> displaylist) {
		this.displaylist = displaylist;
	}

	public Display getDisplayNew() {
		return displayNew;
	}

	public void setDisplayNew(Display displayNew) {
		this.displayNew = displayNew;
	}

	public List<Member> getMembertypelist() {
		return membertypelist;
	}

	public void setMembertypelist(List<Member> membertypelist) {
		this.membertypelist = membertypelist;
	}

	public Collection getCollectionNew() {
		return collectionNew;
	}

	public void setCollectionNew(Collection collectionNew) {
		this.collectionNew = collectionNew;
	}

	public List<Collection> getCollectionlist() {
		return collectionlist;
	}

	public void setCollectionlist(List<Collection> collectionlist) {
		this.collectionlist = collectionlist;
	}

	public Relevancy getRelevancyNew() {
		return relevancyNew;
	}

	public void setRelevancyNew(Relevancy relevancyNew) {
		this.relevancyNew = relevancyNew;
	}

	public List<Relevancy> getRelevancylist() {
		return relevancylist;
	}

	public void setRelevancylist(List<Relevancy> relevancylist) {
		this.relevancylist = relevancylist;
	}

	public Pool getPoolNew() {
		return poolNew;
	}

	public void setPoolNew(Pool poolNew) {
		this.poolNew = poolNew;
	}

	public List<Pool> getPoollist() {
		return poollist;
	}

	public void setPoollist(List<Pool> poollist) {
		this.poollist = poollist;
	}

	public Member getMemberNew() {
		return memberNew;
	}

	public void setMemberNew(Member memberNew) {
		this.memberNew = memberNew;
	}

	public List<Member> getMemberlist() {
		return memberlist;
	}

	public void setMemberlist(List<Member> memberlist) {
		this.memberlist = memberlist;
	}

	// 跳转到邀请码页面并生成随机邀请码
	public String makeCode() throws IOException {
		UUID uuid = UUID.randomUUID();
		String code = uuid.toString().substring(1, 7);
		request.setAttribute("code", code);
		// String sql="insert into tk_code_t(NUMBER) values('"+uuid+"')";
		// this.tekumaService.getPsychologyJdbcDao().executeSQL(sql);
		return "addinvite";
	}

	/**
	 * 查询所有collection文件da'e
	 * 
	 * @return
	 */
	public String findcollwnlist() {
		this.pageResultInit();
		String pageNo = this.request.getParameter("pageNo");
		String collcategories = this.request.getParameter("collcategories");
		String collstyles = this.request.getParameter("collstyles");
		String collsubjects = this.request.getParameter("collsubjects");
		String color = this.request.getParameter("color");
		this.pageResult = new PageResult();
		this.pageResult.setPageNo(Integer.valueOf(pageNo));
		this.pageResult.setPageSize(14);
		this.pageResult = this.tekumaService.findcollwnlist(this.pageResult,
				collcategories, collstyles, collsubjects, color);
		// this.membertypelist=this.tekumaService.findMemberType();

		// 显示缩略图
		List<Collection> path = this.pageResult.getList();
		String Thumbnailurl = null;
		Collection picurlr;
		for (int i = 0; i < path.size(); i++) {
			picurlr = path.get(i);
			if (picurlr.getStoreaddress() != null
					&& picurlr.getStoreaddress() != "") {
				Thumbnailurl = picurlr.getStoreaddress().replace(".", "tb.");
				picurlr.setThumbnailpath(Thumbnailurl);
			}
		}
		return "collectionlist";
	}

	public void findcollwnlistajax() {
		this.pageResultInit();
		String pageNo = this.request.getParameter("pageNo");
		String collcategories = this.request.getParameter("collcategories");
		String collstyles = this.request.getParameter("collstyles");
		String collsubjects = this.request.getParameter("collsubjects");
		String color = this.request.getParameter("color");
		this.pageResult = new PageResult();
		this.pageResult.setPageNo(Integer.valueOf(pageNo));
		this.pageResult.setPageSize(14);
		this.pageResult = this.tekumaService.findcollwnlist(this.pageResult,
				collcategories, collstyles, collsubjects, color);
		// this.membertypelist=this.tekumaService.findMemberType();
		this.entityReturnJson(this.pageResult);
	}

	/**
	 * 查询会员
	 * 
	 * @return
	 */
	public void findMemberlistajax() {
		this.pageResultInit();
		String pageNo = this.request.getParameter("pageNo");
		String letters = this.request.getParameter("letters");
		String categories = this.request.getParameter("categories");
		String styles = this.request.getParameter("styles");
		String subjects = this.request.getParameter("subjects");
		this.pageResult = new PageResult();
		this.pageResult.setPageNo(Integer.valueOf(pageNo));
		this.pageResult.setPageSize(14);
		this.pageResult = this.tekumaService.findMemberlist(this.pageResult,
				letters, categories, styles, subjects);
		// this.membertypelist=this.tekumaService.findMemberType();
		this.entityReturnJson(this.pageResult);
	}

	public String findMemberlist() {
		this.pageResultInit();
		String pageNo = this.request.getParameter("pageNo");
		String letters = this.request.getParameter("letters");
		String categories = this.request.getParameter("categories");
		String styles = this.request.getParameter("styles");
		String subjects = this.request.getParameter("subjects");
		this.pageResult = new PageResult();
		this.pageResult.setPageNo(Integer.valueOf(pageNo));
		this.pageResult.setPageSize(14);
		this.pageResult = this.tekumaService.findMemberlist(this.pageResult,
				letters, categories, styles, subjects);
		// this.membertypelist=this.tekumaService.findMemberType();
		return "index";
	}

	/**
	 * 根据会员编号查询出会员的Collection信息
	 * 
	 * @return
	 */
	public String findCollectionlist() {
		this.pageResultInit();
		String pageNo = this.request.getParameter("pageNo");
		String memberid = this.request.getParameter("memberid");
		this.pageResult = new PageResult();
		this.pageResult.setPageNo(Integer.valueOf(pageNo));
		this.pageResult.setPageSize(14);
		this.pageResult = this.tekumaService.findCollectionlist(
				this.pageResult, memberid);
		String sql = "select avatarpath,lastname,firstname,birthday,telephone,email,introduction,bank,bankaccount,payee from tk_member_t where ID="
				+ memberid;
		this.memberNew = (Member) this.tekumaService.getPsychologyJdbcDao()
				.getList(sql, Member.class).get(0);
		return "memcollectionlist";
	}

	public void findCollectionlistajax() {
		this.pageResultInit();
		String pageNo = this.request.getParameter("pageNo");
		String memberid = this.request.getParameter("memberid");
		this.pageResult = new PageResult();
		this.pageResult.setPageNo(Integer.valueOf(pageNo));
		this.pageResult.setPageSize(14);
		this.pageResult = this.tekumaService.findCollectionlist(
				this.pageResult, memberid);
		String sql = "select avatarpath,lastname,firstname,birthday,telephone,email,introduction,bank,bankaccount,payee from tk_member_t where ID="
				+ memberid;
		this.memberNew = (Member) this.tekumaService.getPsychologyJdbcDao()
				.getList(sql, Member.class).get(0);
		this.entityReturnJson(this.pageResult);
	}

	/**
	 * 根据Collection编号查询出所有Pool文件信息
	 * 
	 * @return
	 */
	public String findPoollist() {
		this.pageResultInit();
		String pageNo = this.request.getParameter("pageNo");
		String collectionid = this.request.getParameter("collectionid");
		this.pageResult = new PageResult();
		this.pageResult.setPageNo(Integer.valueOf(pageNo));
		this.pageResult.setPageSize(12);
		this.pageResult = this.tekumaService.findPoollist(this.pageResult,
				collectionid);
		// this.request.getSession().setAttribute("mid",pageResult.getList().get(0));
		/*
		 * String sql="select * from tk_collection_t where ID="+collectionid;
		 * this
		 * .collectionNew=(Collection)this.tekumaService.getPsychologyJdbcDao
		 * ().getList(sql, Collection.class).get(0);
		 */
		String SQL = "select * from tk_display_t where CID=" + collectionid
				+ " order by Time desc limit 0,2 ";
		this.displaylist = this.tekumaService.getPsychologyJdbcDao().getList(
				SQL, Display.class);
		// 显示缩略图
		List<Pool> path = this.pageResult.getList();
		String Thumbnailpath = null;
		Pool picurlr;
		for (int i = 0; i < path.size(); i++) {
			picurlr = path.get(i);
			if (picurlr.getStoreaddress() != null
					&& picurlr.getStoreaddress() != "") {
				Thumbnailpath = picurlr.getStoreaddress().replace(".", "tb.");
				picurlr.setThumbnailurl(Thumbnailpath);
			}
		}
		return "poollist";
	}

	// 根据displayid查询出其展览信息
	public void finddisplayidd() {
		String SQL = "select * from tk_display_t where ID="
				+ this.displayNew.getId();
		this.displayNew = (Display) this.tekumaService.getPsychologyJdbcDao()
				.getList(SQL, Display.class).get(0);
		this.entityReturnJson(this.displayNew);
	}

	// 根据Collectio_id查询出Collectio所有展览信息
	public void finddisplaycid() {
		String SQL = "select * from tk_display_t where CID="
				+ this.displayNew.getCid() + " order by Time desc";
		this.displaylist = this.tekumaService.getPsychologyJdbcDao().getList(
				SQL, Display.class);
		this.listReturnJson(this.displaylist);
	}

	/**
	 * 添加修改Collectio展览信息
	 */
	public void updatedispaly() {
		String SQL = "select * from tk_display_t where ID="
				+ this.displayNew.getId();
		int count = this.tekumaService.getPsychologyJdbcDao()
				.getTempInt(SQL, 0);
		if (count != 0) {
			this.tekumaService.getPsychologyJdbcDao().executeMYSQLDB("update",
					"tk_display_t", this.displayNew, "id");
			this.entityReturnJson("Update successd！");
		} else {
			this.tekumaService.getPsychologyJdbcDao().executeMYSQLDB("save",
					"tk_display_t", this.displayNew, "");
			this.entityReturnJson("ADD successd！");
		}
	}

	// 删除展览信息
	public void deletedispaly() {
		this.tekumaService.getPsychologyJdbcDao().executeMYSQLDB("delete",
				"tk_display_t", this.displayNew, "id");
		this.entityReturnJson("Delete successd!");
	}

	// 根据Collectio_id查询第二个之后的所有展览信息
	public void finddisplaylist() {
		String SQL = "select count(1) from tk_display_t where CID="
				+ this.displayNew.getCid() + " order by Time desc";
		int count = this.tekumaService.getPsychologyJdbcDao()
				.getTempInt(SQL, 0);
		String sql = "select * from tk_display_t where CID="
				+ this.displayNew.getCid() + " order by Time desc limit 2,"
				+ count + "";
		this.displaylist = this.tekumaService.getPsychologyJdbcDao().getList(
				sql, Display.class);
		this.listReturnJson(this.displaylist);
	}

}