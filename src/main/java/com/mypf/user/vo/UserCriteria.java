package com.mypf.user.vo;

public class UserCriteria {

	private int pageNum;
	private int amount;
	
	public UserCriteria() {
		this(1,10);
	}
	
	public UserCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
}
