package com.mypf.portfolio.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.mypf.mapper.PortfolioMapper;
import com.mypf.portfolio.service.PortfolioService;
import com.mypf.portfolio.vo.PortfolioVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PortfolioServiceImpl implements PortfolioService{

	@Autowired
	private PortfolioMapper pfMapper;
	
	@Autowired
	private PortfolioService pfService;
	
	//포폴 리스트 불러오기
	@Override
	public List<PortfolioVO> pfList() throws Exception {
		log.info("목록 조회");
		return pfMapper.pfList();
	}

	//포폴 조회하기
	@Override
	public PortfolioVO pfDetail(int prtf_num) throws Exception {
		log.info("조회 : " + prtf_num);
		return pfMapper.pfDetail(prtf_num);
	}

	//포폴 등록하기
	@Override
	public void pfAdd(PortfolioVO pf) throws Exception {
		log.info("등록 : " + pf);
		pfMapper.pfAdd(pf);
	}

	//포폴 수정하기
	@Override
	public boolean pfMod(PortfolioVO pf) throws Exception {
		log.info("modify : " + pf);
		return pfMapper.pfMod(pf) == 1;
	}

	//포폴 삭제하기
	@Override
	public boolean pfDel(int prft_num) throws Exception {
		log.info("remove : " + prft_num);
		return pfMapper.pfDel(prft_num)==1;
	}
	
	
}
