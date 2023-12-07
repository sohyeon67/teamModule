package kr.or.ddit.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IGridMapper;
import kr.or.ddit.service.IGridService;
import kr.or.ddit.vo.Student;

@Service
public class GridServiceImpl implements IGridService {
	
	@Inject
	private IGridMapper mapper;

	@Override
	public List<Student> list() {
		return mapper.list();
	}

	@Override
	public int update(Student student) {
		return mapper.update(student);
	}

}
