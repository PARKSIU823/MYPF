package com.mypf.tech.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class CommPageDTO {
	
	private int commCnt;
	private List<TechCommVO> list;

}
