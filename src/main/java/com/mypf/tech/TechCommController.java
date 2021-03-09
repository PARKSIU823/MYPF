package com.mypf.tech;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mypf.tech.service.TechService;
import com.mypf.tech.vo.CommPageDTO;
import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.TechCommVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
/* 기술 게시판 댓글 컨트롤러 */
@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class TechCommController {
	
	private TechService service;
	
	// 기술 게시판 댓글 작성
	@PostMapping(value = "/new.do",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create (@RequestBody TechCommVO techcommVO) throws Exception {
		int insertCount = service.register(techcommVO);
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
				//삼항 연산자 처리
	}
	
	// 기술 게시판 댓글 목록 조회
	@GetMapping(value = "/pages/{tech_num}/{page}.do",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<CommPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("tech_num") int tech_num) throws Exception {
				
			Criteria cri = new Criteria(page, 10);
			
			log.info("get Comm List tech_num : " + tech_num);
			log.info("cri : " + cri);
			return new ResponseEntity<>(service.getListPage(cri, tech_num), HttpStatus.OK);
	}
	
	// 기술 게시판 댓글 조회
	@GetMapping(value = "/{comm_num}.do",
			produces = { MediaType.APPLICATION_XML_VALUE,
						 MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<TechCommVO> get(@PathVariable("comm_num") int comm_num) throws Exception {
		return new ResponseEntity<>(service.get(comm_num), HttpStatus.OK);
	}
	
	// 기술 게시판 댓글 삭제
	@DeleteMapping(value = "/{comm_num}.do", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("comm_num") int comm_num) throws Exception {
		return service.remove(comm_num) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 기술 게시판 댓글 수정
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
			value = "/{comm_num}.do",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(
			@RequestBody TechCommVO techcommVO,
			@PathVariable("comm_num") int comm_num) throws Exception {
		techcommVO.setComm_num(comm_num);
		return service.modify(techcommVO) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}