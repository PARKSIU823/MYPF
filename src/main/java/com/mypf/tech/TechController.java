package com.mypf.tech;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mypf.tech.service.TechService;
import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.PageDTO;
import com.mypf.tech.vo.TechFileVO;
import com.mypf.tech.vo.TechVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
/* 기술 게시판 컨트롤러 */
@Controller
@Log4j
@RequestMapping("/tech/*")
public class TechController {
	
	@Autowired
	private TechService service;
	
	// 기술 게시판 목록 조회
	@RequestMapping(value="tech_list.do", method=RequestMethod.GET)
	public void techList(HttpServletRequest request, Criteria cri, Model model) throws Exception {
		model.addAttribute("list", service.techList(cri));
		
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 기술 게시판 글 작성 화면
	@RequestMapping(value="tech_write.do", method=RequestMethod.GET)
	public void techWrite() {
	}
	
	// 기술 게시판 글 작성
	@RequestMapping(value="tech_write.do", method=RequestMethod.POST)
	public String techWrite(TechVO techVO, RedirectAttributes rttr) throws Exception {
		log.info("=================================");
		log.info("register: "+techVO);
		if(techVO.getFileList() != null) {
			techVO.getFileList().forEach(file -> log.info(file));
		}
		log.info("=================================");
		service.techWrite(techVO);
		rttr.addFlashAttribute("result", techVO.getTech_num());
		return "redirect:tech_list.do";
	}
	
	// 기술 게시판 글 상세 조회
	@RequestMapping(value="tech_detail.do")
	public void techDetail(@RequestParam("tech_num") int tech_num, Model model) throws Exception {
		model.addAttribute("board", service.techDetail(tech_num));
		service.updateHit(tech_num);
	}
	
	// 기술 게시판 글 수정 화면
	@RequestMapping(value="tech_modify.do", method=RequestMethod.GET)
	public void techMod(@RequestParam("tech_num") int tech_num, Model model) throws Exception {
		model.addAttribute("board", service.techDetail(tech_num));
	}
	
	// 기술 게시판 글 수정
	@RequestMapping(value="tech_modify.do", method=RequestMethod.POST)
	public String techMod(TechVO techVO, RedirectAttributes rttr) throws Exception {
		if (service.techMod(techVO)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:tech_list.do";
	}
	
	// 기술 게시판 글 삭제
	@RequestMapping(value="tech_del.do", method=RequestMethod.POST)
	public String techDel(@RequestParam("tech_num") int tech_num, Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("delete ... " + tech_num);
		List<TechFileVO> fileList = service.getFileList(tech_num);
		if (service.techDel(tech_num)) {
			// delete files
			deleteFiles(fileList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:tech_list.do" + cri.getListLink();
	}
	
	/* 기술 게시판 첨부파일 */
	
	// 년/월/일 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	// 이미지 파일의 판단
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	// 섬네일 데이터 전송
	@GetMapping("/display.do")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String file_nm) {
		log.info("fileName : " + file_nm);
		File file = new File("c:\\upload\\"+file_nm);
		log.info("file : " + file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	// 기술 게시판 첨부파일 전송
	@PostMapping(value = "/uploadAjaxAction.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<TechFileVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<TechFileVO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();
		// make folder
		File file_path = new File(uploadFolder, uploadFolderPath);
		
		if (file_path.exists() == false) {
			file_path.mkdirs();
		}
		// make yyyy/MM/dd folder
		
		for(MultipartFile multipartFile : uploadFile) {
			
			TechFileVO techfileVO = new TechFileVO();
			
			String uploadfile_nm = multipartFile.getOriginalFilename();
			
			// IE has file path
			uploadfile_nm = uploadfile_nm.substring(uploadfile_nm.lastIndexOf("\\")+1);
			log.info("only file name: " + uploadfile_nm);
			techfileVO.setFile_nm(uploadfile_nm);
			
			UUID uuid = UUID.randomUUID();
			
			uploadfile_nm = uuid.toString() + "_" + uploadfile_nm;
			
			try {
				File saveFile = new File(file_path, uploadfile_nm);
				multipartFile.transferTo(saveFile);
				
				techfileVO.setUuid(uuid.toString());
				techfileVO.setFile_path(uploadFolderPath);
				
				//check image type file
				if (checkImageType(saveFile)) {
					
					techfileVO.setFile_type(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(file_path, "s_" + uploadfile_nm));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				
				//add to List
				list.add(techfileVO);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		} //end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	// 기술 게시판 첨부파일 다운로드
	@GetMapping(value = "/download.do", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String file_nm) {
		log.info("download file: " + file_nm);
		Resource resource = new FileSystemResource("c:\\upload\\" + file_nm);
		log.info("resource: " + resource);
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		String resourceName = resource.getFilename();
		
		// remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		HttpHeaders headers = new HttpHeaders();
		try {
			String downloadName = null;
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			} else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				log.info("Edge name: " + downloadName);
			} else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	// 기술 게시판 첨부파일 db 삭제
	private void deleteFiles(List<TechFileVO> fileList) {
		if(fileList == null || fileList.size() == 0) {
			return;
		}
		log.info("delete attach files..................");
		log.info(fileList);
		
		fileList.forEach(file -> {
			try {
				Path techFile = Paths.get("C:\\upload\\"+file.getFile_path()+"\\" + file.getUuid()+"_"+file.getFile_nm());
				Files.deleteIfExists(techFile);
				if(Files.probeContentType(techFile).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+file.getFile_path()+"\\s_" + file.getUuid()+"_"+file.getFile_nm());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error " + e.getMessage());
			}// end catch
		});// end foreach
	}
	// 기술 게시판 첨부파일 화면 삭제
	@PostMapping("/deleteFile.do")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String file_nm, String type) {
		log.info("deleteFile: " + file_nm);
		File file;
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(file_nm, "UTF-8"));
			file.delete();
			if(type.equals("image")) {
				String largeFile_nm  = file.getAbsolutePath().replace("s_", "");
				log.info("largeFile_nm: " + largeFile_nm);
				file = new File(largeFile_nm);
				file.delete();
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	// 기술 게시판 첨부파일 조회
	@GetMapping(value="/getFileList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<TechFileVO>> getFileList(int tech_num) throws Exception {
		log.info("getFileList " + tech_num);
		return new ResponseEntity<>(service.getFileList(tech_num), HttpStatus.OK);
	}
}
