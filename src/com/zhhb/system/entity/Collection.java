package com.zhhb.system.entity;

import java.util.Date;

import com.pintu.pub.entity.BaseEntity;

@SuppressWarnings("serial")
public class Collection extends BaseEntity {

	private Integer id;// 编号
	private String collectiontitle;// 收藏标题
	private String printquantity;// 限量打印数目
	private String descriptionof;// 收藏描叙
	private Date createtime;// 创建时间

	private Integer memberid;// 会员编号
	private String lastname;// 名
	private String storeaddress;// 头像地址
	private String firstname;// 姓
	private Date birthday;// 生日
	private String telephone;// 电话
	private String email;// 邮箱
	private String avatarpath;// 作品路径
	private String introduction;// 会员简介
	private String membertype;// 会员流派
	private String bank;// 银行
	private String bankaccount;// 银行账号
	private String payee;// 收款人

	private String categories;// 类别
	private String styles;// 风格
	private String subject;// 主题
	private String color;// 颜色

	private String thumbnailpath;// 缩略图路径

	public String getThumbnailpath() {
		return thumbnailpath;
	}

	public void setThumbnailpath(String thumbnailpath) {
		this.thumbnailpath = thumbnailpath;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getCategories() {
		return categories;
	}

	public void setCategories(String categories) {
		this.categories = categories;
	}

	public String getStyles() {
		return styles;
	}

	public void setStyles(String styles) {
		this.styles = styles;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public Integer getMemberid() {
		return memberid;
	}

	public void setMemberid(Integer memberid) {
		this.memberid = memberid;
	}

	public String getAvatarpath() {
		return avatarpath;
	}

	public void setAvatarpath(String avatarpath) {
		this.avatarpath = avatarpath;
	}

	public String getStoreaddress() {
		return storeaddress;
	}

	public void setStoreaddress(String storeaddress) {
		this.storeaddress = storeaddress;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAvatarPath() {
		return avatarpath;
	}

	public void setAvatarPath(String avatarPath) {
		this.avatarpath = avatarPath;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getMembertype() {
		return membertype;
	}

	public void setMembertype(String membertype) {
		this.membertype = membertype;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getBankaccount() {
		return bankaccount;
	}

	public void setBankaccount(String bankaccount) {
		this.bankaccount = bankaccount;
	}

	public String getPayee() {
		return payee;
	}

	public void setPayee(String payee) {
		this.payee = payee;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getDescriptionof() {
		return descriptionof;
	}

	public void setDescriptionof(String descriptionof) {
		this.descriptionof = descriptionof;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

}
