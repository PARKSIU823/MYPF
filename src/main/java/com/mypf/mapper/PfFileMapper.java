package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mypf.portfolio.vo.PfFileVO;

@Mapper
public interface PfFileMapper {
	
	//파일 등록
	public void insert(PfFileVO pfFile);
	
	//파일 삭제
	public void delete(String uuid);
	
	//파일 조회
	public List<PfFileVO> findByPrtf_num(int prtf_num);
	
	//파일 삭제
	public void deleteAll(int prtf_num);

}
