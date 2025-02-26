package uni;

import java.util.*;

public class Course {
    int courseID;
    static List<Course> courseList = new ArrayList<>();
    public String title;
    public int units;

    public Course(String title, int units) {
        this.title = title;
        this.units = units;
        courseList.add(this);
        this.courseID = courseList.size();
    }

    public static Course findById(int ID){
        for (Course course : courseList){
            if (course.courseID == ID)
                return course;
        }
        return null;
    }
}