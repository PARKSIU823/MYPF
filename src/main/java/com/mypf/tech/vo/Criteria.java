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
	// 검색 조건
	private String type;
	// 검색에 사용하는 키워드
	private String keyword;
	
	// 생성자를 통해서 기본값을 1페이지, 10개로 지정해서 처리
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 검색 조건을 배열로 만들어서 한 번에 처리
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
		
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
	// org.springframework.web.util.UriComponentsBuilder
	// 여러 개의 파라미터들을 연결해서 URL의 형태로 만들어주는 기능
}