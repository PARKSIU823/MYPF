package com.mypf.portfolio.vo;

public class PfCriteria {

	private int pageNum;
	private int amount;
	
	public  PfCriteria() {
		this(1,9);
	}
	
	public PfCriteria(int pageNum, int amount) {
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
