package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mypf.portfolio.vo.PortfolioVO;

@Mapper
public interface PortfolioMapper {

	//포폴 리스트
	public List<PortfolioVO> pfList();
	
	//포폴 등록
	public void pfAdd(PortfolioVO pf);
	
	//포폴 상세 보기
	public PortfolioVO pfDetail(int prtfNum);
	
	//포폴 수정
	public int pfMod(PortfolioVO pf);
	
	//포폴 삭제
	public int pfDel(int prtfNum);
	
}
