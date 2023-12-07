package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.Student;

public interface IGridService {

	public List<Student> list();
	public int update(Student student);

}
