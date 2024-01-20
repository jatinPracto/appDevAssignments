package com.example.employeemanager;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
public class DatabaseHelper extends SQLiteOpenHelper {
    private static final String DATABASE_NAME = "employee_db";
    private static final int DATABASE_VERSION = 1;
    private static final String TABLE_EMPLOYEE = "employees";
    private static final String KEY_ID = "id";
    private static final String KEY_NAME = "name";
    private static final String KEY_DATE_OF_BIRTH = "date_of_birth";
    private static final String KEY_DESIGNATION = "designation";
    private static final String KEY_YEARS_OF_EXPERIENCE = "years_of_experience";
    private static final String KEY_ADDRESS = "address";
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
    public DatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }
    @Override
    public void onCreate(SQLiteDatabase db) {
        String createTableQuery = "CREATE TABLE " + TABLE_EMPLOYEE + "(" +
                KEY_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
                KEY_NAME + " TEXT," +
                KEY_DATE_OF_BIRTH + " TEXT," +
                KEY_DESIGNATION + " TEXT," +
                KEY_YEARS_OF_EXPERIENCE + " INTEGER," +
                KEY_ADDRESS + " TEXT" +
                ")";
        db.execSQL(createTableQuery);
    }
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_EMPLOYEE);
        onCreate(db);
    }
    public long addEmployee(EmployeeModel employee) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(KEY_NAME, employee.getName());
        values.put(KEY_DATE_OF_BIRTH, DATE_FORMAT.format(employee.getDateOfBirth()));
        values.put(KEY_DESIGNATION, employee.getDesignation());
        values.put(KEY_YEARS_OF_EXPERIENCE, employee.getYearsOfExperience());
        values.put(KEY_ADDRESS, employee.getAddress());
        long newEmployeeId = db.insert(TABLE_EMPLOYEE, null, values);
        db.close();
        return newEmployeeId;
    }
    public EmployeeModel getEmployee(long employeeId) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.query(TABLE_EMPLOYEE, null, KEY_ID + "=?", new String[]{String.valueOf(employeeId)}, null, null, null);
        EmployeeModel employee = null;
        if (cursor != null && cursor.moveToFirst()) {
            employee = cursorToEmployee(cursor);
            cursor.close();
        }
        db.close();
        return employee;
    }
    public List<EmployeeModel> getAllEmployees() {
        List<EmployeeModel> employees = new ArrayList<>();
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT * FROM " + TABLE_EMPLOYEE, null);
        if (cursor != null && cursor.moveToFirst()) {
            do {
                EmployeeModel employee = cursorToEmployee(cursor);
                employees.add(employee);
            } while (cursor.moveToNext());
            cursor.close();
        }
        db.close();
        return employees;
    }
    public int updateEmployee(EmployeeModel employee) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(KEY_NAME, employee.getName());
        values.put(KEY_DESIGNATION, employee.getDesignation());
        values.put(KEY_YEARS_OF_EXPERIENCE, employee.getYearsOfExperience());
        values.put(KEY_ADDRESS, employee.getAddress());
        int rowsAffected = db.update(TABLE_EMPLOYEE, values, KEY_ID + "=?", new String[]{String.valueOf(employee.getId())});
        db.close();
        return rowsAffected;
    }
    public void deleteEmployee(long employeeId) {
        SQLiteDatabase db = this.getWritableDatabase();
        db.delete(TABLE_EMPLOYEE, KEY_ID + "=?", new String[]{String.valueOf(employeeId)});
        db.close();
    }
    private EmployeeModel cursorToEmployee(Cursor cursor) {
        EmployeeModel employee = new EmployeeModel();
        employee.setId(cursor.getLong(cursor.getColumnIndex(KEY_ID)));
        employee.setName(cursor.getString(cursor.getColumnIndex(KEY_NAME)));
        try {
            Date dateOfBirth = DATE_FORMAT.parse(cursor.getString(cursor.getColumnIndex(KEY_DATE_OF_BIRTH)));
            employee.setDateOfBirth(dateOfBirth);
        } catch (Exception e) {
            e.printStackTrace();
        }
        employee.setDesignation(cursor.getString(cursor.getColumnIndex(KEY_DESIGNATION)));
        employee.setYearsOfExperience(cursor.getInt(cursor.getColumnIndex(KEY_YEARS_OF_EXPERIENCE)));
        employee.setAddress(cursor.getString(cursor.getColumnIndex(KEY_ADDRESS)));
        return employee;
    }
}
