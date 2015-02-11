package com.example.sleepproject;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;



public class AccelView extends Activity implements SensorEventListener {

	private SensorManager sensorManager;
	private Sensor accelerometer;
	private ArrayList<float[]> accelData;
	private ArrayList<String[]> testArray;
	private Button stop;
	
	//Used to remove gravity
	private final float alpha = 0.8f;
	private float[] gravity = new float[]{0,0,0};

	@Override
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);

		//Setup accelerometer sensor
		sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
		accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
		sensorManager.registerListener(this, accelerometer , SensorManager.SENSOR_DELAY_NORMAL);

		//ArrayList of arrays of floats: x, y, z value of accelerometer
		accelData = new ArrayList<float[]>();
		testArray = new ArrayList<String[]>();

		setContentView(R.layout.activity_accel_view);

		stop = (Button) findViewById(R.id.stopAccel);		
	}

	private void updateText(float[] values){
		TextView accelText = (TextView) findViewById(R.id.accelData);
		accelText.setTextSize(20);
		accelText.setPadding(40, 40, 40, 40);
		//accelText.setText("x value: " + values[0] + "\n" + "y value: " + values[1] + "\n"
		//		+ "z value: " + values[2]);
		float[] test = accelData.get(accelData.size()-1);
		accelText.setText("x value: " + test[0] + "\n" + "y value: " + test[1] + "\n"
				+ "z value: " + test[2]);
	}

	@Override
	public void onSensorChanged(SensorEvent event) {
		// TODO Auto-generated method stub
		float[] accelValues = null;
				
		if(event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) {
			accelValues = event.values;
			
			gravity[0] = alpha * gravity[0] + (1 - alpha) * accelValues[0];
			gravity[1] = alpha * gravity[1] + (1 - alpha) * accelValues[1];
			gravity[2] = alpha * gravity[2] + (1 - alpha) * accelValues[2];
			
			accelValues[0] = (accelValues[0] - gravity[0])*100;
			accelValues[1] = (accelValues[1] - gravity[1])*100;
			accelValues[2] = (accelValues[2] - gravity[2])*100;
		}		
		if (!accelValues.equals(null)) { 
			accelData.add(accelData.size(), accelValues);
			String[] testStrings = {Float.toString(accelValues[0]), Float.toString(accelValues[1]),
					Float.toString(accelValues[2])};
			testArray.add(testStrings);
			updateText(accelValues);
		}
	}

	@Override
	public void onAccuracyChanged(Sensor sensor, int accuracy) {
		// TODO Auto-generated method stub

	}

	public void stopAccel(View view){
		String filename = "accelerometerData";
		FileOutputStream fileOut;
		ObjectOutputStream outputStream;

		try {
			fileOut = openFileOutput(filename, MODE_PRIVATE);
			outputStream = new ObjectOutputStream(fileOut);
			outputStream.writeObject(testArray);
			outputStream.close();
			Toast.makeText(getBaseContext(),"Data saved",
					Toast.LENGTH_SHORT).show();
			
		} catch(IOException e) {
			Toast.makeText(getBaseContext(),"Data not saved!",
			         Toast.LENGTH_SHORT).show();
		}
		finish();
	}
}
