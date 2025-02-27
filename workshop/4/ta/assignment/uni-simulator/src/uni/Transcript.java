package uni;

import java.util.*;

public class Transcript{
    int studentID;
    Map<Integer, Double> transcript;

    public Transcript(int studentID){
        this.studentID = studentID;
        this.transcript = new HashMap<>();
    }

    public void setGrade(int presentedCourseID, Double grade){
        PresentedCourse pc = PresentedCourse.findById(presentedCourseID);
        if (pc != null){
            if (pc.studentIDList.contains(studentID)) {
                this.transcript.put(presentedCourseID, grade);
            }
        }
    }

    public void printTranscript(){
        for (var entry : transcript.entrySet()) {
            PresentedCourse pc = PresentedCourse.findById(entry.getKey());
            Course course = null;
            if (pc != null) {
                course = Course.findById(pc.courseID);
            }
            if (course != null) {
                System.out.println(course.title + ": " + entry.getValue());
            }
        }
    }

    public double getGPA(){
        double totalGradePoints = 0;
        int totalUnits = 0;
        double GPA = 0;
        for (var entry : transcript.entrySet()) {
            PresentedCourse pc = PresentedCourse.findById(entry.getKey());
            Course course = null;
            if (pc != null) {
                course = Course.findById(pc.courseID);
            }
            if (course != null) {
                totalGradePoints += entry.getValue() * course.units;
                totalUnits += course.units;
            }
        }
        if (totalUnits > 0) {
            GPA = totalGradePoints / totalUnits;
        }
        return GPA;
    }
}