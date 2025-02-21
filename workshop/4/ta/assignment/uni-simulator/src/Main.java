import java.util.*;

class Major {
    public String name;
    public final int maxStudentNumber;
    public static int majorNumber = 0;
    public int majorID;
    public int numberOfStudents = 0;

    public Major(String name, int maxStudentNumber){
        this.name = name;
        this.maxStudentNumber = maxStudentNumber;
        majorNumber++;
        majorID = majorNumber;
    }

    public void addStudent(){
        if (this.numberOfStudents == this.maxStudentNumber){
            System.out.println("Student number has reached it's max capacity.");
        } else {
            this.numberOfStudents++;
        }
    }
}

class Party {
    public String name;
    public final int codeMeli;
    public Major major;

    public Party(String name, int codeMeli, Major major){
        this.name = name;
        this.codeMeli = codeMeli;
        this.major = major;
    }
}

class Student {
    public Party party;
    public final int entranceYear;
    public int studentID;

    public Student (Party party, int entranceYear) {
        this.party = party;
        this.entranceYear = entranceYear;
        this.party.major.addStudent();
        setStudentID();
    }

    public void setStudentID(){
        studentID = entranceYear * 100000 + this.party.major.majorNumber * 1000 + this.party.major.numberOfStudents;
    }
}


class Professor {
    public Party party;
    public static int numberOfProfessors = 0;
    public String professorID;

    public Professor(Party party) {
        this.party = party;
        numberOfProfessors++;
        professorID = this.party.name + "@###" + numberOfProfessors;
    }
}

class Course {
    public String title;
    public int units;

    public Course(String title, int units) {
        this.title = title;
        this.units = units;
    }
}

class PresentedCourse{
    public Course course;
    public Professor professor;
    public List<Student> students;
    public int maxCapacity;

    public PresentedCourse(Course course, Professor professor, int maxCapacity){
        this.course = course;
        this.professor = professor;
        this.maxCapacity = maxCapacity;
        this.students = new ArrayList<>(maxCapacity);
    }
    public void addStudent(Student student) {
        students.add(student);
    }
}

class Transcript{
    public Student student;
    private Map<PresentedCourse, Double> transcript;
    double GPA;


    public Transcript(Student student){
        this.student = student;
        this.transcript = new HashMap<>();
        this.GPA = 0.0;
    }

    public void setGrade(PresentedCourse course, Double grade){
            this.transcript.put(course, grade);
    }

    public void printTranscript(){
        for (var entry : transcript.entrySet()) {
            System.out.println(entry.getKey().course.title + ": " + entry.getValue());
        }
    }

    public double getGPA(){
        double totalGradePoints = 0;
        int totalUnits = 0;
        for (var entry : transcript.entrySet()) {
            PresentedCourse course = entry.getKey();
            totalGradePoints += transcript.get(course) * course.course.units;
            totalUnits += course.course.units;
        }
        if (totalUnits > 0) {
            this.GPA = totalGradePoints / totalUnits;
        }
        return GPA;
    }
}

public class Main {
    public static void main(String[] args) {
        //ایجاد رشته‌ها
        Major cs = new Major("Computer Science", 3);
        Major ee = new Major("Electrical Engineering", 2);

        // ایجاد افراد (Party)
        Party party1 = new Party("Sania", 123456, cs);
        Party party2 = new Party("Arman", 654321, cs);
        Party party3 = new Party("Mina", 987654, ee);
        Party professorParty1 = new Party("Dr.Nemati", 111222, cs);
        Party professorParty2 = new Party("Dr.Rostami", 111222, ee);

        // ایجاد دانشجویان
        Student student1 = new Student(party1, 402);
        Student student2 = new Student(party2, 401);
        Student student3 = new Student(party3, 400);

        //چاپ شماره دانشجویی
        System.out.println(student1.party.name + ": " + student1.studentID);
        System.out.println(student2.party.name + ": " + student2.studentID);
        System.out.println(student3.party.name + ": " + student3.studentID);


        // ایجاد استاد
        Professor professor1 = new Professor(professorParty1);
        System.out.println(professor1.party.name + ": " + professor1.professorID);

        Professor professor2 = new Professor(professorParty2);

        System.out.println(professor2.party.name + ": " + professor2.professorID);


        // ایجاد دروس
        Course course1 = new Course("Data Structures", 3);
        Course course2 = new Course("Algorithms", 4);
        Course course3 = new Course("Electronic circuits", 3);

        // ایجاد دروس ارائه شده
        PresentedCourse presentedCourse1 = new PresentedCourse(course1, professor1, 5);
        PresentedCourse presentedCourse2 = new PresentedCourse(course2, professor1, 5);
        PresentedCourse presentedCourse3 = new PresentedCourse(course3, professor2, 6);


        // اضافه کردن دانشجویان به دروس ارائه‌شده
        presentedCourse1.addStudent(student1);
        presentedCourse1.addStudent(student2);
        presentedCourse2.addStudent(student1);
        presentedCourse2.addStudent(student2);
        presentedCourse2.addStudent(student3);
        presentedCourse3.addStudent(student3);


        // ایجاد کارنامه برای دانشجو
        Transcript transcript1 = new Transcript(student1);
        Transcript transcript2 = new Transcript(student2);
        Transcript transcript3 = new Transcript(student3);


        // تعیین نمرات
        transcript1.setGrade(presentedCourse1, 20.0);
        transcript1.setGrade(presentedCourse2, 17.5);
        transcript2.setGrade(presentedCourse1, 19.5);
        transcript2.setGrade(presentedCourse2, 18.5);
        transcript3.setGrade(presentedCourse2, 17.75);
        transcript3.setGrade(presentedCourse3, 16.0);

        // چاپ کارنامه و معدل
        System.out.println("Transcript for " + student1.party.name);
        transcript1.printTranscript();
        System.out.println("GPA: " + transcript1.getGPA());

        System.out.println("Transcript for " + student2.party.name);
        transcript2.printTranscript();
        System.out.println("GPA: " + transcript2.getGPA());

        System.out.println("Transcript for " + student3.party.name);
        transcript3.printTranscript();
        System.out.println("GPA: " + transcript3.getGPA());
    }
}