package com.mypf.portfolio.service;

import java.util.List;

import com.mypf.portfolio.vo.PfCriteria;
import com.mypf.portfolio.vo.PfFileVO;
import com.mypf.portfolio.vo.PortfolioVO;

public interface PortfolioService {
	
	//포폴 리스트 불러오기
	public List<PortfolioVO> pfList(PfCriteria cri) throws Exception;
	
	//포폴 조회하기
	public PortfolioVO pfDetail(int prtfNum) throws Exception;
	
	//포폴 조회수 증가
	public void addHit(int prtfNum) throws Exception;
	
	//포폴 등록하기
	public void pfAdd(PortfolioVO pf) throws Exception;
	
	//포폴 수정하기
	public boolean pfMod(PortfolioVO pf) throws Exception;
	
	//포폴 삭제하기
	public boolean pfDel(int prftNum) throws Exception;
	
	//포폴 첨부파일 조회
	public List<PfFileVO> getFileList(int prtfNum) throws Exception;

}
