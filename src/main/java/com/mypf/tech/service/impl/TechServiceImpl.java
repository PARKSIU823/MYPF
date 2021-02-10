package com.mypf.tech.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.mypf.mapper.TechMapper;
import com.mypf.tech.service.TechService;
import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.TechVO;

/* 기술 게시판 서비스 구현 */
@Service
public class TechServiceImpl implements TechService{

	@Autowired
	private TechMapper mapper;
	
	// 기술 게시판 목록 조회
	@Override
	public List<TechVO> techList(Criteria cri) throws Exception {
		return mapper.getListWithPaging(cri);
	}
	
	// 기술 게시판 전체 데이터의 개수 처리
	@Override
	public int getTotal(Criteria cri) throws Exception {
		return mapper.getTotalCount(cri);
	}
	
	// 기술 게시판 글 작성
	@Override
	public void techWrite(TechVO techVO) throws Exception {
		mapper.techWriteSelectKey(techVO);
	}

	// 기술 게시판 글 상세 조회
	@Override
	public TechVO techDetail(int tech_num) throws Exception {
		return mapper.techDetail(tech_num);
	}
	
	// 기술 게시판 글 조회수 +1 증가
	@Override
	public void updateHit(int tech_num) throws Exception {
		mapper.updateHit(tech_num);	
	}
	
	// 기술 게시판 글 수정
	@Override
	public boolean techMod(TechVO techVO) throws Exception {
		return mapper.techMod(techVO) == 1;
	}

	// 기술 게시판 글 삭제
	@Override
	public boolean techDel(int tech_num) throws Exception {
		return mapper.techDel(tech_num) == 1;
	}
}
