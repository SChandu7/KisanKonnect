public class HospitalLogin extends JFrame {
    private ArrayList<Patient> patients = new ArrayList<>();
    private DefaultTableModel tableModel;
    private JTable table;

    public HospitalLogin() {
        setTitle("Patient Management");
        setSize(600, 400);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        String[] columns = {"Name", "Age", "Gender", "Phone"};
        tableModel = new DefaultTableModel(columns, 0);
        table = new JTable(tableModel);

        JScrollPane scrollPane = new JScrollPane(table);

        JButton addBtn = new JButton("Add");
        JButton updateBtn = new JButton("Update");
        JButton deleteBtn = new JButton("Delete");

        JPanel controlPanel = new JPanel();
        controlPanel.add(addBtn);
        controlPanel.add(updateBtn);
        controlPanel.add(deleteBtn);

        add(scrollPane, BorderLayout.CENTER);
        add(controlPanel, BorderLayout.SOUTH);

        // ... [rest of your button logic remains unchanged]

        setVisible(true);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new HospitalLogin());
    }
}
