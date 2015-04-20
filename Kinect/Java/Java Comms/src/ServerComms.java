import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class ServerComms {

	private static BufferedWriter w;
	private static Socket c;
	private static BufferedReader loggedIn;

	public static void main(String[] args) {
		try {
			c = new Socket("46.101.61.151",2000);
			printSocketInfo(c);

			w = new BufferedWriter(new OutputStreamWriter(
					c.getOutputStream()));

			loggedIn = new BufferedReader(new InputStreamReader(c.getInputStream()));

			w.write("LOGIN,p1,byebye,");
			w.newLine();
			w.flush();

			String s = null;
			//while(s == null) {
				s = loggedIn.readLine();
				System.out.println(s);
			//}

			System.out.println(s);

			if (s.equals("LOGGED IN")) {

				System.out.println("this is now real text");

				sendData();

			}

		} catch (IOException e) {
			System.err.println(e.toString());

		} 
		finally {
			try {
				w.write("LOGOUT");
				w.newLine();
				w.flush();
				w.close();
				c.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("done!");

	}

	private static void sendData() throws IOException {
		//path for jar, remove .. if running from eclipse
		String path = System.getProperty("user.dir") + "\\..\\Matlab\\data\\";
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy");
		//String date = sdf.format(cal.getTime());
		String date = "03-06-15";
		
		System.out.println(date);
		
		BufferedReader r = new BufferedReader(new FileReader(path + "move" + date + ".txt"));

		String m = null;

		while ((m=r.readLine())!= null) {
			System.out.println(m);
			w.write(m);
			w.newLine();
			w.flush();
		}

		r.close();
		String s = null;
		//while(s == null) {
			s = loggedIn.readLine();
			System.out.println(s);
		//}
		
		r = new BufferedReader(new FileReader(path + "REM" + date + ".txt"));

		while ((m=r.readLine())!= null) {
			System.out.println(m);
			w.write(m);
			w.newLine();
			w.flush();
		}

		r.close();
		
		s = null;
		//while(s == null) {
			s = loggedIn.readLine();
			System.out.println(s);
		//}
		
		r = new BufferedReader(new FileReader(path + "Dist" + date + ".txt"));

		while ((m=r.readLine())!= null) {
			System.out.println(m);
			w.write(m);
			w.newLine();
			w.flush();
		}

		r.close();
		
		s = null;
		//while(s == null) {
			s = loggedIn.readLine();
			System.out.println(s);
		//}
		
		r = new BufferedReader(new FileReader(path + "Restless" + date + ".txt"));

		while ((m=r.readLine())!= null) {
			System.out.println(m);
			w.write(m);
			w.newLine();
			w.flush();
		}

		r.close();
		
		s = null;
		//while(s == null) {
			s = loggedIn.readLine();
			System.out.println(s);
		//}
		
		r = new BufferedReader(new FileReader(path + "Twitch" + date + ".txt"));

		while ((m=r.readLine())!= null) {
			System.out.println(m);
			w.write(m);
			w.newLine();
			w.flush();
		}

		r.close();
		
		s = null;
		//while(s == null) {
			s = loggedIn.readLine();
			System.out.println(s);
		//}
	}

	private static void printSocketInfo(Socket s) {
		System.out.println("Remote address = "
				+s.getInetAddress().toString());
		System.out.println("Remote port = "
				+s.getPort());
		System.out.println("Local socket address = "
				+s.getLocalSocketAddress().toString());
		System.out.println("Local address = "
				+s.getLocalAddress().toString());
		System.out.println("Local port = "
				+s.getLocalPort());
	}
}