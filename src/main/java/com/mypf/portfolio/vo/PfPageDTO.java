package com.mypf.portfolio.vo;

public class PfPageDTO {

	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int total;
	private PfCriteria pfCri;
	
	public PfPageDTO(PfCriteria pfCri, int total) {
		this.pfCri = pfCri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(pfCri.getPageNum() / 9.0)) *10;
		this.startPage = this.endPage-9;
		
		int realEnd = (int) (Math.ceil((total * 1.0) / pfCri.getAmount()));
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getTotal() {
		return total;
	}

	public PfCriteria getPfCri() {
		return pfCri;
	}
	
	
}