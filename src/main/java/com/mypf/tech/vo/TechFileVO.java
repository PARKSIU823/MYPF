package com.mypf.tech.vo;

import lombok.Data;

@Data
public class TechFileVO {
	
	/*
	 * tech_num : 글 번호
	 * file_path : 파일 경로
	 * file_nm : 파일 이름
	 * uuid : 첨부파일 고유 아이디
	 * file_type : 파일 타입
	 */
	private int tech_num;
	private String file_path;
	private String file_nm;
	private String uuid;
	private boolean file_type;
	
}
