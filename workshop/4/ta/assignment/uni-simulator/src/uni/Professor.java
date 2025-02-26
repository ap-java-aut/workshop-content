package uni;

import java.util.*;

public class Professor {
    public int professorID;
    static List<Professor> professorList = new ArrayList<>();
    public int personID;
    int majorID;

    public Professor(int personID, int majorID) {
        this.personID = personID;
        this.majorID = majorID;
        professorList.add(this);
        this.professorID = professorList.size();
    }
    public static Professor findById(int ID){
        for (Professor professor : professorList){
            if (professor.professorID == ID)
                return professor;
        }
        return null;
    }
}