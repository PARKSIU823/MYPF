package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mypf.portfolio.vo.PfCriteria;
import com.mypf.portfolio.vo.PfFileVO;
import com.mypf.portfolio.vo.PortfolioVO;

@Mapper
public interface PortfolioMapper {

	//포폴 리스트
	public List<PortfolioVO> pfList(PfCriteria cri) throws Exception;
	
	//포폴 전체 개수
	public int getTotalCount(PfCriteria cri) throws Exception;
	
	//포폴 등록
	public void pfAdd(PortfolioVO pf) throws Exception;
	
	//포폴 상세 보기
	public PortfolioVO pfDetail(int prtfNum) throws Exception;
	
	//포폴 조회수 증가
	public void addHit(int prtfNum) throws Exception;
	
	//포폴 수정
	public int pfMod(PortfolioVO pf) throws Exception;
	
	//포폴 삭제
	public int pfDel(int prtfNum) throws Exception;

	//포폴 파일 리스트
	public List<PfFileVO> findByPrtfNum(int prtfNum) throws Exception;
	
}
