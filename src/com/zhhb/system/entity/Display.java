package com.zhhb.system.entity;

import java.util.Date;

import com.pintu.pub.entity.BaseEntity;

@SuppressWarnings("serial")
public class Display extends BaseEntity {

	private Integer id;// 编号
	private Integer cid;// 收藏夹编号
	private String address;// 展览地址
	private String site;// 展览网址
	private Date time;// 展览时间

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getSite() {
		return site;
	}

	public void setSite(String site) {
		this.site = site;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

}
