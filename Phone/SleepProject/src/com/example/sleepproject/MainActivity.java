package com.example.sleepproject;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends ActionBarActivity {

	private EditText username=null;
	private EditText password=null;
	private Button login;
	private int loginCount = 3;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		//requestWindowFeature(Window.FEATURE_ACTION_BAR);
		getSupportActionBar().hide();
		
		setContentView(R.layout.activity_main);

		username = (EditText) findViewById(R.id.editUsername);
		password = (EditText) findViewById(R.id.editPassword);
		login = (Button) findViewById(R.id.loginButton);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	public void login(View view) {
		if(username.getText().toString().equals("") &&
				password.getText().toString().equals("") && loginCount > 0) {
			Toast.makeText(getApplicationContext(), "Logging in...", Toast.LENGTH_SHORT).show();
			Intent intent = new Intent(this, MenuActivity.class);
			startActivity(intent);
		}
		else if(loginCount > 0) {
			loginCount--;
			Toast.makeText(getApplicationContext(), "Login failed. "+loginCount+" attempts left.", Toast.LENGTH_SHORT).show();

		}
		else if(loginCount == 0){
			Toast.makeText(getApplicationContext(), "Login locked.", Toast.LENGTH_SHORT).show();
		}
	}
}
