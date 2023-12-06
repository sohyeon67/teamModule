package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.Student;

public interface IGridMapper {

	public List<Student> list();
	public int update(Student student);

}
