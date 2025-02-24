package edu.uni.components;

import java.util.*;

public class PresentedCourse{
    int presentedCourseID;
    static List<PresentedCourse> presentedCourseList = new ArrayList<>();
    public int courseID;
    public int professorID;
    public int maxCapacity;
    public List<Integer> studentIDList;

    public PresentedCourse(int courseID, int professorID, int maxCapacity){
        this.courseID = courseID;
        this.professorID = professorID;
        this.maxCapacity = maxCapacity;
        this.studentIDList = new ArrayList<>(maxCapacity);
        presentedCourseList.add(this);
        presentedCourseID = presentedCourseList.size();
    }

    public static PresentedCourse findById(int ID){
        for (PresentedCourse presentedCourse : presentedCourseList){
            if (presentedCourse.presentedCourseID == ID)
                return presentedCourse;
        }
        return null;
    }

    public void addStudent(int studentID) {
        studentIDList.add(studentID);
    }
}