import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.HashMap;

public class LoginSignupApp {

    // Store credentials: default username/password = mahesh/mahesh
    private static HashMap<String, String> users = new HashMap<>();

    public static void main(String[] args) {
        // Add default user
        users.put("mahesh", "mahesh");

        SwingUtilities.invokeLater(() -> new LoginFrame());
    }

    // Login Frame
    static class LoginFrame extends JFrame {
        JTextField usernameField;
        JPasswordField passwordField;

        public LoginFrame() {
            setTitle("Login");
            setSize(350, 200);
            setLocationRelativeTo(null);
            setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

            JPanel panel = new JPanel(new GridLayout(3, 2, 10, 10));
            panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

            panel.add(new JLabel("Username:"));
            usernameField = new JTextField();
            panel.add(usernameField);

            panel.add(new JLabel("Password:"));
            passwordField = new JPasswordField();
            panel.add(passwordField);

            JButton loginBtn = new JButton("Login");
            JButton signupBtn = new JButton("Signup");

            panel.add(loginBtn);
            panel.add(signupBtn);

            add(panel);

            loginBtn.addActionListener(e -> {
                String username = usernameField.getText().trim();
                String password = new String(passwordField.getPassword());

                if (users.containsKey(username) && users.get(username).equals(password)) {
                    // Success: Open Home Page and close Login
                    JOptionPane.showMessageDialog(this, "Login successful!");
                    new HomePageFrame(username);
                    dispose();
                } else {
                    JOptionPane.showMessageDialog(this, "Invalid username or password.", "Error", JOptionPane.ERROR_MESSAGE);
                }
            });

            signupBtn.addActionListener(e -> {
                new SignupFrame(this);
                setVisible(false); // Hide login while signing up
            });

            setVisible(true);
        }
    }

    // Signup Frame
    static class SignupFrame extends JFrame {
        JTextField usernameField;
        JPasswordField passwordField;

        public SignupFrame(JFrame loginFrame) {
            setTitle("Signup");
            setSize(350, 200);
            setLocationRelativeTo(null);
            setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

            JPanel panel = new JPanel(new GridLayout(3, 2, 10, 10));
            panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

            panel.add(new JLabel("New Username:"));
            usernameField = new JTextField();
            panel.add(usernameField);

            panel.add(new JLabel("New Password:"));
            passwordField = new JPasswordField();
            panel.add(passwordField);

            JButton registerBtn = new JButton("Register");
            JButton backBtn = new JButton("Back");

            panel.add(registerBtn);
            panel.add(backBtn);

            add(panel);

            registerBtn.addActionListener(e -> {
                String username = usernameField.getText().trim();
                String password = new String(passwordField.getPassword());

                if (username.isEmpty() || password.isEmpty()) {
                    JOptionPane.showMessageDialog(this, "Please enter username and password.", "Warning", JOptionPane.WARNING_MESSAGE);
                } else if (users.containsKey(username)) {
                    JOptionPane.showMessageDialog(this, "Username already exists!", "Error", JOptionPane.ERROR_MESSAGE);
                } else {
                    users.put(username, password);
                    JOptionPane.showMessageDialog(this, "User registered successfully!");
                    dispose();
                    loginFrame.setVisible(true);
                }
            });

            backBtn.addActionListener(e -> {
                dispose();
                loginFrame.setVisible(true);
            });

            setVisible(true);
        }
    }

    // Home Page Frame
    static class HomePageFrame extends JFrame {
        public HomePageFrame(String username) {
            setTitle("Home Page");
            setSize(400, 200);
            setLocationRelativeTo(null);
            setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

            JLabel welcomeLabel = new JLabel("Welcome, " + username + "!", SwingConstants.CENTER);
            welcomeLabel.setFont(new Font("Arial", Font.BOLD, 18));

            add(welcomeLabel);

            setVisible(true);
        }
    }
}
