package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.TechCommVO;
import com.mypf.tech.vo.TechVO;
/* 기술 게시판 메퍼 인터페이스 */
@Mapper
public interface TechMapper {

	// 기술 게시판 목록 조회
	public List<TechVO> techList() throws Exception;
	
	// 기술게시판 목록 페이징
	public List<TechVO> getListWithPaging(Criteria cri) throws Exception;
	
	// 기술 게시판 전체 데이터의 개수 처리
	public int getTotalCount(Criteria cri) throws Exception;
	
	public void techWrite(TechVO techVO) throws Exception;
	
	// 기술 게시판 글 작성
	public void techWriteSelectKey(TechVO techVO) throws Exception;
	
	// 기술 게시판 글 상세 조회
	public TechVO techDetail(int tech_num) throws Exception;
	
	// 기술 게시판 글 조회수 +1 증가
	public void updateHit(int tech_num) throws Exception;
	
	// 기술 게시판 글 수정
	public int techMod(TechVO techVO) throws Exception;
		
	// 기술 게시판 글 삭제
	public int techDel(int tech_num) throws Exception;
	
	// 기술 게시판 댓글 작성
	public int insert(TechCommVO techcommVO) throws Exception;
	
	// 기술 게시판 댓글 조회
	public TechCommVO read(int tech_num) throws Exception;
	
	// 기술 게시판 댓글 삭제
	public int delete(int comm_num) throws Exception;
	
	// 기술 게시판 댓글 수정
	public int update(TechCommVO techcommVO) throws Exception;
	
	// 기술 게시판 댓글 목록 조회(TechMapper.xml에서 #{tech_num}이 @Param("tech_num")와 매칭)
	public List<TechCommVO> getListWithPagingComm(
			@Param("cri") Criteria cri, @Param("tech_num") int tech_num) throws Exception;
}
