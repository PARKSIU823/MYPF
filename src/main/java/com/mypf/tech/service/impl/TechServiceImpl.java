package com.mypf.tech.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mypf.mapper.TechMapper;
import com.mypf.tech.service.TechService;
import com.mypf.tech.vo.CommPageDTO;
import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.TechCommVO;
import com.mypf.tech.vo.TechFileVO;
import com.mypf.tech.vo.TechVO;

import lombok.extern.log4j.Log4j;

/* 기술 게시판 서비스 구현 */
@Service
@Log4j
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
	@Transactional
	@Override
	public void techWrite(TechVO techVO) throws Exception {
		mapper.techWriteSelectKey(techVO);
		
		if(techVO.getFileList() == null || techVO.getFileList().size() <= 0) {
			return;
		}
			techVO.getFileList().forEach(file -> {
				
				file.setTech_num(techVO.getTech_num());
				try {
					mapper.fileInsert(file);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
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
	@Transactional
	@Override
	public boolean techMod(TechVO techVO) throws Exception {
		log.info("modify " + techVO);
		mapper.deleteAll(techVO.getTech_num());
		boolean modifyResult = mapper.techMod(techVO) == 1;
		if (modifyResult && techVO.getFileList() != null && techVO.getFileList().size() > 0) {
			techVO.getFileList().forEach(file -> {
				file.setTech_num(techVO.getTech_num());
				try {
					mapper.fileInsert(file);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
		}
		return modifyResult;
	}

	// 기술 게시판 글 삭제
	@Transactional
	@Override
	public boolean techDel(int tech_num) throws Exception {
		log.info("remove..." + tech_num);
		mapper.deleteAll(tech_num);
		return mapper.techDel(tech_num) == 1;
	}

	// 기술 게시판 댓글 작성
	@Transactional
	@Override
	public int register(TechCommVO techcommVO) throws Exception {
		mapper.updateCommCnt(techcommVO.getTech_num(), 1);
		return mapper.insert(techcommVO);
	}

	// 기술 게시판 댓글 조회
	@Override
	public TechCommVO get(int comm_num) throws Exception {
		return mapper.read(comm_num);
	}

	// 기술 게시판 댓글 수정
	@Override
	public int modify(TechCommVO techcommVO) throws Exception {
		return mapper.update(techcommVO);
	}
	
	// 기술 게시판 댓글 삭제
	@Transactional
	@Override
	public int remove(int comm_num) throws Exception {
		TechCommVO techcommVO = mapper.read(comm_num);
		mapper.updateCommCnt(techcommVO.getTech_num(), -1);
		return mapper.delete(comm_num);
	}

	// 기술 게시판 댓글 목록 조회
	@Override
	public List<TechCommVO> getList(Criteria cri, int tech_num) throws Exception {
		return mapper.getListWithPagingComm(cri, tech_num);
	}
	
	// 기술 게시판 댓글 수
	@Override
	public CommPageDTO getListPage(Criteria cri, int tech_num) throws Exception {
		return new CommPageDTO(
				mapper.getCountByTech_num(tech_num),
				mapper.getListWithPagingComm(cri, tech_num));
	}
	
	// 기술 게시판 첨부파일 조회
	@Override
	public List<TechFileVO> getFileList(int tech_num) throws Exception {
		log.info("get file list by tech_num " + tech_num);
		return mapper.findByTech_num(tech_num);
	}
}