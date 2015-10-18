package com.zhhb.system.entity;


import java.util.Date;

import com.pintu.pub.entity.BaseEntity;

@SuppressWarnings("serial")
public class Pool extends BaseEntity {
	
	private Integer id;//编号
	private Integer memberid;//会员编号
	private String title;//作品标题
	private String createtime;//创作年份
	private String entrylabel;//作品标签
	private String description;//作品描叙
	private Date uploadtime;//上传时间
	private String storeaddress;//作品存放地址
	
	private Integer collectionid;//文件夹编号
	
	private String collectiontitle;//收藏标题
	private String printquantity;//限量打印数目
	private String description0f;//收藏描叙
	
	private String thumbnailurl;//缩略图路径


	public String getThumbnailurl() {
		return thumbnailurl;
	}
	public void setThumbnailurl(String thumbnailurl) {
		this.thumbnailurl = thumbnailurl;
	}
	public Integer getCollectionid() {
		return collectionid;
	}
	public void setCollectionid(Integer collectionid) {
		this.collectionid = collectionid;
	}
	public String getCollectiontitle() {
		return collectiontitle;
	}
	public void setCollectiontitle(String collectiontitle) {
		this.collectiontitle = collectiontitle;
	}
	public String getPrintquantity() {
		return printquantity;
	}
	public void setPrintquantity(String printquantity) {
		this.printquantity = printquantity;
	}
	public String getDescription0f() {
		return description0f;
	}
	public void setDescription0f(String description0f) {
		this.description0f = description0f;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getMemberid() {
		return memberid;
	}
	public void setMemberid(Integer memberid) {
		this.memberid = memberid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getEntrylabel() {
		return entrylabel;
	}
	public void setEntrylabel(String entrylabel) {
		this.entrylabel = entrylabel;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getUploadtime() {
		return uploadtime;
	}
	public void setUploadtime(Date uploadtime) {
		this.uploadtime = uploadtime;
	}
	public String getStoreaddress() {
		return storeaddress;
	}
	public void setStoreaddress(String storeaddress) {
		this.storeaddress = storeaddress;
	}
	
	
}
