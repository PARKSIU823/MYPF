package com.mypf.portfolio.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.mypf.mapper.PortfolioMapper;
import com.mypf.portfolio.service.PortfolioService;
import com.mypf.portfolio.vo.PortfolioVO;

@Service
public class PortfolioServiceImpl implements PortfolioService{

	@Autowired
	private PortfolioMapper pfMapper;
	//포폴 리스트 불러오기
	@Override
	public List<PortfolioVO> pfList() throws Exception {
		return null;
	}

	//포폴 조회하기
	@Override
	public PortfolioVO pfDetail(int prtfNum) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//포폴 등록하기
	public void pfAdd(PortfolioVO pf) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//포폴 수정하기
	public boolean pfMod(PortfolioVO pf) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	//포폴 삭제하기
	public boolean pfDel(int prftNum) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}
	
	
}
