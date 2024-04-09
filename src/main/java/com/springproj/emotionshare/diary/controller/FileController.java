package com.springproj.emotionshare.diary.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.springproj.emotionshare.diary.domain.FileUploadDTO;
import com.springproj.emotionshare.diary.service.FileService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class FileController {	
	
	@Autowired
	private final FileService fileService;
	 
    public FileController(FileService fileService) {
        this.fileService = fileService;
    }
 
    //단일 파일 업로드
    @PostMapping("/uploadFile")
    public FileUploadDTO uploadFile(@RequestParam("file") MultipartFile file) {
        String fileName = fileService.storeFile(file);
 
        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/downloadFile/")
                .path(fileName)
                .toUriString();
 
        return new FileUploadDTO(fileName, fileDownloadUri,
                file.getContentType(), file.getSize());
    }
    // 다중
    @PostMapping("/uploadMultipleFiles")
    public List<FileUploadDTO> uploadMultipleFiles(@RequestParam("files") MultipartFile[] files) {
        return Arrays.asList(files)
                .stream()
                .map(file -> uploadFile(file))
                .collect(Collectors.toList());
    }
    

    @GetMapping("/downloadFile/{fileName:.+}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName, HttpServletRequest request) {
        // 파일을 Resource타입으로 받아온다.
        Resource resource = fileService.loadFileAsResource(fileName);
 
        // 파일 content type 확인 (jpg, png 등..)
        String encodedFileName = null;
        String contentType = null;
        try {
            contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
            encodedFileName = URLEncoder.encode(resource.getFilename(),"UTF-8").replaceAll("\\+", "%20");
            log.info("encodedFileName : " + encodedFileName);
        } catch (IOException ex) {
            log.info("Could not determine file type.");
        }
 
        // 파일 타입을 알 수 없는 경우의 기본값
        if(contentType == null) {
            contentType = "application/octet-stream";
        }
 
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"")
                .body(resource);
    }
}
