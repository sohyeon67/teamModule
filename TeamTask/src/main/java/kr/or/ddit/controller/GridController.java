package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.IGridService;
import kr.or.ddit.vo.Student;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/grid")
public class GridController {
	
	@Inject
	private IGridService gridService;
	
	// 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "/getGridData", method=RequestMethod.POST)
	public ResponseEntity<List<Student>> getGridData(@RequestBody String id) {
		
		List<Student> studentList = gridService.list();
		System.out.println(studentList);
		return new ResponseEntity<List<Student>>(studentList, HttpStatus.OK);
	}
	
	
	// 3) 객체 타입의 JSON 요청 데이터 @RequestBody 어노테이션을 지정하여 자바빈즈 매개변수로 처리한다.
	// 비동기 처리 진행시, 객체 매개변수 -> 요청 본문안에 데이터 바인딩을 위한 @RequestBody를 필수로 붙여줘야함
	@ResponseBody
	@RequestMapping(value = "/gridUpdate", method = RequestMethod.POST)
	public ResponseEntity<String> grid02Update(@RequestBody Map<String, String> param) {
	    log.info("grid02Update() 실행...!");
	    int stId = Integer.parseInt(param.get("stId"));
	    String columnName = param.get("columnName");
	    String value = param.get("value");

	    // Student 객체에 파라미터 넣기
	    Student student = new Student();
	    student.setStId(stId);
	    if ("grade".equals(columnName)) {
	        student.setGrade(value);
	    }
	    if ("tel".equals(columnName)) {
	        student.setTel(value);
	    }
	    if ("certificate".equals(columnName)) {
	        student.setCertificate(value);
	    }
	    if ("majorType".equals(columnName)) {
	        student.setMajorType(value);
	    }

	    // update 호출
	    log.info("student : " + student);
	    int result = gridService.update(student);
	    log.info("변화 수 : " + result);
	    

	    log.info("changeColumn : " + columnName);
	    return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	
	
	/*
	 * @RequestMapping(value = "/grid02", method = RequestMethod.GET) public String
	 * grid02(){
	 * 
	 * return "api_read"; }
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping("/saveData") public String saveData(@RequestBody String
	 * jsonData) { return "result"; // 담은 result는 ajax에게 넘겨준다. }
	 */
	
	
	
	
}
