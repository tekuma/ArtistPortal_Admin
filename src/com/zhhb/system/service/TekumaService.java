package com.zhhb.system.service;

import javax.annotation.Resource;

import org.aspectj.lang.annotation.SuppressAjWarnings;
import org.springframework.stereotype.Service;

import com.pintu.pub.page.PageResult;
import com.zhhb.server.comm.PublicJdbcDao;
import com.zhhb.system.entity.Collection;
import com.zhhb.system.entity.Member;
import com.zhhb.system.entity.Pool;
import com.zhhb.system.entity.User;




@SuppressAjWarnings("unchecked")
@Service(value = "tekumaService")
public class TekumaService {
	@Resource
	private PublicJdbcDao psychologyJdbcDao;
	
	public PublicJdbcDao getPsychologyJdbcDao() {
		return psychologyJdbcDao;
	}

	public void setPsychologyJdbcDao(PublicJdbcDao psychologyJdbcDao) {
		this.psychologyJdbcDao = psychologyJdbcDao;
	}
	
	
	/***
	 * 获取用户信息
	 */
	public User findUser(User userNew){
		String sql="select UserName from tk_user_t where LoginName='"+userNew.getLoginname()+"' and LoginPwd='"+userNew.getLoginpwd()+"'";
		return (User)this.psychologyJdbcDao.getList(sql,User.class).get(0);
	}
	
/*	*//***
	 * 查询所有流派
	 *//*
	public List<Member> findMemberType(){
		String sql="select MemberType from tk_member_t group by MemberType";
		return this.psychologyJdbcDao.getList(sql,Member.class);
	}*/
	
	/**
	 * 查询所有collection文件
	 * @param pageResul
	 * @return
	 */
	public PageResult findcollwnlist(PageResult pageResult,String collcategories,String collstyles,String collsubjects,String color){
		String sql="select t1.id,t1.CollectionTitle,t3.MemberID,t3.storeaddress,t4.LastName,t4.FirstName,t4.MemberType from tk_collection_t t1 "
				+ "left join (select * from tk_relevancy_t) t2 on t2.COLLECTIONID=t1.ID "
				+ "left join (select * from tk_pool_t) t3 on t3.ID=t2.POOLID "
				+ "left join (select * from tk_member_t) t4 on t4.ID=t3.MemberID where 1=1 ";
		if(collcategories!=null&&!collcategories.equals("")){
			sql+="and t1.Categories='"+collcategories+"' ";
		}
		if(collstyles!=null&&!collstyles.equals("")){
			sql+="and t1.Styles='"+collstyles+"' ";
		}
		if(collsubjects!=null&&!collsubjects.equals("")){
			sql+="and t1.Subject='"+collsubjects+"' ";
		}
		if(color!=null&&!color.equals("")){
			String colorcc=color.substring(0,4);
			sql+="and t1.color like '"+colorcc+"%' ";
		}
		sql+="group by t1.ID ";
		pageResult=this.getPsychologyJdbcDao().findPageResult(sql, pageResult, Collection.class);
		return pageResult;
	}
	
	
	/**
	 * 分页查询出所有会员
	 * Check out all of the members
	 * @return aa
	 */
	public PageResult findMemberlist(PageResult pageResult,String letters,String categories,String styles,String subjects){
		String sql="select t1.id,t1.firstname,t1.lastname,t1.avatarpath,t4.Categories,t4.Styles,t4.Subject from tk_member_t t1 "
				+ "left join (select * from tk_pool_t ) t2 on t2.MemberID=t1.ID "
				+ "left join (select * from tk_relevancy_t ) t3 on t3.POOLID=t2.ID "
				+ "left join (select * from tk_collection_t ) t4 on t4.ID=t3.COLLECTIONID where 1=1 ";
		if(letters!=null&&!letters.equals("")){
			sql+="and firstname like'"+letters+"%' ";
		}
		if(categories!=null&&!categories.equals("")){
			sql+="and t4.Categories='"+categories+"' ";
		}
		if(styles!=null&&!styles.equals("")){
			sql+="and t4.Styles='"+styles+"' ";
		}
		if(subjects!=null&&!subjects.equals("")){
			sql+="and t4.Subject='"+subjects+"' ";
		}
		sql+="group by t1.id";
		pageResult=this.getPsychologyJdbcDao().findPageResult(sql, pageResult, Member.class);
		return pageResult;
	}
	
	
	/**
	 * 根据会员id查询所有Collection文件
	 * Query all Collection files according to member ID
	 * @return
	 */
	public PageResult findCollectionlist(PageResult pageResult,String memberID){
		String sql="select t3.ID,t3.CollectionTitle,t3.CreateTime from tk_relevancy_t t1 "
				+ "left join (select * from tk_pool_t) t2 on t2.ID=t1.POOLID "
				+ "left join (select * from tk_collection_t) t3 on t3.ID=t1.COLLECTIONID "
				+ "left join (select * from tk_member_t) t4 on t4.ID=t2.MemberID "
				+ "where t4.ID='"+memberID+"' group by t1.COLLECTIONID ";
		pageResult=this.getPsychologyJdbcDao().findPageResult(sql, pageResult, Collection.class);
		return pageResult;
	}
	
	
	/**
	 * 根据Collectionid查询所有pool文件
	 * Query all pool files according to member Collectionid
	 * @return ID,MemberID,Title,CreateTime,EntryLabel,Description,UploadTime,storeaddress
	 */
	public PageResult findPoollist(PageResult pageResult,String Collectionid){
		String sql="select t1.COLLECTIONID,t2.ID,t2.MemberID,t2.Title,t2.CreateTime,t2.storeaddress,t3.CollectionTitle,t3.DescriptionOf,t3.PrintQuantity from tk_relevancy_t t1 "
				+ "left join (select * from tk_pool_t) t2 on t2.ID=t1.POOLID "
				+ "left join (select * from tk_collection_t) t3 on t3.ID=t1.COLLECTIONID "
				+ "left join (select * from tk_member_t) t4 on t4.ID=t2.MemberID "
				+ "where t1.COLLECTIONID='"+Collectionid+"' order by t2.UploadTime desc";
		pageResult=this.getPsychologyJdbcDao().findPageResult(sql,pageResult,Pool.class);
		return pageResult;
	}
	
	
	
	
	
	
	
	

}
