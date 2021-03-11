package com.mypf.portfolio;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mypf.portfolio.service.PortfolioService;
import com.mypf.portfolio.vo.PfCriteria;
import com.mypf.portfolio.vo.PfFileVO;
import com.mypf.portfolio.vo.PfPageDTO;
import com.mypf.portfolio.vo.PortfolioVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/portfolio/*")
public class PortfolioController {
	
	@Autowired
	private PortfolioService pfService;
	
	//포트폴리오 게시판 리스트
	@RequestMapping(value = "pf_list.do", method=RequestMethod.GET)
	public String pfList(Model model, PfCriteria cri)  throws Exception{
		log.info("pfList : " + cri);
		model.addAttribute("pfList", pfService.pfList(cri));
		model.addAttribute("pageMaker", new PfPageDTO(cri, 10));
		return "portfolio/pf_list";
	}

	//포트폴리오 게시판 글 내용 조회
	@RequestMapping(value="pf_read.do", method=RequestMethod.GET)
	public String pfRead(@RequestParam("prtf_num") int prtf_num, @ModelAttribute("pfCri") PfCriteria pfCri, Model model) throws Exception{
		log.info("포트폴리오 조회 : " + prtf_num);
		model.addAttribute("pfRead", pfService.pfDetail(prtf_num));
		return "portfolio/pf_read";
	}
	
	//포트폴리오 게시판 글 작성 페이지
	@RequestMapping(value="pf_write.do", method = RequestMethod.GET)
	public String pfWriteform(Model model) throws Exception {
		log.info("포트폴리오 작성화면");
		return "portfolio/pf_write";
	}
	
	//포트폴리오 게시판 글 작성
	@RequestMapping(value="pf_write.do", method = RequestMethod.POST)
	public String pfWrite(PortfolioVO pf, Model model)  throws Exception{
		log.info("포트폴리오 작성 : " + pf);
		pf.setFrm_dt((String)pf.getFrm_dt());
		pf.setTo_dt((String)pf.getTo_dt());
		pfService.pfAdd(pf);
		model.addAttribute("result", pf.getPrtf_num());
		return "portfolio/pf_read.do?prtf_num="+pf.getPrtf_num();
	}
	
	//포트폴리오 작성시 섬네일 출력
	@RequestMapping(value="pfDisplay.do")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String file_nm) {
		log.info("파일 이름 : " + file_nm);
		File file = new File("C:\\upload\\"+file_nm);
		log.info("파일 : " + file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result= new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//포트폴리오 게시판 글 수정 페이지
	@RequestMapping(value = "pf_modify.do", method = RequestMethod.GET)
	public String pfModForm(@RequestParam("prtf_num") int prtf_num, Model model) throws Exception{
		log.info("포폴 글 수정 페이지");
		model.addAttribute("pfModify", pfService.pfDetail(prtf_num));
		return "portfolio/pf_modify";
	}
	
	//포트폴리오 게시판 글 수정
	@RequestMapping(value = "pf_modify.do", method = RequestMethod.POST)
	public String pfMod(PortfolioVO pf ,@ModelAttribute("pfCri") PfCriteria pfCri, Model model)  throws Exception{
		log.info("포트폴리오 수정 : " + pf);
		if(pfService.pfMod(pf)) {
			pf.setFrm_dt((String)pf.getFrm_dt());
			pf.setTo_dt((String)pf.getTo_dt());
			model.addAttribute("result", pf);
		}
		return "redirect:/portfolio/pf_read.do?prtf_num="+pf.getPrtf_num();
	}
	
	//포트폴리오 게시판 글 삭제
	@RequestMapping(value = "pf_delete.do", method = RequestMethod.POST)
	public String pfDel(@RequestParam("prtf_num") int prtf_num, @ModelAttribute("pfCri") PfCriteria pfCri, Model model)  throws Exception{
		log.info("포트폴리오 삭제 : " + prtf_num);
		List<PfFileVO> pfFileList = pfService.getFileList(prtf_num);
		if(pfService.pfDel(prtf_num)) {
			deleteFiles(pfFileList);
			model.addAttribute("result", prtf_num);
		}
		return "redirect:/portfolio/pf_list.do";
	}
	
	//업로드한 파일 형식 확인
	private boolean checkFileType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//파일 업로드시 연월일 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	//포트폴리오 파일 업로드
	@RequestMapping(value="pf_file_write.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<PfFileVO>> pfFileWrite(MultipartFile[] uploadFile)  throws Exception{
		log.info("포트폴리오 파일 업로드 : " + uploadFile);
		
		//파일 업로드
		List<PfFileVO> pfFileList = new ArrayList<>();
		
		//파일 저장 경로
		String uploadFolder = "C:\\upload";
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		//연월일 폴더가 존재하지 않으면 생성
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			PfFileVO pfFileVO = new PfFileVO();
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE 파일 path 수정
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info("File Name : "+ uploadFileName);
			pfFileVO.setFile_nm(uploadFileName);
			
			//중복방지 UUID 생성 후 파일 이름에 붙여넣기
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				pfFileVO.setFile_nm(uuid.toString());
				pfFileVO.setFile_path(uploadFolderPath);
				
				//이미지 파일 thumbnail 보여주기
				if(checkFileType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200,200);
					thumbnail.close();
				}
				pfFileList.add(pfFileVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(pfFileList, HttpStatus.OK);
	}
	
	//포트폴리오 파일 DB와 비교 후 삭제
	private void deleteFiles(List<PfFileVO> pfFileList) {
		log.info("포트폴리오 파일 DB 삭제");
		log.info("삭제 파일 리스트 : " + pfFileList);
		if(pfFileList == null || pfFileList.size() ==0) {
			return;
		}
		
		pfFileList.forEach(file -> {
			try {
				Path pfFile = Paths.get("C:\\upload\\" + file.getFile_path()+ "\\" +file.getUuid()+"_"+file.getFile_nm()); 
				Files.deleteIfExists(pfFile);
				Path thumbnail = Paths.get("C:\\upload\\" + file.getFile_path()+"\\s_"+ file.getUuid()+"_"+file.getFile_nm());
				Files.delete(thumbnail);
			} catch (Exception e) {
				log.error("파일 삭제 오류 : " + e.getMessage());
			}
		});
	}
}
