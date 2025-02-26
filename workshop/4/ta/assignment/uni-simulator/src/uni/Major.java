package uni;

import java.util.*;

public class Major {
    int majorID;
    static List<Major> majorList = new ArrayList<>();
    String name;
    final int maxCapacity;
    int numberOfStudents = 0;

    public Major(String name, int maxStudentNumber){
        this.name = name;
        this.maxCapacity = maxStudentNumber;
        majorList.add(this);
        this.majorID = majorList.size();
    }

    public static Major findById(int ID){
        for (Major major : majorList){
            if (major.majorID == ID)
                return major;
        }
        return null;
    }

    public void addStudent(){
        if (this.numberOfStudents == this.maxCapacity){
            System.out.println("Student number has reached it's max capacity.");
        } else {
            this.numberOfStudents++;
        }
    }
}
