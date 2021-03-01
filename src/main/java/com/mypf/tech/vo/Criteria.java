package com.mypf.tech.vo;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	// 페이지 번호
	private int pageNum;
	// 한 페이지 당 보여줄 데이터의 수
	private int amount;
	
	// 생성자를 통해서 기본값을 1페이지, 10개로 지정해서 처리
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount());
		
		return builder.toUriString();
	}

}