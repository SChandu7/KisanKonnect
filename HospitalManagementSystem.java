class SignUpFrame extends JFrame {
    public SignUpFrame() {
        setTitle("Patient Sign-Up");
        setSize(300, 250);
        setLocationRelativeTo(null);

        JTextField uname = new JTextField();
        JTextField fullName = new JTextField();
        JPasswordField pass = new JPasswordField();
        JButton registerBtn = new JButton("Register");

        JPanel panel = new JPanel(new GridLayout(4, 2));
        panel.add(new JLabel("Username:"));
        panel.add(uname);
        panel.add(new JLabel("Full Name:"));
        panel.add(fullName);
        panel.add(new JLabel("Password:"));
        panel.add(pass);
        panel.add(new JLabel(""));
        panel.add(registerBtn);

        registerBtn.addActionListener(e -> {
            String u = uname.getText().trim();
            String p = new String(pass.getPassword());
            String f = fullName.getText().trim();

            boolean exists = HospitalManagementSystem.users.stream().anyMatch(user -> user.username.equals(u));
            if (exists) {
                JOptionPane.showMessageDialog(this, "Username already exists.");
                return;
            }

            HospitalManagementSystem.users.add(new User(u, SecurityUtil.hashPassword(p), "patient", f));
            LoggerUtil.log(u, "patient", "Registered");
            JOptionPane.showMessageDialog(this, "Registration Successful!");
            dispose();
        });

        add(panel);
        setVisible(true);
    }
}
