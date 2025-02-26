package base;

import java.util.*;

public class Person {
    int personID;
    static List<Person> personList = new ArrayList<Person>();
    public String name;
    final String nationalID;

    public Person(String name, String nationalID){
        this.name = name;
        this.nationalID = nationalID;
        personList.add(this);
        this.personID = personList.size();
    }

    public static Person findById(int ID){
        for (Person person : personList){
            if (person.personID == ID)
                return person;
        }
        return null;
    }
}
