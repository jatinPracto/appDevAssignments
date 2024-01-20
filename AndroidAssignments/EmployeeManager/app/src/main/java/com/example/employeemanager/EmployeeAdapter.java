package com.example.employeemanager;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
public class EmployeeAdapter extends RecyclerView.Adapter<EmployeeAdapter.EmployeeViewHolder> {
    private List<EmployeeModel> employeeModels;
    private MainActivity mainActivity;
    public EmployeeAdapter(List<EmployeeModel> employeeModels, MainActivity mainActivity) {
        this.employeeModels = employeeModels;
        this.mainActivity = mainActivity;
    }
    @NonNull
    @Override
    public EmployeeViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.employee_item, parent, false);
        return new EmployeeViewHolder(itemView);
    }
    @Override
    public void onBindViewHolder(@NonNull EmployeeViewHolder holder, int position) {
        EmployeeModel employee = employeeModels.get(position);
        holder.bind(employee);
    }
    @Override
    public int getItemCount() {
        return employeeModels.size();
    }
    public void setEmployeeModels(List<EmployeeModel> employeeModels) {
        this.employeeModels = employeeModels;
    }
    static class EmployeeViewHolder extends RecyclerView.ViewHolder {
        TextView textViewName;
        TextView textViewDOB;
        TextView textViewDesignation;
        TextView textViewExperience;
        TextView textViewAddress;
        public EmployeeViewHolder(@NonNull View itemView) {
            super(itemView);
            textViewName = itemView.findViewById(R.id.textViewName);
            textViewDOB = itemView.findViewById(R.id.textViewDOB);
            textViewDesignation = itemView.findViewById(R.id.textViewDesignation);
            textViewExperience = itemView.findViewById(R.id.textViewExperience);
            textViewAddress = itemView.findViewById(R.id.textViewAddress);
        }
        public void bind(EmployeeModel employee) {
            textViewName.setText(employee.getName());
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault());
            textViewDOB.setText(sdf.format(employee.getDateOfBirth()));
            textViewDesignation.setText(employee.getDesignation());
            textViewExperience.setText(String.valueOf(employee.getYearsOfExperience()));
            textViewAddress.setText(employee.getAddress());
        }
    }
}










