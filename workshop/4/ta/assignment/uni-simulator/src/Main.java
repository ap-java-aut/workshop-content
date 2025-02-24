import java.util.*;

import edu.uni.party.Person;
import edu.uni.entities.*;
import edu.uni.components.*;

public class Main {
    public static void main(String[] args) {

        // Creating majors
        Major cs = new Major("Computer Science", 3);
        Major ee = new Major("Electrical Engineering", 2);

        // Creating people
        Person person1 = new Person("Sania", "123456");
        Person person2 = new Person("Arman", "654321");
        Person person3 = new Person("Mina", "987654");
        Person person4 = new Person("Dr.Nemati", "111222");
        Person person5 = new Person("Dr.Rostami", "111222");


        // Creating Students
        Student student1 = new Student(1, 402, 1);
        Student student2 = new Student(2, 401, 1);
        Student student3 = new Student(3, 403, 2);

        // Printing students' names and student numbers
        System.out.println(Person.findById(student1.personID).name + ": " + student1.studentCode);
        System.out.println(Person.findById(student2.personID).name + ": " + student2.studentCode);
        System.out.println(Person.findById(student3.personID).name + ": " + student3.studentCode);


        // Creating Professors
        Professor professor1 = new Professor(4,1);
        Professor professor2 = new Professor(5,2);

        // Printing Professors' names and ids
        System.out.println(Person.findById(professor1.personID).name + ": " + professor1.professorID);
        System.out.println(Person.findById(professor2.personID).name + ": " + professor2.professorID);


        // Creating Courses
        Course course1 = new Course("Data Structures", 3);
        Course course2 = new Course("Algorithms", 4);
        Course course3 = new Course("Electronic circuits", 3);

        // Creating Presented Courses
        PresentedCourse presentedCourse1 = new PresentedCourse(1, 1, 5);
        PresentedCourse presentedCourse2 = new PresentedCourse(2, 1, 5);
        PresentedCourse presentedCourse3 = new PresentedCourse(3, 2, 6);


        // Adding students to presented courses
        presentedCourse1.addStudent(1);
        presentedCourse1.addStudent(2);
        presentedCourse2.addStudent(1);
        presentedCourse2.addStudent(2);
        presentedCourse2.addStudent(3);
        presentedCourse3.addStudent(3);


        // Creating Transcript for each student
        Transcript transcript1 = new Transcript(1);
        Transcript transcript2 = new Transcript(2);
        Transcript transcript3 = new Transcript(3);


        // Grading each course for each transcript
        transcript1.setGrade(1, 20.0);
        transcript1.setGrade(2, 17.5);
        transcript2.setGrade(1, 19.5);
        transcript2.setGrade(2, 18.5);
        transcript3.setGrade(2, 17.75);
        transcript3.setGrade(3, 16.0);


        // Printing transcripts
        System.out.println("Transcript for " + Person.findById(student1.personID).name);
        transcript1.printTranscript();
        System.out.println("GPA: " + transcript1.getGPA());

        System.out.println("Transcript for " + Person.findById(student2.personID).name);
        transcript2.printTranscript();
        System.out.println("GPA: " + transcript2.getGPA());

        System.out.println("Transcript for " + Person.findById(student3.personID).name);
        transcript3.printTranscript();
        System.out.println("GPA: " + transcript3.getGPA());
    }
}