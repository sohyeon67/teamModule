package kr.or.ddit.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.IAcademyService;
import kr.or.ddit.vo.AcademyVO;

@Controller
public class HomeController {

	@Inject
	private IAcademyService academyService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}

	@ResponseBody
	@RequestMapping(value = "/treelist.do", method = RequestMethod.POST)
	public List<AcademyVO> jqAcademyTree(AcademyVO academyVO, Model model) {
		List<AcademyVO> academyList = academyService.getAcademyTree();
		return academyList;
	}

	/*
	 * @RequestMapping(value = "/createTree.do", method = RequestMethod.POST) public
	 * ResponseEntity<AcademyVO> createTree(@RequestBody AcademyVO academyVO, Model
	 * model) { academyService.create(academyVO); return "redirect:/"; }
	 */
}
