package com.example.employeemanager;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
public class ActivityDetails extends AppCompatActivity {
    private EditText editTextName;
    private EditText editTextDOB;
    private EditText editTextDesignation;
    private EditText editTextExperience;
    private EditText editTextAddress;
    private Button btnSave;
    private DatabaseHelper databaseHelper;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);
        // Set the title of the screen
        setTitle("Employee Details");
        editTextName = findViewById(R.id.editTextName);
        editTextDOB = findViewById(R.id.editTextDOB);
        editTextDesignation = findViewById(R.id.editTextDesignation);
        editTextExperience = findViewById(R.id.editTextExperience);
        editTextAddress = findViewById(R.id.editTextAddress);
        btnSave = findViewById(R.id.btnSave);
        databaseHelper = new DatabaseHelper(this);
        btnSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                saveEmployeeDetails();
            }
        });
    }
    private void saveEmployeeDetails() {
        String name = editTextName.getText().toString().trim();
        String dobString = editTextDOB.getText().toString().trim();
        String designation = editTextDesignation.getText().toString().trim();
        int yearsOfExperience = Integer.parseInt(editTextExperience.getText().toString().trim());
        String address = editTextAddress.getText().toString().trim();
        if (name.isEmpty() || dobString.isEmpty() || designation.isEmpty() || address.isEmpty()) {
            Toast.makeText(this, "Please enter all the details", Toast.LENGTH_SHORT).show();
            return;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault());
        Date dob = null;
        try {
            dob = sdf.parse(dobString);
        } catch (ParseException e) {
            e.printStackTrace();
            Toast.makeText(this, "Please enter a valid date in the format dd/MM/yyyy", Toast.LENGTH_SHORT).show();
            return;
        }
        EmployeeModel employee = new EmployeeModel(name, dob, designation, yearsOfExperience, address);
        databaseHelper.addEmployee(employee);
        Toast.makeText(this, "Employee saved", Toast.LENGTH_SHORT).show();
    }
}