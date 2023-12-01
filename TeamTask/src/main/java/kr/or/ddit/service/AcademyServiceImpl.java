package kr.or.ddit.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IAcademyMapper;
import kr.or.ddit.vo.AcademyVO;

@Service
public class AcademyServiceImpl implements IAcademyService {

	@Inject
	private IAcademyMapper mapper;
	
	@Override
	public List<AcademyVO> getAcademyTree() {
		return mapper.getAcademyTree();
	}

}
