package com.example.sleepproject;

import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.util.ArrayList;

import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.series.DataPoint;
import com.jjoe64.graphview.series.LineGraphSeries;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class MyGraphView extends ActionBarActivity {

	ArrayList<float[]> accelData;
	ArrayList<String[]> stringData;

	@Override
	public void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_my_graph_view);

		accelData = new ArrayList<float[]>();
		stringData = new ArrayList<String[]>();

		getData();

		TextView accelText = (TextView) findViewById(R.id.accelData);

		StringBuilder builder = new StringBuilder();
		
		//This shit was retarded - turned out that accelData in AccelView was adding the
		//pointer to the values each time, so when the values were updated every element
		//in the array was being changed. To get around it, had to convert the values to
		//a string each time and save these instead.
		//Get fucked Java.

//		for(int i = 0 ; i < accelData.size() ; i++) {
//			float[] values = accelData.get(i);
//			builder.append("x value: " + Float.toString(values[0]) + " y value: " + Float.toString(values[1])
//					+ " z value: " + Float.toString(values[2]) + "\n");
//		}

		//accelText.setText(builder.toString());
				
		for(int i = 0 ; i < stringData.size() ; i++) {
			String[] strings = stringData.get(i);
			float[] floats = {Float.parseFloat(strings[0]),Float.parseFloat(strings[1]),Float.parseFloat(strings[2])};
			accelData.add(floats);
			builder.append("x value: " + strings[0] + " y value: " + strings[1]
					+ " z value: " + strings[2] + "\n");
		}
		
		float[] test = accelData.get(0);
		float[] test2 = accelData.get(1);
		float[] test3 = accelData.get(2);
		float[] test4 = accelData.get(3);
		
		GraphView graph = new GraphView(this);
		LineGraphSeries<DataPoint> series = new LineGraphSeries<DataPoint>(new DataPoint[] {
				new DataPoint (0, 0),
				new DataPoint (1, 1),
				new DataPoint (2, 2),
				new DataPoint (3, 3)});
		
		graph.addSeries(series);
		
		RelativeLayout layout = (RelativeLayout) findViewById(R.layout.activity_my_graph_view);
		
		//layout.addView(graph);
		
		setContentView(graph);
		
		//accelText.setText(builder.toString());
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.menu, menu);
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

	private void getData(){
		FileInputStream fileIn;
		try {
			fileIn = openFileInput("accelerometerData");
			ObjectInputStream inputStream = new ObjectInputStream(fileIn);
			//accelData =  (ArrayList<float[]>) inputStream.readObject();
			stringData = (ArrayList<String[]>) inputStream.readObject();
			inputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
