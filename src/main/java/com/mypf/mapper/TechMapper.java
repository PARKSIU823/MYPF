package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.TechVO;
/* 기술 게시판 메퍼 인터페이스 */
@Mapper
public interface TechMapper {

	// 기술 게시판 목록 조회
	public List<TechVO> techList() throws Exception;
	
	// 기술게시판 목록 페이징
	public List<TechVO> getListWithPaging(Criteria cri);
	
	public void techWrite(TechVO techVO) throws Exception;
	
	// 기술 게시판 글 작성
	public void techWriteSelectKey(TechVO techVO) throws Exception;
	
	// 기술 게시판 글 상세 조회
	public TechVO techDetail(int techNum) throws Exception;
	
	// 기술 게시판 글 수정
	public int techMod(TechVO techVO) throws Exception;
		
	// 기술 게시판 글 삭제
	public int techDel(int techNum) throws Exception;
}
