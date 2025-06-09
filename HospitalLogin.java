import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.HashSet;

public class HospitalLogin extends JFrame {

    private HashSet<String> existingUsers = new HashSet<>(); // Simulated user DB
    private JTextField usernameField;
    private JLabel messageLabel;

    public HospitalLogin() {
        setTitle("Hospital Management - Welcome");
        setSize(400, 250);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null); // center the frame
        setLayout(new BorderLayout());

        // Heading
        JLabel titleLabel = new JLabel("Welcome to Hospital Management System", JLabel.CENTER);
        titleLabel.setFont(new Font("Arial", Font.BOLD, 16));
        add(titleLabel, BorderLayout.NORTH);

        // Center Panel
        JPanel centerPanel = new JPanel(new GridLayout(3, 1, 10, 10));
        usernameField = new JTextField();
        centerPanel.add(new JLabel("Enter Username:"));
        centerPanel.add(usernameField);

        // Buttons
        JPanel buttonPanel = new JPanel();
        JButton signInButton = new JButton("Sign In");
        JButton loginButton = new JButton("Login");
        buttonPanel.add(signInButton);
        buttonPanel.add(loginButton);

        centerPanel.add(buttonPanel);
        add(centerPanel, BorderLayout.CENTER);

        // Message Label (for errors)
        messageLabel = new JLabel("", JLabel.CENTER);
        messageLabel.setForeground(Color.RED);
        add(messageLabel, BorderLayout.SOUTH);

        // Add some existing users
        existingUsers.add("admin");
        existingUsers.add("doctor");
        existingUsers.add("chandu");

        // Sign In Action
        signInButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String user = usernameField.getText().trim();
                if (existingUsers.contains(user)) {
                    openNextFrame(user);
                    dispose(); // Close current window
                } else {
                    messageLabel.setText("User not found! Please try again.");
                }
            }
        });

        // Login Action (you can implement later as separate logic)
        loginButton.addActionListener(e -> {
            JOptionPane.showMessageDialog(null, "Login button clicked! (To be implemented)");
        });

        setVisible(true);
    }

    private void openNextFrame(String username) {
        JFrame nextFrame = new JFrame("Welcome " + username);
        nextFrame.setSize(300, 200);
        nextFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        nextFrame.setLocationRelativeTo(null);
        nextFrame.add(new JLabel("Hello " + username + ", you're signed in!", JLabel.CENTER));
        nextFrame.setVisible(true);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new HospitalLogin());
    }
}
