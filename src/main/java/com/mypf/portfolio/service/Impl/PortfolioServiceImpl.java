package com.mypf.portfolio.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mypf.mapper.PortfolioMapper;
import com.mypf.portfolio.service.PortfolioService;
import com.mypf.portfolio.vo.PfCriteria;
import com.mypf.portfolio.vo.PfFileVO;
import com.mypf.portfolio.vo.PortfolioVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PortfolioServiceImpl implements PortfolioService{

	@Autowired
	private PortfolioMapper pfMapper;
	
	//포폴 리스트 불러오기
	@Override
	public List<PortfolioVO> pfList(PfCriteria cri) throws Exception {
		log.info("목록 조회 : " + cri);
		return pfMapper.pfList(cri);
	}

	//포폴 조회하기
	@Override
	public PortfolioVO pfDetail(int prtf_num) throws Exception {
		log.info("포폴 게시글 조회 : " + prtf_num);
		return pfMapper.pfDetail(prtf_num);
	}

	//포폴 등록하기
	@Override
	public void pfAdd(PortfolioVO pf) throws Exception {
		log.info("등록 : " + pf);
		pfMapper.pfAdd(pf);
		//파일 리스트가 없으면 실행 종료
		if(pf.getPfFileList() == null || pf.getPfFileList().size() <= 0) {return;}
		//파일 리스트가 있으면 파일 저장 반복 실행
		pf.getPfFileList().forEach(pfFile -> {
			pfFile.setPrtf_num(pf.getPrtf_num());
			try {
				pfMapper.pfFileAdd(pfFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}

	//포폴 수정하기
	@Override
	public boolean pfMod(PortfolioVO pf) throws Exception {
		log.info("포폴 수정 : " + pf);
		pfMapper.pfDel(pf.getPrtf_num());
		boolean pfModResult = pfMapper.pfMod(pf) == 1;
		if(pfModResult && pf.getPfFileList() != null && pf.getPfFileList().size() > 0) {
			pf.getPfFileList().forEach(pfFile -> {
				pfFile.setPrtf_num(pf.getPrtf_num());
				try {
					pfMapper.pfFileAdd(pfFile);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
		}
		return pfModResult;
	}
	
	//포폴 삭제하기
	@Transactional
	@Override
	public boolean pfDel(int prft_num) throws Exception {
		log.info("포폴 삭제 : " + prft_num);
		pfMapper.pfDel(prft_num);
		return pfMapper.pfDel(prft_num)==1;
	}

	//포폴 조회수 증가
	@Override
	public void addHit(int prtfNum) throws Exception {
		pfMapper.addHit(prtfNum);
		
	}

	//포폴 첨부파일 조회
	@Override
	public List<PfFileVO> getFileList(int prtfNum) throws Exception {
		log.info("포폴 첨부파일 조회 : " + prtfNum);
		return pfMapper.findByPrtfNum(prtfNum);
	}
	
	
}
