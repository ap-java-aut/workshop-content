package packages;

import javax.swing.*;

public class Page2 {

    public void create(JFrame frame) {
        // Create and configure the panel
        JPanel panel = new JPanel();
        panel.setBounds(0, 0, 600, 600);
        panel.setLayout(null);

        // Question 1
        JLabel question1 = new JLabel("چقدر رابط کاربری نرم افزار از نظر شما جذاب است؟");
        question1.setBounds(10, 10, 300, 20);

        JRadioButton radio1_1 = new JRadioButton("۱ (اصلاً جذاب نیست)");
        radio1_1.setBounds(10, 40, 150, 20);
        JRadioButton radio1_2 = new JRadioButton("۲ (کم جذاب)");
        radio1_2.setBounds(150, 40, 100, 20);
        JRadioButton radio1_3 = new JRadioButton("۳ (معمولی)");
        radio1_3.setBounds(240, 40, 100, 20);
        JRadioButton radio1_4 = new JRadioButton("۴ (جذاب)");
        radio1_4.setBounds(330, 40, 100, 20);
        JRadioButton radio1_5 = new JRadioButton("۵ (خیلی جذاب)");
        radio1_5.setBounds(420, 40, 150, 20);

        ButtonGroup group1 = new ButtonGroup();
        group1.add(radio1_1);
        group1.add(radio1_2);
        group1.add(radio1_3);
        group1.add(radio1_4);
        group1.add(radio1_5);

        // Question 2
        JLabel question2 = new JLabel("آیا دسترسی به امکانات مختلف نرم افزار برای شما آسان است؟");
        question2.setBounds(10, 90, 300, 20);

        JRadioButton radio2_1 = new JRadioButton("بله");
        radio2_1.setBounds(10, 120, 150, 20);
        JRadioButton radio2_2 = new JRadioButton("خیر");
        radio2_2.setBounds(100, 120, 100, 20);
        JRadioButton radio2_3 = new JRadioButton("تا حدودی");
        radio2_3.setBounds(190, 120, 100, 20);

        ButtonGroup group2 = new ButtonGroup();
        group2.add(radio2_1);
        group2.add(radio2_2);
        group2.add(radio2_3);

        // Question 3
        JLabel question3 = new JLabel("چقدر طراحی صفحات نرم افزار ساده و کاربرپسند است؟");
        question3.setBounds(10, 170, 300, 20);

        JRadioButton radio3_1 = new JRadioButton("۱ (خیلی پیچیده)");
        radio3_1.setBounds(10, 200, 150, 20);
        JRadioButton radio3_2 = new JRadioButton("۲ (پیچیده)");
        radio3_2.setBounds(130, 200, 100, 20);
        JRadioButton radio3_3 = new JRadioButton("۳ (معمولی)");
        radio3_3.setBounds(220, 200, 100, 20);
        JRadioButton radio3_4 = new JRadioButton("۴ (ساده)");
        radio3_4.setBounds(310, 200, 100, 20);
        JRadioButton radio3_5 = new JRadioButton("۵ (خیلی ساده و کاربرپسند)");
        radio3_5.setBounds(400, 200, 200, 20);

        ButtonGroup group3 = new ButtonGroup();
        group3.add(radio3_1);
        group3.add(radio3_2);
        group3.add(radio3_3);
        group3.add(radio3_4);
        group3.add(radio3_5);

        // Question 4
        JLabel question4 = new JLabel("آیا رنگ ها و فونت های استفاده شده در نرم افزار مناسب هستند؟");
        question4.setBounds(10, 250, 350, 20);

        JRadioButton radio4_1 = new JRadioButton("بله");
        radio4_1.setBounds(10, 280, 150, 20);
        JRadioButton radio4_2 = new JRadioButton("خیر");
        radio4_2.setBounds(100, 280, 100, 20);
        JRadioButton radio4_3 = new JRadioButton("نیاز به تغییر دارد");
        radio4_3.setBounds(190, 280, 150, 20);

        ButtonGroup group4 = new ButtonGroup();
        group4.add(radio4_1);
        group4.add(radio4_2);
        group4.add(radio4_3);

        // Next button to go to Page3
        JButton nextButton = new JButton("صفحه بعد");
        nextButton.setBounds(10, 320, 100, 20);
        nextButton.addActionListener(e -> {
            frame.remove(panel);
            frame.revalidate();
            frame.repaint();

            Page3 page3 = new Page3();
            page3.create(frame);

            frame.revalidate();
            frame.repaint();
        });

        // Add components to the panel
        panel.add(question1);
        panel.add(radio1_1);
        panel.add(radio1_2);
        panel.add(radio1_3);
        panel.add(radio1_4);
        panel.add(radio1_5);

        panel.add(question2);
        panel.add(radio2_1);
        panel.add(radio2_2);
        panel.add(radio2_3);

        panel.add(question3);
        panel.add(radio3_1);
        panel.add(radio3_2);
        panel.add(radio3_3);
        panel.add(radio3_4);
        panel.add(radio3_5);

        panel.add(question4);
        panel.add(radio4_1);
        panel.add(radio4_2);
        panel.add(radio4_3);

        panel.add(nextButton);

        // Add panel to the frame
        frame.add(panel);
    }
}
