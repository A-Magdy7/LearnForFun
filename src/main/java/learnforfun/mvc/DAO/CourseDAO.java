package learnforfun.mvc.DAO;

import java.util.ArrayList;

import learnforfun.mvc.Models.Course;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseDAO
{
	public void insert(Course course);
	
	public void delete(int ID);
	
	public int getID(String name);
	
	public ArrayList<Course> TeacherCourses(int ID);
	
	public ArrayList<Course> AllCourses();
}
